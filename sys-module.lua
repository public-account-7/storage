getgenv().NeverLose = loadstring(game:HttpGet("https://raw.githubusercontent.com/cchoan709-ui/Ccho-/refs/heads/main/neveri.txt"))()

local NeverLose = getgenv().NeverLose
repeat task.wait() until game:IsLoaded()
setfflag("TaskSchedulerTargetFps", "5099990")
local Players = cloneref(game:GetService('Players'))
local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local UserInputService = cloneref(game:GetService('UserInputService'))
local RunService = cloneref(game:GetService('RunService'))
local Stats = cloneref(game:GetService('Stats'))
local CoreGui = cloneref(game:GetService('CoreGui'))

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GlassStatusGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 260, 0, 44)
Frame.Position = UDim2.new(0.5, -130, 0.12, 0)
Frame.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
Frame.BackgroundTransparency = 0.15
Frame.BorderSizePixel = 0
Frame.Active = true

local Corner = Instance.new("UICorner", Frame)
Corner.CornerRadius = UDim.new(1, 0)

local Stroke = Instance.new("UIStroke", Frame)
Stroke.Color = Color3.fromRGB(55, 55, 60)
Stroke.Thickness = 1
Stroke.Transparency = 0.25

local Gradient = Instance.new("UIGradient", Frame)
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 45))
})
Gradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.15),
    NumberSequenceKeypoint.new(1, 0.35)
})

local Layout = Instance.new("UIListLayout", Frame)
Layout.FillDirection = Enum.FillDirection.Horizontal
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.VerticalAlignment = Enum.VerticalAlignment.Center
Layout.Padding = UDim.new(0, 24)

local Padding = Instance.new("UIPadding", Frame)
Padding.PaddingLeft = UDim.new(0, 28)
Padding.PaddingRight = UDim.new(0, 28)

local createStat = function(titleText)
    local Holder = Instance.new("Frame")
    Holder.Size = UDim2.new(0, 56, 1, 0)
    Holder.BackgroundTransparency = 1
    Holder.Parent = Frame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0.45, 0)
    Title.BackgroundTransparency = 1
    Title.Text = titleText
    Title.Font = Enum.Font.GothamMedium
    Title.TextSize = 12
    Title.TextColor3 = Color3.fromRGB(180, 180, 185)
    Title.TextXAlignment = Enum.TextXAlignment.Center
    Title.TextYAlignment = Enum.TextYAlignment.Bottom
    Title.Parent = Holder

    local Value = Instance.new("TextLabel")
    Value.Position = UDim2.new(0, 0, 0.45, 0)
    Value.Size = UDim2.new(1, 0, 0.55, 0)
    Value.BackgroundTransparency = 1
    Value.Text = "0"
    Value.Font = Enum.Font.GothamBold
    Value.TextSize = 18
    Value.TextColor3 = Color3.fromRGB(235, 235, 235)
    Value.TextXAlignment = Enum.TextXAlignment.Center
    Value.TextYAlignment = Enum.TextYAlignment.Top
    Value.Parent = Holder

    return Value
end

local FPSValue  = createStat("FPS")
local CPUValue  = createStat("CPU %")
local PingValue = createStat("PING")

local frames = 0
local last = os.clock()

RunService.RenderStepped:Connect(function()
    frames += 1
    local now = os.clock()
    if now - last >= 1 then
        FPSValue.Text = tostring(frames)
        frames = 0
        last = now
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
            PingValue.Text = tostring(math.floor(ping))

            local cpu = math.clamp(Stats:GetTotalMemoryUsageMb() / 50, 1, 100)
            CPUValue.Text = tostring(math.floor(cpu))
        end)
    end
end)


local dragging = false
local dragStart, startPos

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
    end
end)

Frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

local Smooth = {}
Smooth.last = os.clock()
Smooth.avgDelta = 1/60
Smooth.alpha = 0.15

local clampSpike = function(delta)
    if delta > 0.08 then
        return Smooth.avgDelta
    end
    return delta
end

RunService.Heartbeat:Connect(function()
    local now = os.clock()
    local delta = now - Smooth.last
    Smooth.last = now

    delta = clampSpike(delta)
    Smooth.avgDelta = Smooth.avgDelta + (delta - Smooth.avgDelta) * Smooth.alpha
end)

RunService.RenderStepped:Connect(function(delta)
    local smoothDelta = Smooth.avgDelta
    local drift = math.abs(delta - smoothDelta)
    if drift > 0.012 then
        smoothDelta = (smoothDelta + delta) * 0.5
        Smooth.avgDelta = smoothDelta
    end
end)

task.spawn(function()
    while true do
        task.wait(0.017)
    end
end)

if not LocalPlayer.Character then
    LocalPlayer.CharacterAdded:Wait()
end


local islclosure = islclosure or function(f) return type(f) == "function" end
local setupvalue = setupvalue or debug.setupvalue

if not debug.getupvalues then
    debug.getupvalues = function(f)
        local t, i = {}, 1
        while true do
            local n, v = debug.getupvalue(f, i)
            if not n then break end
            t[i] = v
            i = i + 1
        end
        return t
    end
end

local function safeGetConnections(event)
    if not getconnections then return {} end
    local ok, r = pcall(getconnections, event)
    return (ok and r) or {}
end

local function disableConn(conn)
    if conn.Disable then 
        pcall(function() conn:Disable() end)
    elseif conn.Disconnect then 
        pcall(function() conn:Disconnect() end) 
    end
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Alive = workspace:FindFirstChild("Alive") or workspace:WaitForChild("Alive")
local Runtime = workspace:FindFirstChild("Runtime") or workspace:WaitForChild("Runtime")

local swordInstancesInstance = ReplicatedStorage:WaitForChild("Shared", 9e9):WaitForChild("ReplicatedInstances", 9e9):WaitForChild("Swords", 9e9)

local oldIdentity = (getthreadidentity and getthreadidentity()) or 2
if setthreadidentity then pcall(setthreadidentity, 2) end

local success, swordInstances = pcall(require, swordInstancesInstance)

if setthreadidentity then pcall(setthreadidentity, oldIdentity) end

if not success then return end

local getSlashName = function(swordName)
    if type(swordName) ~= "string" or swordName == "" then return "SlashEffect" end
    local ok, result = pcall(function() return swordInstances:GetSword(swordName) end)
    if ok and type(result) == "table" then
        return result.SlashName or result.SlashEffect or "SlashEffect"
    end
    return "SlashEffect"
end

local skinchangerSystem = {
    equipHooked = false,
    originalEquipSwordTo = nil,
    fxHooked = false,
    playParryFunc = nil,
    swordsController = nil,
    myParryHandler = nil,
    slashName = nil,
    changeSwordModel = false,
    changeSwordAnimation = false,
    changeSwordFX = false,
    fxConnection = nil,
    swordModel = nil,
    swordAnimations = nil,
    swordFX = nil,
    setSword = nil,
    skinChangerEnabled = false
}

if not skinchangerSystem.equipHooked then
    skinchangerSystem.originalEquipSwordTo = swordInstances.EquipSwordTo
    swordInstances.EquipSwordTo = function(self, char, swordName)
        if skinchangerSystem.skinChangerEnabled and skinchangerSystem.changeSwordModel and char == LocalPlayer.Character then
            swordName = skinchangerSystem.swordModel
        end
        return skinchangerSystem.originalEquipSwordTo(self, char, swordName)
    end
    skinchangerSystem.equipHooked = true
end

local setSword = function()
    if not skinchangerSystem.skinChangerEnabled then return end
    
    pcall(function() setupvalue(skinchangerSystem.originalEquipSwordTo, 3, false) end)
    
    if skinchangerSystem.changeSwordModel and LocalPlayer.Character then
        pcall(function()
            swordInstances:EquipSwordTo(LocalPlayer.Character, skinchangerSystem.swordModel)
        end)
    end
    
    if skinchangerSystem.changeSwordAnimation and skinchangerSystem.swordsController then
        pcall(function()
            skinchangerSystem.swordsController:SetSword(skinchangerSystem.swordAnimations)
        end)
    end
end

skinchangerSystem.myParryHandler = function(...)
    if setthreadidentity then pcall(setthreadidentity, 2) end
    local args = {...}
    local argCount = select("#", ...)
    
    if tostring(args[4]) == LocalPlayer.Name then
        if skinchangerSystem.skinChangerEnabled and skinchangerSystem.changeSwordFX then
           
            args[1] = skinchangerSystem.slashName or getSlashName(skinchangerSystem.swordFX or skinchangerSystem.swordModel) or "SlashEffect"
            args[3] = skinchangerSystem.swordFX or skinchangerSystem.swordModel
        end
    end
    
    if skinchangerSystem.playParryFunc then
       
        return skinchangerSystem.playParryFunc(unpack(args, 1, math.max(argCount, 4)))
    end
end

if skinchangerSystem.fxConnection then
    pcall(function() skinchangerSystem.fxConnection:Disconnect() end)
end
skinchangerSystem.fxConnection = ReplicatedStorage.Remotes.ParrySuccessAll.OnClientEvent:Connect(skinchangerSystem.myParryHandler)
skinchangerSystem.fxHooked = true

task.spawn(function()
    while task.wait(0.2) do
        if not skinchangerSystem.skinChangerEnabled then continue end

        local fireConns = safeGetConnections(ReplicatedStorage.Remotes.FireSwordInfo.OnClientEvent)
        for i = #fireConns, 1, -1 do
            local conn = fireConns[i]
            if conn.Function and islclosure(conn.Function) then
                local upvalues = debug.getupvalues(conn.Function)
                if type(upvalues[1]) == "table" and upvalues[1].SetSword then
                    local controller = upvalues[1]
                    skinchangerSystem.swordsController = controller
                    
                    if not controller.isHooked then
                        local oldSet = controller.SetSword
                        controller.SetSword = function(self, anim)
                            if skinchangerSystem.skinChangerEnabled and skinchangerSystem.changeSwordAnimation then
                                anim = skinchangerSystem.swordAnimations
                            end
                            return oldSet(self, anim)
                        end
                        controller.isHooked = true
                        
                        if skinchangerSystem.changeSwordAnimation then
                            pcall(function() oldSet(controller, skinchangerSystem.swordAnimations) end)
                        end
                    end
                    break
                end
            end
        end

        local parryConns = safeGetConnections(ReplicatedStorage.Remotes.ParrySuccessAll.OnClientEvent)
        for i = #parryConns, 1, -1 do
            local conn = parryConns[i]
            if conn.Function then
                local ok, info = pcall(debug.getinfo, conn.Function)
                if ok and info and info.name == "parrySuccessAll" then
                    if not skinchangerSystem.playParryFunc then
                        skinchangerSystem.playParryFunc = conn.Function
                    end
                    pcall(function()
                        if conn.Disable then conn:Disable() end
                    end)
                end
            end
        end
        
        local clientConns = safeGetConnections(ReplicatedStorage.Remotes.ParrySuccessClient.Event)
        for i = #clientConns, 1, -1 do
            local conn = clientConns[i]
            if conn.Function then
                local ok, info = pcall(debug.getinfo, conn.Function)
                if ok and info and info.name == "parrySuccessAll" then
                    pcall(function()
                        if conn.Disable then conn:Disable() end
                    end)
                end
            end
        end
    end
end)

if skinchangerSystem.swordFX then
    skinchangerSystem.slashName = getSlashName(skinchangerSystem.swordFX)
end

skinchangerSystem.updateSword = function()
    if skinchangerSystem.changeSwordFX and skinchangerSystem.swordFX then
        skinchangerSystem.slashName = getSlashName(skinchangerSystem.swordFX)
    end
    setSword()
end

