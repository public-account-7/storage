task.spawn(function()

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Eagle Hub X",
    SubTitle = "Paid Version",
    TabWidth = 100,
    Size = UDim2.fromOffset(440, 315),
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Rage      = Window:AddTab({Title = "Autoparry", Icon = "sword"}),
    Spam      = Window:AddTab({Title = "Spam",       Icon = "skull"}),
    Detection = Window:AddTab({Title = "Detection",  Icon = "monitor"}),
    Player    = Window:AddTab({Title = "Player",     Icon = "user"}),
    Visuals   = Window:AddTab({Title = "Visuals",    Icon = "eye"}),
    Misc      = Window:AddTab({Title = "Misc",       Icon = "settings"}),
    Settings  = Window:AddTab({Title = "Settings",   Icon = "sliders"})
}

local Options = Fluent.Options

repeat task.wait(0.5) until game:IsLoaded()

local Players           = cloneref(game:GetService('Players'))
local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local UserInputService  = cloneref(game:GetService('UserInputService'))
local RunService        = cloneref(game:GetService('RunService'))
local TweenService      = cloneref(game:GetService('TweenService'))
local Stats             = cloneref(game:GetService('Stats'))
local Debris            = cloneref(game:GetService('Debris'))
local CoreGui           = cloneref(game:GetService('CoreGui'))

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

if not LocalPlayer.Character then
    LocalPlayer.CharacterAdded:Wait()
end

local Alive   = workspace:FindFirstChild("Alive") or workspace:WaitForChild("Alive")
local Runtime = workspace.Runtime

local System = {
    __properties = {
        __autoparry_enabled = false,
        __triggerbot_enabled = false,
        __manual_spam_enabled = false,
        __auto_spam_enabled = false,
        __play_animation = false,
        __curve_mode = 1,
        __accuracy = 1,
        __divisor_multiplier = 1.1,
        __parried = false,
        __training_parried = false,
        __spam_threshold = 1.5,
        __parries = 0,
        __parry_key = nil,
        __grab_animation = nil,
        __tornado_time = tick(),
        __first_parry_done = false,
        __connections = {},
        __reverted_remotes = {},
        __spam_accumulator = 0,
        __spam_rate = 240,
        __infinity_active = false,
        __deathslash_active = false,
        __timehole_active = false,
        __slashesoffury_active = false,
        __slashesoffury_count = 0,
        __is_mobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled,
        __mobile_guis = {}
    },
    __config = {
        __curve_names = {'Camera','Random','Accelerated','Backwards','Slow','High'},
        __detections = {
            __infinity=false,__deathslash=false,
            __timehole=false,__slashesoffury=false,__phantom=false
        }
    },
    __triggerbot = {
        __enabled=false,__is_parrying=false,
        __parries=0,__max_parries=10000,__parry_delay=0.5
    }
}

local revertedRemotes = {}
local originalMetatables = {}
local Parry_Key = nil
local PF = nil
local SC = nil

if ReplicatedStorage:FindFirstChild("Controllers") then
    for _, child in ipairs(ReplicatedStorage.Controllers:GetChildren()) do
        if child.Name:match("^SwordsController%s*$") then SC = child end
    end
end

local function update_divisor()
    System.__properties.__divisor_multiplier = 0.7 + (System.__properties.__accuracy - 1) * (0.9/99)
end

local function update_randomized_accuracy()
    if not System.__properties.__randomized_accuracy_enabled then return end
    local ping_str = Stats.Network.ServerStatsItem["Data Ping"]:GetValueString()
    local ping = tonumber(ping_str:match("%d+")) or 0
    local new_accuracy
    if ping >= 90 then new_accuracy = 4
    elseif ping <= 50 then new_accuracy = math.random(70, 100)
    else new_accuracy = System.__properties.__accuracy end
    if new_accuracy then System.__properties.__accuracy = new_accuracy; update_divisor() end
end

task.spawn(function()
    while task.wait(1) do
        if System.__properties.__randomized_accuracy_enabled then update_randomized_accuracy() end
    end
end)

-- ========== REMOTE HOOK ==========
function getCurveCFrame()
    local camera = workspace.CurrentCamera
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return camera.CFrame end
    local closestDot=-math.huge; local targetPos=nil
    if Alive then
        for _,entity in pairs(Alive:GetChildren()) do
            if entity ~= char and entity:FindFirstChild("HumanoidRootPart") then
                local dir=(entity.HumanoidRootPart.Position-camera.CFrame.Position).Unit
                local dot=camera.CFrame.LookVector:Dot(dir)
                if dot > closestDot then closestDot=dot; targetPos=entity.HumanoidRootPart.Position end
            end
        end
    end
    targetPos = targetPos or (root.Position + camera.CFrame.LookVector*1000)
    local toTarget=(targetPos-root.Position).Unit
    local curveMode = System.__properties.__curve_mode or 1
    local curve_functions = {
        function() return camera.CFrame end,
        function()
            local direction=(targetPos-root.Position).Unit
            local random_offset; local attempts=0
            repeat
                random_offset=Vector3.new(math.random(-4000,4000),math.random(-4000,4000),math.random(-4000,4000))
                local curve_direction=(targetPos+random_offset-root.Position).Unit
                local dot=direction:Dot(curve_direction); attempts=attempts+1
            until dot < 0.95 or attempts > 10
            return CFrame.new(root.Position,targetPos+random_offset)
        end,
        function() return CFrame.new(root.Position,targetPos+Vector3.new(0,5,0)) end,
        function()
            local direction=(root.Position-targetPos).Unit
            local backwards_pos=root.Position+direction*10000+Vector3.new(0,1000,0)
            return CFrame.new(camera.CFrame.Position,backwards_pos)
        end,
        function() return CFrame.new(root.Position,targetPos+Vector3.new(0,-9e18,0)) end,
        function() return CFrame.new(root.Position,targetPos+Vector3.new(0,9e18,0)) end
    }
    return curve_functions[curveMode]()
end

local Players = cloneref(game:GetService('Players'))
local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))

local Camera = workspace.CurrentCamera

local PRY = require(ReplicatedStorage:FindFirstChild('PRY', true))

local Network = getupvalue(PRY, 6)
local Constants = getupvalue(PRY, 3)
local Convert = getupvalue(PRY, 4)

