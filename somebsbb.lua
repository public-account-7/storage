local Library = loadstring(game:HttpGet("https://gist.githubusercontent.com/AgentX771/d03e5759189ec6a975a84c7651121f9c/raw/419e503168f3791549b7658a52bd470158bde5b1/gistfile1.txt"))()
local LibraryN = loadstring(game:HttpGet("https://gist.githubusercontent.com/AgentX771/dc2106f953b3d8826affc7ea37ef7d93/raw/831ecb2835687dedded86a5c6201a19a35cd4d96/gistfile1.txt"))() local screenGui = Instance.new("ScreenGui") screenGui.Name = "/" screenGui.ResetOnSpawn = false screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Window = Library:CreateWindow({Title = "AHHX", Theme = "Crimson"})
local BlatantTab = Window:CreateTab("", "rbxassetid://107508753698171")
local PlayersTab = Window:CreateTab("", "rbxassetid://112812457747322")
local WorldTab = Window:CreateTab("", "rbxassetid://103015658414639")
local DesyncsTab = Window:CreateTab("", "rbxassetid://137726256442333")
local SettingsTab = Window:CreateTab("", "rbxassetid://129471648866534", true)

local UserInputService = cloneref(game:GetService("UserInputService"))
local ContextActionService = cloneref(game:GetService("ContextActionService"))
local HttpService = cloneref(game:GetService("HttpService"))
local RunService = cloneref(game:GetService("RunService"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local Stats = cloneref(game:GetService("Stats")):FindFirstChild("Network"):FindFirstChild("ServerStatsItem")
local Debris = cloneref(game:GetService("Debris"))
local Net
local TeleportService = cloneref(game:GetService("TeleportService"))
local LocalPlayer = game.Players.LocalPlayer
local InfinityCD = LocalPlayer.PlayerGui.Hotbar.Ability.Duration.Fill.UIGradient
local Workspace = cloneref(game:GetService("Workspace"))
local PlrForc = false
local Phantom = false
local Parried = false
local LastPlayedd = 0
local Sword_CP = false
local Sword_Spped = 1
local Up = false
local Grab_Parry = nil
local ParriedTigger = false
local ParriedTigger2 = false
local Training_Parried = false
local Parries = 0
local LastBall1 = nil
local LastSpeed2 = 0
local Threshold = 1
local Tiggerbot_2 = 0.5
local Tornado_Time = tick()
local Lerp_Radians = 0
local LastSwitch = tick()
local Last_Warping = tick()
local Curving = tick()
local connections_Manager = {}
local ParryRemote = nil
local Parry_Key = nil
local Parry_Args = nil
local Auto_Parry = {}
local Animation = {}
Animation.storage = {}
local Emote_Data = {}
local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled
local Vector2_Mouse_Location = nil
Animation.current = nil
Animation.track = nil
Animation.last = nil
local Closest_Entity = nil
local Runtime = Workspace.Runtime
local Selected_Parry_Type = "Camera"
local CurveType = "Camera"
local Balls1,Balls2 = Workspace:WaitForChild("Balls"),Workspace:WaitForChild("TrainingBalls")
getgenv().mname = math.random(5000000, 7000000)
getgenv().abilityrandom = "Legit"
getgenv().activeEsps = {}
getgenv().DesyncTypes = {}
loadstring(game:HttpGet("https://gist.githubusercontent.com/AgentX771/83254168467eb5c1f7a10f1440842ed8/raw/a21b1e1417b4ff98b2afe463023d94279137bba9/gistfile1.txt"))()
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

function Auto_Parry.Get_Balls()
    local Balls = {}
    for _, Instance in pairs(Balls1:GetChildren()) do
        if Instance:GetAttribute("realBall") then
            Instance.CanCollide = false
            table.insert(Balls, Instance)
        end
    end
    return Balls
end

function Auto_Parry.Get_Ball()
    for _, Instance in pairs(Workspace.Balls:GetChildren()) do
        if Instance:GetAttribute("realBall") then
            Instance.CanCollide = false
            return Instance
        end
    end
end

function Auto_Parry.Lobby_Balls()
    for _, Instance in pairs(Balls2:GetChildren()) do
        if Instance:GetAttribute("realBall") then
            return Instance
        end
    end
end

function Auto_Parry.Grab_Parry_Play(track)
    track:Play(
        track:GetAttribute("PlayFadeTime") or 0,
        track:GetAttribute("PlayWeight") or 1,
        track:GetAttribute("PlaySpeed") or 1
    )
end

function Auto_Parry.Parry_Animation()
    if (os.clock() - LastPlayedd) >= (Sword_Spped - 0.8) or Sword_CP then
        LastPlayedd = os.clock()
        Sword_CP = false
        for _, track in pairs(LocalPlayer.Character.Humanoid.Animator:GetPlayingAnimationTracks()) do
            if track.Name == "GrabParry" or track.Name == "Grab" then
                track.TimePosition = 0
                Auto_Parry.Grab_Parry_Stop(track)
            elseif track.Name == "SuccessParry" or track.Name == "Success" then
                Auto_Parry.Grab_Parry_Stop(track)
            end
        end
        Grab_Parry = LocalPlayer.Character.Humanoid.Animator:LoadAnimation(
            ReplicatedStorage.Shared.SwordAPI.Collection.Default:FindFirstChild("GrabParry")
        )
        Auto_Parry.Grab_Parry_Play(Grab_Parry)
    end
end

function Auto_Parry.Grab_Parry_Stop(track)
    track:Stop(track:GetAttribute("StopFadeTime") or 0.1)
end

function Auto_Parry.Closest_Player()
    local Max_Distance = math.huge
    local Found_Entity = nil
    for _, Entity in pairs(Workspace.Alive:GetChildren()) do
        if Entity ~= LocalPlayer then
            if Entity.PrimaryPart then
                local Distance = LocalPlayer:DistanceFromCharacter(Entity.PrimaryPart.Position)
                if Distance < Max_Distance then
                    Max_Distance = Distance
                    Found_Entity = Entity
                end
            end
        end
    end
    Closest_Entity = Found_Entity
    return Found_Entity
end

function Auto_Parry.Parry_Data(Parry_Type)
    local Camera = Workspace.CurrentCamera
    local Events = {}
    local Players_Screen_Positions = {}
    local Vector2_Mouse_Location
    if not isMobile then
        local Mouse_Location = UserInputService:GetMouseLocation()
        Vector2_Mouse_Location = {Mouse_Location.X, Mouse_Location.Y}
    else
        Vector2_Mouse_Location = {Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2}
    end
    for _, v in pairs(Workspace.Alive:GetChildren()) do
        if v ~= LocalPlayer.Character then
            local worldPos = (v and v.PrimaryPart and v.PrimaryPart.Position) or Vector3.zero
            local screenPos, isOnScreen = Camera:WorldToScreenPoint(worldPos)
            if isOnScreen and screenPos then
                Players_Screen_Positions[v] = Vector2.new(screenPos.X, screenPos.Y)
            end
            Events[tostring(v)] = screenPos
        end
    end
    if Parry_Type == "Camera" then
        return {Camera.CFrame, Events, Vector2_Mouse_Location}
    end
    if Parry_Type == "Normal" then
        return {CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position, LocalPlayer.Character.HumanoidRootPart.Position + LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector), Events, Vector2_Mouse_Location}
    end
    if Parry_Type == "Speed" then
        return {CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + Camera.CFrame.UpVector * 5), Events, Vector2_Mouse_Location}
    end
    if Parry_Type == "High" then
        return {CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + Camera.CFrame.UpVector * 9e9), Events, Vector2_Mouse_Location}
    end
    if Parry_Type == "Down" then
        return {CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + Camera.CFrame.UpVector * -9e9), Events, Vector2_Mouse_Location}
    end
    if Parry_Type == "Random" then
        return {CFrame.new(Camera.CFrame.Position, Vector3.new(math.random(-4000, 4000), math.random(-4000, 4000), math.random(-4000, 4000))), Events, Vector2_Mouse_Location}
    end
    if Parry_Type == "Left" then
        return {CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position - Camera.CFrame.RightVector * 9e9), Events, Vector2_Mouse_Location}
    end
    if Parry_Type == "Right" then
        return {CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + Camera.CFrame.RightVector * 9e9), Events, Vector2_Mouse_Location}
    end
    if Parry_Type == "Backwards" then
        return {CFrame.new(Camera.CFrame.Position, LocalPlayer.Character.HumanoidRootPart.Position + (LocalPlayer.Character.HumanoidRootPart.Position - (Camera.CFrame.Position + Camera.CFrame.LookVector * 100)).Unit * 10000000 + Vector3.new(1000)), Events, Vector2_Mouse_Location}
    end