LocalPlayer.CharacterAdded:Connect(function(character)
    if not skinchangerSystem.skinChangerEnabled then return end
    
    local hrp = character:WaitForChild("HumanoidRootPart", 5)
    if not hrp then return end
    
    character.ChildAdded:Connect(function(child)
        if skinchangerSystem.skinChangerEnabled and skinchangerSystem.changeSwordModel and child:IsA("Model") and child.Name ~= skinchangerSystem.swordModel then
            local success, isSword = pcall(function() 
                return swordInstances:GetSword(child.Name) 
            end)
            
            if success and isSword then
                task.wait()
                child:Destroy()
            end
        end
    end)

    task.wait(1)
    pcall(setSword)
end)

task.spawn(function()
    while task.wait(0.5) do
        if not skinchangerSystem.skinChangerEnabled then continue end
        local char = LocalPlayer.Character
        
        if char and skinchangerSystem.swordModel then
            if not char:FindFirstChild(skinchangerSystem.swordModel) then
                pcall(setSword)
            end
            
            for _, child in pairs(char:GetChildren()) do
                if child:IsA("Model") and child.Name ~= skinchangerSystem.swordModel then
                    local success, isSword = pcall(function() 
                        return swordInstances:GetSword(child.Name) 
                    end)
                    if success and isSword then
                        child:Destroy()
                    end
                end
            end
        end
    end
end)


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
        vfxdisabled = false,
        lastOtherParryTimestamp = 0,
        __parry_key = nil,
        __grab_animation = nil,
        potatographics = false,
        potatocache = {},
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
        __curve_names = {'Camera', 'Random', 'Straight', 'Backwards', 'Slow', 'High', 'Left', 'Right', 'RandomTarget'},
        __detections = {
            __infinity = false,
            __deathslash = false,
            __timehole = false,
            __slashesoffury = false,
            __phantom = false
        }
    },
    
    __triggerbot = {
        __enabled = false,
        __is_parrying = false,
        __parries = 0,
        __max_parries = 10000,
        __parry_delay = 0.1
    }
}

System.detection = System.detection or {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

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

local parryfunction = function() end

if ParryRemote and Hash1 and Hash2 and Hash3 then
    local LocalPlayer = Players.LocalPlayer
    
    local StealthBridge = Instance.new("BindableEvent")
    
    local stealth_action = function(countparries, curvecframe)
        if not LocalPlayer.Character or not LocalPlayer.Character.PrimaryPart then return end

        local current_frame_data = {}
        local current_frame_cam = workspace.CurrentCamera.CFrame

        local aliveFolder = workspace:FindFirstChild("Alive")
        if aliveFolder then
            for _, v in ipairs(aliveFolder:GetChildren()) do
                if v ~= LocalPlayer.Character and v.PrimaryPart then
                    local screenPos, isOnScreen = workspace.CurrentCamera:WorldToScreenPoint(v.PrimaryPart.Position)
                    if isOnScreen then
                        current_frame_data[tostring(v)] = screenPos
                    end
                end
            end
        end

        local isonMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled
        local aim = nil
        if isonMobile then
            local screenSize = workspace.CurrentCamera.ViewportSize
            aim = {(screenSize.X / 2), (screenSize.Y / 2)}
        else
            local mouseLocation = UserInputService:GetMouseLocation()
            aim = {mouseLocation.X, mouseLocation.Y}
        end

        local finnalcframe = curvecframe or current_frame_cam

        pcall(function()
            local spoof_script = LocalPlayer.PlayerScripts:FindFirstChildOfClass("LocalScript") 

            if type(secure_call) == "function" and spoof_script then
                secure_call(ParryRemote.FireServer, spoof_script, ParryRemote, Hash1, Hash2, Hash3(), 0.5, finnalcframe, current_frame_data, aim, false)
            else
                local fire_func = (type(clonefunction) == "function" and clonefunction(ParryRemote.FireServer)) or ParryRemote.FireServer
                fire_func(ParryRemote, Hash1, Hash2, Hash3(), 0.5, finnalcframe, current_frame_data, aim, false)
            end
        end)

        if countparries then
            pcall(function()
                System.__properties.__parries += 1
                task.delay(0.5, function()
                    if System.__properties.__parries > 0 then
                        System.__properties.__parries -= 1
                    end
                end)
            end)
        end
    end

    if type(newcclosure) == "function" then
        stealth_action = newcclosure(stealth_action)
    end

    StealthBridge.Event:Connect(stealth_action)

    local bridge_fire = StealthBridge.Fire
    if type(clonefunction) == "function" then
        bridge_fire = clonefunction(bridge_fire)
    end

    parryfunction = function(countparries, curvecframe)
        bridge_fire(StealthBridge, countparries, curvecframe)
    end

    if type(newcclosure) == "function" then
        parryfunction = newcclosure(parryfunction)
    end

    print("Founded Remote:", ParryRemote.Name, "| Hash:", Hash, "| UUID:", UUID)
else
    warn("An error has been detected: Failed to find game data!\nRemote:", ParryRemote and "Found" or "Missing", "| Hash:", Hash and "Found" or "Missing", "| UUID:", UUID and "Found" or "Missing")
end


--// BALL VELOCITY MODULE (FIXED DRAG)

local ball_velocity = {
    __config = {
        gui_name = "BallStatsGui",
        colors = {
            background = Color3.fromRGB(18, 18, 18),
            header = Color3.fromRGB(12, 12, 12),
            text_primary = Color3.fromRGB(255, 255, 255),
            text_secondary = Color3.fromRGB(170, 170, 170),
            accent_green = Color3.fromRGB(34, 197, 94),
            accent_orange = Color3.fromRGB(249, 115, 22),
            border = Color3.fromRGB(40, 40, 40)
        }
    },

    __state = {
        active = false,
        gui = nil,
        ball_data = {},
        is_dragging = false
    }
}

--// UI HELPERS
ball_velocity.create_corner = function(radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    return c
end

ball_velocity.create_stroke = function(thickness, color)
    local s = Instance.new("UIStroke")
    s.Thickness = thickness or 1
    s.Color = color or ball_velocity.__config.colors.border
    return s
end

--// CREATE GUI
ball_velocity.create_gui = function()
    local gui = Instance.new("ScreenGui")
    gui.Name = ball_velocity.__config.gui_name
    gui.ResetOnSpawn = false
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 230, 0, 120)
    main.Position = UDim2.new(0, 20, 0, 150)
    main.BackgroundColor3 = ball_velocity.__config.colors.background
    main.BorderSizePixel = 0
    main.Parent = gui

    ball_velocity.create_corner(12).Parent = main
    ball_velocity.create_stroke(1).Parent = main

    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 32)
    header.BackgroundColor3 = ball_velocity.__config.colors.header
    header.BorderSizePixel = 0
    header.Active = true
    header.Selectable = true
    header.Parent = main
    ball_velocity.create_corner(12).Parent = header

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -16, 1, 0)
    title.Position = UDim2.new(0, 16, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Ball Stats"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextColor3 = ball_velocity.__config.colors.text_primary
    title.Parent = header

    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -24, 1, -44)
    content.Position = UDim2.new(0, 12, 0, 38)
    content.BackgroundTransparency = 1
    content.Parent = main

    local stat = WYNF_NO_VIRTUALIZE(function(y, label, color)
        local l = Instance.new("TextLabel")
        l.Size = UDim2.new(1, 0, 0, 16)
        l.Position = UDim2.new(0, 0, 0, y)
        l.BackgroundTransparency = 1
        l.Text = label
        l.Font = Enum.Font.Gotham
        l.TextSize = 11
        l.TextXAlignment = Enum.TextXAlignment.Left
        l.TextColor3 = ball_velocity.__config.colors.text_secondary
        l.Parent = content

        local v = Instance.new("TextLabel")
        v.Size = UDim2.new(1, 0, 0, 22)
        v.Position = UDim2.new(0, 0, 0, y + 14)
        v.BackgroundTransparency = 1
        v.Text = "0.0"
        v.Font = Enum.Font.GothamBold
        v.TextSize = 18
        v.TextXAlignment = Enum.TextXAlignment.Left
        v.TextColor3 = color
        v.Parent = content
        return v
    end)

    local current_value = stat(0, "Current Speed", ball_velocity.__config.colors.accent_green)
    local peak_value = stat(42, "Peak Speed", ball_velocity.__config.colors.accent_orange)

    --// DRAG LOGIC (FIXED)
    local drag_start, start_pos

    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            ball_velocity.__state.is_dragging = true
            drag_start = input.Position
            start_pos = main.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if ball_velocity.__state.is_dragging
        and input.UserInputState == Enum.UserInputState.Change then
            local delta = input.Position - drag_start
            main.Position = UDim2.new(
                start_pos.X.Scale,
                start_pos.X.Offset + delta.X,
                start_pos.Y.Scale,
                start_pos.Y.Offset + delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            ball_velocity.__state.is_dragging = false
        end
    end)

    return gui, current_value, peak_value
end

--// START
ball_velocity.start = function()
    if ball_velocity.__state.active then return end
    ball_velocity.__state.active = true
    ball_velocity.__state.ball_data = {}

    local gui, current, peak = ball_velocity.create_gui()
    ball_velocity.__state.gui = gui

    System.__properties.__connections.ball_velocity =
        RunService.Heartbeat:Connect(function()
            local ball = System.ball.get()
            if not ball then
                current.Text = "0.0"
                peak.Text = "0.0"
                return
            end

            local z = ball:FindFirstChild("zoomies")
            if not z then
                current.Text = "0.0"
                return
            end

            local speed = z.VectorVelocity.Magnitude
            ball_velocity.__state.ball_data[ball] =
                math.max(ball_velocity.__state.ball_data[ball] or 0, speed)

            current.Text = string.format("%.1f", speed)
            peak.Text = string.format("%.1f", ball_velocity.__state.ball_data[ball])
        end)
end

--// STOP
ball_velocity.stop = function()
    ball_velocity.__state.active = false
    if System.__properties.__connections.ball_velocity then
        System.__properties.__connections.ball_velocity:Disconnect()
        System.__properties.__connections.ball_velocity = nil
    end
    if ball_velocity.__state.gui then
        ball_velocity.__state.gui:Destroy()
        ball_velocity.__state.gui = nil
    end
    ball_velocity.__state.ball_data = {}
end

local Replion = require(ReplicatedStorage.Packages.Replion)
local ReplionData = Replion.Client:WaitReplion("Data")

local function StopAnimation(animationtrack)
    local StopFadeTime = animationtrack:GetAttribute("StopFadeTime")
    animationtrack:Stop(StopFadeTime)
end

local function PlayGrabAnimation(animationtrack)
    local DATAtimesParried = ReplionData and ReplionData:Get("timesParried") or 0
    local PlayFadeTime = DATAtimesParried <= 4 and 0.05 or animationtrack:GetAttribute("PlayFadeTime")
    local PlayWeight = DATAtimesParried <= 4 and 1 or animationtrack:GetAttribute("PlayWeight")
    local PlaySpeed = DATAtimesParried <= 4 and DATAtimesParried / 5 + 1 or (animationtrack:GetAttribute("PlaySpeed") or 1)
    animationtrack:Play(PlayFadeTime, PlayWeight, PlaySpeed)
end


System.animation = {}

System.animation.play_grab_parry = function()
    if not System.__properties.__play_animation then
        return
    end
    
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass('Humanoid')
    local animator = humanoid and humanoid:FindFirstChildOfClass('Animator')
    if not humanoid or not animator then return end
    
    local sword_name
    if skinchangerSystem.skinChangerEnabled then
        sword_name = skinchangerSystem.swordAnimations
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
    
    for _, track in pairs(animator:GetPlayingAnimationTracks()) do
        if track.Name == "GrabParry" or track.Name == "Grab" then
            StopAnimation(track)
        elseif track.Name == "SuccessParry" or track.Name == "Success" then
            track.TimePosition = 0
            StopAnimation(track)
        end
    end
    
    System.__properties.__grab_animation = animator:LoadAnimation(parry_animation)
    PlayGrabAnimation(System.__properties.__grab_animation)