local Hash1 = getupvalue(PRY, 8)
local Hash2 = Constants[2]
local Hash3 = function()
    local Constant = Convert(Hash2, 'TIME')
    local Time = tostring(math.floor(workspace:GetServerTimeNow() * 100))
    local Encoded = {}
    for i = 1, #Time do
        local s1 = string.byte(Constant, ((i - 1) % #Constant) + 1)
        Encoded[i] = string.char(bit32.bxor((string.byte(Time, i) + i) % 256, s1))
    end
    return table.concat(Encoded)
end

local ParryRemote = nil; do
    local RemoteName = string.gsub(game.JobId, '-', '')
    local GetRemote = Network.RemoteEvent
    task.spawn(function()
        setthreadidentity(2)
        setfenv(0, getfenv(PRY))
        setfenv(1, getfenv(PRY))
        ParryRemote = GetRemote(Network, RemoteName)
    end)
end

local function fireParry()
    if not (remote and f_raw) then return end
    local cam=workspace.CurrentCamera
    local char=LocalPlayer.Character
    if not char then return end
    local event_data={}
    if Alive then
        for _,entity in pairs(Alive:GetChildren()) do
            if entity.PrimaryPart then
                local ok,sp=pcall(function() return cam:WorldToScreenPoint(entity.PrimaryPart.Position) end)
                if ok then event_data[entity.Name]=sp end
            end
        end
    end
    local viewport=cam.ViewportSize
    local curveCF=getCurveCFrame()
    pcall(function() ParryRemote:FireServer(Hash1, Hash2, Hash3(), 0.025, urveCF, event_data, {viewport.X/2,viewport.Y/2}, false) end)
end

System.animation = {}

-- ========== ANIMATION ==========
local SwordAPI=ReplicatedStorage:WaitForChild("Shared"):WaitForChild("SwordAPI")
local lastplayedd=0; local bypasscd=false; local AnimationDelay=1
local AnimationCache={}; local Grab_Parry=nil

local function GetCharacter() return LocalPlayer.Character end
local function GetHumanoid()
    local char=GetCharacter(); return char and char:FindFirstChildOfClass("Humanoid")
end
local function StopAnimation(track) track:Stop(track:GetAttribute("StopFadeTime") or 0.1) end
local function PlayGrabAnimation(track)
    track:Play(track:GetAttribute("PlayFadeTime") or 0,track:GetAttribute("PlayWeight") or 1,track:GetAttribute("PlaySpeed") or 1)
end
local function GetParryAnimation()
    local char=GetCharacter(); if not char then return nil end
    local currentSword=char:GetAttribute("CurrentlyEquippedSword")
    if not currentSword then return SwordAPI.Collection.Default:FindFirstChild("GrabParry") end
    if AnimationCache[currentSword] then return AnimationCache[currentSword] end
    local ok,swordData=pcall(function() return ReplicatedStorage.Shared.ReplicatedInstances.Swords.GetSword:Invoke(currentSword) end)
    if not ok or type(swordData)~="table" then
        AnimationCache[currentSword]=SwordAPI.Collection.Default:FindFirstChild("GrabParry"); return AnimationCache[currentSword]
    end
    for _,obj in pairs(SwordAPI.Collection:GetChildren()) do
        if obj.Name==swordData.AnimationType then
            local anim=obj:FindFirstChild("GrabParry") or obj:FindFirstChild("Grab")
            if anim then AnimationCache[currentSword]=anim; return anim end
        end
    end
    AnimationCache[currentSword]=SwordAPI.Collection.Default:FindFirstChild("GrabParry"); return AnimationCache[currentSword]
end

function System.animation.play_grab_parry()
    if not System.__properties.__play_animation then
        return
    end
    
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass('Humanoid')
    local animator = humanoid and humanoid:FindFirstChildOfClass('Animator')
    if not humanoid or not animator then return end
    
    local sword_name
    if getgenv().skinChangerEnabled then
        sword_name = getgenv().swordAnimations
    else
        sword_name = character:GetAttribute('CurrentlyEquippedSword')
    end
    if not sword_name then return end
    
    local sword_api = ReplicatedStorage.Shared.SwordAPI.Collection
    local parry_animation = sword_api.Default:FindFirstChild('GrabParry')
    if not parry_animation then return end
    
    local sword_data = ReplicatedStorage.Shared.ReplicatedInstances.Swords.GetSword:Invoke(sword_name)
    if not sword_data or not sword_data['AnimationType'] then return end
    
    for _, object in pairs(sword_api:GetChildren()) do
        if object.Name == sword_data['AnimationType'] then
            if object:FindFirstChild('GrabParry') or object:FindFirstChild('Grab') then
                local animation_type = object:FindFirstChild('GrabParry') and 'GrabParry' or 'Grab'
                parry_animation = object[animation_type]
            end
        end
    end
    
    if System.__properties.__grab_animation and System.__properties.__grab_animation.IsPlaying then
        System.__properties.__grab_animation:Stop()
    end
    
    System.__properties.__grab_animation = animator:LoadAnimation(parry_animation)
    System.__properties.__grab_animation.Priority = Enum.AnimationPriority.Action4
    System.__properties.__grab_animation:Play()
end

local function SpamParry_Animation()
    if (os.clock()-lastplayedd) >= (AnimationDelay-0.8) or bypasscd then
        lastplayedd=os.clock(); bypasscd=false; System.animation.play_grab_parry()
    end
end

pcall(function()
    ReplicatedStorage.Remotes.ParrySuccess.OnClientEvent:Connect(function()
        bypasscd=true
        local humanoid=GetHumanoid()
        if humanoid then
            for _,track in pairs(humanoid.Animator:GetPlayingAnimationTracks()) do
                if track.Name=="GrabParry" or track.Name=="Grab" then StopAnimation(track) end
            end
        end
    end)
end)

System.ball = {}
function System.ball.get()
    local balls=workspace:FindFirstChild('Balls'); if not balls then return nil end
    for _,ball in pairs(balls:GetChildren()) do
        if ball:GetAttribute('realBall') then ball.CanCollide=false; return ball end
    end; return nil
end
function System.ball.get_all()
    local balls_table={}; local balls=workspace:FindFirstChild('Balls')
    if not balls then return balls_table end
    for _,ball in pairs(balls:GetChildren()) do
        if ball:GetAttribute('realBall') then ball.CanCollide=false; table.insert(balls_table,ball) end
    end; return balls_table
end

System.player = {}
local Closest_Entity=nil; local last_closest_check=0
function System.player.get_closest()
    local now=tick()
    if now-last_closest_check < 0.1 then return Closest_Entity end
    last_closest_check=now
    local max_distance=math.huge; local closest_entity=nil
    if not Alive then return nil end
    for _,entity in pairs(Alive:GetChildren()) do
        if entity ~= LocalPlayer.Character and entity.PrimaryPart then
            local distance=LocalPlayer:DistanceFromCharacter(entity.PrimaryPart.Position)
            if distance < max_distance then max_distance=distance; closest_entity=entity end
        end
    end
    Closest_Entity=closest_entity; return closest_entity
end

function System.player.get_closest_to_cursor()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild('HumanoidRootPart') then return nil end
    local closest_player=nil; local minimal_dot=-math.huge; local camera=workspace.CurrentCamera
    if not Alive then return nil end
    local ok,mouse_location=pcall(function() return UserInputService:GetMouseLocation() end)
    if not ok then return nil end
    local ray=camera:ScreenPointToRay(mouse_location.X,mouse_location.Y)
    local pointer=CFrame.lookAt(ray.Origin,ray.Origin+ray.Direction)
    for _,player in pairs(Alive:GetChildren()) do
        if player==LocalPlayer.Character then continue end
        if not player:FindFirstChild('HumanoidRootPart') then continue end
        local direction=(player.HumanoidRootPart.Position-camera.CFrame.Position).Unit
        local dot=pointer.LookVector:Dot(direction)
        if dot > minimal_dot then minimal_dot=dot; closest_player=player end
    end
    return closest_player
end

System.curve = {}
function System.curve.get_cframe() return getCurveCFrame() end
local function Parry()
    local PlayerPositions = {}
    for _, char in next, workspace.Alive:GetChildren() do
        if char:FindFirstChild('HumanoidRootPart') then
            PlayerPositions[char.Name] = char.HumanoidRootPart.Position
        end
    end
    local CameraCenter = Camera.ViewportSize / 2
    local CameraData = {CameraCenter.X, CameraCenter.Y}
    ParryRemote:FireServer(Hash1, Hash2, Hash3(), 0.025, Camera.CFrame, PlayerPositions, CameraData, false)
end
System.parry = {}
function System.parry.execute()
    if System.__properties.__parries > 10000 or not LocalPlayer.Character then return end
    Parry()
    if System.__properties.__parries > 10000 then return end
    System.__properties.__parries=System.__properties.__parries+1
    task.delay(0.5,function() if System.__properties.__parries > 0 then System.__properties.__parries=System.__properties.__parries-1 end end)
end

function System.parry.keypress()
    if System.__properties.__parries > 10000 or not LocalPlayer.Character then return end
    fireParry()
    if System.__properties.__parries > 10000 then return end
    System.__properties.__parries=System.__properties.__parries+1
    task.delay(0.5,function() if System.__properties.__parries > 0 then System.__properties.__parries=System.__properties.__parries-1 end end)
end

function System.parry.execute_action()
    System.animation.play_grab_parry(); System.parry.execute()
end

local function linear_predict(a,b,t) return a+(b-a)*t end

System.detection = {
    __ball_properties = {__aerodynamic_time=tick(),__last_warping=tick(),__lerp_radians=0,__curving=tick()}
}

function System.detection.is_curved()
    local props=System.detection.__ball_properties
    local ball=System.ball.get(); if not ball then return false end
    local zoomies=ball:FindFirstChild("zoomies"); if not zoomies then return false end
    local velocity=zoomies.VectorVelocity; local speed=velocity.Magnitude
    if speed < 1 then return false end
    local ball_dir=velocity.Unit; local char=LocalPlayer.Character
    if not char or not char.PrimaryPart then return false end
    local pos=char.PrimaryPart.Position; local direction=(pos-ball.Position).Unit
    local dot=direction:Dot(ball_dir)
    local ping=Stats.Network.ServerStatsItem["Data Ping"]:GetValue()/1000
    local distance=(pos-ball.Position).Magnitude; local reach_time=distance/speed-ping
    local dot_threshold=math.clamp(0.55-(ping*0.75),-1,0.45)
    local speed_threshold=math.min(speed/100,45)
    local ball_distance_threshold=15-math.min(distance/1000,15)+speed_threshold
    local clamped_dot=math.clamp(dot,-1,1); local radians=math.asin(clamped_dot)
    props.__lerp_radians=linear_predict(props.__lerp_radians,radians,0.85)
    if props.__lerp_radians < 0.016 then props.__last_warping=tick() end
    if distance < (ball_distance_threshold*0.85) then return false end
    if (tick()-props.__last_warping) < (reach_time/1.4) then return true end
    if (tick()-props.__curving) < (reach_time/1.1) then return true end
    return dot < dot_threshold
end

ReplicatedStorage.Remotes.DeathBall.OnClientEvent:Connect(function(c,d)
    System.__properties.__deathslash_active = d or false
end)
ReplicatedStorage.Remotes.InfinityBall.OnClientEvent:Connect(function(a,b)
    System.__properties.__infinity_active = b or false
end)

ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net["RE/TimeHoleActivate"].OnClientEvent:Connect(function(...)
    local args={...}; local player=args[1]
    if player==LocalPlayer or player==LocalPlayer.Name or (player and player.Name==LocalPlayer.Name) then
        System.__properties.__timehole_active=true
    end
end)
ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net["RE/TimeHoleDeactivate"].OnClientEvent:Connect(function()
    System.__properties.__timehole_active=false
end)

local maxParryCount=36; local parryDelay=0.05

ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net["RE/SlashesOfFuryActivate"].OnClientEvent:Connect(function(...)
    local args={...}; local player=args[1]
    if player==LocalPlayer or player==LocalPlayer.Name or (player and player.Name==LocalPlayer.Name) then
        System.__properties.__slashesoffury_active=true; System.__properties.__slashesoffury_count=0
    end
end)
ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net["RE/SlashesOfFuryEnd"].OnClientEvent:Connect(function()
    System.__properties.__slashesoffury_active=false; System.__properties.__slashesoffury_count=0
end)
ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net["RE/SlashesOfFuryParry"].OnClientEvent:Connect(function()
    System.__properties.__slashesoffury_count=System.__properties.__slashesoffury_count+1
end)
ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net["RE/SlashesOfFuryCatch"].OnClientEvent:Connect(function()
    spawn(function()
        while System.__properties.__slashesoffury_active and System.__properties.__slashesoffury_count < maxParryCount do
            if System.__config.__detections.__slashesoffury then System.parry.execute(); task.wait(parryDelay)
            else break end
        end
    end)
end)

Runtime.ChildAdded:Connect(function(Object)
    if System.__config.__detections.__phantom then
        if Object.Name=="maxTransmission" or Object.Name=="transmissionpart" then
            local Weld=Object:FindFirstChildWhichIsA("WeldConstraint")
            if Weld then
                local Character=LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                if Character and Weld.Part1==Character.HumanoidRootPart then
                    local CurrentBall=System.ball.get(); Weld:Destroy()
                    if CurrentBall then
                        local FocusConnection
                        FocusConnection=RunService.RenderStepped:Connect(function()
                            local Highlighted=CurrentBall:GetAttribute("highlighted")
                            if Highlighted==true then
                                ReplicatedStorage.Remotes.AbilityButtonPress:Fire()
                                System.__properties.__parried=true
                                task.delay(1,function() System.__properties.__parried=false end)
                            elseif Highlighted==false then FocusConnection:Disconnect() end
                        end)
                        task.delay(3,function() if FocusConnection and FocusConnection.Connected then FocusConnection:Disconnect() end end)
                    end
                end
            end
        end
    end
end)

ReplicatedStorage.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(_,root)
    if root.Parent and root.Parent ~= LocalPlayer.Character then
        if not Alive or root.Parent.Parent ~= Alive then return end
    end
    local closest=System.player.get_closest(); local ball=System.ball.get()
    if not ball or not closest then return end
    local target_distance=(LocalPlayer.Character.PrimaryPart.Position-closest.PrimaryPart.Position).Magnitude
    local distance=(LocalPlayer.Character.PrimaryPart.Position-ball.Position).Magnitude
    local direction=(LocalPlayer.Character.PrimaryPart.Position-ball.Position).Unit
    local dot=direction:Dot(ball.AssemblyLinearVelocity.Unit)
    local curve_detected=System.detection.is_curved()
    if target_distance < 15 and distance < 15 and dot > -0.25 then
        if curve_detected then System.parry.execute_action() end
    end
    if System.__properties.__grab_animation then System.__properties.__grab_animation:Stop() end
end)

ReplicatedStorage.Remotes.ParrySuccess.OnClientEvent:Connect(function()
    if not Alive or LocalPlayer.Character.Parent ~= Alive then return end
    if System.__properties.__grab_animation then System.__properties.__grab_animation:Stop() end
end)

ReplicatedStorage.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(a,b)
    local Primary_Part=LocalPlayer.Character.PrimaryPart
    local Ball=System.ball.get(); if not Ball then return end
    local Zoomies=Ball:FindFirstChild('zoomies'); if not Zoomies then return end
    local Speed=Zoomies.VectorVelocity.Magnitude
    local Distance=(LocalPlayer.Character.PrimaryPart.Position-Ball.Position).Magnitude
    local Velocity=Zoomies.VectorVelocity; local Ball_Direction=Velocity.Unit
    local Direction=(LocalPlayer.Character.PrimaryPart.Position-Ball.Position).Unit
    local Dot=Direction:Dot(Ball_Direction)
    local Pings=Stats.Network.ServerStatsItem['Data Ping']:GetValue()
    local Speed_Threshold=math.min(Speed/100,40)
    local Reach_Time=Distance/Speed-(Pings/1000)
    local Enough_Speed=Speed > 1
    local Ball_Distance_Threshold=15-math.min(Distance/1000,15)+Speed_Threshold
    if Enough_Speed and Reach_Time > Pings/10 then
        Ball_Distance_Threshold=math.max(Ball_Distance_Threshold-15,15)
    end
    if b ~= Primary_Part and Distance > Ball_Distance_Threshold then
        System.detection.__ball_properties.__curving=tick()
    end
end)