end

function Auto_Parry.Parry(Selected_Parry_Type)
    local Parry_Data = Auto_Parry.Parry_Data(Selected_Parry_Type)
    if true then
        Auto_Parry.Parry_Animation()
        ParryRemote:FireServer(Hash1, Hash2, Hash3(), 0, Parry_Data[1], Parry_Data[2], Parry_Data[3], false)
        if Parries > 7 then
            return false
        end
        Parries += 1
        task.delay(0.5, function()
            if Parries > 0 then
                Parries -= 1
            end
        end)
        return true
    end
end

function Auto_Parry.Linear_Interpolation(a, b, time_volume)
    return a + (b - a) * time_volume
end

function Auto_Parry.Is_Curved()
    local Ball = Auto_Parry.Get_Ball()
    if Ball then
        local Zoomies = Ball:FindFirstChild("zoomies")
        if Zoomies then
            local Velocity = Ball.zoomies.VectorVelocity
            local Speed = Velocity.Magnitude
            local Speed_Factor = Speed / 250
            local Ball_Distance = LocalPlayer:DistanceFromCharacter(Ball.Position)
            local Direction = (LocalPlayer.Character.PrimaryPart and (LocalPlayer.Character.PrimaryPart.Position - Ball.Position).Unit) or Vector3.zero
            local Dot = Direction:Dot(Velocity.Unit)
            local Ball_Speed_Limited = math.min(Speed / 1000, 0.1)
            Auto_Parry.Closest_Player()
            local Reach_Speed = math.clamp(1 + (Speed / 1925), 1, 3)
            if Speed >= 2000 then Reach_Speed = math.random(20, 30) / 10 end
            local Target_Position = Closest_Entity.HumanoidRootPart.Position
            local Target_Distance = LocalPlayer:DistanceFromCharacter(Target_Position)
            local Target_Distance_Limited = math.min(Target_Distance / 10000, 0.1)
            local Clamped_Dot = math.clamp(Dot, -1, 1)
            local Ball_Distance_Threshold = 15 - math.min(Ball_Distance / 1000, 15) + Speed / 100
            local Radians = math.rad(math.asin(Clamped_Dot))
            local Reach_Time = Ball_Distance / Speed
            Lerp_Radians = Auto_Parry.Linear_Interpolation(Lerp_Radians, Radians, 0.8)
            if Ball_Distance < Ball_Distance_Threshold then
                return false
            end
            if (tick() - Curving) < (Reach_Time / Reach_Speed) then
                Last_Warping = tick()
            end
            if (tick() - Last_Warping) >= 0.15 + Target_Distance_Limited - Ball_Speed_Limited or Ball_Distance <= 10 then
                return false else
                return true
            end
        end
    end
end

local function AutoColdown()
    if not LocalPlayer.PlayerGui.Hotbar.Ability.Red.Visible then
        if not Workspace.Map:FindFirstChild("WorldCup") then
            if game.Players.LocalPlayer.PlayerGui.Hotbar.Block.UIGradient.Offset.Y < 0.4 then
                ReplicatedStorage.Remotes.AbilityButtonPress:Fire()
                return true
            end
        end
        return false
    end
end

local function get_auto_ability()
    if not LocalPlayer.PlayerGui.Hotbar.Ability.Red.Visible then
        if not Workspace.Map:FindFirstChild("WorldCup") then
            if LocalPlayer.PlayerGui.Hotbar.Ability.UIGradient.Offset.Y == 0.5 then
                if tonumber(LocalPlayer.PlayerGui.Hotbar.Ability.ready.counts.Text) > 0 then
                    if getgenv().abilityrandom == "Legit" then
                        if math.random(1, 100) <= 80 then
                            return
                        end
                    end
                    get_parry_ap = true
                    ReplicatedStorage.Remotes.AbilityButtonPress:Fire()
                    return true
                end
            end
        end
    end
    return false
end

for _, v in pairs(ReplicatedStorage.Misc.Emotes:GetChildren()) do
    if v:IsA("Animation") and v:GetAttribute("EmoteName") then
        local emote_name = v:GetAttribute("EmoteName")
        Animation.storage[emote_name] = v
    end
end

function FindPlayerByName(name)
    if name and name ~= "" then
        local body = HttpService:JSONEncode({
            usernames = {name},
            excludeBannedUsers = false
        })
        local data
        repeat
            local res = request({
                Url = "https://users.roblox.com/v1/usernames/users",
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = body
            })
            if res and res.Body then
                data = HttpService:JSONDecode(res.Body)
            end
            task.wait()
        until data and data.data and data.data[1] and data.data[1].id
        return {
            UserId = data.data[1].id
        }
    end
end

for Object in pairs(Animation.storage) do
    table.insert(Emote_Data, Object)
    table.sort(Emote_Data)
end

function MorphToPlayer(target)
    if target then
        local userId = target.UserId
        if username2 ~= userId then
            username2 = userId
            local hum = LocalPlayer.Character:WaitForChild("Humanoid")
            local desc
            pcall(function()
                desc = game.Players:GetHumanoidDescriptionFromUserId(userId)
            end)
            LocalPlayer:ClearCharacterAppearance()
            hum:ApplyDescriptionClientServer(desc)
        end
    end
end

getgenv().createESP = function(player, ability)
    if player and player ~= LocalPlayer then
        local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
        local key = player.UserId
        if activeEsps[key] then
            activeEsps[key]:Destroy()
            activeEsps[key] = nil
        end
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Name = "AbilityESP_" .. player.Name
        billboardGui.Size = UDim2.new(0, 150, 0, 20)
        billboardGui.StudsOffset = Vector3.new(0, 3.5, 0)
        billboardGui.AlwaysOnTop = true
        billboardGui.Parent = humanoidRootPart
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.TextScaled = true
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        textLabel.TextStrokeTransparency = 0.8
        textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
        textLabel.Text = player.DisplayName .. ": [" .. ability .. "]"
        textLabel.Parent = billboardGui
        activeEsps[key] = billboardGui
    end
end

getgenv().removeESP = function(player)
    local key = player.UserId
    if activeEsps[key] then
        activeEsps[key]:Destroy()
        activeEsps[key] = nil
    end
end

getgenv().removeAllESPs = function()
    for _, esp in pairs(activeEsps) do
        esp:Destroy()
    end
    activeEsps = {}
end

getgenv().updateESPs = function()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local targetChar = nil
        if Workspace:FindFirstChild("Alive") and Workspace.Alive:FindFirstChild(player.Name) then
            targetChar = Workspace.Alive[player.Name]
        elseif getgenv().AbilityESPDead and Workspace:FindFirstChild("Dead") and Workspace.Dead:FindFirstChild(player.Name) then
            targetChar = Workspace.Dead[player.Name]
        end
        if not targetChar or not targetChar:FindFirstChild("HumanoidRootPart") then
            removeESP(player)
            continue
        end
        if getgenv().AbilityESPEnabled then
            local ability = "Unknown"
            local attr = player:GetAttribute("CurrentlyEquippedAbility")
            if attr then
                ability = tostring(attr)
            end
            if ability ~= "Unknown" and ability ~= "" then
                createESP(player, ability)
            else
                removeESP(player)
            end
        else
            removeESP(player)
        end
    end
    for key, espGui in pairs(activeEsps) do
        local userId = tonumber(key)
        local p = game.Players:GetPlayerByUserId(userId)
        local targetChar = nil
        if p then
            if Workspace:FindFirstChild("Alive") and Workspace.Alive:FindFirstChild(p.Name) then
                targetChar = Workspace.Alive[p.Name]
            elseif getgenv().AbilityESPDead and Workspace:FindFirstChild("Dead") and Workspace.Dead:FindFirstChild(p.Name) then
                targetChar = Workspace.Dead[p.Name]
            end
        end
        if not p or not targetChar or not targetChar:FindFirstChild("HumanoidRootPart") then
            espGui:Destroy()
            activeEsps[key] = nil
        end
    end
end

local BlatantTab0 = BlatantTab:CreateGroupbox("Combat - Blatant", "Left")
local BlatantTab1 = BlatantTab:CreateGroupbox("Forcefield - Detections", "Right")
local BlatantTab5 = BlatantTab:CreateGroupbox("Tigger - Spam - Legit", "Left")
local BlatantTab2 = BlatantTab:CreateGroupbox("Anti - Auto", "Left")
local BlatantTab3 = BlatantTab:CreateGroupbox("Settings - Blatant", "Right")
local BlatantTab4 = BlatantTab:CreateGroupbox("Lobby AP - Tiggerbot", "Left")