end

System.ball = {}

System.ball.get = function()
    local balls = workspace:FindFirstChild('Balls')
    if not balls then return nil end
    
    for _, ball in pairs(balls:GetChildren()) do
        if ball:GetAttribute('realBall') then
            ball.CanCollide = false
            return ball
        end
    end
    return nil
end

System.ball.get_all = function()
    local balls_table = {}
    local balls = workspace:FindFirstChild('Balls')
    if not balls then return balls_table end
    
    for _, ball in pairs(balls:GetChildren()) do
        if ball:GetAttribute('realBall') then
            ball.CanCollide = false
            table.insert(balls_table, ball)
        end
    end
    return balls_table
end

System.player = {}

local Closest_Entity = nil

System.player.get_closest = function()
    if not Alive then return nil end
    
    local player_character = LocalPlayer.Character
    
    if not player_character or not player_character.PrimaryPart then 
        Closest_Entity = nil
        return nil 
    end
    
    local player_pos = player_character.PrimaryPart.Position
    local min_distance_sq = math.huge
    local closest_entity = nil
    
    for _, entity in pairs(Alive:GetChildren()) do
        if entity ~= player_character and entity:IsA("Model") and entity.PrimaryPart then
            local entity_pos = entity.PrimaryPart.Position
            
            local dx = player_pos.X - entity_pos.X
            local dy = player_pos.Y - entity_pos.Y
            local dz = player_pos.Z - entity_pos.Z
            local distance_sq = dx*dx + dy*dy + dz*dz
            
            if distance_sq < min_distance_sq then
                min_distance_sq = distance_sq
                closest_entity = entity
            end
        end
    end
    
    Closest_Entity = closest_entity
    return closest_entity
end

System.player.get_closest_to_cursor =function()
    if not Alive then return nil end

    local player_character = LocalPlayer.Character
    if not player_character or not player_character.PrimaryPart then
        return nil
    end

    local camera = workspace.CurrentCamera
    if not camera then return nil end

    local mouse_location = UserInputService:GetMouseLocation()
    if not mouse_location then return nil end

    local ray = camera:ViewportPointToRay(mouse_location.X, mouse_location.Y)
    local ray_dir = ray.Direction
    local camera_pos = camera.CFrame.Position
    
    local best_score = -math.huge
    local best_player = nil

    for _, player in pairs(Alive:GetChildren()) do
        if player ~= player_character and player:IsA("Model") then
            local hrp = player.PrimaryPart or player:FindFirstChild("HumanoidRootPart")
            if hrp then
                local delta = hrp.Position - camera_pos
                local distance_sq = delta.X*delta.X + delta.Y*delta.Y + delta.Z*delta.Z
                
                if distance_sq < 250000 then
                    local dir = delta.Unit
                    local dot = ray_dir:Dot(dir)
                    
                    if dot > 0.2 then
                        local distance_factor = 1 - math.sqrt(distance_sq) / 500
                        local score = (dot * 0.6) + (distance_factor * 0.4)
                        
                        if score > best_score then
                            best_score = score
                            best_player = player
                        end
                    end
                end
            end
        end
    end
    
    return best_player
end

System.curve = {}