System.triggerbot = {}
function System.triggerbot.trigger(ball)
    if System.__triggerbot.__is_parrying or System.__triggerbot.__parries > System.__triggerbot.__max_parries then return end
    if LocalPlayer.Character and LocalPlayer.Character.PrimaryPart and
       LocalPlayer.Character.PrimaryPart:FindFirstChild('SingularityCape') then return end
    System.__triggerbot.__is_parrying=true; System.__triggerbot.__parries=System.__triggerbot.__parries+1
    System.animation.play_grab_parry(); System.parry.execute()
    task.delay(System.__triggerbot.__parry_delay,function()
        if System.__triggerbot.__parries > 0 then System.__triggerbot.__parries=System.__triggerbot.__parries-1 end
    end)
    local connection
    connection=ball:GetAttributeChangedSignal('target'):Once(function()
        System.__triggerbot.__is_parrying=false
        if connection then connection:Disconnect() end
    end)
    task.spawn(function()
        local start_time=tick()
        repeat RunService.Heartbeat:Wait()
        until (tick()-start_time >= 1 or not System.__triggerbot.__is_parrying)
        System.__triggerbot.__is_parrying=false
    end)
end

function System.triggerbot.loop()
    if not System.__triggerbot.__enabled then return end
    if LocalPlayer.Character and LocalPlayer.Character.PrimaryPart and
       LocalPlayer.Character.PrimaryPart:FindFirstChild('SingularityCape') then return end
    local balls=workspace:FindFirstChild('Balls'); if not balls then return end
    for _,ball in pairs(balls:GetChildren()) do
        if ball:IsA('BasePart') and ball:GetAttribute('target')==LocalPlayer.Name then
            System.triggerbot.trigger(ball); break
        end
    end
end

function System.triggerbot.enable(enabled)
    System.__triggerbot.__enabled=enabled
    if enabled then
        if not System.__properties.__connections.__triggerbot then
            System.__properties.__connections.__triggerbot=RunService.Heartbeat:Connect(System.triggerbot.loop)
        end
    else
        if System.__properties.__connections.__triggerbot then
            System.__properties.__connections.__triggerbot:Disconnect()
            System.__properties.__connections.__triggerbot=nil
        end
        System.__triggerbot.__is_parrying=false; System.__triggerbot.__parries=0
    end
end

System.manual_spam = {}
local manualSpamThread=nil
local macroSpamActive=false; local macroSpamPanelVisible=false
local macroFrameFireCount=0; local macroFrameTime=0; local macroRealCPS=0; local macroAnimFix=true

function System.manual_spam.start()
    System.manual_spam.stop()
    System.__properties.__manual_spam_enabled=true; macroSpamActive=true
    local parry_keypress=System.parry.keypress; local parry_execute=System.parry.execute
    local play_animation=System.animation.play_grab_parry; local threshold=0.015
    manualSpamThread=coroutine.create(function()
        local last_spam=0
        while System.__properties.__manual_spam_enabled do
            local now=os.clock()
            if now-last_spam >= threshold then
                last_spam=now
                if getgenv().ManualSpamMode=="Keypress" then parry_keypress()
                else parry_execute(); if getgenv().ManualSpamAnimationFix then play_animation(); SpamParry_Animation() end end
            end
            coroutine.yield()
        end
    end)
    task.spawn(function()
        while System.__properties.__manual_spam_enabled and manualSpamThread
              and coroutine.status(manualSpamThread) ~= "dead" do
            coroutine.resume(manualSpamThread); task.wait()
        end
    end)
end

function System.manual_spam.stop()
    System.__properties.__manual_spam_enabled=false; macroSpamActive=false; manualSpamThread=nil
end

RunService.Heartbeat:Connect(function(dt)
    macroFrameTime=macroFrameTime+dt
    if macroFrameTime >= 0.1 then
        if macroSpamActive then macroRealCPS=math.floor(macroFrameFireCount/macroFrameTime) end
        macroFrameFireCount=0; macroFrameTime=0
    end
    if macroSpamActive and remote and f_raw then
        pcall(function() fireParry(); macroFrameFireCount=macroFrameFireCount+1 end)
        if macroAnimFix then SpamParry_Animation() end
    end
end)

System.auto_spam = {}
local autoSpamThread=nil

function System.auto_spam:get_entity_properties()
    local entity=Closest_Entity; if not entity or not entity.PrimaryPart then return false end
    local char=LocalPlayer.Character; if not char or not char.PrimaryPart then return false end
    local root_pos=char.PrimaryPart.Position; local entity_pos=entity.PrimaryPart.Position
    local diff=root_pos-entity_pos
    return {Velocity=entity.PrimaryPart.Velocity,Direction=diff.Unit,Distance=diff.Magnitude}
end

function System.auto_spam:get_ball_properties()
    local ball=System.ball.get(); if not ball then return false end
    local char=LocalPlayer.Character; if not char or not char.PrimaryPart then return false end
    local ball_pos=ball.Position; local root_pos=char.PrimaryPart.Position; local diff=root_pos-ball_pos
    local ball_velocity=ball.AssemblyLinearVelocity or Vector3.zero
    return {Velocity=ball_velocity,Direction=diff.Unit,Distance=diff.Magnitude,Dot=diff.Unit:Dot(ball_velocity.Unit)}
end

function System.auto_spam.spam_service(self)
    local ball=System.ball.get(); local entity=System.player.get_closest()
    if not ball or not entity or not entity.PrimaryPart then return false end
    local spam_accuracy=0; local velocity=ball.AssemblyLinearVelocity or Vector3.zero; local speed=velocity.Magnitude
    local direction=(LocalPlayer.Character.PrimaryPart.Position-ball.Position).Unit; local dot=direction:Dot(velocity.Unit)
    local target_position=entity.PrimaryPart.Position; local target_distance=LocalPlayer:DistanceFromCharacter(target_position)
    local multiplier=System.__properties.__auto_spam_distance_multiplier or 1.0
    local base_distance=30*multiplier; local maximum_spam_distance=(self.Ping+math.min(speed/4,60))*multiplier
    if self.Entity_Properties.Distance > maximum_spam_distance and self.Entity_Properties.Distance > base_distance then return 0 end
    if self.Ball_Properties.Distance > maximum_spam_distance and self.Ball_Properties.Distance > base_distance then return 0 end
    if target_distance > maximum_spam_distance and target_distance > base_distance then return 0 end
    local maximum_speed=7-math.min(speed/5,5); local maximum_dot=math.clamp(dot,-1,1)*maximum_speed
    spam_accuracy=maximum_spam_distance-maximum_dot; return spam_accuracy
end