BlatantTab0:CreateToggle({
    Name = "Auto Parry",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        if state then
            connections_Manager["Auto Parry"] = RunService.PreSimulation:Connect(function()
                for _, Ball in pairs(Auto_Parry.Get_Balls()) do
                    if Ball then
                        local Zoomies = Ball:FindFirstChild("zoomies")
                        if Zoomies then
                            local Ball_Target = Ball:GetAttribute("target")
                            local TeamPlayer = (LocalPlayer.Team.Name == "Blue" and "Goal1" or LocalPlayer.Team.Name == "Red" and "Goal2")
                            if not Workspace.Map:FindFirstChild("WorldCup") then
                                if Ball_Target ~= LocalPlayer.Name then
                                    Parried = false
                                end else
                                if Ball_Target ~= TeamPlayer then
                                    Parried = false
                                end
                            end
                            local Speed = Ball:FindFirstChild("zoomies").VectorVelocity.Magnitude
                            if Speed > 0 and not PlrForc and not Auto_Parry.Is_Curved() then
                                local Distance = LocalPlayer:DistanceFromCharacter(Ball.Position)
                                local Ping = Stats["Data Ping"]:GetValue() / 10
                                local Parry_Accuracy = math.max(math.max(Ping, 4) + Speed / 3.5, 9.5)
                                if Ball:FindFirstChild("AeroDynamicSlashVFX") then
                                    Debris:AddItem(Ball.AeroDynamicSlashVFX, 0)
                                    Tornado_Time = tick()
                                end
                                if Runtime:FindFirstChild("Tornado") then
                                    if (tick() - Tornado_Time) < (Runtime.Tornado:GetAttribute("TornadoTime")) then
                                        return
                                    end
                                end
                                if not Parried then
                                    if (Ball_Target == LocalPlayer.Name or Ball_Target == TeamPlayer) and Distance <= Parry_Accuracy then
                                        if getgenv().AutoAbility and AutoAbility() then
                                            return
                                        end
                                        if getgenv().AutoColdown and AutoColdown() then
                                            return
                                        end
                                        Auto_Parry.Parry(Selected_Parry_Type)
                                        Parried = true
                                    end
                                end
                            end
                        end
                        local Last_Parrys = tick()
                        repeat
                            RunService.PreSimulation:Wait()
                        until (tick() - Last_Parrys) >= 0.7 or not Parried
                        Parried = false
                    end
                end
            end)
        else
            if connections_Manager["Auto Parry"] then
                connections_Manager["Auto Parry"]:Disconnect()
                connections_Manager["Auto Parry"] = nil
            end
        end
    end
})

BlatantTab0:CreateToggle({
    Name = "Auto Clash",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        if state then
			connections_Manager["Auto Spam"] = RunService.PreSimulation:Connect(function(delta)
				local Ball = Auto_Parry.Get_Ball()
				if Ball then
                    local Zoomies = Ball:FindFirstChild("zoomies")
                    if Zoomies then
                        local Speed = Zoomies.VectorVelocity.Magnitude
                        local Distance = LocalPlayer:DistanceFromCharacter(Ball.Position)
                        local Speed_Factor = Speed / 250
                        local Ball_Distance_Threshold = 17 + Speed_Factor * 7 - math.min(Distance / 2000)
                        if Distance < Ball_Distance_Threshold and Parries > Threshold then
                            Auto_Parry.Parry(Selected_Parry_Type)
                        end
                    end
                end
			end)
		else
			if connections_Manager["Auto Spam"] then
				connections_Manager["Auto Spam"]:Disconnect()
				connections_Manager["Auto Spam"] = nil
			end
		end
    end
})

BlatantTab0:CreateDropdown({
    Name = "Curve Type",
    Options = {"Camera", "Normal", "Speed", "High", "Down", "Random", "Left", "Right", "Backwards"},
    Default = "Camera",
    Callback = function(state)
        Selected_Parry_Type = state
    	CurveType = state
    end
})

BlatantTab0:CreateToggle({
    Name = "Random Curve",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        if state then
			connections_Manager["Random Curve"] = RunService.Heartbeat:Connect(function()
                Selected_Parry_Type = ({"Speed", "High", "Down", "Random", "Left", "Right", "Backwards"})[math.random(7)]
            end)
		else
			if connections_Manager["Random Curve"] then
				connections_Manager["Random Curve"]:Disconnect()
				connections_Manager["Random Curve"] = nil
			end
			Selected_Parry_Type = CurveType
		end
    end
})

BlatantTab0:CreateSection({Name = "AUTO ABILITY"})

BlatantTab0:CreateToggle({
    Name = "Auto Ability - AP",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        getgenv().AutoAbility = state
    end
})

BlatantTab0:CreateDropdown({
    Name = "Legit / Blatant",
    Options = {"Legit", "Blatant"},
    Default = "Blatant",
    Callback = function(state)
        getgenv().abilityrandom = state
    end
})

BlatantTab1:CreateToggle({
    Name = "Infinity Detection",
    Default = true,
    Keybind = Enum.KeyCode,
    Callback = function(state)
        getgenv().InfinityDetection = state
    end
})

BlatantTab1:CreateToggle({
    Name = "Death Slash Detection",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        getgenv().DeathSlashDetection = state
    end
})

BlatantTab1:CreateToggle({
    Name = "Time Hole Detection",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        getgenv().TimeHoleDetection = state
    end
})

BlatantTab1:CreateToggle({
    Name = "Slash of Fury Detection",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        getgenv().SlashOfFuryDetection = state
    end
})

BlatantTab1:CreateToggle({
    Name = "Forcefield Detection",
    Default = true,
    Keybind = Enum.KeyCode,
    Callback = function(state)
        getgenv().ForcefieldDetection = state
    end
})

BlatantTab1:CreateToggle({
    Name = "Singularity Detection",
    Default = true,
    Keybind = Enum.KeyCode,
    Callback = function(state)
        getgenv().SingularityCape2 = state
    end
})

BlatantTab5:CreateToggle({
    Name = "Legit Parry - AP",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        if state then
            connections_Manager["leggb"] = RunService.Heartbeat:Connect(function()
                for _, Ball in pairs(Auto_Parry.Get_Balls()) do
                    if Ball then
                        local Zoomies = Ball:FindFirstChild("zoomies")
                        if Zoomies then
                            local a = Workspace.Alive:FindFirstChild(LocalPlayer.Name)
                            local b = #Workspace.Alive:GetChildren()
                            local Ball_Target = Ball:GetAttribute("target")
                            if (Ball_Target == LocalPlayer.Name or (b == 1 and a)) and Ball ~= LastBall1 and LastBall1 ~= nil then
                                if LastSpeed2 >= getgenv().instantparry then
                                    Auto_Parry.Parry(Selected_Parry_Type)
                                end
                            end
                            LastBall1 = Ball
                            LastSpeed2 = Zoomies.VectorVelocity.Magnitude
                        end
                    end
                end
            end)
        else
            if connections_Manager["leggb"] then
                connections_Manager["leggb"]:Disconnect()
                connections_Manager["leggb"] = nil
            end
		end
    end
})

BlatantTab5:CreateToggle({
    Name = "Tiggerbot",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        if state then
            connections_Manager["Triggerbot"] = RunService.PreSimulation:Connect(function()
                for _, Ball in pairs(Auto_Parry.Get_Balls()) do
                    if Ball then
                        local Zoomies = Ball:FindFirstChild("zoomies")
                        if Zoomies then
                            local Ball_Target = Ball:GetAttribute("target")
                            local TeamPlayer = (LocalPlayer.Team.Name == "Blue" and "Goal1" or LocalPlayer.Team.Name == "Red" and "Goal2")
                            if not Workspace.Map:FindFirstChild("WorldCup") then
                                if Ball_Target ~= LocalPlayer.Name then
                                    ParriedTigger = false
                                end else
                                if Ball_Target ~= TeamPlayer then
                                    ParriedTigger = false
                                end
                            end
                            if not ParriedTigger then
                                if not PlrForc then
                                    local Speed = Zoomies.VectorVelocity.Magnitude
                                    if (Ball_Target == LocalPlayer.Name or Ball_Target == TeamPlayer) and Speed > 0 then
                                        Auto_Parry.Parry(Selected_Parry_Type)
                                        ParriedTigger = true
                                    end
                                end
                            end
                        end
                        local Triggerbot_Last_Parrys = tick()
                        repeat
                            RunService.PreSimulation:Wait()
                        until (tick() - Triggerbot_Last_Parrys) >= Tiggerbot_2 or not ParriedTigger
                        ParriedTigger = false
                    end
                end
            end)
        else
            if connections_Manager["Triggerbot"] then
                connections_Manager["Triggerbot"]:Disconnect()
                connections_Manager["Triggerbot"] = nil
            end
        end
    end
})