System.curve.get_cframe = function()
    local camera = workspace.CurrentCamera
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('HumanoidRootPart')
    if not root then return camera.CFrame end

    local targetPart
    local closest = System.player.get_closest_to_cursor()
    if closest and closest:FindFirstChild('HumanoidRootPart') then
        targetPart = closest.HumanoidRootPart
    end

    local target_pos = targetPart
        and targetPart.Position
        or (root.Position + camera.CFrame.LookVector * 100)

    local curve_functions = {
    --cam
        function()
            return camera.CFrame
        end,

        function()
            local direction = (target_pos - root.Position).Unit
            local random_offset
            local attempts = 0
            repeat
                random_offset = Vector3.new(
                    math.random(-4000, 4000),
                    math.random(-4000, 4000),
                    math.random(-4000, 4000)
                )
                local curve_direction = (target_pos + random_offset - root.Position).Unit
                local dot = direction:Dot(curve_direction)
                attempts = attempts + 1
            until dot < 0.95 or attempts > 10
            return CFrame.new(root.Position, target_pos + random_offset)
        end,

        
        function()
            local Mouse_Location = UserInputService:GetMouseLocation()
            local Mouse_Vector = Vector2.new(Mouse_Location.X, Mouse_Location.Y)
            local Aimed_Player = nil
            local Closest_Distance = math.huge

            for _, v in pairs(workspace.Alive:GetChildren()) do
                if v ~= LocalPlayer.Character and v.PrimaryPart then
                    local screenPos, isOnScreen = camera:WorldToScreenPoint(v.PrimaryPart.Position)
                    if isOnScreen then
                        local dist = (Mouse_Vector - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                        if dist < Closest_Distance then
                            Closest_Distance = dist
                            Aimed_Player = v
                        end
                    end
                end
            end

            if Aimed_Player then
                return CFrame.new(root.Position, Aimed_Player.PrimaryPart.Position)
            else
                return CFrame.new(root.Position, target_pos)
            end
        end,
 
--back
        function()
            local direction = (root.Position - target_pos).Unit
            local backwards_pos = root.Position + direction * 10000 + Vector3.new(0, 1000, 0)
            return CFrame.new(camera.CFrame.Position, backwards_pos)
        end,

--slow ball
        function()
            return CFrame.new(root.Position, target_pos + Vector3.new(0, -9e18, 0))
        end,

        --high
        function()
            return CFrame.new(root.Position, target_pos + Vector3.new(0, 9e18, 0))
        end,

        --left
        function()
            local left_pos = camera.CFrame.Position - camera.CFrame.RightVector * 10000
            return CFrame.new(camera.CFrame.Position, left_pos)
        end,

        --right
        function()
            local right_pos = camera.CFrame.Position + camera.CFrame.RightVector * 10000
            return CFrame.new(camera.CFrame.Position, right_pos)
        end,

       -- random target
        function()
            local candidates = {}
            for _, v in pairs(workspace.Alive:GetChildren()) do
                if v ~= LocalPlayer.Character and v.PrimaryPart then
                    local screenPos, isOnScreen = camera:WorldToScreenPoint(v.PrimaryPart.Position)
                    if isOnScreen then
                        table.insert(candidates, v)
                    end
                end
            end
            if #candidates > 0 then
                local pick = candidates[math.random(1, #candidates)]
                return CFrame.new(root.Position, pick.PrimaryPart.Position)
            else
                return camera.CFrame
            end
        end,
    }

    local mode = System.__properties.__curve_mode
    if curve_functions[mode] then
        return curve_functions[mode]()
    else
        return camera.CFrame
    end
end

System.AnimationFixService = {}

local AnimationFixService = {
    Rate = 60,
    FEMode = false,
    Cache = {},

    AnimationFixThread = nil,
    AnimationFixRunning = false,

    DisableThread = nil,
    DisableRunning = false,

    VFXThread = nil,
    VFXRunning = false
}

System.AnimationFixService = AnimationFixService

local function GetCharacter()
    return LocalPlayer.Character
end

local function GetHumanoid()
    local character = GetCharacter()
    return character and character:FindFirstChildOfClass("Humanoid")
end

local function GetAnimator()
    local humanoid = GetHumanoid()
    return humanoid and humanoid:FindFirstChildOfClass("Animator")
end

local function StopAnimation(animationtrack)
    if not animationtrack then return end
    local StopFadeTime = animationtrack:GetAttribute("StopFadeTime")
    animationtrack:Stop(typeof(StopFadeTime) == "number" and StopFadeTime or 0)
end

local function StopParryTracks()
    local animator = GetAnimator()
    if not animator then return end

    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
        local name = track.Name
        if name == "GrabParry" or name == "Grab" or name == "SuccessParry" or name == "Success" then
            pcall(function()
                track.TimePosition = 0
                StopAnimation(track)
            end)
        end
    end
end

local function DisableVFXStep()
    if not (System and System.properties and System.properties.vfxdisabled) then
        return
    end

    local character = LocalPlayer.Character
    local ballFolder = workspace:FindFirstChild("Balls")
    local runtimeFolder = workspace:FindFirstChild("Runtime")

    local function kill(root)
        if not root then return end
        for _, obj in ipairs(root:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam")
            or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                pcall(function() obj.Enabled = false end)
            elseif obj:IsA("Highlight") then
                pcall(function() obj.Enabled = false end)
            end
        end
    end

    kill(character)
    kill(ballFolder)
    kill(runtimeFolder)
end

local function PlayGrabAnimation(animationtrack)
    local DATAtimesParried = ReplionData and ReplionData:Get("timesParried") or 0
    local PlayFadeTime = DATAtimesParried <= 4 and 0.05 or animationtrack:GetAttribute("PlayFadeTime")
    local PlayWeight = DATAtimesParried <= 4 and 1 or animationtrack:GetAttribute("PlayWeight")
    local PlaySpeed = DATAtimesParried <= 4 and DATAtimesParried / 5 + 1 or (animationtrack:GetAttribute("PlaySpeed") or 1)

    animationtrack:Play(
        typeof(PlayFadeTime) == "number" and PlayFadeTime or 0.05,
        typeof(PlayWeight) == "number" and PlayWeight or 1,
        typeof(PlaySpeed) == "number" and PlaySpeed or 1
    )
end

local function GetParryAnimation()
    local character = GetCharacter()
    if not character then return nil end
    
    local currentSword
    if skinchangerSystem.skinChangerEnabled and skinchangerSystem.swordAnimations then
        currentSword = skinchangerSystem.swordAnimations
    else
        currentSword = character:GetAttribute("CurrentlyEquippedSword")
    end

    local defaultAnimation = ReplicatedStorage.Shared.SwordAPI.Collection.Default:FindFirstChild("GrabParry")
    if not currentSword then
        return defaultAnimation
    end
    
    if AnimationFixService.Cache[currentSword] then
        return AnimationFixService.Cache[currentSword]
    end
    
    local success, swordData = pcall(function()
        return ReplicatedStorage.Shared.ReplicatedInstances.Swords.GetSword:Invoke(currentSword)
    end)
    
    if not success or type(swordData) ~= "table" or type(swordData.AnimationType) ~= "string" then
        AnimationFixService.Cache[currentSword] = defaultAnimation
        return defaultAnimation
    end
    
    local swordCollection = ReplicatedStorage.Shared.SwordAPI.Collection
    for _, object in pairs(swordCollection:GetChildren()) do
        if object.Name == swordData.AnimationType then
            local animation = object:FindFirstChild("GrabParry") or object:FindFirstChild("Grab")
            if animation then
                AnimationFixService.Cache[currentSword] = animation
                return animation
            end
        end
    end
    
    AnimationFixService.Cache[currentSword] = defaultAnimation
    return defaultAnimation
end

local function RunAnimationFixStep()
    if not System.properties.playanimation then
        return
    end

    local humanoid = GetHumanoid()
    local animator = GetAnimator()
    if not humanoid or not animator then return end

    local parryAnimation = GetParryAnimation()
    if not parryAnimation then return end

    local hasRelevantTrack = false
    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
        local name = track.Name
        if name == "GrabParry" or name == "Grab" or name == "SuccessParry" or name == "Success" then
            hasRelevantTrack = true
            break
        end
    end

    if not hasRelevantTrack then
        return
    end

    StopParryTracks()

    local loadedTrack
    local ok = pcall(function()
        loadedTrack = animator:LoadAnimation(parryAnimation)
    end)

    if ok and loadedTrack then
        System.properties.grabanimation = loadedTrack
        PlayGrabAnimation(loadedTrack)
    end
end

function AnimationFixService.StartAnimationFix()
    if AnimationFixService.AnimationFixRunning then
        return
    end

    if AnimationFixService.DisableRunning then
        AnimationFixService.StopDisableAnimation()
    end

    AnimationFixService.AnimationFixRunning = true

    AnimationFixService.AnimationFixThread = task.spawn(function()
        local interval = 1 / math.max(AnimationFixService.Rate or 60, 1)

        while AnimationFixService.AnimationFixRunning do
            pcall(RunAnimationFixStep)
            task.wait(interval)
        end
    end)
end

function AnimationFixService.StopAnimationFix()
    AnimationFixService.AnimationFixRunning = false

    if AnimationFixService.AnimationFixThread then
        pcall(function()
            task.cancel(AnimationFixService.AnimationFixThread)
        end)
        AnimationFixService.AnimationFixThread = nil
    end
end

function AnimationFixService.StartDisableAnimation()
    if AnimationFixService.DisableRunning then
        return
    end

    if AnimationFixService.AnimationFixRunning then
        AnimationFixService.StopAnimationFix()
    end

    AnimationFixService.DisableRunning = true

    AnimationFixService.DisableThread = task.spawn(function()
        local interval = 1 / math.max(AnimationFixService.Rate or 60, 1)

        while AnimationFixService.DisableRunning do
            pcall(StopParryTracks)
            task.wait(interval)
        end
    end)
end

function AnimationFixService.StopDisableAnimation()
    AnimationFixService.DisableRunning = false

    if AnimationFixService.DisableThread then
        pcall(function()
            task.cancel(AnimationFixService.DisableThread)
        end)
        AnimationFixService.DisableThread = nil
    end
end

function AnimationFixService.StartDisableVFX()
    if AnimationFixService.VFXRunning then
        return
    end

    AnimationFixService.VFXRunning = true

    AnimationFixService.VFXThread = task.spawn(function()
        local interval = 1 / math.max(AnimationFixService.Rate or 60, 1)

        while AnimationFixService.VFXRunning do
            pcall(DisableVFXStep)
            task.wait(interval)
        end
    end)
end

function AnimationFixService.StopDisableVFX()
    AnimationFixService.VFXRunning = false

    if AnimationFixService.VFXThread then
        pcall(function()
            task.cancel(AnimationFixService.VFXThread)
        end)
        AnimationFixService.VFXThread = nil
    end
end

function AnimationFixService.ToggleDisableVFX(state)
    local properties = System and (rawget(System, "properties") or rawget(System, "__properties"))
    if not properties then
        return
    end

    properties.vfxdisabled = state

    if state then
        if AnimationFixService.StartDisableVFX then
            AnimationFixService.StartDisableVFX()
        end
    else
        if AnimationFixService.StopDisableVFX then
            AnimationFixService.StopDisableVFX()
        end
    end
end

function AnimationFixService.ClearCache()
    AnimationFixService.Cache = {}
end

System.animation = System.animation or {}

System.animation.startfix = function()
    System.AnimationFixService.StartAnimationFix()
end

System.animation.stopfix = function()
    System.AnimationFixService.StopAnimationFix()
end

System.animation.startdisable = function()
    System.AnimationFixService.StartDisableAnimation()
end

System.animation.stopdisable = function()
    System.AnimationFixService.StopDisableAnimation()
end

System.animation.startdisablevfx = function()
    System.AnimationFixService.ToggleDisableVFX(true)
end

System.animation.stopdisablevfx = function()
    System.AnimationFixService.ToggleDisableVFX(false)
end

System.animation.togglevfx = function(state)
    System.AnimationFixService.ToggleDisableVFX(state)
end

System.vfx = System.vfx or {}
System.vfx.disable = function(state)
    System.AnimationFixService.ToggleDisableVFX(state)
end

System.graphics = System.graphics or {}

local function getProperties()
    return System and (rawget(System, "properties") or rawget(System, "__properties"))
end

System.graphics.enablepotato = function(state)
    local properties = getProperties()
    if not properties then
        return
    end

    properties.potatographics = state and true or false
    properties.potatocache = properties.potatocache or {}
    properties.connections = properties.connections or {}

    local cache = properties.potatocache
    local Lighting = game:GetService("Lighting")
    local Terrain = workspace:FindFirstChildOfClass("Terrain")
    local MaterialService = game:GetService("MaterialService")

    local function save(obj, prop)
        if not obj then return end
        cache[obj] = cache[obj] or {}

        if cache[obj][prop] == nil then
            local ok, value = pcall(function()
                return obj[prop]
            end)

            if ok then
                cache[obj][prop] = value
            end
        end
    end

    local function setprop(obj, prop, value)
        if not obj then return end
        pcall(function()
            obj[prop] = value
        end)
    end

    local function stripObject(obj)
        if not obj then return end

        if obj:IsA("BasePart") then
            save(obj, "Material")
            save(obj, "Reflectance")
            save(obj, "CastShadow")
            save(obj, "Transparency")

            setprop(obj, "Material", Enum.Material.SmoothPlastic)
            setprop(obj, "Reflectance", 0)
            setprop(obj, "CastShadow", false)

            if obj.Name ~= "HumanoidRootPart" then
                if obj.Transparency < 0.85 and not obj:IsDescendantOf(LocalPlayer.Character or nil) then
                    setprop(obj, "Transparency", math.max(obj.Transparency, 0.15))
                end
            end

        elseif obj:IsA("MeshPart") then
            save(obj, "TextureID")
            save(obj, "RenderFidelity")

            setprop(obj, "TextureID", "")
            pcall(function()
                obj.RenderFidelity = Enum.RenderFidelity.Performance
            end)

        elseif obj:IsA("SpecialMesh") then
            save(obj, "TextureId")
            save(obj, "VertexColor")

            setprop(obj, "TextureId", "")
            setprop(obj, "VertexColor", Vector3.new(1, 1, 1))

        elseif obj:IsA("Decal") or obj:IsA("Texture") then
            save(obj, "Transparency")
            setprop(obj, "Transparency", 1)

        elseif obj:IsA("ParticleEmitter")
            or obj:IsA("Trail")
            or obj:IsA("Beam")
            or obj:IsA("Smoke")
            or obj:IsA("Fire")
            or obj:IsA("Sparkles") then
            save(obj, "Enabled")
            setprop(obj, "Enabled", false)

        elseif obj:IsA("Explosion") then
            save(obj, "BlastPressure")
            save(obj, "BlastRadius")

            setprop(obj, "BlastPressure", 0)
            setprop(obj, "BlastRadius", 0)

        elseif obj:IsA("PointLight")
            or obj:IsA("SpotLight")
            or obj:IsA("SurfaceLight") then
            save(obj, "Enabled")
            save(obj, "Brightness")
            save(obj, "Shadows")

            setprop(obj, "Enabled", false)
            setprop(obj, "Brightness", 0)
            pcall(function()
                obj.Shadows = false
            end)

        elseif obj:IsA("Highlight") then
            save(obj, "Enabled")
            setprop(obj, "Enabled", false)

        elseif obj:IsA("BillboardGui")
            or obj:IsA("SurfaceGui") then
            save(obj, "Enabled")
            setprop(obj, "Enabled", false)

        elseif obj:IsA("ViewportFrame") then
            save(obj, "Visible")
            setprop(obj, "Visible", false)

        elseif obj:IsA("ShirtGraphic") then
            save(obj, "Graphic")
            setprop(obj, "Graphic", "")

        elseif obj:IsA("WrapLayer") or obj:IsA("WrapTarget") then
            save(obj, "Enabled")
            pcall(function()
                obj.Enabled = false
            end)
        end
    end

    if state then
        save(Lighting, "GlobalShadows")
        save(Lighting, "Brightness")
        save(Lighting, "FogEnd")
        save(Lighting, "EnvironmentalDiffuseScale")
        save(Lighting, "EnvironmentalSpecularScale")
        save(Lighting, "ClockTime")
        save(Lighting, "ExposureCompensation")

        setprop(Lighting, "GlobalShadows", false)
        setprop(Lighting, "Brightness", 0)
        setprop(Lighting, "FogEnd", 9e9)
        setprop(Lighting, "EnvironmentalDiffuseScale", 0)
        setprop(Lighting, "EnvironmentalSpecularScale", 0)
        setprop(Lighting, "ExposureCompensation", 0)

        for _, obj in ipairs(Lighting:GetChildren()) do
            if obj:IsA("Atmosphere")
                or obj:IsA("BloomEffect")
                or obj:IsA("BlurEffect")
                or obj:IsA("SunRaysEffect")
                or obj:IsA("ColorCorrectionEffect")
                or obj:IsA("DepthOfFieldEffect")
                or obj:IsA("Sky") then
                save(obj, "Enabled")
                pcall(function()
                    obj.Enabled = false
                end)

                if obj:IsA("Sky") then
                    save(obj, "SkyboxBk")
                    save(obj, "SkyboxDn")
                    save(obj, "SkyboxFt")
                    save(obj, "SkyboxLf")
                    save(obj, "SkyboxRt")
                    save(obj, "SkyboxUp")

                    setprop(obj, "SkyboxBk", "")
                    setprop(obj, "SkyboxDn", "")
                    setprop(obj, "SkyboxFt", "")
                    setprop(obj, "SkyboxLf", "")
                    setprop(obj, "SkyboxRt", "")
                    setprop(obj, "SkyboxUp", "")
                end
            end
        end

        if Terrain then
            save(Terrain, "Decoration")
            save(Terrain, "WaterWaveSize")
            save(Terrain, "WaterWaveSpeed")
            save(Terrain, "WaterReflectance")
            save(Terrain, "WaterTransparency")

            setprop(Terrain, "Decoration", false)
            setprop(Terrain, "WaterWaveSize", 0)
            setprop(Terrain, "WaterWaveSpeed", 0)
            setprop(Terrain, "WaterReflectance", 0)
            setprop(Terrain, "WaterTransparency", 1)
        end

        for _, obj in ipairs(workspace:GetDescendants()) do
            stripObject(obj)
        end

        if properties.connections.potato_descendant_added then
            pcall(function()
                properties.connections.potato_descendant_added:Disconnect()
            end)
        end

        properties.connections.potato_descendant_added = workspace.DescendantAdded:Connect(function(obj)
            if properties.potatographics then
                task.defer(stripObject, obj)
            end
        end)

        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        end)

        pcall(function()
            if MaterialService then
                for _, v in ipairs(MaterialService:GetChildren()) do
                    if v:IsA("MaterialVariant") then
                        save(v, "Parent")
                        v.Parent = nil
                    end
                end
            end
        end)
    else
        if properties.connections.potato_descendant_added then
            pcall(function()
                properties.connections.potato_descendant_added:Disconnect()
            end)
            properties.connections.potato_descendant_added = nil
        end

        for obj, props in pairs(cache) do
            if obj and obj.Parent then
                for prop, value in pairs(props) do
                    pcall(function()
                        obj[prop] = value
                    end)
                end
            end
        end

        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        end)

        properties.potatocache = {}
    end
end

System.parry = {}

System.parry.execute = function()
    if System.__properties.__parries > 10000 or not LocalPlayer.Character then
        return
    end
    
    if System.__properties.__parries > 10000 then return end

    local usefirstparry = false
    if not System.__properties.__first_parry_done and usefirstparry then
        System.__properties.__first_parry_done = true
        task.delay(0.1, function()
            if System.__properties.__parries > 0 then
                System.__properties.__parries = System.__properties.__parries - 1
            end
        end)
    end
    
    parryfunction(true)
end

System.parry.keypress = function()
    if System.__properties.__parries > 10000 or not LocalPlayer.Character then
        return
    end
    
    System.parry.execute()

    if System.__properties.__parries > 10000 then return end
    
    System.__properties.__parries = System.__properties.__parries + 1
    task.delay(0.5, function()
        if System.__properties.__parries > 0 then
            System.__properties.__parries = System.__properties.__parries - 1
        end
    end)
end

-- // aqqqqq

System.parry.execute_action = function()
    System.animation.play_grab_parry()
    System.parry.execute()
end

local linear_predict = function(start_value, end_value, t)
    t = math.clamp(t, 0, 1)
    return start_value + (end_value - start_value) * t
end

System.detection.is_curved = function()
    if not System.detection.__ball_properties then
        local initial_history = {}
        for i = 1, 6 do initial_history[i] = {v = Vector3.new(), t = 0} end

        System.detection.__ball_properties = {
            history = initial_history,
            idx = 0, 
            smooth_accel_vec = Vector3.new(),
            smooth_angular = 0,
            last_ping = 0.05,
            last_ping_tick = 0,
            last_ability_check = 0,
            ability_tick = 0
        }
    end

    local props = System.detection.__ball_properties
    local Ball = System.ball.get()
    if not Ball then return false end
    
    local Zoomies = Ball:FindFirstChild('zoomies')
    if not Zoomies then return false end

    local Velocity = Zoomies.VectorVelocity
    local Speed = Velocity.Magnitude
    if Speed < 15 then return false end

    local playerPart = LocalPlayer.Character and LocalPlayer.Character.PrimaryPart
    if not playerPart then return false end
    
    local ballPos = Ball.Position
    local playerPos = playerPart.Position
    local toPlayerVec = playerPos - ballPos
    local Distance = toPlayerVec.Magnitude
    
    local toPlayerDir = toPlayerVec / Distance 
    local velocityDir = Velocity / Speed

    if Distance <= 16 then return false end 

    local now = os.clock()

    props.idx = (props.idx % 6) + 1
    props.history[props.idx].v = Velocity
    props.history[props.idx].t = now

    local raw_accel_vec = Vector3.new()
    local raw_angular = 0

    local oldest_idx = (props.idx % 6) + 1
    local oldest = props.history[oldest_idx]

    if oldest.t > 0 then
        local time_span = now - oldest.t
        if time_span > 0.005 then 
            local velocity_diff = Velocity - oldest.v
            
            if velocity_diff.Magnitude > 2 then
                raw_accel_vec = velocity_diff / time_span
                local crossVec = (oldest.v / oldest.v.Magnitude):Cross(velocityDir)
                raw_angular = math.deg(math.asin(math.clamp(crossVec.Magnitude, -1, 1))) / time_span
            end
        end
    end

    props.smooth_accel_vec = props.smooth_accel_vec:Lerp(raw_accel_vec, 0.4)
    props.smooth_angular = props.smooth_angular + (raw_angular - props.smooth_angular) * 0.4

    local Acceleration = props.smooth_accel_vec
    local accelMagnitude = Acceleration.Magnitude

    if now - props.last_ability_check > 0.1 then
        props.last_ability_check = now
        if Ball:FindFirstChild('AeroDynamicSlashVFX') or workspace.Runtime:FindFirstChild('Tornado') then
            props.ability_tick = now
        end
    end
    local hasAbility = (now - props.ability_tick) < 1.0

    if now - props.last_ping_tick > 1.0 then
        props.last_ping_tick = now
        local ok, pingStats = pcall(function() return game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue() end)
        props.last_ping = math.clamp((ok and pingStats or 50) / 1000, 0, 0.15)
    end
    local Ping = props.last_ping

    local accelDir = accelMagnitude > 0 and (Acceleration / accelMagnitude) or Vector3.new()
    local currentDot = toPlayerDir:Dot(velocityDir)
    local accelDot = toPlayerDir:Dot(accelDir)

    local confidence = 0
    local adaptive_accel_thresh = math.max(Speed * 0.25, 25) 
    local angular_weight = (Distance < 35) and 40 or 50 
    
    confidence = confidence + math.clamp((accelMagnitude / adaptive_accel_thresh) * 0.4, 0, 0.4)
    confidence = confidence + math.clamp((props.smooth_angular / angular_weight) * 0.4, 0, 0.4)
    if hasAbility then confidence = confidence + 0.2 end
    if accelDot > 0.35 then confidence = confidence + 0.2 end

    local ReachTime = Distance / Speed
   
    local effective_ping = Ping + 0.055
    local shield_linger = math.clamp(1 - (Speed / 500), 0, 1) * 0.2
    local required_tti = effective_ping + 0.05 + shield_linger
    
    local dynamic_range = math.clamp(21 + (Speed * 0.008), 21, 40)
    local required_confidence = (Distance < 35) and 0.58 or 0.62

    if confidence > required_confidence then
        local lookAheadTime = (Distance < 35) and math.clamp(ReachTime, 0.01, 0.12) or math.clamp(ReachTime, 0.01, 0.2)
        local predictedPos = ballPos + (Velocity * lookAheadTime) + (0.5 * Acceleration * lookAheadTime * lookAheadTime)
        local predictedDistance = (playerPos - predictedPos).Magnitude

        local is_getting_closer = predictedDistance <= (Distance + 5)

        if is_getting_closer then
            local danger_radius = (Distance < 35) and 18 or 25
            
            if predictedDistance < danger_radius or Distance <= dynamic_range then
                local flatToPlayerDir = Vector3.new(toPlayerDir.X, 0, toPlayerDir.Z)
                local flatVelocityDir = Vector3.new(velocityDir.X, 0, velocityDir.Z)
                if flatToPlayerDir.Magnitude > 0 then flatToPlayerDir = flatToPlayerDir.Unit else flatToPlayerDir = Vector3.new(0,0,1) end
                if flatVelocityDir.Magnitude > 0 then flatVelocityDir = flatVelocityDir.Unit else flatVelocityDir = flatToPlayerDir end

                local horizontalDot = flatToPlayerDir:Dot(flatVelocityDir)

                if horizontalDot < 0.4 or Distance <= dynamic_range then
                    return true
                end
            end
        end
    end

    local dynamic_dot_threshold = 1.0 - math.exp(-Speed / 1500) * 0.15
    if currentDot > dynamic_dot_threshold then
        if ReachTime <= required_tti or Distance <= dynamic_range then
            return true
        end
    end

    return false
end


System.detection.get_curve_strength = function()
    if not System.detection.__ball_properties then
        return 0
    end
    return System.detection.__ball_properties.__curve_strength or 0
end

ReplicatedStorage.Remotes.DeathBall.OnClientEvent:Connect(function(c, d)
    System.__properties.__deathslash_active = d or false
end)

ReplicatedStorage.Remotes.InfinityBall.OnClientEvent:Connect(function(a, b)
    System.__properties.__infinity_active = b or false
end)

ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net["RE/TimeHoleActivate"].OnClientEvent:Connect(function(...)
    local args = {...}
    local player = args[1]
    
    if player == LocalPlayer or player == LocalPlayer.Name or (player and player.Name == LocalPlayer.Name) then
        System.__properties.__timehole_active = true
    end
end)

ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net["RE/TimeHoleDeactivate"].OnClientEvent:Connect(function()
    System.__properties.__timehole_active = false
end)

local maxParryCount = 36
local parryDelay = 0.05

ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net["RE/SlashesOfFuryActivate"].OnClientEvent:Connect(function(...)
    local args = {...}
    local player = args[1]
    
    if player == LocalPlayer or player == LocalPlayer.Name or (player and player.Name == LocalPlayer.Name) then
        System.__properties.__slashesoffury_active = true
        System.__properties.__slashesoffury_count = 0
    end
end)

ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net["RE/SlashesOfFuryEnd"].OnClientEvent:Connect(function()
    System.__properties.__slashesoffury_active = false
    System.__properties.__slashesoffury_count = 0
end)

ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net["RE/SlashesOfFuryParry"].OnClientEvent:Connect(function()
    System.__properties.__slashesoffury_count = System.__properties.__slashesoffury_count + 1
end)

ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net["RE/SlashesOfFuryCatch"].OnClientEvent:Connect(function()
    spawn(function()
        while System.__properties.__slashesoffury_active and System.__properties.__slashesoffury_count < maxParryCount do
            if System.__config.__detections.__slashesoffury then
                System.parry.execute()
                task.wait(parryDelay)
            else
                break
            end
        end
    end)
end)

local Runtime = workspace:FindFirstChild("Runtime") or workspace:WaitForChild("Runtime")

Runtime.ChildAdded:Connect(function(Object)
    task.defer(function()
        if not System or not System.config or not System.config.detections then
            return
        end
        if not System.config.detections.phantom then
            return
        end
        if Object.Name ~= "maxTransmission" and Object.Name ~= "transmissionpart" then
            return
        end

        local Weld = Object:FindFirstChildWhichIsA("WeldConstraint") or Object:WaitForChild("WeldConstraint", 0.2)
        if not Weld then
            return
        end

        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = Character and Character:FindFirstChild("HumanoidRootPart")
        if not HRP or Weld.Part1 ~= HRP then
            return
        end

        local CurrentBall = System.ball.get()
        pcall(function() Weld:Destroy() end)

        if not CurrentBall then
            return
        end

        local FocusConnection
        FocusConnection = RunService.RenderStepped:Connect(function()
            if not CurrentBall or not CurrentBall.Parent then
                if FocusConnection then FocusConnection:Disconnect() end
                return
            end

            local Highlighted = CurrentBall:GetAttribute("highlighted")
            if Highlighted == true then
                ReplicatedStorage.Remotes.AbilityButtonPress:Fire()
                System.properties.parried = true

                task.delay(1, function()
                    if System and System.properties then
                        System.properties.parried = false
                    end
                end)
            elseif Highlighted == false then
                if FocusConnection then FocusConnection:Disconnect() end
            end
        end)

        task.delay(3, function()
            if FocusConnection and FocusConnection.Connected then
                FocusConnection:Disconnect()
            end
        end)
    end)
end)

local ReplicatedStorage = game:GetService("ReplicatedStorage")

ReplicatedStorage.Remotes.ParrySuccess.OnClientEvent:Connect(function()
    local character = LocalPlayer.Character
    if not character or not Alive or character.Parent ~= Alive then return end

    local humanoid = character:FindFirstChild("Humanoid")
    local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
    if not animator then return end
    
    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
        local name = track.Name
        if name == "GrabParry" or name == "Grab" then
            track:Stop()
        end
    end
end)

System.manual_spam = {}

local msthreads = {}
local msconns   = {}

local ms_burst_delay = 0

System.manual_spam.loop_stop = function()
    System.__properties.__manual_spam_enabled = false

    for _, t in ipairs(msthreads) do
        pcall(function() task.cancel(t) end)
    end
    msthreads = {}

    for _, c in ipairs(msconns) do
        pcall(function() c:Disconnect() end)
    end
    msconns = {}
end

System.manual_spam.loop_start = function()
    System.manual_spam.loop_stop()

    System.__properties.__manual_spam_enabled = true

    local anim_fn = System.animation and System.animation.play_grab_parry

    local function burst_fire(dt)
        local parry_fn = parryfunction
        if parry_fn then
            local target_speed = System.__properties.__spam_rate or 180
            ms_burst_delay = ms_burst_delay + dt
            local packets_to_fire = math.floor(ms_burst_delay * target_speed)
            if packets_to_fire > 0 then
                ms_burst_delay = ms_burst_delay - (packets_to_fire / target_speed)
                for _ = 1, packets_to_fire do
                    task.spawn(parry_fn)
                    if anim_fn then task.defer(anim_fn) end
                end
            end
        end
    end

    -- Heartbeat
    table.insert(msconns, RunService.PreRender:Connect(function(dt)
        if System.__properties.__manual_spam_enabled then
            burst_fire(dt)
        end
    end))

    task.spawn(function()
        local original_quality = settings().Rendering.QualityLevel
        while true do
            local dt  = RunService.Heartbeat:Wait()
            local fps = 1 / dt
            if fps < 45 and System.__properties.__manual_spam_enabled then
                pcall(function() settings().Rendering.QualityLevel = 1 end)
            else
                pcall(function() settings().Rendering.QualityLevel = original_quality end)
            end
            if not System.__properties.__manual_spam_enabled then break end
            task.wait(0.5)
        end
    end)
end

System.manual_spam.start = function()
    System.manual_spam.loop_start()
end

System.manual_spam.stop = function()
    System.manual_spam.loop_stop()
    ms_burst_delay = 0
    pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic end)
end

System.__properties = System.__properties or {}
System.__properties.__manual_spam_enabled = System.__properties.__manual_spam_enabled or false

System.__properties = System.__properties or {}
System.__properties.__auto_spam_enabled = System.__properties.__auto_spam_enabled or false
System.__properties.__isspamming = System.__properties.__isspamming or false
System.auto_spam = {}

local RunService   = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
local Stats        = cloneref and cloneref(game:GetService("Stats")) or game:GetService("Stats")

local as_conns       = {}
local last_ball      = nil
local last_zoomies   = nil
local was_clashing   = false
local next_fire_time = 0

System.auto_spam.start = function()
    for _, c in ipairs(as_conns) do pcall(function() c:Disconnect() end) end
    table.clear(as_conns)

    if setfpscap then setfpscap(240) end

    System.__properties.__auto_spam_enabled = true
    System.__properties.__is_spamming       = false
    was_clashing   = false
    next_fire_time = 0

    local anim_fn     = System.animation and System.animation.play_grab_parry
    local ping_stat   = Stats.Network.ServerStatsItem["Data Ping"]
    local LocalPlayer = game:GetService("Players").LocalPlayer

    local last_ping_update = 0
    local cached_ping      = 50
    local is_clashing      = false

    local function burst_fire(dt)
        local parry_fn = parryfunction
        if parry_fn then
            local target_speed = System.__properties.__spam_rate or 180
            next_fire_time = next_fire_time + dt
            local packets_to_fire = math.floor(next_fire_time * target_speed)
            if packets_to_fire > 0 then
                next_fire_time = next_fire_time - (packets_to_fire / target_speed)
                for _ = 1, packets_to_fire do
                    task.spawn(parry_fn)
                    if anim_fn then task.defer(anim_fn) end
                end
            end
        end
    end

    local function update_clash_state()
        if not System.__properties.__auto_spam_enabled then
            is_clashing  = false
            was_clashing = false
            return
        end

        local ball = System.ball.get()
        if not ball then
            is_clashing  = false
            was_clashing = false
            return
        end

        local character    = LocalPlayer.Character
        local primary_part = character and character.PrimaryPart
        if not primary_part then
            is_clashing  = false
            was_clashing = false
            return
        end

        System.player.get_closest()
        local closest = Closest_Entity
        if not closest or not closest.PrimaryPart then
            is_clashing  = false
            was_clashing = false
            return
        end

        if ball ~= last_ball then
            last_ball    = ball
            last_zoomies = ball:FindFirstChild("zoomies")
        end

        local ball_vel    = (last_zoomies and last_zoomies.VectorVelocity) or ball.AssemblyLinearVelocity or Vector3.zero
        local speed       = math.max(ball_vel.Magnitude, 1)
        local ball_target = ball:GetAttribute("target")
        local my_name     = tostring(LocalPlayer)

        local my_pos      = primary_part.Position
        local ball_dist   = (my_pos - ball.Position).Magnitude
        local entity_dist = (my_pos - closest.PrimaryPart.Position).Magnitude

       
        if (ball_target ~= my_name and ball_target ~= closest.Name) or ball_dist > 40 then
            is_clashing  = false
            was_clashing = false
            return
        end

        local now = os.clock()
        if now - last_ping_update > 0.25 then
            local ok, p_val = pcall(function() return ping_stat:GetValue() end)
            if ok then cached_ping = p_val / 10 end
            last_ping_update = now
        end

        
        local tti = ball_dist / speed
        
        local is_approaching = true
        if speed > 5 then
            local dir_to_player = (my_pos - ball.Position).Unit
           
            is_approaching = (dir_to_player:Dot(ball_vel.Unit) > 0.05)
        end

        local is_true_clash = (entity_dist <= 25) 
                          and (speed >= 65) 
                          and (tti <= 0.135) 
                          and (is_approaching or ball_dist < 12)

        is_clashing = System.__properties.__is_spamming or is_true_clash
       
        if is_clashing then 
            if not was_clashing then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
                if animator then
                    for _, track in pairs(animator:GetPlayingAnimationTracks()) do
                        if track.Name == "GrabParry" or track.Name == "Grab" or track.Name == "SuccessParry" then
                            track.TimePosition = 0
                            track:Stop(0)
                        end
                    end
                end
                was_clashing = true
            end
        else
            was_clashing = false
        end
    end

    table.insert(as_conns, RunService.PreRender:Connect(function(dt)
        update_clash_state()
        if is_clashing then burst_fire() end
    end))

    task.spawn(function()
        local original_quality = settings().Rendering.QualityLevel
        local is_low_quality = false

        while System.__properties.__auto_spam_enabled do
            local dt  = RunService.Heartbeat:Wait()
            local fps = 1 / dt
            
            if fps < 50 and System.__properties.__is_spamming then
                if not is_low_quality then
                    is_low_quality = true
                    pcall(function() settings().Rendering.QualityLevel = 1 end)
                end
            else
                if is_low_quality then
                    is_low_quality = false
                    pcall(function() settings().Rendering.QualityLevel = original_quality end)
                end
            end
            
            task.wait(0.5)
        end
    end)
end

System.auto_spam.stop = function()
    System.__properties.__auto_spam_enabled = false
    System.__properties.__is_spamming       = false
    was_clashing   = false
    last_ball      = nil
    last_zoomies   = nil
    next_fire_time = 0
    
    for _, c in ipairs(as_conns) do pcall(function() c:Disconnect() end) end
    table.clear(as_conns)
    
    pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic end)