function System.auto_spam.start()
    if System.__properties.__connections.__auto_spam_connection then
        System.__properties.__connections.__auto_spam_connection:Disconnect()
    end
    System.__properties.__auto_spam_enabled=true
    local last_auto_spam=0; local last_target_check=0; local event=RunService.Heartbeat
    local get_ball=System.ball.get; local get_closest=System.player.get_closest
    local parry_keypress=System.parry.keypress; local parry_execute=System.parry.execute
    local play_animation=System.animation.play_grab_parry
    System.__properties.__connections.__auto_spam_connection=event:Connect(function()
        local char=LocalPlayer.Character
        if not System.__properties.__auto_spam_enabled or not char or char.Parent ~= Alive then return end
        local now=tick(); local threshold=0.015
        if now-last_auto_spam < threshold then return end; last_auto_spam=now
        local ball=get_ball(); if not ball then return end
        local zoomies=ball:FindFirstChild('zoomies'); if not zoomies then return end
        if now-last_target_check > 0.1 then
            get_closest(); last_target_check=now
            if System.__properties.__spam_target then
                local target=System.__properties.__spam_target
                if not target.Parent or not target:FindFirstChild("Humanoid") or target.Humanoid.Health <= 0 then
                    System.__properties.__spam_target=nil; System.__properties.__spam_target_time=0
                end
            end
            if not System.__properties.__spam_target or (now-System.__properties.__spam_target_time > 1) then
                System.__properties.__spam_target=Closest_Entity; System.__properties.__spam_target_time=now
            end
        end
        local ball_target=ball:GetAttribute('target'); if not ball_target then return end
        local ball_properties=System.auto_spam:get_ball_properties()
        local entity_properties=System.auto_spam:get_entity_properties()
        if ball_properties and entity_properties then
            local ping=Stats.Network.ServerStatsItem['Data Ping']:GetValue()
            local ping_threshold=math.clamp(ping/5,1,16)
            local spam_accuracy=System.auto_spam.spam_service({
                Ball_Properties=ball_properties,Entity_Properties=entity_properties,Ping=ping_threshold
            })
            if spam_accuracy > 0 then
                local root=char.PrimaryPart; if not root then return end
                local target_entity=Closest_Entity; if not target_entity or not target_entity.PrimaryPart then return end
                local target_pos=target_entity.PrimaryPart.Position
                local target_dist=(root.Position-target_pos).Magnitude
                local ball_pos=ball.Position; local dist_to_ball=(root.Position-ball_pos).Magnitude
                local shouldSpam=false; local spam_target=System.__properties.__spam_target
                if spam_target then
                    if ball_target==spam_target.Name or ball_target==LocalPlayer.Name then shouldSpam=true end
                end
                if shouldSpam and not char:GetAttribute('Pulsed') then
                    if target_dist <= spam_accuracy and dist_to_ball <= spam_accuracy then
                        local mult=System.__properties.__auto_spam_distance_multiplier or 1.0
                        local max_allowed_dist=35*mult
                        local is_target=(ball_target==LocalPlayer.Name)
                        local final_max_dist=is_target and max_allowed_dist or (max_allowed_dist*0.8)
                        if target_dist <= final_max_dist and dist_to_ball <= final_max_dist then
                            if System.__properties.__parries > System.__properties.__spam_threshold then
                                if getgenv().AutoSpamMode=="Keypress" then parry_keypress()
                                else parry_execute()
                                    if getgenv().AutoSpamAnimationFix then play_animation(); SpamParry_Animation() end
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end

function System.auto_spam.stop()
    System.__properties.__auto_spam_enabled=false
    System.__properties.__spam_target=nil; System.__properties.__spam_target_time=0; autoSpamThread=nil
end

System.autoparry = {}
function System.autoparry.start()
    if System.__properties.__connections.__autoparry then
        System.__properties.__connections.__autoparry:Disconnect()
    end
    System.__properties.__connections.__autoparry=RunService.PreSimulation:Connect(function()
        if not System.__properties.__autoparry_enabled or not LocalPlayer.Character or
           not LocalPlayer.Character.PrimaryPart then return end
        local balls=System.ball.get_all(); local one_ball=System.ball.get()
        local training_ball=nil
        if workspace:FindFirstChild("TrainingBalls") then
            for _,Instance in pairs(workspace.TrainingBalls:GetChildren()) do
                if Instance:GetAttribute("realBall") then training_ball=Instance; break end
            end
        end
        for _,ball in pairs(balls) do
            if System.__triggerbot.__enabled then return end
            if getgenv().BallVelocityAbove800 then return end
            if not ball then continue end
            local zoomies=ball:FindFirstChild('zoomies'); if not zoomies then continue end
            ball:GetAttributeChangedSignal('target'):Once(function() System.__properties.__parried=false end)
            if System.__properties.__parried then continue end
            local ball_target=ball:GetAttribute('target')
            local velocity=zoomies.VectorVelocity
            local distance=(LocalPlayer.Character.PrimaryPart.Position-ball.Position).Magnitude
            local ping=Stats.Network.ServerStatsItem['Data Ping']:GetValue()/10
            local ping_threshold=math.clamp(ping/10,5,17); local speed=velocity.Magnitude
            local capped_speed_diff=math.min(math.max(speed-9.5,0),650)
            local speed_divisor=(2.4+capped_speed_diff*0.002)*System.__properties.__divisor_multiplier
            local parry_accuracy=ping_threshold+math.max(speed/speed_divisor,9.5)
            local curved=System.detection.is_curved()
            if ball:FindFirstChild('AeroDynamicSlashVFX') then
                ball.AeroDynamicSlashVFX:Destroy(); System.__properties.__tornado_time=tick()
            end
            if Runtime:FindFirstChild('Tornado') then
                if (tick()-System.__properties.__tornado_time) <
                   (Runtime.Tornado:GetAttribute('TornadoTime') or 1)+0.314159 then continue end
            end
            if one_ball and one_ball:GetAttribute('target')==LocalPlayer.Name and curved then continue end
            if ball:FindFirstChild('ComboCounter') then continue end
            if LocalPlayer.Character.PrimaryPart:FindFirstChild('SingularityCape') then continue end
            if System.__config.__detections.__infinity and System.__properties.__infinity_active then continue end
            if System.__config.__detections.__deathslash and System.__properties.__deathslash_active then continue end
            if System.__config.__detections.__timehole and System.__properties.__timehole_active then continue end
            if System.__config.__detections.__slashesoffury and System.__properties.__slashesoffury_active then continue end
            if ball_target==LocalPlayer.Name and distance <= parry_accuracy then
                if getgenv().AutoAbility then
                    local AbilityCD=LocalPlayer.PlayerGui.Hotbar.Ability.UIGradient
                    if AbilityCD and AbilityCD.Offset.Y==0.5 then
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Abilities") then
                            local abilities=LocalPlayer.Character.Abilities
                            if (abilities:FindFirstChild("Raging Deflection") and abilities["Raging Deflection"].Enabled) or
                               (abilities:FindFirstChild("Rapture") and abilities["Rapture"].Enabled) or
                               (abilities:FindFirstChild("Calming Deflection") and abilities["Calming Deflection"].Enabled) or
                               (abilities:FindFirstChild("Aerodynamic Slash") and abilities["Aerodynamic Slash"].Enabled) or
                               (abilities:FindFirstChild("Fracture") and abilities["Fracture"].Enabled) or
                               (abilities:FindFirstChild("Death Slash") and abilities["Death Slash"].Enabled) then
                                System.__properties.__parried=true
                                ReplicatedStorage.Remotes.AbilityButtonPress:Fire()
                                task.wait(2.432)
                                ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
                                continue
                            end
                        end
                    end
                end
            end
            if ball_target==LocalPlayer.Name and distance <= parry_accuracy then
                if getgenv().AutoParryMode=="Keypress" then System.parry.keypress()
                else System.parry.execute_action() end
                System.__properties.__parried=true
            end
            local last_parrys=tick()
            repeat RunService.Stepped:Wait()
            until (tick()-last_parrys) >= 1 or not System.__properties.__parried
            System.__properties.__parried=false
        end
        if training_ball then
            local zoomies=training_ball:FindFirstChild('zoomies')
            if zoomies then
                training_ball:GetAttributeChangedSignal('target'):Once(function() System.__properties.__training_parried=false end)
                if not System.__properties.__training_parried then
                    local ball_target=training_ball:GetAttribute('target')
                    local velocity=zoomies.VectorVelocity
                    local distance=LocalPlayer:DistanceFromCharacter(training_ball.Position)
                    local speed=velocity.Magnitude
                    local ping=Stats.Network.ServerStatsItem['Data Ping']:GetValue()/10
                    local ping_threshold=math.clamp(ping/10,5,17)
                    local capped_speed_diff=math.min(math.max(speed-9.5,0),650)
                    local speed_divisor=(2.4+capped_speed_diff*0.002)*System.__properties.__divisor_multiplier
                    local parry_accuracy=ping_threshold+math.max(speed/speed_divisor,9.5)
                    if ball_target==LocalPlayer.Name and distance <= parry_accuracy then
                        if getgenv().AutoParryMode=="Keypress" then System.parry.keypress()
                        else System.parry.execute_action() end
                        System.__properties.__training_parried=true
                        local last_parrys=tick()
                        repeat RunService.Stepped:Wait()
                        until (tick()-last_parrys) >= 1 or not System.__properties.__training_parried
                        System.__properties.__training_parried=false
                    end
                end
            end
        end
    end)
end

function System.autoparry.stop()
    if System.__properties.__connections.__autoparry then
        System.__properties.__connections.__autoparry:Disconnect()
        System.__properties.__connections.__autoparry=nil
    end
end

local function create_mobile_button(name,position_y,color)
    local gui=Instance.new('ScreenGui'); gui.Name='Eagle hub'..name..'Mobile'
    gui.ResetOnSpawn=false; gui.IgnoreGuiInset=true; gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
    local button=Instance.new('TextButton')
    button.Size=UDim2.new(0,140,0,50); button.Position=UDim2.new(0.5,-70,position_y,0)
    button.BackgroundTransparency=1; button.AnchorPoint=Vector2.new(0.5,0)
    button.Draggable=true; button.AutoButtonColor=false; button.ZIndex=2
    local bg=Instance.new('Frame'); bg.Size=UDim2.new(1,0,1,0); bg.BackgroundColor3=Color3.fromRGB(40,40,40); bg.Parent=button
    Instance.new('UICorner',bg).CornerRadius=UDim.new(0,10)
    local stroke=Instance.new('UIStroke',bg); stroke.Color=color; stroke.Thickness=1; stroke.Transparency=0.3
    local text=Instance.new('TextLabel'); text.Size=UDim2.new(1,0,1,0); text.BackgroundTransparency=1
    text.Text=name; text.Font=Enum.Font.GothamBold; text.TextSize=16; text.TextColor3=Color3.fromRGB(255,255,255)
    text.ZIndex=3; text.Parent=button; button.Parent=gui; gui.Parent=CoreGui
    return {gui=gui,button=button,text=text,bg=bg}
end

local function destroy_mobile_gui(gui_data)
    if gui_data and gui_data.gui then gui_data.gui:Destroy() end
end

-- ========== AVATAR CHANGER (Airflow Style) ==========
local __av_flags={}; local __av_persistent={}
local function __av_match(a,b)
    if not a or not b then return false end
    for _,k in ipairs({"Shirt","Pants","ShirtGraphic","Head","Face","BodyTypeScale","HeightScale","WidthScale"}) do
        local av,bv=a[k],b[k]
        if av~=nil and bv~=nil and tostring(av)~=tostring(bv) then return false end
    end; return true
end
local function __av_force_apply(hum,desc)
    if not hum or not desc then return false end
    for _=1,20 do
        pcall(function() hum:ApplyDescriptionClientServer(desc) end); task.wait(0.05)
        local ok,ap=pcall(function() return hum:GetAppliedDescription() end)
        if ok and ap and __av_match(ap,desc) then return true end
    end
    pcall(function() hum.Description=Instance.new("HumanoidDescription") end); task.wait(0.1)
    for _=1,40 do
        pcall(function() hum:ApplyDescriptionClientServer(desc) end); task.wait(0.05)
        local ok,ap=pcall(function() return hum:GetAppliedDescription() end)
        if ok and ap and __av_match(ap,desc) then return true end
    end; return false
end
local function __av_start_persistent(char,desc)
    if not char or not desc then return end
    local key=char; if __av_persistent[key] then return end
    local stop=false; __av_persistent[key]={stop=function() stop=true end}
    task.spawn(function()
        local hum=char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid",5)
        if not hum then __av_persistent[key]=nil; return end
        while not stop and char.Parent do
            pcall(function() __av_force_apply(hum,desc) end)
            local ok,ap=pcall(function() return hum:GetAppliedDescription() end)
            if ok and ap and __av_match(ap,desc) then
                for _=1,40 do if stop or not char.Parent then break end; task.wait(0.25) end
            else
                for _=1,20 do if stop or not char.Parent then break end
                    pcall(function() hum:ApplyDescriptionClientServer(desc) end); task.wait(0.1)
                end
            end
            if not hum.Parent then hum=char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid",5) end
        end
        __av_persistent[key]=nil
    end)
end
local function __av_stop_all()
    for k,v in pairs(__av_persistent) do
        if v and type(v.stop)=="function" then pcall(v.stop) end; __av_persistent[k]=nil
    end
end
local function __av_set(name,char)
    if not name or name=="" then return end
    local hum=char and char:WaitForChild("Humanoid",5); if not hum then return end
    local ok,desc=pcall(function()
        local id=Players:GetUserIdFromNameAsync(name); return Players:GetHumanoidDescriptionFromUserId(id)
    end)
    if not ok or not desc then return end
    pcall(function() LocalPlayer:ClearCharacterAppearance(); hum.Description=Instance.new("HumanoidDescription") end)
    task.wait(0.05); pcall(function() __av_force_apply(hum,desc) end); __av_start_persistent(char,desc)
end

-- ========== SKIN CHANGER (Airflow Style - tam versia) ==========
local swordInstancesInstance = ReplicatedStorage:WaitForChild("Shared",9e9):WaitForChild("ReplicatedInstances",9e9):WaitForChild("Swords",9e9)
local swordInstances = require(swordInstancesInstance)
local swordsController

task.spawn(function()
    while task.wait() and not swordsController do
        for i,v in getconnections(ReplicatedStorage.Remotes.FireSwordInfo.OnClientEvent) do
            if v.Function and islclosure(v.Function) then
                local upvalues=getupvalues(v.Function)
                if #upvalues==1 and type(upvalues[1])=="table" then
                    swordsController=upvalues[1]; break
                end
            end
        end
    end
end)

local function getSlashName(swordName)
    local s=swordInstances:GetSword(swordName)
    return (s and s.SlashName) or "SlashEffect"
end

local function refreshSlashName()
    local fn=getgenv().swordFX~="" and getgenv().swordFX or getgenv().swordModel
    getgenv().slashName = fn~="" and getSlashName(fn) or "SlashEffect"
end

local function setSword()
    if not getgenv().skinChangerEnabled or not LocalPlayer.Character then return end
    pcall(function()
        local f=rawget(swordInstances,"EquipSwordTo")
        if type(f)=="function" then
            local ups=getupvalues(f)
            for i=1,#ups do if type(ups[i])=="boolean" then setupvalue(f,i,false); break end end
        end
    end)
    if getgenv().changeSwordModel and getgenv().swordModel~="" then
        pcall(function() swordInstances:EquipSwordTo(LocalPlayer.Character,getgenv().swordModel) end)
    end
    task.spawn(function()
        local att=0
        while not swordsController and att<20 do task.wait(0.5); att=att+1 end
        if not swordsController then return end
        if getgenv().changeSwordAnimation then
            pcall(function()
                if swordsController.SetSword then
                    swordsController:SetSword(getgenv().swordAnimations~="" and getgenv().swordAnimations or getgenv().swordModel)
                end
            end)
        end
        pcall(function()
            refreshSlashName()
            if swordsController.currentSword~=nil then
                pcall(function() swordsController.currentSword=getgenv().swordFX~="" and getgenv().swordFX or getgenv().swordModel end)
            end
            if swordsController.SwordFX~=nil then
                pcall(function() swordsController.SwordFX=getgenv().swordFX~="" and getgenv().swordFX or getgenv().swordModel end)
            end
        end)
    end)
end

refreshSlashName()

local hookedFuncs={}
task.spawn(function()
    while task.wait(1) do
        local ok,conns=pcall(getconnections,ReplicatedStorage.Remotes.ParrySuccessAll.OnClientEvent)
        if ok and type(conns)=="table" then
            for _,v in ipairs(conns) do
                local func=v.Function
                if func and not hookedFuncs[func] then
                    if isourclosure and isourclosure(func) then hookedFuncs[func]=true; continue end
                    hookedFuncs[func]=true; v:Disable()
                    local tf=func; local of
                    of=function(...)
                        local args={...}
                        if tostring(args[4])==LocalPlayer.Name and getgenv().skinChangerEnabled then
                            refreshSlashName(); args[1]=getgenv().slashName
                            args[3]=getgenv().swordFX~="" and getgenv().swordFX or getgenv().swordModel
                        end
                        if setthreadidentity then pcall(setthreadidentity,2) end
                        pcall(tf,unpack(args))
                    end
                    hookedFuncs[of]=true
                    ReplicatedStorage.Remotes.ParrySuccessAll.OnClientEvent:Connect(of)
                end
            end
        end
    end
end)

getgenv().updateSword = function()
    refreshSlashName(); setSword()
end

task.spawn(function()
    while task.wait(1) do
        if getgenv().skinChangerEnabled and getgenv().swordModel~="" then
            local char=LocalPlayer.Character
            if char then
                if LocalPlayer:GetAttribute("CurrentlyEquippedSword")~=getgenv().swordModel then setSword() end
                if not char:FindFirstChild(getgenv().swordModel) then setSword() end
                for _,v in char:GetChildren() do
                    if v:IsA("Model") and v.Name~=getgenv().swordModel then v:Destroy() end
                    task.wait()
                end
            end
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    if getgenv().skinChangerEnabled then
        getgenv().skinChangerEnabled=false; task.wait(2)
        getgenv().skinChangerEnabled=true; task.wait(0.5)
        pcall(function() getgenv().updateSword() end)
    end
end)

-- ========== GETGENV INIT ==========
getgenv().AutoParryMode="Remote"; getgenv().AutoParryNotify=false
getgenv().CooldownProtection=false; getgenv().AutoAbility=false
getgenv().TriggerbotNotify=false; getgenv().AutoCurveHotkeyNotify=false
getgenv().AutoCurveHotkeyEnabled=false; getgenv().InfinityNotify=false
getgenv().ManualSpamNotify=false; getgenv().ManualSpamMode="Remote"
getgenv().ManualSpamAnimationFix=false; getgenv().AutoSpamNotify=false
getgenv().AutoSpamMode="Remote"; getgenv().AutoSpamAnimationFix=false
getgenv().AutoStop=false; getgenv().CameraEnabled=false; getgenv().CameraFOV=70
getgenv().CharacterModifierEnabled=false; getgenv().WalkspeedCheckboxEnabled=false
getgenv().CustomWalkSpeed=36; getgenv().JumpPowerCheckboxEnabled=false
getgenv().CustomJumpPower=50; getgenv().SpinbotCheckboxEnabled=false
getgenv().CustomSpinSpeed=5; getgenv().GravityCheckboxEnabled=false
getgenv().CustomGravity=196.2; getgenv().HipHeightCheckboxEnabled=false
getgenv().CustomHipHeight=0; getgenv().InfiniteJumpCheckboxEnabled=false
getgenv().skinChangerEnabled=false; getgenv().changeSwordModel=true
getgenv().changeSwordAnimation=true; getgenv().changeSwordFX=true
getgenv().swordModel=""; getgenv().swordAnimations=""; getgenv().swordFX=""
getgenv().slashName="SlashEffect"; getgenv().AutoVote=false

-- ========== KEYBIND STATE ==========
local spamKeyCode  = Enum.KeyCode.E
local trigKeyCode  = Enum.KeyCode.R

-- ========== UI TABS ==========

-- AUTO PARRY
local autoparry_section = Tabs.Rage:AddSection("Auto Parry", "shield")

autoparry_section:AddToggle("AutoParryToggle", {
    Title = "Auto Parry",
    Description = "Automatically parries ball",
    Default = false,
    Callback = function(value)
        System.__properties.__autoparry_enabled=value
        System.__properties.__play_animation=value
        if value then System.autoparry.start() else System.autoparry.stop() end
        if getgenv().AutoParryNotify then Fluent:Notify({Title="Auto Parry",Content=value and "ON" or "OFF",Duration=2}) end
    end
})

autoparry_section:AddDropdown("ParryMode", {
    Title="Parry Mode", Values={"Remote","Keypress"}, Default="Remote", Multi=false,
    Callback=function(value) getgenv().AutoParryMode=value end
})

autoparry_section:AddDropdown("ModeCurve", {
    Title="Mode curve", Values=System.__config.__curve_names, Default="Camera", Multi=false,
    Callback=function(value)
        for i,name in ipairs(System.__config.__curve_names) do
            if name==value then System.__properties.__curve_mode=i; break end
        end
    end
})

autoparry_section:AddSlider("ParryAccuracy", {
    Title="Accuracy", Default=50, Min=1, Max=100, Rounding=1,
    Callback=function(value) System.__properties.__accuracy=value; update_divisor() end
})

autoparry_section:AddToggle("RandomizeAccuracy", {
    Title="Randomize Accuracy", Default=false,
    Callback=function(value)
        System.__properties.__randomized_accuracy_enabled=value
        if value then update_randomized_accuracy() end
    end
})

autoparry_section:AddToggle("CooldownProtection", {
    Title="Cooldown Protection", Default=false,
    Callback=function(value) getgenv().CooldownProtection=value end
})

autoparry_section:AddToggle("AutoAbility", {
    Title="Auto Ability", Default=false,
    Callback=function(value) getgenv().AutoAbility=value end
})

autoparry_section:AddToggle("AutoParryNotify", {
    Title="Notify", Default=false,
    Callback=function(value) getgenv().AutoParryNotify=value end
})

-- TRIGGERBOT
local triggerbot_section = Tabs.Rage:AddSection("Triggerbot", "target")

triggerbot_section:AddToggle("TriggerbotToggle", {
    Title="Triggerbot", Description="Parries instantly if targeted", Default=false,
    Callback=function(value)
        if System.__properties.__is_mobile then
            if value then
                if not System.__properties.__mobile_guis.triggerbot then
                    local triggerbot_mobile=create_mobile_button('Trigger',0.7,Color3.fromRGB(255,100,0))
                    System.__properties.__mobile_guis.triggerbot=triggerbot_mobile
                    local touch_start=0; local was_dragged=false
                    triggerbot_mobile.button.InputBegan:Connect(function(input)
                        if input.UserInputType==Enum.UserInputType.Touch then touch_start=tick(); was_dragged=false end
                    end)
                    triggerbot_mobile.button.InputChanged:Connect(function(input)
                        if input.UserInputType==Enum.UserInputType.Touch then
                            if (tick()-touch_start) > 0.1 then was_dragged=true end
                        end
                    end)
                    triggerbot_mobile.button.InputEnded:Connect(function(input)
                        if input.UserInputType==Enum.UserInputType.Touch and not was_dragged then
                            System.__properties.__triggerbot_enabled=not System.__properties.__triggerbot_enabled
                            System.triggerbot.enable(System.__properties.__triggerbot_enabled)
                            if System.__properties.__triggerbot_enabled then
                                triggerbot_mobile.text.Text="ON"; triggerbot_mobile.text.TextColor3=Color3.fromRGB(255,100,0)
                            else
                                triggerbot_mobile.text.Text="Trigger"; triggerbot_mobile.text.TextColor3=Color3.fromRGB(255,255,255)
                            end
                            if getgenv().TriggerbotNotify then Fluent:Notify({Title="Triggerbot",Content=System.__properties.__triggerbot_enabled and "ON" or "OFF",Duration=2}) end
                        end
                    end)
                end
            else
                System.__properties.__triggerbot_enabled=false; System.triggerbot.enable(false)
                destroy_mobile_gui(System.__properties.__mobile_guis.triggerbot)
                System.__properties.__mobile_guis.triggerbot=nil
            end
        else
            System.__properties.__triggerbot_enabled=value; System.triggerbot.enable(value)
            if getgenv().TriggerbotNotify then Fluent:Notify({Title="Triggerbot",Content=value and "ON" or "OFF",Duration=2}) end
        end
    end
})

triggerbot_section:AddToggle("TriggerbotNotify", {
    Title="Notify", Default=false,
    Callback=function(value) getgenv().TriggerbotNotify=value end
})

-- AUTOCURVE
local autocurve_section = Tabs.Rage:AddSection("AutoCurve Hotkey", "keyboard")
autocurve_section:AddToggle("AutoCurveHotkey", {
    Title="AutoCurve Hotkey", Default=false,
    Callback=function(state) getgenv().AutoCurveHotkeyEnabled=state end
})
autocurve_section:AddToggle("AutoCurveHotkeyNotify", {
    Title="Notify", Default=false,
    Callback=function(value) getgenv().AutoCurveHotkeyNotify=value end
})

-- DETECTION
local infinity_section=Tabs.Detection:AddSection("Infinity Detection","infinity")
infinity_section:AddToggle("InfinityDetection",{Title="Infinity Detection",Default=false,Callback=function(v) System.__config.__detections.__infinity=v end})
infinity_section:AddToggle("InfinityNotify",{Title="Notify",Default=false,Callback=function(v) getgenv().InfinityNotify=v end})

local deathslash_section=Tabs.Detection:AddSection("Death Slash Detection","skull")
deathslash_section:AddToggle("DeathSlashDetection",{Title="Death Slash Detection",Default=false,Callback=function(v) System.__config.__detections.__deathslash=v end})

local timehole_section=Tabs.Detection:AddSection("Time Hole Detection","clock")
timehole_section:AddToggle("TimeHoleDetection",{Title="Time Hole Detection",Default=false,Callback=function(v) System.__config.__detections.__timehole=v end})

local slashes_section=Tabs.Detection:AddSection("Slashes Of Fury Detection","swords")
slashes_section:AddToggle("SlashesOfFuryDetection",{Title="Slashes Of Fury Detection",Default=false,Callback=function(v) System.__config.__detections.__slashesoffury=v end})
slashes_section:AddSlider("ParryDelay",{Title="Parry Delay",Default=0.05,Min=0.05,Max=0.250,Rounding=2,Callback=function(v) parryDelay=v end})
slashes_section:AddSlider("MaxParryCount",{Title="Max Parry Count",Default=35,Min=1,Max=35,Rounding=0,Callback=function(v) maxParryCount=v end})

local phantom_section=Tabs.Detection:AddSection("Anti-Phantom","ghost")
phantom_section:AddToggle("AntiPhantom",{Title="Anti-Phantom",Default=false,Callback=function(v) System.__config.__detections.__phantom=v end})

-- SPAM TAB
local manual_spam_section=Tabs.Spam:AddSection("Manual Spam","zap")

manual_spam_section:AddToggle("ManualSpamToggle", {
    Title="Manual Spam", Description="High-frequency parry spam", Default=false,
    Callback=function(state)
        getgenv().ManualSpamAnimationFix=state
        if System.__properties.__is_mobile then
            if state then
                if not System.__properties.__mobile_guis.manual_spam then
                    local msm=create_mobile_button('Spam',0.8,Color3.fromRGB(255,140,0))
                    System.__properties.__mobile_guis.manual_spam=msm
                    local mts=0; local mwd=false
                    msm.button.InputBegan:Connect(function(input)
                        if input.UserInputType==Enum.UserInputType.Touch then mts=tick(); mwd=false end
                    end)
                    msm.button.InputChanged:Connect(function(input)
                        if input.UserInputType==Enum.UserInputType.Touch then
                            if (tick()-mts) > 0.1 then mwd=true end
                        end
                    end)
                    msm.button.InputEnded:Connect(function(input)
                        if input.UserInputType==Enum.UserInputType.Touch and not mwd then
                            local ns=not System.__properties.__manual_spam_enabled
                            System.__properties.__manual_spam_enabled=ns; macroSpamActive=ns
                            if ns then System.manual_spam.start() else System.manual_spam.stop() end
                            msm.text.Text=ns and "ON" or "Spam"
                            msm.text.TextColor3=ns and Color3.fromRGB(255,140,0) or Color3.fromRGB(255,255,255)
                            if getgenv().ManualSpamNotify then Fluent:Notify({Title="Manual Spam",Content=ns and "ON" or "OFF",Duration=2}) end
                        end
                    end)
                end
            else
                System.__properties.__manual_spam_enabled=false; macroSpamActive=false
                System.manual_spam.stop()
                destroy_mobile_gui(System.__properties.__mobile_guis.manual_spam)
                System.__properties.__mobile_guis.manual_spam=nil
            end
        else
            System.__properties.__manual_spam_enabled=state; macroSpamActive=state
            if state then System.manual_spam.start() else System.manual_spam.stop() end
            if getgenv().ManualSpamNotify then Fluent:Notify({Title="Manual Spam",Content=state and "ON" or "OFF",Duration=2}) end
        end
    end
})

manual_spam_section:AddToggle("ManualSpamNotify", {
    Title="Notify", Default=false,
    Callback=function(v) getgenv().ManualSpamNotify=v end
})

manual_spam_section:AddDropdown("ManualSpamMode", {
    Title="Mode", Values={"Remote","Keypress"}, Default="Remote", Multi=false,
    Callback=function(v) getgenv().ManualSpamMode=v end
})

local auto_spam_section=Tabs.Spam:AddSection("Auto Spam","zap")

auto_spam_section:AddToggle("AutoSpamToggle", {
    Title="Auto Spam", Description="Automatically spam parries ball", Default=false,
    Callback=function(value)
        getgenv().AutoSpamAnimationFix=value
        System.__properties.__auto_spam_enabled=value
        if value then System.auto_spam.start() else System.auto_spam.stop() end
        if getgenv().AutoSpamNotify then Fluent:Notify({Title="Auto Spam",Content=value and "ON" or "OFF",Duration=2}) end
    end
})

auto_spam_section:AddToggle("AutoSpamNotify",{Title="Notify",Default=false,Callback=function(v) getgenv().AutoSpamNotify=v end})
auto_spam_section:AddDropdown("AutoSpamMode",{Title="Mode",Values={"Remote","Keypress"},Default="Remote",Multi=false,Callback=function(v) getgenv().AutoSpamMode=v end})
auto_spam_section:AddSlider("ParryThreshold",{Title="Parry Threshold",Default=2.5,Min=0,Max=10,Rounding=1,Callback=function(v) System.__properties.__spam_threshold=v end})
auto_spam_section:AddSlider("DistanceMultiplier",{Title="Distance Multiplier",Default=0.3,Min=0.3,Max=3.0,Rounding=1,Callback=function(v) System.__properties.__auto_spam_distance_multiplier=v end})

-- PLAYER TAB
local avatar_section=Tabs.Player:AddSection("Avatar Changer","user")

avatar_section:AddToggle("AvatarChanger", {
    Title="Avatar Changer", Default=false,
    Callback=function(val)
        __av_flags['AvatarChanger']=val
        if val then
            local char=LocalPlayer.Character
            if char and __av_flags['name'] then __av_set(__av_flags['name'],char) end
            if not __av_flags['loop'] then
                __av_flags['loop']=LocalPlayer.CharacterAdded:Connect(function(char)
                    task.wait(.75)
                    if __av_flags['name'] then __av_set(__av_flags['name'],char) end
                end)
            end
        else
            if __av_flags['loop'] then __av_flags['loop']:Disconnect(); __av_flags['loop']=nil end
            __av_stop_all()
            local char=LocalPlayer.Character
            if char then
                pcall(function()
                    LocalPlayer:ClearCharacterAppearance()
                    local ok,desc=pcall(function() return Players:GetHumanoidDescriptionFromUserId(LocalPlayer.UserId) end)
                    if ok and desc then
                        local hum=char:FindFirstChildOfClass("Humanoid")
                        if hum then hum:ApplyDescriptionClientServer(desc) end
                    end
                end)
            end
        end
    end
})

avatar_section:AddInput("TargetUsername", {
    Title="Target Username", Placeholder="Enter Username...", Default="",
    Callback=function(val)
        __av_flags['name']=val
        if __av_flags['AvatarChanger'] and val~='' then
            local char=LocalPlayer.Character; if char then __av_set(val,char) end
        end
    end
})

local fov_section=Tabs.Player:AddSection("FOV","maximize")
fov_section:AddToggle("FOV", {
    Title="FOV", Default=false,
    Callback=function(value)
        getgenv().CameraEnabled=value; local Camera=workspace.CurrentCamera
        if value then
            getgenv().CameraFOV=getgenv().CameraFOV or 70; Camera.FieldOfView=getgenv().CameraFOV
            if not getgenv().FOVLoop then
                getgenv().FOVLoop=RunService.RenderStepped:Connect(function()
                    if getgenv().CameraEnabled then Camera.FieldOfView=getgenv().CameraFOV end
                end)
            end
        else
            Camera.FieldOfView=70
            if getgenv().FOVLoop then getgenv().FOVLoop:Disconnect(); getgenv().FOVLoop=nil end
        end
    end
})
fov_section:AddSlider("CameraFOV", {
    Title="Camera FOV", Default=70, Min=50, Max=120, Rounding=1,
    Callback=function(v) getgenv().CameraFOV=v; if getgenv().CameraEnabled then workspace.CurrentCamera.FieldOfView=v end end
})

local character_section=Tabs.Player:AddSection("Character","user")
character_section:AddToggle("CharacterModifier", {
    Title="Character Modifier", Default=false,
    Callback=function(value)
        getgenv().CharacterModifierEnabled=value
        if value then
            if not getgenv().CharacterConnection then
                getgenv().OriginalValues={}; getgenv().spinAngle=0
                getgenv().CharacterConnection=RunService.Heartbeat:Connect(function()
                    local char=LocalPlayer.Character; if not char then return end
                    local humanoid=char:FindFirstChild("Humanoid"); local root=char:FindFirstChild("HumanoidRootPart")
                    if humanoid then
                        if not getgenv().OriginalValues.WalkSpeed then
                            getgenv().OriginalValues.WalkSpeed=humanoid.WalkSpeed
                            getgenv().OriginalValues.JumpPower=humanoid.JumpPower
                            getgenv().OriginalValues.JumpHeight=humanoid.JumpHeight
                            getgenv().OriginalValues.HipHeight=humanoid.HipHeight
                            getgenv().OriginalValues.AutoRotate=humanoid.AutoRotate
                        end
                        if getgenv().WalkspeedCheckboxEnabled then humanoid.WalkSpeed=getgenv().CustomWalkSpeed or 36 end
                        if getgenv().JumpPowerCheckboxEnabled then
                            if humanoid.UseJumpPower then humanoid.JumpPower=getgenv().CustomJumpPower or 50
                            else humanoid.JumpHeight=getgenv().CustomJumpHeight or 7.2 end
                        end
                        if getgenv().HipHeightCheckboxEnabled then humanoid.HipHeight=getgenv().CustomHipHeight or 0 end
                        if getgenv().SpinbotCheckboxEnabled and root then
                            humanoid.AutoRotate=false
                            getgenv().spinAngle=(getgenv().spinAngle+(getgenv().CustomSpinSpeed or 5))%360
                            root.CFrame=CFrame.new(root.Position)*CFrame.Angles(0,math.rad(getgenv().spinAngle),0)
                        else
                            if getgenv().OriginalValues.AutoRotate~=nil then humanoid.AutoRotate=getgenv().OriginalValues.AutoRotate end
                        end
                    end
                    if getgenv().GravityCheckboxEnabled and getgenv().CustomGravity then workspace.Gravity=getgenv().CustomGravity end
                end)
            end
        else
            if getgenv().CharacterConnection then
                getgenv().CharacterConnection:Disconnect(); getgenv().CharacterConnection=nil
                local char=LocalPlayer.Character
                if char then
                    local humanoid=char:FindFirstChild("Humanoid")
                    if humanoid and getgenv().OriginalValues then
                        humanoid.WalkSpeed=getgenv().OriginalValues.WalkSpeed or 16
                        if humanoid.UseJumpPower then humanoid.JumpPower=getgenv().OriginalValues.JumpPower or 50
                        else humanoid.JumpHeight=getgenv().OriginalValues.JumpHeight or 7.2 end
                        humanoid.HipHeight=getgenv().OriginalValues.HipHeight or 0
                        humanoid.AutoRotate=getgenv().OriginalValues.AutoRotate or true
                    end
                end
                workspace.Gravity=196.2
                if getgenv().InfiniteJumpConnection then getgenv().InfiniteJumpConnection:Disconnect(); getgenv().InfiniteJumpConnection=nil end
                getgenv().OriginalValues=nil; getgenv().spinAngle=nil
            end
        end
    end
})

character_section:AddToggle("InfiniteJump",{Title="Infinite Jump",Default=false,Callback=function(value)
    getgenv().InfiniteJumpCheckboxEnabled=value
    if value and getgenv().CharacterModifierEnabled then
        if not getgenv().InfiniteJumpConnection then
            getgenv().InfiniteJumpConnection=UserInputService.JumpRequest:Connect(function()
                if getgenv().InfiniteJumpCheckboxEnabled and getgenv().CharacterModifierEnabled then
                    local char=LocalPlayer.Character
                    if char and char:FindFirstChild("Humanoid") then char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
                end
            end)
        end
    else
        if getgenv().InfiniteJumpConnection then getgenv().InfiniteJumpConnection:Disconnect(); getgenv().InfiniteJumpConnection=nil end
    end
end})

character_section:AddToggle("Spinbot",{Title="Spin",Default=false,Callback=function(value)
    getgenv().SpinbotCheckboxEnabled=value
    if not value and getgenv().CharacterModifierEnabled then
        local char=LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") and getgenv().OriginalValues then
            char.Humanoid.AutoRotate=getgenv().OriginalValues.AutoRotate or true
        end
    end
end})
character_section:AddSlider("SpinSpeed",{Title="Spin Speed",Default=5,Min=1,Max=50,Rounding=1,Callback=function(v) getgenv().CustomSpinSpeed=v end})
character_section:AddToggle("WalkSpeed",{Title="Walk Speed",Default=false,Callback=function(value)
    getgenv().WalkspeedCheckboxEnabled=value
    if not value and getgenv().CharacterModifierEnabled then
        local char=LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") and getgenv().OriginalValues then char.Humanoid.WalkSpeed=getgenv().OriginalValues.WalkSpeed or 16 end
    end
end})
character_section:AddSlider("WalkSpeedValue",{Title="Walk Speed Value",Default=36,Min=16,Max=500,Rounding=1,Callback=function(v)
    getgenv().CustomWalkSpeed=v
    if getgenv().CharacterModifierEnabled and getgenv().WalkspeedCheckboxEnabled then
        local char=LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed=v end
    end
end})
character_section:AddToggle("JumpPower",{Title="Jump Power",Default=false,Callback=function(value)
    getgenv().JumpPowerCheckboxEnabled=value
    if not value and getgenv().CharacterModifierEnabled then
        local char=LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") and getgenv().OriginalValues then
            local hum=char.Humanoid
            if hum.UseJumpPower then hum.JumpPower=getgenv().OriginalValues.JumpPower or 50
            else hum.JumpHeight=getgenv().OriginalValues.JumpHeight or 7.2 end
        end
    end
end})
character_section:AddSlider("JumpPowerValue",{Title="Jump Power Value",Default=50,Min=50,Max=200,Rounding=1,Callback=function(v)
    getgenv().CustomJumpPower=v; getgenv().CustomJumpHeight=v*0.144
    if getgenv().CharacterModifierEnabled and getgenv().JumpPowerCheckboxEnabled then
        local char=LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            local hum=char.Humanoid
            if hum.UseJumpPower then hum.JumpPower=v else hum.JumpHeight=v*0.144 end
        end
    end
end})
character_section:AddToggle("Gravity",{Title="Gravity",Default=false,Callback=function(value)
    getgenv().GravityCheckboxEnabled=value
    if not value and getgenv().CharacterModifierEnabled then workspace.Gravity=196.2 end
end})
character_section:AddSlider("GravityValue",{Title="Gravity Value",Default=196.2,Min=0,Max=400.0,Rounding=1,Callback=function(v)
    getgenv().CustomGravity=v
    if getgenv().CharacterModifierEnabled and getgenv().GravityCheckboxEnabled then workspace.Gravity=v end
end})
character_section:AddToggle("HipHeight",{Title="Hip Height",Default=false,Callback=function(value)
    getgenv().HipHeightCheckboxEnabled=value
    if not value and getgenv().CharacterModifierEnabled then
        local char=LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") and getgenv().OriginalValues then char.Humanoid.HipHeight=getgenv().OriginalValues.HipHeight or 0 end
    end
end})
character_section:AddSlider("HipHeightValue",{Title="Hip Height Value",Default=0,Min=-5,Max=20,Rounding=1,Callback=function(v)
    getgenv().CustomHipHeight=v
    if getgenv().CharacterModifierEnabled and getgenv().HipHeightCheckboxEnabled then
        local char=LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then char.Humanoid.HipHeight=v end
    end
end})

-- VISUALS TAB
local ability_esp={
    __config={gui_name="AbilityESPGui",gui_size=UDim2.new(0,200,0,40),studs_offset=Vector3.new(0,3.2,0),
        text_color=Color3.fromRGB(255,255,255),stroke_color=Color3.fromRGB(0,0,0),
        font=Enum.Font.GothamBold,text_size=14,update_rate=1/30},
    __state={active=false,players={},update_task=nil}
}
function ability_esp.create_billboard(player)
    local character=player.Character; if not character then return nil end
    local humanoid=character:FindFirstChild("Humanoid"); local head=character:FindFirstChild("Head")
    if not humanoid or not head then return nil end
    local existing=head:FindFirstChild(ability_esp.__config.gui_name); if existing then existing:Destroy() end
    local billboard=Instance.new("BillboardGui"); billboard.Name=ability_esp.__config.gui_name
    billboard.Adornee=head; billboard.Size=ability_esp.__config.gui_size
    billboard.StudsOffset=ability_esp.__config.studs_offset; billboard.AlwaysOnTop=true; billboard.Parent=head
    local label=Instance.new("TextLabel"); label.Size=UDim2.new(1,0,1,0); label.BackgroundTransparency=1
    label.TextColor3=ability_esp.__config.text_color; label.TextStrokeColor3=ability_esp.__config.stroke_color
    label.TextStrokeTransparency=0.5; label.Font=ability_esp.__config.font; label.TextSize=ability_esp.__config.text_size
    label.Parent=billboard; return label,billboard
end
function ability_esp.update_label(player,label)
    if not player or not label then return false end
    if ability_esp.__state.active then
        label.Visible=true; local ability_name=player:GetAttribute("EquippedAbility")
        label.Text=ability_name and (player.DisplayName.."  ["..ability_name.."]") or player.DisplayName
    else label.Visible=false end; return true
end
function ability_esp.setup_character(player)
    task.wait(0.1); local character=player.Character; if not character then return end
    local label,billboard=ability_esp.create_billboard(player); if not label then return end
    if not ability_esp.__state.players[player] then ability_esp.__state.players[player]={} end
    ability_esp.__state.players[player].label=label
    ability_esp.__state.players[player].billboard=billboard
    ability_esp.__state.players[player].character=character
end
function ability_esp.add_player(player)
    if player==LocalPlayer then return end
    player.CharacterAdded:Connect(function() ability_esp.setup_character(player) end)
    if player.Character then task.spawn(function() ability_esp.setup_character(player) end) end
end
function ability_esp.update_loop()
    while ability_esp.__state.active do
        task.wait(ability_esp.__config.update_rate)
        for player,data in pairs(ability_esp.__state.players) do
            if player.Character and data.label then ability_esp.update_label(player,data.label) end
        end
    end
end
function ability_esp.start()
    if ability_esp.__state.active then return end
    ability_esp.__state.active=true; getgenv().AbilityESP=true
    for _,player in pairs(Players:GetPlayers()) do if player~=LocalPlayer then ability_esp.add_player(player) end end
    ability_esp.__state.update_task=task.spawn(function() ability_esp.update_loop() end)
end
function ability_esp.stop()
    if not ability_esp.__state.active then return end
    ability_esp.__state.active=false; getgenv().AbilityESP=false
    for _,v in pairs(ability_esp.__state.players) do if v.billboard then v.billboard:Destroy() end end
    ability_esp.__state.players={}
end
function ability_esp.toggle(v) if v then ability_esp.start() else ability_esp.stop() end end

local ability_esp_section=Tabs.Visuals:AddSection("Ability ESP","eye")
ability_esp_section:AddToggle("AbilityESP",{Title="Ability ESP",Default=false,Callback=function(value)
    ability_esp.toggle(value)
    Fluent:Notify({Title="Ability ESP",Content=value and "Activated" or "Deactivated",Duration=2})
end})

-- Ball Speed Display
local ball_velocity_section=Tabs.Visuals:AddSection("Ball Speed","gauge")
local speedLabel=nil; local speedFrame=nil; local speedGui=nil

function System.create_speed_gui()
    if speedGui then speedGui:Destroy(); speedGui=nil; speedFrame=nil; speedLabel=nil end
    speedGui=Instance.new("ScreenGui"); speedGui.Name="BallSpeedGUI"; speedGui.ResetOnSpawn=false
    speedGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling; speedGui.DisplayOrder=999
    speedFrame=Instance.new("Frame"); speedFrame.Size=UDim2.new(0,130,0,35)
    speedFrame.Position=UDim2.new(0,10,0,10); speedFrame.BackgroundTransparency=1
    speedFrame.BorderSizePixel=0; speedFrame.Active=true; speedFrame.Selectable=true; speedFrame.Draggable=true
    speedLabel=Instance.new("TextLabel"); speedLabel.Size=UDim2.new(1,0,1,0)
    speedLabel.BackgroundTransparency=1; speedLabel.Text="Ball Veloctiy: 0.0"
    speedLabel.TextColor3=Color3.fromRGB(255,255,255); speedLabel.Font=Enum.Font.GothamBold
    speedLabel.TextSize=18; speedLabel.TextStrokeTransparency=0.3; speedLabel.TextStrokeColor3=Color3.new(0,0,0)
    speedLabel.Parent=speedFrame; speedFrame.Parent=speedGui; speedGui.Parent=CoreGui
end

function System.update_speed_display()
    if not System.__properties.__speed_display_enabled or not speedLabel then return end
    local ball=System.ball.get()
    if not ball then speedLabel.Text="Speed: 0.0"; return end
    local zoomies=ball:FindFirstChild('zoomies')
    if not zoomies then speedLabel.Text="Speed: 0.0"; return end
    speedLabel.Text=string.format("Speed: %.1f",zoomies.VectorVelocity.Magnitude)
end

ball_velocity_section:AddToggle("ShowSpeed",{Title="Show Speed",Default=false,Callback=function(value)
    System.__properties.__speed_display_enabled=value
    if value then
        System.create_speed_gui()
        if not System.__properties.__connections.__speed_display then
            System.__properties.__connections.__speed_display=RunService.RenderStepped:Connect(function() System.update_speed_display() end)
        end
        Fluent:Notify({Title="Speed Display",Content="Activated",Duration=2})
    else
        if speedGui then speedGui:Destroy(); speedGui=nil; speedFrame=nil; speedLabel=nil end
        if System.__properties.__connections.__speed_display then
            System.__properties.__connections.__speed_display:Disconnect(); System.__properties.__connections.__speed_display=nil
        end
        Fluent:Notify({Title="Speed Display",Content="Deactivated",Duration=2})
    end
end})

-- MISC TAB
local skin_changer_section=Tabs.Misc:AddSection("Skin Changer","sword")

skin_changer_section:AddToggle("SkinChanger",{
    Title="Skin Changer", Description="Change sword skins", Default=false,
    Callback=function(value)
        getgenv().skinChangerEnabled=value
        if value then getgenv().updateSword(); Fluent:Notify({Title="Skin Changer",Content="Enabled",Duration=2})
        else Fluent:Notify({Title="Skin Changer",Content="Disabled",Duration=2}) end
    end
})
skin_changer_section:AddToggle("ChangeSwordModel",{Title="Change Sword Model",Default=true,Callback=function(v)
    getgenv().changeSwordModel=v; if getgenv().skinChangerEnabled then getgenv().updateSword() end
end})
skin_changer_section:AddInput("SwordModelName",{Title="Sword Model Name",Placeholder="Enter Sword Model Name...",Default="",Callback=function(t)
    getgenv().swordModel=t; if getgenv().skinChangerEnabled and getgenv().changeSwordModel then getgenv().updateSword() end
end})
skin_changer_section:AddToggle("ChangeSwordAnimation",{Title="Change Sword Animation",Default=true,Callback=function(v)
    getgenv().changeSwordAnimation=v; if getgenv().skinChangerEnabled then getgenv().updateSword() end
end})
skin_changer_section:AddInput("SwordAnimationName",{Title="Sword Animation Name",Placeholder="Enter Sword Animation Name...",Default="",Callback=function(t)
    getgenv().swordAnimations=t; if getgenv().skinChangerEnabled and getgenv().changeSwordAnimation then getgenv().updateSword() end
end})
skin_changer_section:AddToggle("ChangeSwordFX",{Title="Change Sword FX",Default=true,Callback=function(v)
    getgenv().changeSwordFX=v; if getgenv().skinChangerEnabled then getgenv().updateSword() end
end})
skin_changer_section:AddInput("SwordFXName",{Title="Sword FX Name",Placeholder="Enter Sword FX Name...",Default="",Callback=function(t)
    getgenv().swordFX=t; if getgenv().skinChangerEnabled and getgenv().changeSwordFX then getgenv().updateSword() end
end})

local no_render_section=Tabs.Misc:AddSection("No Render","eye-off")
local Connections_Manager={}
no_render_section:AddToggle("NoRender",{Title="No Render",Default=false,Callback=function(state)
    local effectScripts=LocalPlayer.PlayerScripts:FindFirstChild("EffectScripts")
    if effectScripts then
        local clientFX=effectScripts:FindFirstChild("ClientFX"); if clientFX then clientFX.Disabled=state end
    end
    if state then
        Connections_Manager['No Render']=workspace.Runtime.ChildAdded:Connect(function(Value) Debris:AddItem(Value,0) end)
    else
        if Connections_Manager['No Render'] then Connections_Manager['No Render']:Disconnect(); Connections_Manager['No Render']=nil end
    end
end})

-- Mobile UI button
local mobile_ui_button=nil
local function create_mobile_ui_button()
    if mobile_ui_button then mobile_ui_button.gui:Destroy() end
    local gui=Instance.new('ScreenGui'); gui.Name='EagleMobileUIButton'; gui.ResetOnSpawn=false
    gui.IgnoreGuiInset=true; gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling; gui.DisplayOrder=9999
    local button=Instance.new('TextButton'); button.Size=UDim2.new(0,50,0,50)
    button.Position=UDim2.new(0.95,-25,0.05,0); button.BackgroundColor3=Color3.fromRGB(0,0,0)
    button.BackgroundTransparency=0.3; button.AnchorPoint=Vector2.new(0.5,0.5)
    button.Draggable=true; button.AutoButtonColor=true; button.ZIndex=10000
    Instance.new('UICorner',button).CornerRadius=UDim.new(1,0)
    local stroke=Instance.new('UIStroke',button); stroke.Color=Color3.fromRGB(255,255,255); stroke.Thickness=2; stroke.Transparency=0.3
    local text=Instance.new('TextLabel'); text.Size=UDim2.new(1,0,1,0); text.BackgroundTransparency=1
    text.Text=""; text.Font=Enum.Font.GothamBold; text.TextSize=24; text.TextColor3=Color3.fromRGB(255,255,255)
    text.ZIndex=10001; text.Parent=button
    button.MouseButton1Click:Connect(function() Window:Minimize(not Window.Minimized) end)
    button.Parent=gui; gui.Parent=CoreGui
    mobile_ui_button={gui=gui,button=button}; return mobile_ui_button
end
if System.__properties.__is_mobile then
    task.spawn(function() task.wait(2); create_mobile_ui_button() end)
end

-- ========== SETTINGS TAB — Keybind Section ==========
local keybinds_section=Tabs.Settings:AddSection("Keybinds","keyboard")

keybinds_section:AddKeybind("SpamKeybind", {
    Title="Spam Key",
    Description="",
    Default="E",
    Callback=function() end,
    ChangedCallback=function(k)
        local kc=Enum.KeyCode[k]
        if kc then spamKeyCode=kc; Fluent:Notify({Title="Spam Key Set",Content=k,Duration=2}) end
    end
})

keybinds_section:AddKeybind("TriggerKeybind", {
    Title="Trigger Key",
    Description="",
    Default="R",
    Callback=function() end,
    ChangedCallback=function(k)
        local kc=Enum.KeyCode[k]
        if kc then trigKeyCode=kc; Fluent:Notify({Title="Trigger Key Set",Content=k,Duration=2}) end
    end
})

-- ========== SETTINGS ==========
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
InterfaceManager:SetFolder("Eagle Hub X")
SaveManager:SetFolder("Eagle Hub X/configs")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)
SaveManager:LoadAutoloadConfig()