BlatantTab5:CreateToggle({
    Name = "Manual Spam",
    Keybind = Enum.KeyCode.E,
    Callback = function(state)
        if state then
            if isMobile then
                if game:GetService("CoreGui"):FindFirstChild(getgenv().mname) then
                    game:GetService("CoreGui")[getgenv().mname].Enabled = true
                    return
                end
                local TweenService = game:GetService("TweenService")
                local ScreenGui = Instance.new("ScreenGui")
                ScreenGui.Name = getgenv().mname
                local Frame = Instance.new("Frame")
                local UICorner = Instance.new("UICorner")
                local Title = Instance.new("TextLabel")
                local Toggle = Instance.new("TextButton")
                local ToggleCorner = Instance.new("UICorner")
                local Dot = Instance.new("Frame")
                local DotCorner = Instance.new("UICorner")
                local UIStroke = Instance.new("UIStroke")
                ScreenGui.Parent = game:GetService("CoreGui")
                ScreenGui.Enabled = true
                Frame.Parent = ScreenGui
                UICorner.Parent = Frame
                Title.Parent = Frame
                Toggle.Parent = Frame
                ToggleCorner.Parent = Toggle
                Dot.Parent = Toggle
                DotCorner.Parent = Dot
                UIStroke.Parent = Frame
                ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                Frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
                Frame.Size = UDim2.new(0,220,0,100)
                Frame.Position = UDim2.new(0.5,-110,0.5,-50)
                Frame.Active = true
                UICorner.CornerRadius = UDim.new(0,15)
                UIStroke.Thickness = 2
                UIStroke.Color = Color3.fromRGB(40,40,40)
                Title.BackgroundTransparency = 1
                Title.Size = UDim2.new(1,0,0,22)
                Title.Position = UDim2.new(0,0,0,0)
                Title.Text = "Argon Hub X"
                Title.TextColor3 = Color3.fromRGB(255,255,255)
                Title.Font = Enum.Font.GothamBold
                Title.TextScaled = true
                Toggle.Size = UDim2.new(0.9,0,0,35)
                Toggle.Position = UDim2.new(0.05,0,0.37,0)
                Toggle.BackgroundColor3 = Color3.fromRGB(20,20,20)
                Toggle.Text = "Toggle Spam"
                Toggle.TextColor3 = Color3.fromRGB(255,255,255)
                Toggle.Font = Enum.Font.Gotham
                Toggle.TextSize = 16
                Toggle.AutoButtonColor = false
                ToggleCorner.CornerRadius = UDim.new(0,10)
                Dot.Size = UDim2.new(0,14,0,14)
                Dot.Position = UDim2.new(0,12,0.5,-8)
                Dot.BackgroundColor3 = Color3.fromRGB(255,0,0)
                Dot.ZIndex = 2
                DotCorner.CornerRadius = UDim.new(1,0)
                Toggle.MouseEnter:Connect(function()
                    TweenService:Create(Toggle,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3 = Color3.fromRGB(20,20,20)}):Play()
                end)
                Toggle.MouseLeave:Connect(function()
                    local col = state and Color3.fromRGB(20,20,20) or Color3.fromRGB(20,20,20)
                    TweenService:Create(Toggle,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3 = col}):Play()
                end)
                Toggle.MouseButton1Click:Connect(function()
                    state = not state
                    if state then
                        TweenService:Create(Dot,TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3 = Color3.fromRGB(0,255,0)}):Play()
                        TweenService:Create(Toggle,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(20,20,20)}):Play()
                        connections_Manager["manualspam"] = RunService.PreSimulation:Connect(function()
                            Auto_Parry.Parry(Selected_Parry_Type)
                        end)
                    else
                        TweenService:Create(Dot,TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3 = Color3.fromRGB(255,0,0)}):Play()
                        TweenService:Create(Toggle,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(20,20,20)}):Play()
                        if connections_Manager["manualspam"] then
                            connections_Manager["manualspam"]:Disconnect()
                            connections_Manager["manualspam"] = nil
                        end
                    end
                end)
                local dragging, dragInput, dragStart, startPos
                function update(input)
                    local delta = input.Position - dragStart
                    local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                    TweenService:Create(Frame,TweenInfo.new(0.12,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position = newPos}):Play()
                end
                Frame.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                        dragStart = input.Position
                        startPos = Frame.Position
                        input.Changed:Connect(function()
                            if input.UserInputState == Enum.UserInputState.End then
                                dragging = false
                            end
                        end)
                    end
                end)
                Frame.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                        dragInput = input
                    end
                end)
                UserInputService.InputChanged:Connect(function(input)
                    if input == dragInput and dragging then
                        update(input)
                    end
                end)
                function downspam()
                    state = false
                    Dot.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                end
            else
                connections_Manager["manualspam"] = RunService.PreSimulation:Connect(function()
                    Auto_Parry.Parry(Selected_Parry_Type)
                end)
            end
        else
            if game:GetService("CoreGui"):FindFirstChild(getgenv().mname) then
                game:GetService("CoreGui")[getgenv().mname].Enabled = false
                downspam()
            end
            if connections_Manager["manualspam"] then
                connections_Manager["manualspam"]:Disconnect()
                connections_Manager["manualspam"] = nil
            end
        end
    end
})

BlatantTab2:CreateToggle({
    Name = "Anti Phatom Attack",
    Default = true,
    Keybind = Enum.KeyCode,
    Callback = function(state)
        if state then
            connections_Manager["Anti Phantom Attack"] = RunService.Heartbeat:Connect(function()
                for _, Ball in pairs(Auto_Parry.Get_Balls()) do
                    if Ball then
                        local Ball_Target = Ball:GetAttribute("target")
                        if Phantom and Ball_Target == LocalPlayer.Name then
                            ContextActionService:BindAction("BlockMovement", function() return Enum.ContextActionResult.Sink end, false, unpack(Enum.PlayerActions:GetEnumItems()))
                            LocalPlayer.Character.Humanoid.WalkSpeed = 37.5
                            LocalPlayer.Character.Humanoid:MoveTo(Ball.Position)
                            Ball:GetAttributeChangedSignal("target"):Once(function()
                                ContextActionService:UnbindAction("BlockMovement")
                                LocalPlayer.Character.Humanoid.WalkSpeed = 36
                                LocalPlayer.Character.Humanoid:MoveTo(LocalPlayer.Character.HumanoidRootPart.Position)
                                Phantom = false
                            end)
                        end
                    end
                end
            end)
        else
            if connections_Manager["Anti Phantom Attack"] then
                connections_Manager["Anti Phantom Attack"]:Disconnect()
                connections_Manager["Anti Phantom Attack"] = nil
            end
        end
    end
})

BlatantTab2:CreateToggle({
    Name = "Anti Hellhok Attack",
    Default = true,
    Keybind = Enum.KeyCode,
    Callback = function(state)
        getgenv().Anti_Hellhook = state
    end
})

BlatantTab2:CreateToggle({
    Name = "Cooldown Protection",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        getgenv().AutoColdown = state
    end
})

BlatantTab2:CreateToggle({
    Name = "Anti Pulse Protection",
    Default = true,
    Keybind = Enum.KeyCode,
    Callback = function(state)
        getgenv().antipulse = state
    end
})

BlatantTab3:CreateToggle({
    Name = "Random Accuracy",
    Keybind = Enum.KeyCode,
    Callback = function(state)
    end
})

BlatantTab3:CreateSection({Name = "SETTINGS - BLATANT"})

BlatantTab3:CreateSlider({
    Name = "Parry Accuracy",
    Min = 1, Max = 100, Default = 100,
    Increment = 1, Clamp = 1,
    Callback = function(state)
    end
})

BlatantTab3:CreateSlider({
    Name = "Tigger Speed",
    Min = 0.7, Max = 1, Default = 0.7,
    Increment = 0.1, Clamp = 1,
    Callback = function(state)
        Tiggerbot_2 = state
    end
})

BlatantTab3:CreateSlider({
    Name = "Legit Speed",
    Min = 1, Max = 400, Default = 100,
    Increment = 1, Clamp = 1,
    Callback = function(state)
        getgenv().instantparry = state
    end
})

BlatantTab3:CreateSlider({
    Name = "Threshold Spam",
    Min = 1, Max = 3, Default = 2,
    Increment = 1, Clamp = 1,
    Callback = function(state)
        Threshold = state
    end
})

BlatantTab3:CreateSlider({
    Name = "Slash Fury Delay",
    Min = 0, Max = 1, Default = 0,
    Increment = 0.1, Clamp = 1,
    Callback = function(state)
        getgenv().SlashOfFuryDelay = state
    end
})