end


System.autoparry = {}

local MainCache = {
    Parry = {},
    Global = {
        AutoParryParried = false,
        AutoParryCurrentAccuracy = 0,
        TornadoTime = 0
    },
}

local function IsBall_Curved(Ball, Ping, char)
    if not Ball then
        return false
    end

    local Zoomies = Ball:FindFirstChild("zoomies")

    if not Zoomies then
        return false
    end

    local velocity = Zoomies.VectorVelocity
    local ball_direction = velocity.Unit
    local direction = (char.PrimaryPart.Position - Ball.Position).Unit
    local dot = direction:Dot(ball_direction)
    local speed = velocity.Magnitude
    local speed_threshold = math.min(speed / 100, 40)
    local direction_difference = (ball_direction - velocity).Unit
    local direction_similarity = direction:Dot(direction_difference)
    local dot_difference = dot - direction_similarity
    local distance = (char.PrimaryPart.Position - Ball.Position).Magnitude
    local dot_threshold = 0.5 - (Ping / 1000)
    local reach_time = distance / speed - (Ping / 1000)
    local ball_distance_threshold = 15 - math.min(distance / 1000, 15) + speed_threshold
    local clamped_dot = math.clamp(dot, -1, 1)
    local radians = math.rad(math.asin(clamped_dot))

    table.insert(MainCache.Parry[Ball].velHistory, velocity)
    if #MainCache.Parry[Ball].velHistory > 4 then
        table.remove(MainCache.Parry[Ball].velHistory, 1)
    end

    local enough_speed = speed > 160
    if enough_speed and reach_time > (Ping / 10 + (1 / 33.33)) then
        if speed < 300 then
            ball_distance_threshold = math.max(ball_distance_threshold - 15, 15)
        elseif speed > 300 and speed < 600 then
            ball_distance_threshold = math.max(ball_distance_threshold - 16, 16)
        elseif speed > 600 and speed < 1000 then
            ball_distance_threshold = math.max(ball_distance_threshold - 17, 17)
        elseif speed > 1000 and speed < 1500 then
            ball_distance_threshold = math.max(ball_distance_threshold - 19, 19)
        elseif speed > 1500 then
            ball_distance_threshold = math.max(ball_distance_threshold - 20, 20)
        end
    end

    if distance < ball_distance_threshold then
        return false
    end

    local adjusted_reach_time = reach_time + (1 / 33.33)
    if speed < 300 then
        if (tick() - MainCache.Parry[Ball].curving) < (adjusted_reach_time / 1.2) then
            return true
        end
    elseif speed >= 300 and speed < 450 then
        if (tick() - MainCache.Parry[Ball].curving) < (adjusted_reach_time / 1.21) then
            return true
        end
    elseif speed > 450 and speed < 600 then
        if (tick() - MainCache.Parry[Ball].curving) < (adjusted_reach_time / 1.335) then
            return true
        end
    elseif speed > 600 then
        if (tick() - MainCache.Parry[Ball].curving) < (adjusted_reach_time / 1.5) then
            return true
        end
    end

    local dot_threshold = 0.5 - (Ping / 1000)
    local direction_difference = (ball_direction - velocity.Unit)
    local direction_similarity = direction:Dot(direction_difference.Unit)
    local dot_difference = dot - direction_similarity
    
    if dot_difference < dot_threshold then
        return true
    end

    local clamped_dot = math.clamp(dot, -1, 1)
    local radians = math.deg(math.asin(clamped_dot))

    MainCache.Parry[Ball].lerp_radians = MainCache.Parry[Ball].lerp_radians + (radians - MainCache.Parry[Ball].lerp_radians) * 0.8

    if speed < 300 then
        if MainCache.Parry[Ball].lerp_radians < 0.02 then
            MainCache.Parry[Ball].last_warping = tick()
        end
        if (tick() - MainCache.Parry[Ball].last_warping) < (adjusted_reach_time / 1.19) then
            return true
        end
    else
        if MainCache.Parry[Ball].lerp_radians < 0.018 then
            MainCache.Parry[Ball].last_warping = tick()
        end
        if (tick() - MainCache.Parry[Ball].last_warping) < (adjusted_reach_time / 1.5) then
            return true
        end
    end

    if #MainCache.Parry[Ball].velHistory >= 4 then
        local intended_direction_difference = (ball_direction - MainCache.Parry[Ball].velHistory[1].Unit).Unit
        local intended_dot = direction:Dot(intended_direction_difference)
        local intended_dot_difference = dot - intended_dot

        local intended_direction_difference2 = (ball_direction - MainCache.Parry[Ball].velHistory[2].Unit).Unit
        local intended_dot2 = direction:Dot(intended_direction_difference2)
        local intended_dot_difference2 = dot - intended_dot2

        if intended_dot_difference < dot_threshold or intended_dot_difference2 < dot_threshold then
            return true
        end
    end

    local backwards_curve_detected = false
    local backwards_angle_threshold = 60

    local horiz_direction = Vector3.new(char.PrimaryPart.Position.X - Ball.Position.X, 0, char.PrimaryPart.Position.Z - Ball.Position.Z)
    if horiz_direction.Magnitude > 0 then
        horiz_direction = horiz_direction.Unit
    end

    local away_from_player = -horiz_direction

    local horiz_ball_dir = Vector3.new(ball_direction.X, 0, ball_direction.Z)
    if horiz_ball_dir.Magnitude > 0 then
        horiz_ball_dir = horiz_ball_dir.Unit
        local backwards_angle = math.deg(math.acos(math.clamp(away_from_player:Dot(horiz_ball_dir), -1, 1)))
        if backwards_angle < backwards_angle_threshold then
            backwards_curve_detected = true
        end
    end

    return (dot < dot_threshold) or backwards_curve_detected