-- ========== KEYBIND HANDLER (PC + Xbox + PS) ==========
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end

    local kc = input.KeyCode

    if kc == spamKeyCode then
        System.__properties.__manual_spam_enabled = not System.__properties.__manual_spam_enabled
        macroSpamActive = System.__properties.__manual_spam_enabled
        if macroSpamActive then System.manual_spam.start() else System.manual_spam.stop() end
        if getgenv().ManualSpamNotify then
            Fluent:Notify({Title="Manual Spam",Content=macroSpamActive and "ON" or "OFF",Duration=1})
        end
    end

    if kc == trigKeyCode then
        local ns = not System.__properties.__triggerbot_enabled
        System.__properties.__triggerbot_enabled = ns
        System.triggerbot.enable(ns)
        if getgenv().TriggerbotNotify then
            Fluent:Notify({Title="Triggerbot",Content=ns and "ON" or "OFF",Duration=1})
        end
    end
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.UserInputType ~= Enum.UserInputType.Gamepad1 and
       input.UserInputType ~= Enum.UserInputType.Gamepad2 then return end

    local kc = input.KeyCode

    if kc == spamKeyCode then
        System.__properties.__manual_spam_enabled = not System.__properties.__manual_spam_enabled
        macroSpamActive = System.__properties.__manual_spam_enabled
        if macroSpamActive then System.manual_spam.start() else System.manual_spam.stop() end
        if getgenv().ManualSpamNotify then
            Fluent:Notify({Title="Manual Spam",Content=macroSpamActive and "ON" or "OFF",Duration=1})
        end
    end

    if kc == trigKeyCode then
        local ns = not System.__properties.__triggerbot_enabled
        System.__properties.__triggerbot_enabled = ns
        System.triggerbot.enable(ns)
        if getgenv().TriggerbotNotify then
            Fluent:Notify({Title="Triggerbot",Content=ns and "ON" or "OFF",Duration=1})
        end
    end
end)
print("Eagle Hub X loaded!")
end)