BlatantTab3:CreateSection({Name = "LOBBY AP"})

BlatantTab3:CreateToggle({
    Name = "Random Accuracy.",
    Keybind = Enum.KeyCode,
    Callback = function(state)
    end
})

BlatantTab3:CreateSlider({
    Name = "Parry Accuracy.",
    Min = 0, Max = 100, Default = 100,
    Increment = 1, Clamp = 1,
    Callback = function(state)
    end
})

BlatantTab3:CreateSlider({
    Name = "Speed for Spam",
    Min = 0, Max = 1000, Default = 750,
    Increment = 1, Clamp = 1,
    Callback = function(state)
        getgenv().speedforspam = state
    end
})

BlatantTab3:CreateSection({Name = "TIGGERBOT - BLATANT"})

BlatantTab3:CreateSlider({
    Name = "Tigger Speed.",
    Min = 0.7, Max = 1, Default = 0.7,
    Increment = 0.1, Clamp = 1,
    Callback = function(state)
        Tiggerbot_3 = state
    end
})

BlatantTab4:CreateToggle({
    Name = "Auto Parry.",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        if state then
            connections_Manager["Lobby AP"] = RunService.PreSimulation:Connect(function()
                local Ball = Auto_Parry.Lobby_Balls()
                if Ball then
                    local Zoomies = Ball:FindFirstChild("zoomies")
                    if Zoomies then
                        Ball.AttributeChanged:Once(function()
                            Training_Parried = false
                        end)
                        if not Training_Parried then
                            local Speed = Zoomies.VectorVelocity.Magnitude
                            if Speed > 0 then
                                local Ball_Target = Ball:GetAttribute("target")
                                local Distance = LocalPlayer:DistanceFromCharacter(Ball.Position)
                                local Ping = Stats["Data Ping"]:GetValue() / 10
                                local LobbyAPParry_Accuracys = math.max(math.max(Ping, 4) + Speed / 3.5, 9.5)
                                if Ball_Target == LocalPlayer.Name and Distance <= LobbyAPParry_Accuracys then
                                    Auto_Parry.Parry(Selected_Parry_Type)
                                    Training_Parried = true
                                end
                            end
                        end
                    end
                end
            end)
        else
            if connections_Manager["Lobby AP"] then
                connections_Manager["Lobby AP"]:Disconnect()
                connections_Manager["Lobby AP"] = nil
            end
        end
    end
})

BlatantTab4:CreateToggle({
    Name = "Auto Clash.",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        if state then
            connections_Manager["Lobby APP"] = RunService.PreSimulation:Connect(function()
                local Ball = Auto_Parry.Lobby_Balls()
                if Ball then
                    local Speed = (Ball:FindFirstChild("zoomies") and Ball.zoomies.VectorVelocity.Magnitude) or 0
                    if Speed >= getgenv().speedforspam then
                        Auto_Parry.Parry(Selected_Parry_Type)
                    end
                end
            end)
        else
            if connections_Manager["Lobby APP"] then
                connections_Manager["Lobby APP"]:Disconnect()
                connections_Manager["Lobby APP"] = nil
            end
        end
    end
})

BlatantTab4:CreateSection({Name = "TIGGERBOT - AP"})

BlatantTab4:CreateToggle({
    Name = "Tiggerbot.",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        if state then
            connections_Manager["TriggerbotAP"] = RunService.PreSimulation:Connect(function()
                local Ball = Auto_Parry.Lobby_Balls()
                if Ball then
                    Ball.AttributeChanged:Once(function()
                        ParriedTigger2 = false
                    end)
                    local Ball_Target = Ball:GetAttribute("target")
                    local Speed = (Ball:FindFirstChild("zoomies") and Ball.zoomies.VectorVelocity.Magnitude) or 0
                    if not ParriedTigger2 then
                        if Ball_Target == LocalPlayer.Name and Speed > 0 then
                            Auto_Parry.Parry(Selected_Parry_Type)
                            ParriedTigger2 = true
                        end
                    end
                end
            end)
        else
            if connections_Manager["TriggerbotAP"] then
                connections_Manager["TriggerbotAP"]:Disconnect()
                connections_Manager["TriggerbotAP"] = nil
            end
        end
    end
})

local PlayersTab0 = PlayersTab:CreateGroupbox("Local - Player", "Left")
local PlayersTab3 = PlayersTab:CreateGroupbox("Sword - Changer", "Right")
local PlayersTab2 = PlayersTab:CreateGroupbox("Avatar - Changer", "Left")
local PlayersTab4 = PlayersTab:CreateGroupbox("Korblox - Headless", "Right")

PlayersTab0:CreateToggle({
    Name = "Enabled Speed - Jump",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        if state then
            connections_Manager["speed"] = RunService.Heartbeat:Connect(function()
                LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().speed_jump1
                LocalPlayer.Character.Humanoid.UseJumpPower = true
                LocalPlayer.Character.Humanoid.JumpPower = getgenv().speed_jump2
            end)
        else
            if connections_Manager["speed"] then
                connections_Manager["speed"]:Disconnect()
                connections_Manager["speed"] = nil
            end
            LocalPlayer.Character.Humanoid.WalkSpeed = 36
            LocalPlayer.Character.Humanoid.JumpPower = 50
        end
    end
})

PlayersTab0:CreateSlider({
    Name = "Walk Speed",
    Min = 36, Max = 400, Default = 36,
    Increment = 1, Clamp = 1,
    Callback = function(state)
        getgenv().speed_jump1 = state
    end
})

PlayersTab0:CreateSlider({
    Name = "Jump Power",
    Min = 50, Max = 450, Default = 50,
    Increment = 1, Clamp = 1,
    Callback = function(state)
        getgenv().speed_jump2 = state
    end
})

PlayersTab3:CreateToggle({
    Name = "Sword Changer",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        getgenv().enabled = state
        if state then
            if getgenv().swordName ~= "" then
                LibraryN.Warn(screenGui, "Argon Hub X", "Everyone Will See The Animations.", 7)
            end
        end
    end
})

PlayersTab3:CreateSection({Name = "NAME SWORD"})

PlayersTab3:CreateTextbox({
    Name = "Sword Name",
    Default = "",
    Callback = function(state)
        getgenv().swordName = state
        if getgenv().enabled then
            if getgenv().swordName ~= "" then
                LibraryN.Warn(screenGui, "Argon Hub X", "Everyone Will See The Animations.", 7)
            end
        end
    end
})

PlayersTab2:CreateToggle({
    Name = "Avatar Changer",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        if state then
            MorphToPlayer(FindPlayerByName(username))
            connections_Manager["avatar_changerrr"] = LocalPlayer.CharacterAdded:Connect(function()
                task.wait(0.55)
                username2 = nil
                MorphToPlayer(FindPlayerByName(username))
            end)
        else
            if connections_Manager["avatar_changerrr"] then
                connections_Manager["avatar_changerrr"]:Disconnect()
                connections_Manager["avatar_changerrr"] = nil
            end
            MorphToPlayer(FindPlayerByName(LocalPlayer.Name))
        end
    end
})

PlayersTab2:CreateTextbox({
    Name = "Username",
    Default = "",
    Callback = function(state)
        username = state
        if connections_Manager["avatar_changerrr"] then
            task.spawn(function()
                MorphToPlayer(FindPlayerByName(username))
            end)
        end
    end
})

PlayersTab4:CreateToggle({
    Name = "Korblox",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        if state then
            function k()
                local rl = LocalPlayer.Character:WaitForChild("Right Leg", 5)
                if rl and not rl:FindFirstChild("KorbloxMesh") then
                    local m = Instance.new("SpecialMesh")
                    m.Name = "KorbloxMesh"
                    m.MeshId = "rbxassetid://101851696"
                    m.MeshType = Enum.MeshType.FileMesh
                    m.TextureId = "rbxassetid://115727863"
                    m.Parent = rl
                end
            end
            k() connections_Manager["k"] = LocalPlayer.CharacterAdded:Connect(function()
                task.wait(1) k()
            end)
		else
			if connections_Manager["k"] then
				connections_Manager["k"]:Disconnect()
				connections_Manager["k"] = nil
			end
			local char = LocalPlayer.Character
			if char then
				local rl = char:FindFirstChild("Right Leg")
				if rl then
					local m = rl:FindFirstChild("KorbloxMesh")
					if m then m:Destroy() end
				end
			end
		end
    end
})

PlayersTab4:CreateSection({Name = "KORBLOX - HEADLESS"})