end


System.autoparry.start = function()
    if System.__properties.__connections.__autoparry then
        System.__properties.__connections.__autoparry:Disconnect()
        System.__properties.__connections.__autoparry = nil
    end

    System.__properties.__autoparry_enabled  = true
    System.__properties.__last_parry_time    = 0
    System.__properties.__ball_targets       = System.__properties.__ball_targets or {}
    System.__properties.__interaction_locked = System.__properties.__interaction_locked or {}

   
    local active_training_balls = {}
    local workspace_cache = workspace
    local training_folder = workspace_cache:FindFirstChild("TrainingBalls")
    local alive_folder    = workspace_cache:FindFirstChild("Alive")
    local runtime_folder  = workspace_cache:FindFirstChild("Runtime")
    local all_balls        = workspace_cache.Balls
    local tornado_time    = 0
    local local_name      = LocalPlayer.Name

    if training_folder then
        for _, child in ipairs(training_folder:GetChildren()) do
            if child and child:GetAttribute("realBall") then active_training_balls[child] = true end
        end
        System.__properties.__connections.__training_added = training_folder.ChildAdded:Connect(function(child)
            if child and child:GetAttribute("realBall") then active_training_balls[child] = true end
        end)
        System.__properties.__connections.__training_removed = training_folder.ChildRemoved:Connect(function(child)
            active_training_balls[child] = nil
            System.__properties.__ball_targets[child] = nil
            System.__properties.__interaction_locked[child] = nil
        end)
    end

    local connection
    connection = RunService.RenderStepped:Connect(function()
        if not System.__properties.__autoparry_enabled then return end

        local character = LocalPlayer.Character
        local root_part = character and character.PrimaryPart
        if not character or not root_part then return end

        if root_part:FindFirstChild('SingularityCape') then return end

        if getgenv().InfinityDetection and System.__properties.__infinity_active then return end
        if getgenv().DeathSlashDetection and System.__properties.__deathslash_active then return end
        if getgenv().TimeHoleDetection and System.__properties.__timehole_active then return end
        if getgenv().SlashesOfFuryDetection and System.__properties.__slashesoffury_active then return end

        local ProcessBall = WYNF_NO_VIRTUALIZE(function(Ball, is_training)
           if not Ball then
                return
            end

            if not MainCache.Parry[Ball] then
                MainCache.Parry[Ball] = {
                    lastVelUnit = nil,
                    velHistory = {},
                    lerp_radians = 0,
                    last_warping = 0,
                    curving = tick(),
                    LastParry = 0,
                    LobbyParried = false,
                    LobbyLastParry = tick(),
                    TargetConn = Ball:GetAttributeChangedSignal('target'):Connect(function()
                        MainCache.Global.AutoParryParried = false
                    end),
                    TornadoConn = Ball.ChildAdded:Connect(function(child)
                        if child.Name:lower():find('aerodynamicslashvfx') then
                            MainCache.Global.TornadoTime = tick()
                        end
                    end)
                }
            end

            local zoomies = Ball:FindFirstChild('zoomies')
            if not zoomies then
                return
            end

            Ball:GetAttributeChangedSignal('target'):Once(function()
                MainCache.Global.AutoParryParried = false
            end)

            if MainCache.Global.AutoParryParried then
                return
            end

            local ball_target = Ball:GetAttribute('target')
            local velocity = zoomies.VectorVelocity
            local distance = (character.PrimaryPart.Position - Ball.Position).Magnitude
            local raw_ping = Stats.Network.ServerStatsItem['Data Ping']:GetValue()
            local ping = raw_ping / 10
            local ping_threshold = math.clamp(ping / 10, 5, 17)
            local speed = velocity.Magnitude
            local capped_speed_diff = math.min(math.max(speed - 9.5, 0), 650)
            local speed_divisor = (2.4 + capped_speed_diff * 0.002) * (0.7 + (System.__properties.__accuracy - 0.8) * (0.35 / 99))
            local parry_accuracy = ping_threshold + math.max(speed / speed_divisor, 9.5)
            local curved = IsBall_Curved(Ball, raw_ping, character)

            if Runtime:FindFirstChild('Tornado') then
                if (tick() - MainCache.Global.TornadoTime) < (Runtime.Tornado:GetAttribute("TornadoTime") or 1) + 0.314159 then
                    return
                end
            end

            if Ball:FindFirstChild('ComboCounter') then return end
            if character.PrimaryPart:FindFirstChild('SingularityCape') then return end
          
            if ball_target == tostring(LocalPlayer) and distance <= parry_accuracy and not curved then
                local parry_time = tick()
                local time_view = parry_time - MainCache.Parry[Ball].LastParry
                if time_view > 0.25 then
                    System.animation.play_grab_parry()
                end
                parryfunction(false, nil, Ball)
                MainCache.Parry[Ball].LastParry = parry_time
                MainCache.Global.AutoParryParried = true
            end
            local last_parrys = tick()
            repeat
                RunService.PreSimulation:Wait()
            until (tick() - last_parrys) >= 1 or not MainCache.Global.AutoParryParried
            MainCache.Global.AutoParryParried = false
        end)

        for _, Ball in ipairs(all_balls:GetChildren()) do ProcessBall(Ball, false) end
        for _, t_ball in ipairs(active_training_balls) do ProcessBall(t_ball, true) end
    end)

    System.__properties.__connections.__autoparry = connection
end

System.autoparry.stop = function()
    System.__properties.__autoparry_enabled = false
    if System.__properties.__connections.__autoparry then
        System.__properties.__connections.__autoparry:Disconnect()
        System.__properties.__connections.__autoparry = nil
    end
    if System.__properties.__connections.__training_added then
        System.__properties.__connections.__training_added:Disconnect()
        System.__properties.__connections.__training_added = nil
    end
    if System.__properties.__connections.__training_removed then
        System.__properties.__connections.__training_removed:Disconnect()
        System.__properties.__connections.__training_removed = nil
    end
    System.__properties.__last_parry_time = 0
    System.__properties.__ball_targets = {}
    System.__properties.__interaction_locked = {}
    System.__properties.__multi_threat_urgent = false
end

System.triggerbot = {}

System.triggerbot.start = function()
    if System.__triggerbot.__connection then
        pcall(function() System.__triggerbot.__connection:Disconnect() end)
    end
    System.__triggerbot.__enabled = true
    System.__triggerbot.__last_trigger_time = 0

    System.__triggerbot.__connection = RunService.Heartbeat:Connect(function()
        if not System.__triggerbot.__enabled then return end
        local character = LocalPlayer.Character
        local root = character and character.PrimaryPart
        if not character or not root then return end

        local now = os.clock()
        if now - (System.__triggerbot.__last_trigger_time or 0) < 0.065 then return end

        local char_pos = root.Position
        local my_name = LocalPlayer.Name
        local trig_range = System.__triggerbot.__trigger_range or 28

        local function check_ball(ball)
            local zoomies = ball:FindFirstChild("zoomies")
            if not zoomies then return false end
            local vel = zoomies.VectorVelocity
            local spd = vel.Magnitude
            if spd < 10 then return false end

            local diff = char_pos - ball.Position
            local dist = diff.Magnitude
            if dist > trig_range or dist < 1 then return false end

            local dir = diff / dist
            local vdir = vel / spd
            local dt = dir:Dot(vdir)

            local tti = dist / spd
            local trigger_tti = math.clamp(0.14 + (spd / 2000), 0.14, 0.28)
            local mdot = math.clamp(0.15 - (spd / 500), -0.2, 0.15)

            if (tti <= trigger_tti or dist <= 9.0) and dt > mdot then
                System.__triggerbot.__last_trigger_time = now
                if System.animation and System.animation.play_grab_parry then
                    System.animation.play_grab_parry()
                end
                local cf = System.curve and System.curve.get_cframe()
                if parryfunction then parryfunction(false, cf) end
                return true
            end
            return false
        end

        for _, ball in ipairs(System.ball.get_all()) do
            if ball:GetAttribute("target") == my_name then
                if check_ball(ball) then return end
            end
        end

        local tf = workspace:FindFirstChild("TrainingBalls")
        if tf then
            for _, ball in ipairs(tf:GetChildren()) do
                if ball:GetAttribute("realBall") and check_ball(ball) then return end
            end
        end
    end)
end

System.triggerbot.stop = function()
    System.__triggerbot.__enabled = false
    if System.__triggerbot.__connection then
        pcall(function() System.__triggerbot.__connection:Disconnect() end)
        System.__triggerbot.__connection = nil
    end
end



local Notification = NeverLose:CreateNotification()
local Logging = NeverLose:CreateLogger()
local Indicator = NeverLose:CreateIndicator()

local Window = NeverLose:CreateWindow({
    Logo = "rbxassetid://123531821006884",  
    Name = "SYS-MODULE.XYZ",
    Content = "Blade Ball",
    Size = NeverLose.Scales.Default,
    ConfigFolder = "BladeBallConfigs",
    Enable3DRenderer = false,
    Keybind = "RightControl"
})

local Watermark = Window:Watermark()
Window:AddTabLabel('BLADE BALL')

--watermarker
local ping = Watermark:AddBlock("chart-four-vertical-bars", "0MS")
local UITogg = Watermark:AddBlock("cube-vertexes", "SYS-MODULE")

UITogg:Input(function()
    Window:ToggleInterface()
end)

task.spawn(function()
    while true do 
        task.wait(1)
        ping:SetText(tostring(math.random(30, 90)) .. 'MS')
    end
end)

--bruh
local Blatant = Window:AddTab({
    Icon = 'crosshairs',
    Name = "Blatant"
})

local Exclusive = Window:AddTab({
    Icon = 'crown',
    Name = "Exclusive"
})

local Misc = Window:AddTab({
    Icon = 'gear',
    Name = "Misc"
})

--tab
local CombatSection = Blatant:AddSection({
    Name = "COMBAT"
})

local SpamSection = Blatant:AddSection({
    Name = "SPAM",
    Position = 'right'
})

--combat section
local AutoParryLabel = CombatSection:AddLabel('Auto Parry')
AutoParryLabel:ToolTip("Automatically parries incoming balls")
AutoParryLabel:AddToggle({
    Default = false,
    Flag = "AutoParry",
    Callback = function(value)
        System.__properties.__autoparry_enabled = value
        if value then
            System.autoparry.start()
            if getgenv().AutoParryNotify then
                Notification.new({
                    Title = "Auto Parry",
                    Content = "ON",
                    Duration = 2
                })
            end
        else
            System.autoparry.stop()
            if getgenv().AutoParryNotify then
                Notification.new({
                    Title = "Auto Parry",
                    Content = "OFF",
                    Duration = 2
                })
            end
        end
    end
})

CombatSection:AddLabel('Curve Type'):AddDropdown({
    Default = System.__config.__curve_names[1],
    Values = System.__config.__curve_names,
    Flag = "CurveType",
    Callback = function(value)
        for i, name in ipairs(System.__config.__curve_names) do
            if name == value then
                System.__properties.__curve_mode = i
                break
            end
        end
    end
})