PlayersTab4:CreateToggle({
    Name = "Headless",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        if state then
            function h()
                local head = LocalPlayer.Character:WaitForChild("Head", 5)
                if head then
                    if not head:FindFirstChild("iiface") then
                        local f = head:FindFirstChild("face")
                        if f then
                            f.Name = "iiface"
                            f.Transparency = 1
                        end
                    end
                    head.Transparency = 1
                end
            end
            h() connections_Manager["h"] = LocalPlayer.CharacterAdded:Connect(function()
                task.wait(1) h()
            end)
		else
			if connections_Manager["h"] then
				connections_Manager["h"]:Disconnect()
				connections_Manager["h"] = nil
			end
			local char = LocalPlayer.Character
			if char then
				local head = char:FindFirstChild("Head")
				if head then
					head.Transparency = 0
					local of = head:FindFirstChild("iiface")
					if of then
						of.Transparency = 0
						of.Name = "face"
					end
				end
			end
        end
    end
})

local WorldTab0 = WorldTab:CreateGroupbox("Personal - Detection", "Left")
local WorldTab1 = WorldTab:CreateGroupbox("No Render - Effects", "Right")
local WorldTab3 = WorldTab:CreateGroupbox("ESP Ability / Anti View", "Left")
local WorldTab2 = WorldTab:CreateGroupbox("Tutorials - News", "Right")
local WorldTab4 = WorldTab:CreateGroupbox("Emotes - Changer (1)", "Left")
local WorldTab5 = WorldTab:CreateGroupbox("Emotes - Changer (2)", "Right")

WorldTab0:CreateToggle({
    Name = "Staff Detection",
    Default = true,
    Keybind = Enum.KeyCode,
    Callback = function(state)
        if state then
            task.spawn(function()
                function handle(player)
                    local r = tostring(player:GetRoleInGroup(12836673)):lower()
                    if r ~= "guest" and r ~= "member" and r ~= "" then
                        if getgenv().autokick then
                            task.spawn(function()
                                LocalPlayer:Kick("Personal Detected: " .. player.DisplayName)
                            end)
                            if game:GetService("Stats"):FindFirstChild("Network"):FindFirstChild("ServerStatsItem") then
                                if getgenv().shownwarning then
                                    LibraryN.Error(screenGui, "Argon Hub X", "An Error Occurred The Kick.", 15)
                                    LibraryN.Error(screenGui, "Argon Hub X", "Were Kicking You.", 15)
                                end
                                task.wait(1)
                                task.spawn(function()
                                    game:Shutdown()
                                end)
                                if game:GetService("Stats"):FindFirstChild("Network"):FindFirstChild("ServerStatsItem") then
                                    LibraryN.Warn(screenGui, "Argon Hub X", "Personal Detected: "..player.DisplayName, 15)
                                end
                            end
                        elseif getgenv().serverhop then
                            loadstring(game:HttpGet("https://raw.githubusercontent.com/AgentX771/ArgonHubX/main/Privating/q.lua"))()
                        elseif getgenv().notify then
                           LibraryN.Warn(screenGui, "Argon Hub X", "Personal Detected: ".. player.DisplayName, 15)
                        end
                    end
                end
                connections_Manager["personal_detection"] = game.Players.PlayerAdded:Connect(handle)
                for _, p in ipairs(game.Players:GetPlayers()) do
                    handle(p)
                end
            end)
        else
            if connections_Manager["personal_detection"] then
                connections_Manager["personal_detection"]:Disconnect()
                connections_Manager["personal_detection"] = nil
            end
        end
    end
})

WorldTab0:CreateToggle({
    Name = "Show Warnings",
    Default = true,
    Keybind = Enum.KeyCode,
    Callback = function(state)
        getgenv().shownwarning = state
    end
})

WorldTab0:CreateSection({Name = "ACTION - DETECTED"})

WorldTab0:CreateDropdown({
    Name = "Staff Action",
    Options = {"Notification", "Kick Server", "Change Server"},
    Default = "Notification",
    Callback = function(state)
        getgenv().notify = state == "Notification"
        getgenv().autokick = state == "Kick Server"
        getgenv().serverhop = state == "Change Server"
    end
})

WorldTab1:CreateToggle({
    Name = "No Effects Game",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        Net:FireServer("Low Graphics", state)
    end
})

WorldTab1:CreateSection({Name = "SWORDS VFX"})

WorldTab1:CreateToggle({
    Name = "No Weapon VFX",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        Net:FireServer("Weapon VFX", not state)
    end
})

WorldTab1:CreateToggle({
    Name = "No Explosion VFX",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        Net:FireServer("Explosion VFX", not state)
    end
})

WorldTab3:CreateToggle({
    Name = "ESP Ability",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        if state then
            getgenv().AbilityESPEnabled = state
            pcall(updateESPs)
        else
            pcall(removeAllESPs)
        end
    end
})

WorldTab3:CreateToggle({
    Name = "Remove Dead",
    Default = true,
    Keybind = Enum.KeyCode,
    Callback = function(state)
        getgenv().AbilityESPDead = not state
        pcall(updateESPs)
    end
})

WorldTab3:CreateSection({Name = "OTHER SCRIPTS"})

WorldTab3:CreateToggle({
    Name = "Anti View Ability",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        if state then
			getgenv().ab1 = LocalPlayer:GetAttribute("CurrentlyEquippedAbility")
			getgenv().ab2 = getgenv().ab1 == "Infinity" and "Phantom." or "Infinity."
			LocalPlayer:SetAttribute("CurrentlyEquippedAbility", getgenv().ab2)
			LocalPlayer:SetAttribute("EquippedAbility", getgenv().ab2)
			connections_Manager.antiview1 = LocalPlayer:GetAttributeChangedSignal("CurrentlyEquippedAbility"):Connect(function()
				getgenv().ab1 = LocalPlayer:GetAttribute("CurrentlyEquippedAbility")
				getgenv().ab2 = getgenv().ab1 == "Infinity" and "Phantom." or "Infinity."
				LocalPlayer:SetAttribute("CurrentlyEquippedAbility", getgenv().ab2)
				LocalPlayer:SetAttribute("EquippedAbility", getgenv().ab2)
			end)
		else
			if connections_Manager.antiview1 then
				connections_Manager.antiview1:Disconnect()
				connections_Manager.antiview1 = nil
			end
			LocalPlayer:SetAttribute("CurrentlyEquippedAbility", getgenv().ab1)
			LocalPlayer:SetAttribute("EquippedAbility", getgenv().ab1)
		end
    end
})

WorldTab2:CreateToggle({
    Name = "Tutorial 1",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        if state then
            if game.PlaceId == 16044264830 then
                for _, u in ipairs(LocalPlayer.PlayerGui.TutorialWon:GetDescendants()) do
                    if u:IsA("TextButton") or u:IsA("ImageButton") then
                        for _, o in ipairs(getconnections(u.MouseButton1Click)) do
                            o:Fire()
                        end
                    end
                end
            end
        end
    end
})

WorldTab2:CreateSection({Name = "NEWS PLAYERS"})

WorldTab2:CreateToggle({
    Name = "Tutorial 2",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        if state then
            if game.PlaceId == 16281300371 then
                connections_Manager["skip_tutoriall"] = LocalPlayer:GetAttributeChangedSignal("PlayerWins"):Connect(function()
                    if LocalPlayer:GetAttribute("PlayerWins") >= 5 then
                        if getgenv().Tutorials then
                            LibraryN.Info(screenGui, "Argon Hub X", "The Tutorial Was Completed Success.", 5)
                            task.wait(1)
                        end
                        TeleportService:Teleport(13772394625, LocalPlayer)
                    end
                end)
                if LocalPlayer:GetAttribute("PlayerWins") >= 5 then
                    if getgenv().Tutorials then
                        LibraryN.Info(screenGui, "Argon Hub X", "The Tutorial Was Completed Success.", 5)
                        task.wait(1)
                    end
                    TeleportService:Teleport(13772394625, LocalPlayer)
                end
            end
        else
            if connections_Manager["skip_tutoriall"] then
                connections_Manager["skip_tutoriall"]:Disconnect()
                connections_Manager["skip_tutoriall"] = nil
            end
        end
    end
})

WorldTab2:CreateLabel({Name = "Tutorial (2):\nThe tutorial will be completed when you reach 5 rounds."})