CombatSection:AddLabel('Parry Accuracy'):AddSlider({
    Min = 1,
    Max = 100,
    Type = "%",
    Default = 50,
    Flag = "Accuracy",
    Callback = function(value)
        System.__properties.__accuracy = value
    end
})

CombatSection:AddLabel('Triggerbot'):AddToggle({
    Default = false,
    Flag = "Triggerbot",
    Callback = function(value)
        System.__triggerbot.__enabled = value
        if value then
            System.triggerbot.start()
        else
            System.triggerbot.stop()
        end
    end
})

CombatSection:AddLabel('Trigger Range'):AddSlider({
    Min = 10,
    Max = 50,
    Type = " studs",
    Default = 28,
    Flag = "TriggerRange",
    Callback = function(value)
        System.__triggerbot.__trigger_range = value
    end
})

CombatSection:AddLabel("Infinity Detection"):AddToggle({
    Default = false,
    Flag = "InfinityDetection",
    Callback = function(value)
        getgenv().InfinityDetection = value
    end
})

CombatSection:AddLabel("Death Slash Detection"):AddToggle({
    Default = false,
    Flag = "DeathSlashDetection",
    Callback = function(value)
        getgenv().DeathSlashDetection = value
    end
})


CombatSection:AddLabel("Time Hole Detection"):AddToggle({
    Default = false,
    Flag = "TimeHoleDetection",
    Callback = function(value)
        getgenv().TimeHoleDetection = value
    end
})

CombatSection:AddLabel("Slashes of Fury Detection"):AddToggle({
    Default = false,
    Flag = "SlashesOfFuryDetection",
    Callback = function(value)
        getgenv().SlashesOfFuryDetection = value
    end
})

CombatSection:AddLabel("Phantom Detection"):AddToggle({
    Default = false,
    Flag = "PhantomDetection",
    Callback = function(value)
        System.__config.__detections.__phantom = value
    end
})

CombatSection:AddLabel("Fracture Detection"):AddToggle({
    Default = false,
    Flag = "FractureDetection",
    Callback = function(value)
        getgenv().FractureDetection = value
    end
})

CombatSection:AddLabel("Aerodynamic Slash Detection"):AddToggle({
    Default = false,
    Flag = "AerodynamicSlashDetection",
    Callback = function(value)
        getgenv().AerodynamicSlashDetection = value
    end
})


local create_mobile_button = function(name, position_y, color)
    local gui = Instance.new("ScreenGui")
    gui.Name = "Sigma" .. name .. "Mobile"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = gethui()

    local container = Instance.new("Frame")
    container.Size = UDim2.new(0, 200, 0, 100)
    container.Position = UDim2.new(0.5, -100, position_y, 0)
    container.AnchorPoint = Vector2.new(0.5, 0)
    container.BackgroundColor3 = Color3.fromRGB(35, 40, 90)
    container.BorderSizePixel = 0
    container.Active = true        
    container.Draggable = true    
    container.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 22)
    corner.Parent = container

    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Color3.fromRGB(180, 170, 255)
    stroke.Thickness = 2
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = container

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundTransparency = 1
    button.Text = ""
    button.AutoButtonColor = false
    button.Active = false          
    button.ZIndex = 2
    button.Parent = container

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = name
    text.Font = Enum.Font.GothamBlack
    text.TextSize = 22
    text.TextColor3 = Color3.fromRGB(240, 240, 255)
    text.ZIndex = 3
    text.Parent = button

    return { gui = gui, bg = container, button = button, text = text }
end

local destroy_mobile_gui = function(gui_data)
    if gui_data and gui_data.gui then 
        gui_data.gui:Destroy() 
    end
end

--spam
SpamSection:AddLabel('Auto Spam'):AddToggle({
    Default = false,
    Flag = "AutoSpam",
    Callback = function(value)
        System.__properties.__auto_spam_enabled = value
        if value then 
            System.auto_spam.start() 
        else 
            System.auto_spam.stop() 
        end
    end
})

SpamSection:AddLabel('Spam Rate'):AddSlider({
    Min = 60,
    Max = 5000,
    Type = "ms",
    Default = 240,
    Flag = "SpamRate",
    Callback = function(value)
        System.__properties.__spam_rate = value
    end
})

SpamSection:AddLabel("Mode"):AddDropdown({
    Values = {"Remote", "Keypress"},
    Default = "Remote",
    Multi = false,
    Flag = "autospam_mode",
    Callback = function(value)
        getgenv().AutoSpamMode = value
    end
})

local ManualSpamLabel = SpamSection:AddLabel('Manual Spam')
ManualSpamLabel:AddToggle({
    Default = false,
    Flag = "ManualSpam",
    Callback = function(state)
        if System.__properties.__is_mobile then
            if state then
                if not System.__properties.__mobile_guis.manual_spam then
                    local manual_spam_mobile = create_mobile_button('Spam', 0.8, Color3.fromRGB(255, 255, 255))
                    System.__properties.__mobile_guis.manual_spam = manual_spam_mobile
                    local manual_touch_start = 0
                    local manual_was_dragged = false

                    manual_spam_mobile.button.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Touch then
                            manual_touch_start = tick()
                            manual_was_dragged = false
                        end
                    end)

                    manual_spam_mobile.button.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Touch then
                            if (tick() - manual_touch_start) > 0.1 then 
                                manual_was_dragged = true 
                            end
                        end
                    end)

                    manual_spam_mobile.button.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Touch and not manual_was_dragged then
                            System.__properties.__manual_spam_enabled = not System.__properties.__manual_spam_enabled
                            if System.__properties.__manual_spam_enabled then
                                System.manual_spam.start()
                                manual_spam_mobile.text.Text = "ON"
                                manual_spam_mobile.text.TextColor3 = Color3.fromRGB(0, 255, 100)
                            else
                                System.manual_spam.stop()
                                manual_spam_mobile.text.Text = "Spam"
                                manual_spam_mobile.text.TextColor3 = Color3.fromRGB(255, 255, 255)
                            end
                        end
                    end)
                end
            else
                System.__properties.__manual_spam_enabled = false
                System.manual_spam.stop()
                destroy_mobile_gui(System.__properties.__mobile_guis.manual_spam)
                System.__properties.__mobile_guis.manual_spam = nil
            end
        else
            System.__properties.__manual_spam_enabled = state
            if state then 
                System.manual_spam.start() 
            else 
                System.manual_spam.stop() 
            end
        end
    end
})

local AnimationSection = Blatant:AddSection({
    Name = "ANIMATION",
    Position = "right"
})

local AnimationLabel = AnimationSection:AddLabel("Animation")

AnimationLabel:AddSlider({
    Min = 0,
    Max = 240,
    Type = " Hz",
    Default = 0,
    Rounding = 0,
    Flag = "AnimationFixRate",
    Callback = function(value)
        System.AnimationFixService.Rate = value

        if value > 0 then
            System.animation.startfix()
        else
            System.animation.stopfix()
        end
    end
})

AnimationSection:AddLabel("Disable Animation"):AddToggle({
    Default = false,
    Flag = "DisableAnimation",
    Callback = function(state)
        if state then
            System.animation.startdisable()
        else
            System.animation.stopdisable()
        end
    end
})

AnimationSection:AddLabel("Disable VFX"):AddToggle({
    Default = false,
    Flag = "DisableVFX",
    Callback = function(state)
        System.animation.togglevfx(state)
    end
})

local SkinSection = Exclusive:AddSection({
    Name = "SKIN CHANGER"
})

local EnableSkinLabel = SkinSection:AddLabel('Enable Skin Changer')
EnableSkinLabel:ToolTip("Changes your sword appearance and effects")
EnableSkinLabel:AddToggle({
    Default = false,
    Flag = "SkinChanger",
    Callback = function(value)
        skinchangerSystem.skinChangerEnabled = value
        if value then
            skinchangerSystem.changeSwordModel = true
            skinchangerSystem.changeSwordAnimation = true
            skinchangerSystem.changeSwordFX = true
            if skinchangerSystem.updateSword then 
                skinchangerSystem.updateSword() 
            end
        end
    end
})

SkinSection:AddLabel('Sword Name'):AddTextInput({
    Default = "",
    Placeholder = "Your Sword",
    Flag = "SwordName",
    Size = 150,
    Numeric = false,
    Callback = function(text)
        skinchangerSystem.swordModel = text
        skinchangerSystem.swordAnimations = text
        skinchangerSystem.swordFX = text
        if skinchangerSystem.skinChangerEnabled and skinchangerSystem.updateSword then
            skinchangerSystem.updateSword()
        end
    end
})

--misc

local MiscSection = Misc:AddSection({
    Name = "STATS"
})

MiscSection:AddLabel('Ball Stats'):AddToggle({
    Default = false,
    Flag = "BallStats",
    Callback = function(state)
        if state then 
            ball_velocity.start() 
        else 
            ball_velocity.stop() 
        end
    end
})

-- Tab Misc
local FOVSection = Misc:AddSection({
    Name = "FOV",
    Position = "right"
})

local FOVLabel = FOVSection:AddLabel("FOV")
FOVLabel:ToolTip("Changes Camera POV")
FOVLabel:AddToggle({
    Default = false,
    Flag = "FOV",
    Callback = function(value)
        getgenv().CameraEnabled = value
        local Camera = workspace.CurrentCamera

        if value then
            getgenv().CameraFOV = getgenv().CameraFOV or 70
            Camera.FieldOfView = getgenv().CameraFOV

            if not getgenv().FOVLoop then
                getgenv().FOVLoop = RunService.RenderStepped:Connect(function()
                    if getgenv().CameraEnabled then
                        workspace.CurrentCamera.FieldOfView = getgenv().CameraFOV
                    end
                end)
            end
        else
            Camera.FieldOfView = 70

            if getgenv().FOVLoop then
                getgenv().FOVLoop:Disconnect()
                getgenv().FOVLoop = nil
            end
        end
    end
})

FOVLabel:AddSlider({
    Min = 50,
    Max = 120,
    Type = "",
    Default = 70,
    Rounding = 0,
    Flag = "Camera_FOV",
    Callback = function(value)
        getgenv().CameraFOV = value
        if getgenv().CameraEnabled then
            workspace.CurrentCamera.FieldOfView = value
        end
    end
})

local GraphicsSection = Misc:AddSection({
    Name = "GRAPHICS",
    Position = "right"
})

GraphicsSection:AddLabel("Potato Graphics"):AddToggle({
    Default = false,
    Flag = "PotatoGraphics",
    Callback = function(state)
        if System and System.graphics and System.graphics.enablepotato then
            System.graphics.enablepotato(state)
        end
    end
})


--setting
Window:AddTabLabel('SETTINGS')

Window.UserSettings:AddLabel("Menu Keybind"):AddKeybind({
    Default = 'RightControl',
    Callback = function(v)
        Window.Keybind = v
        Logging.new("keyboard", 'Changed UI keybind to ' .. tostring(v), 5)
    end
})

Window.UserSettings:AddLabel('Menu Scale'):AddDropdown({
    Default = "Default",
    Values = {"Default", 'Large', 'Mobile', 'Small'},
    Callback = function(v)
        Window:SetSize(NeverLose.Scales[v])
        Logging.new("crop", 'Changed UI size to ' .. tostring(v), 5)
    end
})

Window.UserSettings:AddLabel('3D Menu'):AddToggle({
    Default = false,
    Callback = function(v)
        Window:Set3DRender(v)
    end
})

--notify
Notification.new({
    Title = "SYS-MODULE.XYZ",
    Content = "Successfully loaded Blade Ball",
    Duration = 5
})

Logging.new("check-circle", 'System initialized successfully', 5)

getgenv().Library = Window