WorldTab4:CreateToggle({
    Name = "Play Emote",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        if state then
            connections_Manager["emotesall"] = RunService.Heartbeat:Connect(function()
                local a = Workspace.Alive:FindFirstChild(LocalPlayer.Name) or Workspace.Dead:FindFirstChild(LocalPlayer.Name)
                local b = a:GetAttribute("CurrentlyPlayingAnimation")
                local stop = false
                if getgenv().StopEmoteMode == "All" then
                    stop = (b == "walk" or b == "jump" or b == "fall")
                elseif getgenv().StopEmoteMode == "Walk" then
                    stop = (b == "walk")
                elseif getgenv().StopEmoteMode == "Jump" then
                    stop = (b == "jump")
                elseif getgenv().StopEmoteMode == "Fall" then
                    stop = (b == "fall")
                end
                if stop then
                    if Animation.track then
                        Animation.track:Stop()
                    end
                else
                    if Animation.track and not Animation.track.IsPlaying then
                        Animation.track:Play()
                    end
                end
            end)
        else
            if connections_Manager["emotesall"] then
                connections_Manager["emotesall"]:Disconnect()
                connections_Manager["emotesall"] = nil
                Animation.track:Stop()
            end
        end
    end
})

WorldTab4:CreateToggle({
    Name = "Play by Win",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        if state then
            connections_Manager["play_by_win"] = RunService.Heartbeat:Connect(function()
                local a = Workspace.Alive:FindFirstChild(LocalPlayer.Name)
                local b = #Workspace.Alive:GetChildren()
                if not connections_Manager["emotesall"] then
                    if b == 1 and a then
                        local a = Workspace.Alive:FindFirstChild(LocalPlayer.Name) or Workspace.Dead:FindFirstChild(LocalPlayer.Name)
                        local b = a:GetAttribute("CurrentlyPlayingAnimation")
                        local stop = false
                        if getgenv().StopEmoteMode == "All" then
                            stop = (b == "walk" or b == "jump" or b == "fall")
                        elseif getgenv().StopEmoteMode == "Walk" then
                            stop = (b == "walk")
                        elseif getgenv().StopEmoteMode == "Jump" then
                            stop = (b == "jump")
                        elseif getgenv().StopEmoteMode == "Fall" then
                            stop = (b == "fall")
                        end
                        if stop then
                            if Animation.track then
                                Animation.track:Stop()
                            end
                        else
                            if Animation.track and not Animation.track.IsPlaying then
                                Animation.track:Play()
                            end
                        end
                    else
                        if Animation.track then
                            Animation.track:Stop()
                        end
                    end
                end
            end)
        else
            if connections_Manager["play_by_win"] then
                connections_Manager["play_by_win"]:Disconnect()
                connections_Manager["play_by_win"] = nil
            end
        end
    end
})

WorldTab5:CreateDropdown({
    Name = "Emotes",
    Options = Emote_Data,
    Default = "",
    Callback = function(state)
        local anim = Animation.storage[state]
        local hum = LocalPlayer.Character.Humanoid
        if anim then
            Animation.animation = anim
            Animation.last = anim
            if Animation.track then
                Animation.track:Stop()
            end
            Animation.track = hum:LoadAnimation(Animation.animation)
            Animation.track.Looped = true
            if connections_Manager["emotesall"] then
                Animation.track:Play()
            end
        end
    end
})

WorldTab5:CreateDropdown({
    Name = "Stop Emote",
    Options = {"All", "Walk", "Jump", "Fall", "No Stop"},
    Default = "All",
    Callback = function(state)
        getgenv().StopEmoteMode = state
    end
})

local DesyncsTab0 = DesyncsTab:CreateGroupbox("Semi Inmortal - Walkable", "Left")
local DesyncsTab1 = DesyncsTab:CreateGroupbox("Semi Inmortal - No Walkable", "Right")
local DesyncsTab2 = DesyncsTab:CreateGroupbox("Lag Ball - (Abuse)", "Left")
local DesyncsTab3 = DesyncsTab:CreateGroupbox("Notifications", "Right")

DesyncsTab0:CreateToggle({
    Name = "Semi Inmortal",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        if state then
            if getgenv().Inmortalsx then
                LibraryN.Warn(screenGui, "Argon Hub X", "Semi-Immortal Walkable Enabled.", 10)
            end
            connections_Manager["semi_inmortal_walkable"] = RunService.Heartbeat:Connect(function()
                if Workspace.Alive:FindFirstChild(LocalPlayer.Name) then
                    local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    DesyncTypes[1] = hrp.CFrame
                    DesyncTypes[2] = hrp.AssemblyLinearVelocity
                    local SpoofThis = hrp.CFrame
                    local angle = tick() * 50000 * (math.sin(tick() * 50) > 0 and 1 or -1)
                    hrp.CFrame = SpoofThis * CFrame.new(math.cos(angle) * getgenv().radius1, 0, math.sin(angle) * getgenv().radius1)
                    hrp.AssemblyLinearVelocity = DesyncTypes[2]
                    RunService.RenderStepped:Wait()
                    hrp.CFrame = DesyncTypes[1]
                    hrp.AssemblyLinearVelocity = DesyncTypes[2]
                end
            end)
        else
            if connections_Manager["semi_inmortal_walkable"] then
                connections_Manager["semi_inmortal_walkable"]:Disconnect()
                connections_Manager["semi_inmortal_walkable"] = nil
            end
        end
    end
})

DesyncsTab0:CreateSlider({
    Name = "Immortal Radius",
    Min = 15, Max = 50, Default = 50,
    Increment = 1, Clamp = 1,
    Callback = function(state)
        getgenv().radius1 = state
    end
})

DesyncsTab0:CreateSlider({
    Name = "Immortal Height",
    Min = 5, Max = 75, Default = 35,
    Increment = 1, Clamp = 1,
    Callback = function(state)
    end
})

DesyncsTab0:CreateSlider({
    Name = "Immortal Speed",
    Min = 10, Max = 150, Default = 15,
    Increment = 1, Clamp = 1,
    Callback = function(state)
    end
})

DesyncsTab1:CreateToggle({
    Name = "Semi Inmortal",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        if state then
            if getgenv().Inmortalsx then
                LibraryN.Warn(screenGui, "Argon Hub X", "Semi-Immortal No Walkable Enabled.", 10)
            end
            connections_Manager["semi_inmortal_nowalkable"] = RunService.Heartbeat:Connect(function()
                if Workspace.Alive:FindFirstChild(LocalPlayer.Name) then
                    local RootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if tick() - LastSwitch >= (1 / 9e9) then
                        LastSwitch = tick()
                        Up = not Up
                        RootPart.CFrame = RootPart.CFrame * CFrame.new(0, Up and 250 or -250, 0)
                    end
                end
            end)
        else
            if connections_Manager["semi_inmortal_nowalkable"] then
                connections_Manager["semi_inmortal_nowalkable"]:Disconnect()
                connections_Manager["semi_inmortal_nowalkable"] = nil
            end
        end
    end
})

DesyncsTab1:CreateSlider({
    Name = "Immortal Height",
    Min = 15, Max = 50, Default = 15,
    Increment = 1, Clamp = 1,
    Callback = function(state)
        getgenv().highted2 = state
    end
})

DesyncsTab1:CreateSlider({
    Name = "Immortal Speed",
    Min = 2575, Max = 5000, Default = 2575,
    Increment = 1, Clamp = 1,
    Callback = function(state)
        getgenv().speed2 = state
    end
})

DesyncsTab2:CreateToggle({
    Name = "Lag - Ball",
    Keybind = Enum.KeyCode,
    Callback = function(state)
        Net:FireServer("Gray Sky", state)
		if state then
			connections_Manager["lag_balll"] = RunService.PreSimulation:Connect(function()
				for i = 1, (getgenv().lagballip or 2) do
					Net:FireServer("Lag-Ball")
				end
			end)
		else
			if connections_Manager["lag_balll"] then
				connections_Manager["lag_balll"]:Disconnect()
				connections_Manager["lag_balll"] = nil
			end
			Net:FireServer("Lag-Ball", false)
		end
    end
})

DesyncsTab2:CreateSlider({
    Name = "Lag - Ball (Rate)",
    Min = 1, Max = 3, Default = 3,
    Increment = 1, Clamp = 1,
    Callback = function(state)
        getgenv().lagballip = state
    end
})

DesyncsTab3:CreateToggle({
    Name = "Hellhook",
    Default = true,
    Keybind = Enum.KeyCode,
    Callback = function(state)
        getgenv().HellHookNotify = state
    end
})

DesyncsTab3:CreateToggle({
    Name = "Phantom",
    Default = true,
    Keybind = Enum.KeyCode,
    Callback = function(state)
        getgenv().PhantomNotify = state
    end
})

DesyncsTab3:CreateToggle({
    Name = "Tutorials",
    Default = true,
    Keybind = Enum.KeyCode,
    Callback = function(state)
        getgenv().Tutorials = state
    end
})

DesyncsTab3:CreateToggle({
    Name = "Inmortals",
    Default = true,
    Keybind = Enum.KeyCode,
    Callback = function(state)
        getgenv().Inmortalsx = state
    end
})

local Settings0 = SettingsTab:CreateGroupbox("Settings UI", "Left")
local Settings1 = SettingsTab:CreateGroupbox("Interface UI", "Right")
local Settings2 = SettingsTab:CreateGroupbox("Discord", "Left")
local Settings3 = SettingsTab:CreateGroupbox("Auto - Rewards", "Right")

Settings0:CreateButton({
    Name = "Save Settings",
    Callback = function()
        Library:SaveConfig("-argon-hub-x")
        LibraryN.Info(screenGui, "Argon Hub X", "Settings Saved.", 5)
    end
})

Settings0:CreateButton({
    Name = "Load Settings",
    Callback = function()
        if not getgenv().LoadSetting then getgenv().LoadSetting = true
            Library:LoadConfig("-argon-hub-x")
            getgenv().LoadedArgonSettings = true
        end
        if getgenv().LoadedArgonSettings then
            LibraryN.Info(screenGui, "Argon Hub X", "Settings Loaded.", 2) else
            LibraryN.Warn(screenGui, "Argon Hub X", "Some Settings Are Loading.", 5)
        end
    end
})

Settings0:CreateSection({Name = "TOGGLE UI"})

Settings0:CreateKeybind({
    Name = "Toggle UI",
    Default = Enum.KeyCode.LeftControl,
    Callback = function(state)
        Library.ToggleKey = state
    end
})

Settings1:CreateToggle({
    Name = "UI - Undetectable",
    Default = true,
    Keybind = Enum.KeyCode,
    Callback = function(state)
    end
})

Settings1:CreateSection({Name = "REMOTES (HASHES)"})
Settings1:CreateLabel({Name = "Remote: "..tostring(Net and Net.Name or "N/A") .."\nHash 1: "..tostring(Parry_Args) .."\nHash 2: "..tostring(Parry_Key)})

Settings2:CreateButton({
    Name = "Join Discord",
    Callback = function()
        setclipboard("https://discord.gg/U3xsxbtSp2")
        LibraryN.Info(screenGui, "Argon Hub X", "Link Copied To Clipboard.", 5)
    end
})

Settings3:CreateToggle({
    Name = "Auto - Rewards",
    Default = true,
    Keybind = Enum.KeyCode,
    Callback = function(state)
        if state then
            function claim_rewards()
                if getgenv().dailyreward then
                    for d = 0, 30 do
                        ReplicatedStorage.Remote.RemoteFunction:InvokeServer("ClaimNewDailyLoginReward", d)
                    end
                end
                if getgenv().taskrewards then
                    ReplicatedStorage.Remote.RemoteEvent:FireServer("OpeningCase", true)
                end
                if getgenv().spinrewards then
                    ReplicatedStorage.Remote.RemoteFunction:InvokeServer("SpinWheel")
                end
            end
            claim_rewards()
            connections_Manager["Auto-Rewards-AP"] = LocalPlayer.CharacterAdded:Connect(claim_rewards)
        else
            if connections_Manager["Auto-Rewards-AP"] then
				connections_Manager["Auto-Rewards-AP"]:Disconnect()
				connections_Manager["Auto-Rewards-AP"] = nil
			end
        end
    end
})

Settings3:CreateDropdown({
    Name = "Type Rewards",
    Options = {"All", "Tasks", "Spins"},
    Default = "All",
    Callback = function(state)
        getgenv().dailyreward = false
        getgenv().taskrewards = false
        getgenv().spinrewards = false
        if state == "All" then
            getgenv().dailyreward = true
            getgenv().taskrewards = true
            getgenv().spinrewards = true
            getgenv().codesrewards = true
        elseif state == "Tasks" then
            getgenv().taskrewards = true
        elseif state == "Spins" then
            getgenv().spinrewards = true
        end
        pcall(claim_rewards)
    end
})

local old
old = hookmetamethod(game, "__index", newcclosure(function(self, key)
    if key == "CFrame" and not checkcaller() and not Workspace.Dead:FindFirstChild(LocalPlayer.Name) then
        if connections_Manager["semi_inmortal_walkable"] then
            if self == LocalPlayer.Character.HumanoidRootPart then
                return DesyncTypes[1] or CFrame.new()
            end
        end
    end
    return old(self, key)
end))

Balls1.ChildAdded:Connect(function(Value)
    Parries = 0 Parried = false Phantom = false PlrForc = false getgenv().APJ = false
    Value.ChildAdded:Connect(function(Child)
        if getgenv().SlashOfFuryDetection and Child.Name == "ComboCounter" then
            PlrForc = true
            Child.AncestryChanged:Connect(function(_,parent)
                if not parent then
                    PlrForc = false
                end
            end)
            local Sof_Label = Child:FindFirstChildOfClass("TextLabel")
            if Sof_Label then
                local conn
                conn = Sof_Label:GetPropertyChangedSignal("Text"):Connect(function()
                    local Slashes_Counter = tonumber(Sof_Label.Text)
                    if Slashes_Counter < 35 and task.wait(getgenv().SlashOfFuryDelay) then
                        Auto_Parry.Parry(Selected_Parry_Type)
                    else
                        if conn then
                            conn:Disconnect()
                            conn = nil
                        end
                    end
                end)
            end
        end
    end)
end)

connections_Manager["hook-AntiController"] = RunService.PreSimulation:Connect(function()
    pcall(function()
        if getgenv().SingularityCape2 then PlrForc = LocalPlayer.Character.HumanoidRootPart:FindFirstChild("SingularityCape") end
    end)
end)

ReplicatedStorage.Remotes.PlrHellHooked.OnClientEvent:Connect(function(a,b)
    if b.Name == LocalPlayer.Name and getgenv().Anti_Hellhook then
        local pos = LocalPlayer.Character.HumanoidRootPart.CFrame
        connections_Manager["antihellhook"] = RunService.Heartbeat:Connect(function()
            LocalPlayer.Character.HumanoidRootPart.CFrame = pos
        end)
        if getgenv().HellHookNotify then
            LibraryN.Info(screenGui, "Argon Hub X", "Player Just HellHooked: "..a.Name, 5)
        end
    end
end)

ReplicatedStorage.Remotes.PlrHellHookCompleted.OnClientEvent:Connect(function()
    if connections_Manager["antihellhook"] and task.wait(1) then
        connections_Manager["antihellhook"]:Disconnect()
        connections_Manager["antihellhook"] = nil
    end
end)

ReplicatedStorage.Remotes.ParrySuccessAll.OnClientEvent:Connect(function()
    Curving = tick()
    Sword_CP = true
    for _, t in pairs(LocalPlayer.Character.Humanoid.Animator:GetPlayingAnimationTracks()) do
        if t.Name == "GrabParry" or t.Name == "Grab" then
            Auto_Parry.Grab_Parry_Stop(t)
        end
    end
end)

task.spawn(function()
    while task.wait(2) do
        if getgenv().AbilityESPEnabled then
            pcall(updateESPs)
        end
    end
end)

ReplicatedStorage.Remotes.Phantom.OnClientEvent:Connect(function(a,b)
    if b.Name == LocalPlayer.Name then
        Phantom = true
    end
    if getgenv().HellHookNotify then
        LibraryN.Info(screenGui, "Argon Hub X", "Player Just Phantom: "..a.Name, 5)
    end
end)

InfinityCD:GetPropertyChangedSignal("Offset"):Connect(function()
    if LocalPlayer.Character.Abilities["Forcefield"].Enabled and getgenv().ForcefieldDetection then
        PlrForc = true
    elseif LocalPlayer.Character.Abilities["Slashes of Fury"].Enabled and getgenv().SlashOfFuryDetection then
        PlrForc = true
    elseif LocalPlayer.Character.Abilities["Time Hole"].Enabled and getgenv().TimeHoleDetection then
        PlrForc = true
    elseif LocalPlayer.Character.Abilities["Death Slash"].Enabled and getgenv().DeathSlashDetection then
        PlrForc = true
    elseif LocalPlayer.Character.Abilities["Infinity"].Enabled and getgenv().InfinityDetection then
        PlrForc = true
    else
        PlrForc = false
    end
    if InfinityCD.Offset.Y >= 0.985 then PlrForc = false end
end)

task.spawn(function()
    getgenv().ToggleUIVisibility()
    task.wait(0.7)
    getgenv().ToggleUIVisibility()
end)

Balls1.ChildRemoved:Connect(function()
    Parries = 0 Parried = false Phantom = false PlrForc = false
end)

LocalPlayer.Idled:Connect(function()
    cloneref(game:GetService("VirtualUser")):CaptureController()
    cloneref(game:GetService("VirtualUser")):ClickButton2(Vector2.new())
end)
