
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

pcall(function()
    WindUI:SetTheme("Midnight")
end)

WindUI:SetFont("rbxasset://fonts/families/FredokaOne.json")

function CrashServer()
    local e = game:GetService("ReplicatedStorage").GetSyncData
    local InvokeServer = e.InvokeServer
    local spawn = task.spawn
    local a = 0;
    
    game:GetService("StarterGui"):SetCore(
        "SendNotification",
        {
            Title = "Server IS COOKED",
            Text = "look how ppl freezing mid air lmao",
            Duration = 5
        }
    )
    while 1 do
        for i = 1, 1 do
            spawn(InvokeServer, e)
        end
        a = a + 1
        if a == 3 then
            a = 0
            wait(0)
        end
    end
end


function gradient(text, startColor, endColor)
		local result = "";
		local length = #text;
		for i = 1, length do
			local t = (i - 1) / math.max(length - 1, 1);
			local r = math.floor((startColor.R + ((endColor.R - startColor.R) * t)) * 255);
			local g = math.floor((startColor.G + ((endColor.G - startColor.G) * t)) * 255);
			local b = math.floor((startColor.B + ((endColor.B - startColor.B) * t)) * 255);
			local char = text:sub(i, i);
			result = result .. '<font color=\"rgb(' .. r .. ", " .. g .. ", " .. b .. ')\">' .. char .. "</font>";
		end
		return result;
	end

    local Confirmed = false;
WindUI:Popup({Title="Trav Hub",Icon="home",Desc="Welcome!",Color=Color3.fromRGB(120, 60, 90),AnimDuration=0.7,Buttons={{Title="Exit",Callback=function()
end,Variant="Tertiary"},{Title="Continue",Callback=function()
	Confirmed = true;
	-- Execute external script after user clicks continue
    loadstring(game:HttpGet("ucanputwhateveruwant"))()
end,Variant="Secondary"}}});
	repeat
		task.wait();
	until Confirmed 

-- */  Colors  /* --
local Green = Color3.fromHex("#FF69B4") -- Valentine Pink
local Blue = Color3.fromHex("#FF1493") -- Deep Pink
local Yellow = Color3.fromHex("#FFB6C1") -- Light Pink
local Grey = Color3.fromHex("#FFC0CB") -- Pink
local Purple = Color3.fromHex("#E91E63") -- Pink Red
local Red = Color3.fromHex("#DC143C") -- Crimson

-- */  Window  /* --
local Window = WindUI:CreateWindow({
    Title = "Trav Hub",
    Author = "🏖️ Summer Event Update :)",
    Folder = "travhub",
    NewElements = true,
    HideSearchBar = false,
    OpenButton = {
        Title = "Open!",
        CornerRadius = UDim.new(0, 10),
        StrokeThickness = 12,
        Enabled = true,
        Draggable = true,
        OnlyMobile = false,
        Scale = 1.2,
        Position = UDim2.new(0, 20, 1, -70),
        Color = ColorSequence.new(
            Color3.fromRGB(255, 105, 180),
            Color3.fromRGB(180, 0, 255)
        )
    },
    Topbar = {
        Height = 44,
        ButtonsType = "Mac",
        TagOffset = 56,  -- pixels to push Revamped! tag right, prevents overlap with title
    },
})

-- Toggle key (desktop); mobile uses the OpenButton tap (OnlyMobile = false so button shows on all platforms)
Window:SetToggleKey(Enum.KeyCode.RightShift)

-- */  Mac Button Effects  /* --
task.defer(function()
    local TweenService = game:GetService("TweenService")
    local RunService   = game:GetService("RunService")

    for _, btn in pairs(Window.TopBarButtons) do
        pcall(function()
            local frame = btn.Object

            -- Show indicators (icons) so users know close/minimize/fullscreen
            for _, desc in ipairs(frame:GetDescendants()) do
                if desc:IsA("ImageLabel") then
                    desc.ImageTransparency = 0
                end
            end

            -- Pulse effect using existing UIScale
            local scale = frame:FindFirstChildOfClass("UIScale")
                or Instance.new("UIScale", frame)
            task.spawn(function()
                while frame and frame.Parent do
                    TweenService:Create(scale, TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Scale=1.1}):Play()
                    task.wait(0.9)
                    TweenService:Create(scale, TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Scale=1.0}):Play()
                    task.wait(0.9)
                end
            end)
        end)
    end

    -- Spin gradient inside each button every frame
    RunService.RenderStepped:Connect(function()
        for _, btn in pairs(Window.TopBarButtons) do
            pcall(function()
                local grad = btn.Object:FindFirstChildOfClass("UIGradient")
                if grad then
                    grad.Rotation = (grad.Rotation + 3) % 360
                end
            end)
        end
    end)
end)

-- */  Tags  /* --
local AuraTag
do
    AuraTag = Window:Tag({
        Title = "xYSF",
        Icon = "youtube",
        Color = Color3.fromRGB(90, 25, 55),
        Border = true,
    })
end

-- */  Sections  /* --
local Sections = {
    HomeSection = Window:Section({
        Title = "Home",
        Box = false,
        FontWeight = "SemiBold",
        TextTransparency = 0.05,
        TextXAlignment = "Left",
        TextSize = 17,
        Opened = true,
    }),
    AutofarmSection = Window:Section({
        Title = "Autofarm",
        Box = false,
        FontWeight = "SemiBold",
        TextTransparency = 0.05,
        TextXAlignment = "Left",
        TextSize = 17,
        Opened = true, -- Expanded by default so tabs pop out
    }),
    DetectionSection = Window:Section({
        Title = "Detection",
        Box = false,
        FontWeight = "SemiBold",
        TextTransparency = 0.05,
        TextXAlignment = "Left",
        TextSize = 17,
        Opened = true,
    }),
    CombatSection = Window:Section({
        Title = "Combat",
        Box = false,
        FontWeight = "SemiBold",
        TextTransparency = 0.05,
        TextXAlignment = "Left",
        TextSize = 17,
        Opened = true,
    }),
    EspSection = Window:Section({
        Title = "ESP",
        Box = false,
        FontWeight = "SemiBold",
        TextTransparency = 0.05,
        TextXAlignment = "Left",
        TextSize = 17,
        Opened = true,
    }),
    NewGodlies = Window:Section({
        Title = "Event",
        Box = false,
        FontWeight = "SemiBold",
        TextTransparency = 0.05,
        TextXAlignment = "Left",
        TextSize = 17,
        Opened = true,
    }),
    RoundManagement = Window:Section({
        Title = "Round Management",
        Box = false,
        FontWeight = "SemiBold",
        TextTransparency = 0.05,
        TextXAlignment = "Left",
        TextSize = 17,
        Opened = true,
    }),
    Halloween = Window:Section({
        Title = "Items",
        Box = false,
        FontWeight = "SemiBold",
        TextTransparency = 0.05,
        TextXAlignment = "Left",
        TextSize = 17,
        Opened = true,
    }),
    AppearanceSection = Window:Section({
        Title = "Appearance",
        Box = false,
        FontWeight = "SemiBold",
        TextTransparency = 0.05,
        TextXAlignment = "Left",
        TextSize = 17,
        Opened = true,
    }),
    Credits = Window:Section({
        Title = "Credits",
        Box = false,
        FontWeight = "SemiBold",
        TextTransparency = 0.05,
        TextXAlignment = "Left",
        TextSize = 17,
        Opened = true,
    }),
}

-- */  Tabs  /* --
local Tabs = {
    HomeTab = Sections.HomeSection:Tab({ Title = "Welcome", Icon = "home", Desc = "Get started with Trav Hub", IconColor = Blue, IconShape = "Square", Border = true }),
    FastestAutofarmTab = Sections.AutofarmSection:Tab({ Title = "Autofarm", Icon = "zap", Desc = "Collect coins automatically", IconColor = Green, IconShape = "Square", Border = true }),
    AntiAFKTab = Sections.AutofarmSection:Tab({ Title = "AFK", Icon = "clock", Desc = "Stay active during long sessions", IconColor = Blue, IconShape = "Square", Border = true }),
    CoinDetectionTab = Sections.DetectionSection:Tab({ Title = "Coin Detection", Icon = "coins", Desc = "Track coins and auto-reset", IconColor = Yellow, IconShape = "Square", Border = true }),
    CombatTab = Sections.CombatSection:Tab({ Title = "Combat", Icon = "crosshair", Desc = "Aimbot and combat tools", IconColor = Red, IconShape = "Square", Border = true }),
    EspTab = Sections.EspSection:Tab({ Title = "ESP", Icon = "eye", Desc = "ESP settings", IconColor = Green, IconShape = "Square", Border = true }),
    EndRoundTab = Sections.RoundManagement:Tab({ Title = "End Round", Icon = "refresh-cw", Desc = "Fling and round controls", IconColor = Purple, IconShape = "Square", Border = true }),
    Spawner = Sections.NewGodlies:Tab({ Title = "Item Spawner", Icon = "refresh-cw", Desc = "Spawn any weapon in game", IconColor = Blue, IconShape = "Square", Border = true }),
    CoinDuper = Sections.NewGodlies:Tab({ Title = "Coin Duper", Icon = "refresh-cw", Desc = "Duplicate event coins", IconColor = Green, IconShape = "Square", Border = true }),
    ServerCrasher = Sections.RoundManagement:Tab({ Title = "Crash Server", Icon = "refresh-cw", Desc = "Crash the server", IconColor = Red, IconShape = "Square", Border = true }),
    BeachballsTab = Sections.Halloween:Tab({ Title = "Event Items", Icon = "gift", Desc = "Event coin duplication", IconColor = Green, IconShape = "Square", Border = true }),
    ChangelogsTab = Sections.Halloween:Tab({ Title = "Changelogs", Icon = "info", Desc = "Update history", IconColor = Grey, IconShape = "Square", Border = true }),
    ThemesTab = Sections.AppearanceSection:Tab({ Title = "Themes", Icon = "palette", Desc = "Switch the UI theme", IconColor = Purple, IconShape = "Square", Border = true }),
    DevelopersTab = Sections.Credits:Tab({ Title = "Developers", Icon = "info", Desc = "Credits and developers", IconColor = Grey, IconShape = "Square", Border = true })
}

-- */  Theme Icon Colors  /* --
local ThemeIconMap = {
    Rose        = { Accent="#be185d", Icon="#fb7185", Button="#e95f74", Placeholder="#d67aa6" },
    Easter      = { Accent="#a855f7", Icon="#e879f9", Button="#7c3aed", Placeholder="#9b8fc0" },
    CottonCandy = { Accent="#ec4899", Icon="#06b6d4", Button="#d946ef", Placeholder="#8a5fd3" },
    Dark        = { Accent="#18181b", Icon="#a1a1aa", Button="#52525b", Placeholder="#7a7a7a" },
    Light       = { Accent="#FFFFFF", Icon="#52525b", Button="#18181b", Placeholder="#555555" },
    Midnight    = { Accent="#1e3a8a", Icon="#5591f4", Button="#2563eb", Placeholder="#2f74d1" },
    Crimson     = { Accent="#b91c1c", Icon="#dc2626", Button="#991b1b", Placeholder="#6f757b" },
    Violet      = { Accent="#6d28d9", Icon="#8b5cf6", Button="#7c3aed", Placeholder="#8f7ee0" },
    Indigo      = { Accent="#3730a3", Icon="#6366f1", Button="#4f46e5", Placeholder="#7078d9" },
    Sky         = { Accent="#00d4ff", Icon="#2db8d9", Button="#00a8cc", Placeholder="#66b3cc" },
    Plant       = { Accent="#166534", Icon="#4ade80", Button="#16a34a", Placeholder="#4fbf7a" },
    Red         = { Accent="#991b1b", Icon="#ef4444", Button="#dc2626", Placeholder="#d95353" },
    Emerald     = { Accent="#047857", Icon="#10b981", Button="#059669", Placeholder="#3fbf8f" },
    Amber       = { Accent="#b45309", Icon="#f59e0b", Button="#d97706", Placeholder="#d1a326" },
    MonokaiPro  = { Accent="#fc9867", Icon="#a9dc76", Button="#ab9df2", Placeholder="#6f6f6f" },
    Mellowsi    = { Accent="#342A1E", Icon="#C9B79C", Button="#342A1E", Placeholder="#9C8A73" },
    Rainbow     = { Accent="#00ff41", Icon="#ffffff", Button="#ff0080", Placeholder="#00ff80" },
}

local function updateTabColors(theme)
    local t = ThemeIconMap[theme]
    if not t then return end
    local accent      = Color3.fromHex(t.Accent)
    local icon        = Color3.fromHex(t.Icon)
    local button      = Color3.fromHex(t.Button)
    local placeholder = Color3.fromHex(t.Placeholder)

    local function setColor(tab, fillColor)
        pcall(function()
            local frame = tab.UIElements.Main.Frame
            for _, child in ipairs(frame:GetChildren()) do
                if child:IsA("ImageLabel") then
                    -- Update fill background
                    child.ImageColor3 = fillColor
                    -- Update icon image to contrast color
                    local _, _, v = Color3.toHSV(fillColor)
                    local contrastColor = v > 0.65 and Color3.fromRGB(30, 30, 30) or Color3.fromRGB(255, 255, 255)
                    for _, desc in ipairs(child:GetDescendants()) do
                        if desc:IsA("ImageLabel") then
                            desc.ImageColor3 = contrastColor
                        end
                    end
                    break
                end
            end
        end)
    end

    setColor(Tabs.HomeTab,             accent)
    setColor(Tabs.FastestAutofarmTab,  icon)
    setColor(Tabs.AntiAFKTab,          accent)
    setColor(Tabs.CoinDetectionTab,    icon)
    setColor(Tabs.CombatTab,           button)
    setColor(Tabs.EspTab,              icon)
    setColor(Tabs.EndRoundTab,         accent)
    setColor(Tabs.Spawner,             accent)
    setColor(Tabs.CoinDuper,           icon)
    setColor(Tabs.ServerCrasher,       button)
    setColor(Tabs.BeachballsTab,       icon)
    setColor(Tabs.ChangelogsTab,       placeholder)
    setColor(Tabs.ThemesTab,           accent)
    setColor(Tabs.DevelopersTab,       placeholder)

    -- Update aura... tag color
    pcall(function()
        AuraTag:SetColor(accent)
    end)

    -- Update Mac button colors + gradients
    local btnThemeColors = { accent, icon, button }
    local i = 1
    for _, btn in pairs(Window.TopBarButtons) do
        pcall(function()
            local col = btnThemeColors[i] or accent
            local h, s, v = Color3.toHSV(col)
            local lighter = Color3.fromHSV(h, math.max(s - 0.25, 0), math.min(v + 0.3, 1))
            btn.Object.ImageColor3 = col
            local grad = btn.Object:FindFirstChildOfClass("UIGradient")
                or Instance.new("UIGradient", btn.Object)
            grad.Rotation = 135
            grad.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, lighter),
                ColorSequenceKeypoint.new(1, col),
            })
            i = i + 1
        end)
    end
end

local ThemeGradientMap = {
    Rose        = { Color3.fromRGB(255, 105, 180), Color3.fromRGB(220,  20,  60) },
    Easter      = { Color3.fromRGB(168,  85, 247), Color3.fromRGB(236, 121, 249) },
    CottonCandy = { Color3.fromRGB(236,  72, 153), Color3.fromRGB(  6, 182, 212) },
    Dark        = { Color3.fromRGB( 82,  82,  91), Color3.fromRGB(161, 161, 170) },
    Light       = { Color3.fromRGB( 24,  24,  27), Color3.fromRGB( 82,  82,  91) },
    Midnight    = { Color3.fromRGB( 30,  58, 138), Color3.fromRGB( 85, 145, 244) },
    Crimson     = { Color3.fromRGB(185,  28,  28), Color3.fromRGB(220,  38,  38) },
    Violet      = { Color3.fromRGB(109,  40, 217), Color3.fromRGB(139,  92, 246) },
    Indigo      = { Color3.fromRGB( 55,  48, 163), Color3.fromRGB( 99, 102, 241) },
    Sky         = { Color3.fromRGB(  0, 212, 255), Color3.fromRGB( 45, 184, 217) },
    Plant       = { Color3.fromRGB( 22, 101,  52), Color3.fromRGB( 74, 222, 128) },
    Red         = { Color3.fromRGB(153,  27,  27), Color3.fromRGB(239,  68,  68) },
    Emerald     = { Color3.fromRGB(  4, 120,  87), Color3.fromRGB( 16, 185, 129) },
    Amber       = { Color3.fromRGB(180,  83,   9), Color3.fromRGB(245, 158,  11) },
    MonokaiPro  = { Color3.fromRGB(252, 152, 103), Color3.fromRGB(169, 220, 118) },
    Mellowsi    = { Color3.fromRGB( 52,  42,  30), Color3.fromRGB(201, 183, 156) },
    Rainbow     = { Color3.fromRGB(  0, 255,  65), Color3.fromRGB(128,   0, 255) },
}

local function updateBorderGradient(theme)
    local colors = ThemeGradientMap[theme]
    if not colors then return end
    local seq = ColorSequence.new({
        ColorSequenceKeypoint.new(0,   colors[1]),
        ColorSequenceKeypoint.new(0.5, colors[2]),
        ColorSequenceKeypoint.new(1,   colors[1]),
    })
    if Window.UIElements.WindowGradient then
        Window.UIElements.WindowGradient.Color = seq
    end
    pcall(function()
        Window:EditOpenButton({ Color = seq })
    end)
end

updateTabColors("Mellowsi")
updateBorderGradient("Mellowsi")

WindUI:OnThemeChange(function(newTheme)
    updateTabColors(newTheme)
end)

-- */  Home Tab  /* --
do
    Tabs.HomeTab:Paragraph({
        Title = "Welcome to Trav Hub!",
        Desc = "Thanks for using our MM2 script. This guide will help you get the most out of every feature.",
    })
    Tabs.HomeTab:Paragraph({
        Title = "Getting Started",
        Desc = "· Toggle the script with Right Shift (or tap the Open button on mobile)\n· Use the section tabs on the left to navigate each category\n· Enable features with toggles; many work instantly",
    })
    Tabs.HomeTab:Paragraph({
        Title = "Autofarm",
        Desc = "Autofarm collects coins automatically; AFK keeps you active during long sessions.",
    })
    Tabs.HomeTab:Paragraph({
        Title = "Detection & Combat",
        Desc = "Coin Detection tracks coins and can auto-reset at 40. Combat includes aimbot (hold E on desktop) and sheriff tools.",
    })
    Tabs.HomeTab:Paragraph({
        Title = "ESP & Round Control",
        Desc = "ESP highlights players and gun drops; End Round lets you fling or auto-fling the murderer.",
    })
    Tabs.HomeTab:Paragraph({
        Title = "Event",
        Desc = "Item Spawner spawns weapons; Coin Duper and Event Items help with coin duplication.",
    })
    Tabs.HomeTab:Paragraph({
        Title = "Discord Webhook",
        Desc = "Set a webhook URL in the Autofarm tab to receive session reports with coins collected.",
    })
end

-- */  Coin Duper Tab  /* --
do
    local CoinDuperSection = Tabs.CoinDuper:Section({ Title = "Coin Duplication", Box = true, BoxBorder = true, Opened = true })
    local DupeCoinsBtn
    DupeCoinsBtn = Tabs.CoinDuper:Button({
        Title = "Dupe Event Coins",
        Callback = function()
            DupeCoinsBtn:Highlight()
            local EventFrames = game:GetService("Players").LocalPlayer.PlayerGui.CrossPlatform.Christmas2025.Container.EventFrames

            local function getOldValue()
                return tonumber(EventFrames.BattlePass.Info.Tokens.Container.TextLabel.Text)
            end

            local gui_list = {
                EventFrames.BattlePass.Info.Tokens.Container.TextLabel,
                EventFrames.MysteryBox.Info.Tokens.Container.TextLabel,
                EventFrames.PurchaseCurrency.Info.Tokens.Container.TextLabel
            }

            local function dupeAllValues()
                local old_value = getOldValue()
                local new_value = old_value * 2
                for _, v in pairs(gui_list) do
                    v.Text = new_value
                end
            end

            dupeAllValues()
        end
    })
end

-- */  Themes Tab  /* --
do
    local ThemeSection = Tabs.ThemesTab:Section({ Title = "UI Theme", Desc = "Switch the look of Trav Hub", Box = true, BoxBorder = true, Opened = true })
    ThemeSection:Dropdown({
        Title = "Select Theme",
        Values = { "Rose", "Easter", "CottonCandy", "Dark", "Light", "Midnight", "Crimson", "Violet", "Indigo", "Sky", "Plant", "Red", "Emerald", "Amber", "MonokaiPro", "Mellowsi", "Rainbow" },
        Default = "Mellowsi",
        Callback = function(theme)
            WindUI:SetTheme(theme)
            updateBorderGradient(theme)
            WindUI:Notify({ Title = "Theme", Content = "Switched to " .. theme, Icon = "palette", Duration = 3 })
        end
    })

    Tabs.ThemesTab:Space()

    local BorderSection = Tabs.ThemesTab:Section({ Title = "Border", Desc = "Adjust the window gradient border", Box = true, BoxBorder = true, Opened = true })
    BorderSection:Slider({
        Title = "Border Thickness",
        Value = { Min = 1, Max = 20, Default = 6 },
        Step = 1,
        Callback = function(val)
            pcall(function()
                Window.UIElements.WindowStroke.Thickness = val
            end)
        end
    })
end

-- */  Developers Tab  /* --
do
    Tabs.DevelopersTab:Paragraph({
        Title = 'made by xYSF',
        Desc = 'enjoy!'
    })
end

-- MiniFling function
local function miniFling(Targets)
    local Players = game:GetService("Players")
    local AllBool = false

    local GetPlayer = function(Name)
        Name = Name:lower()
        if Name == "all" or Name == "others" then
            AllBool = true
            return
        elseif Name == "random" then
            local GetPlayers = Players:GetPlayers()
            if table.find(GetPlayers,Players.LocalPlayer) then table.remove(GetPlayers,table.find(GetPlayers,Players.LocalPlayer)) end
            return GetPlayers[math.random(#GetPlayers)]
        elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then
            for _,x in next, Players:GetPlayers() do
                if x ~= Players.LocalPlayer then
                    if x.Name:lower():match("^"..Name) then
                        return x;
                    elseif x.DisplayName:lower():match("^"..Name) then
                        return x;
                    end
                end
            end
        else
            return
        end
    end

    local SkidFling = function(TargetPlayer)
        local Character = Players.LocalPlayer.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Humanoid and Humanoid.RootPart

        local TCharacter = TargetPlayer.Character
        local THumanoid
        local TRootPart
        local THead
        local Accessory
        local Handle

        if TCharacter:FindFirstChildOfClass("Humanoid") then
            THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
        end
        if THumanoid and THumanoid.RootPart then
            TRootPart = THumanoid.RootPart
        end
        if TCharacter:FindFirstChild("Head") then
            THead = TCharacter.Head
        end
        if TCharacter:FindFirstChildOfClass("Accessory") then
            Accessory = TCharacter:FindFirstChildOfClass("Accessory")
        end
        if Accessory and Accessory:FindFirstChild("Handle") then
            Handle = Accessory.Handle
        end

        if Character and Humanoid and RootPart then
            if RootPart.Velocity.Magnitude < 50 then
                getgenv().OldPos = RootPart.CFrame
            end
            if THumanoid and THumanoid.Sit and not AllBool then
                return 
            end
            if THead then
                game.Workspace.CurrentCamera.CameraSubject = THead
            elseif not THead and Handle then
                game.Workspace.CurrentCamera.CameraSubject = Handle
            elseif THumanoid and TRootPart then
                game.Workspace.CurrentCamera.CameraSubject = THumanoid
            end
            if not TCharacter:FindFirstChildWhichIsA("BasePart") then
                return
            end

            local FPos = function(BasePart, Pos, Ang)
                RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
                Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
                RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
                RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
            end

            local SFBasePart = function(BasePart)
                local TimeToWait = 2
                local Time = tick()
                local Angle = 0

                repeat
                    if RootPart and THumanoid then
                        if BasePart.Velocity.Magnitude < 50 then
                            Angle = Angle + 100

                            FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
                            task.wait()

                            FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()

                            FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()

                            FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()

                            FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()

                            FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()
                        else
                            FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()

                            FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                            task.wait()

                            FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()

                            FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()

                            FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                            task.wait()

                            FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()

                            FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()

                            FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                            task.wait()

                            FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
                            task.wait()

                            FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                            task.wait()
                        end
                    else
                        break
                    end
                until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
            end

            game.Workspace.FallenPartsDestroyHeight = 0/0

            local BV = Instance.new("BodyVelocity")
            BV.Name = "EpixVel"
            BV.Parent = RootPart
            BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
            BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)

            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

            if TRootPart and THead then
                if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
                    SFBasePart(THead)
                else
                    SFBasePart(TRootPart)
                end
            elseif TRootPart and not THead then
                SFBasePart(TRootPart)
            elseif not TRootPart and THead then
                SFBasePart(THead)
            elseif not TRootPart and not THead and Accessory and Handle then
                SFBasePart(Handle)
            else
                return 
            end

            BV:Destroy()
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            game.Workspace.CurrentCamera.CameraSubject = Humanoid

            repeat
                RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
                Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
                Humanoid:ChangeState("GettingUp")
                table.foreach(Character:GetChildren(), function(_, x)
                    if x:IsA("BasePart") then
                        x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                    end
                end)
                task.wait()
            until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
            game.Workspace.FallenPartsDestroyHeight = -500
        else
            return 
        end
        game.Workspace.FallenPartsDestroyHeight = -500
    end

    if Targets[1] then for _,x in next, Targets do GetPlayer(x) end else return end

    if AllBool then
        for _,x in next, Players:GetPlayers() do
            SkidFling(x)
        end
    end

    for _,x in next, Targets do
        if GetPlayer(x) and GetPlayer(x) ~= Players.LocalPlayer then
            local TPlayer = GetPlayer(x)
            if TPlayer then
                SkidFling(TPlayer)
            end
        elseif not GetPlayer(x) and not AllBool then
            
        end
    end
end

-- Find murderer logic (from mm2summerupd.lua)
local function getMurderer()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local success, result = pcall(function()
        return ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
    end)
    if success and result then
        for name, data in pairs(result) do
            if data.Role == "Murderer" then
                return game:GetService("Players"):FindFirstChild(name)
            end
        end
    end
    return nil
end

-- =========================
-- ESP CONFIG & CORE STATE
-- =========================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Universal-style ESP settings combined with MM2-specific role + gun ESP
local ESPSettings = {
    -- Universal visual toggles
    Enabled = false,
    BoxESP = false,
    OutlineESP = false,
    ShowName = false,
    ShowDistance = false,
    ESPTeammates = false,

    -- MM2 role / gun toggles
    HighlightMurderer = false,
    HighlightSheriff = false, -- used for both Sheriff and Hero (gun holders)
    HighlightInnocent = false,

    GunDropESP = false,
    NotifyGunDrop = true,
    AutoGrabGun = false,
}

-- MM2 role state
local roles, Murder, Sheriff, Hero = {}, nil, nil, nil

-- Gun-drop ESP state
local notifiedGunDrops = {}

-- Per-player ESP objects (SelectionBox + Highlight + BillboardGui)
local ESPObjects = {}

-- MM2 map names that can contain GunDrop (game may add new maps or change names)
local mapPaths = {
    "ResearchFacility", "Hospital3", "MilBase", "House2", "Workplace",
    "Mansion2", "BioLab", "Hotel", "Factory", "Bank2", "PoliceStation"
}

-- Possible names for gun drop instance (game updates may rename)
local gunDropNames = { "GunDrop", "DroppedGun", "Gun" }

-- Collect all gun-drop instances in workspace (recursive fallback if structure changed)
local function getAllGunDrops()
    local seen = {}
    local list = {}
    local function add(inst)
        if inst and not seen[inst] then
            seen[inst] = true
            table.insert(list, inst)
        end
    end
    -- Maps (original behavior)
    for _, mapName in ipairs(mapPaths) do
        local map = workspace:FindFirstChild(mapName)
        if map then
            for _, name in ipairs(gunDropNames) do
                local g = map:FindFirstChild(name)
                if g then add(g) end
            end
        end
    end
    -- Root workspace
    for _, name in ipairs(gunDropNames) do
        local g = workspace:FindFirstChild(name)
        if g then add(g) end
    end
    -- Recursive search anywhere (in case game moved or renamed)
    for _, desc in ipairs(workspace:GetDescendants()) do
        if table.find(gunDropNames, desc.Name) then add(desc) end
    end
    return list
end

-- =========================
-- MM2 ROLE HELPERS
-- =========================

local function IsAlive(player)
    local data = roles[player.Name]
    return data and not data.Killed and not data.Dead
end

local function UpdateRoles()
    local success, result = pcall(function()
        return ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
    end)

    if success and result then
        roles = result
        Murder, Sheriff, Hero = nil, nil, nil

        for name, data in pairs(roles) do
            if data.Role == "Murderer" then
                Murder = name
            elseif data.Role == "Sheriff" then
                Sheriff = name
            elseif data.Role == "Hero" then
                Hero = name
            end
        end
    end
end

local function getRoleTag(player)
    local data = roles[player.Name]
    if not data then return "Innocent" end
    return data.Role or "Innocent"
end

-- Returns Color3 or nil if this player should not be highlighted based on role toggles
local function getESPColorForPlayer(player)
    if not IsAlive(player) then
        return nil
    end

    if ESPSettings.HighlightMurderer and player.Name == Murder then
        return Color3.fromRGB(255, 0, 0) -- red
    end

    if ESPSettings.HighlightSheriff and (player.Name == Sheriff or player.Name == Hero) then
        return Color3.fromRGB(0, 0, 255) -- blue for gun holder (sheriff/hero)
    end

    if ESPSettings.HighlightInnocent
        and player.Name ~= Murder
        and player.Name ~= Sheriff
        and player.Name ~= Hero then
        return Color3.fromRGB(0, 255, 0) -- green for innocents
    end

    return nil
end

-- =========================
-- UNIVERSAL ESP BACKEND
-- =========================

local function shouldESP(player)
    if not ESPSettings.Enabled then
        return false
    end
    if player == LocalPlayer then
        return false
    end

    if not ESPSettings.ESPTeammates then
        local localTeam = LocalPlayer.Team
        local playerTeam = player.Team

        if localTeam and playerTeam and localTeam == playerTeam then
            return false
        end
    end

    return true
end

local function setupESPForPlayer(player)
    if player == LocalPlayer then
        return
    end
    if ESPObjects[player] then
        return
    end

    local box = Instance.new("SelectionBox")
    box.LineThickness = 0.05
    box.SurfaceTransparency = 1
    box.Visible = false
    box.Parent = workspace

    local hl = Instance.new("Highlight")
    hl.FillTransparency = 1
    hl.Enabled = false
    hl.Parent = workspace

    local bb = Instance.new("BillboardGui")
    bb.Size = UDim2.new(0, 200, 0, 40)
    bb.AlwaysOnTop = true
    bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.Enabled = false
    bb.Parent = workspace

    local txt = Instance.new("TextLabel")
    txt.Size = UDim2.new(1, 0, 1, 0)
    txt.BackgroundTransparency = 1
    txt.Font = Enum.Font.Gotham
    txt.TextStrokeTransparency = 0
    txt.TextSize = 13
    txt.TextColor3 = Color3.new(1, 1, 1)
    txt.Parent = bb

    ESPObjects[player] = {
        Box = box,
        HL = hl,
        BB = bb,
        TXT = txt,
    }
end

for _, p in ipairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then
        setupESPForPlayer(p)
    end
end

Players.PlayerAdded:Connect(function(p)
    setupESPForPlayer(p)
end)

Players.PlayerRemoving:Connect(function(p)
    local obj = ESPObjects[p]
    if obj then
        for _, v in pairs(obj) do
            if typeof(v) == "Instance" then
                v:Destroy()
            end
        end
        ESPObjects[p] = nil
    end
end)

RunService.RenderStepped:Connect(function()
    -- Keep roles fresh for MM2 every frame (lightweight table update)
    pcall(UpdateRoles)

    local showName = ESPSettings.ShowName
    local showDist = ESPSettings.ShowDistance
    local showBox = ESPSettings.BoxESP
    local showOutline = ESPSettings.OutlineESP

    for player, obj in pairs(ESPObjects) do
        local character = player.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        local hum = character and character:FindFirstChildOfClass("Humanoid")

        local visible = hum and hum.Health > 0 and hrp and character and shouldESP(player)

        if visible then
            local col = getESPColorForPlayer(player)
            if not col then
                -- Fallback color when ESP is on but no specific role highlight is selected
                col = Color3.fromRGB(0, 255, 0)
            end

            obj.Box.Color3 = col
            obj.HL.OutlineColor = col
            obj.TXT.TextColor3 = col

            obj.Box.Visible = showBox
            obj.Box.Adornee = showBox and character or nil

            obj.HL.Enabled = showOutline
            obj.HL.Adornee = showOutline and character or nil

            local useBillboard = showName or showDist
            obj.BB.Enabled = useBillboard
            obj.BB.Adornee = useBillboard and hrp or nil

            if useBillboard then
                local text = ""
                if showName then
                    text = player.Name
                end

                if showDist then
                    local dist = math.floor((Camera.CFrame.Position - hrp.Position).Magnitude)
                    if showName then
                        text = string.format("%s [%d studs]", text, dist)
                    else
                        text = string.format("%d studs", dist)
                    end
                end

                obj.TXT.Text = text
            end
        else
            obj.Box.Visible = false
            obj.Box.Adornee = nil
            obj.HL.Enabled = false
            obj.HL.Adornee = nil
            obj.BB.Enabled = false
            obj.BB.Adornee = nil
        end
    end
end)

-- =========================
-- GUNDROP ESP & AUTO GRAB
-- =========================

local function createGunDropHighlight(gunDrop)
    if gunDrop and not gunDrop:FindFirstChild("GunDropHighlight") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "GunDropHighlight"
        highlight.FillColor = Color3.fromRGB(255, 182, 193) -- Light Pink
        highlight.OutlineColor = Color3.fromRGB(255, 20, 147) -- Deep Pink
        highlight.Adornee = gunDrop
        highlight.Parent = gunDrop
    end
end

local function updateGunDropESP()
    local allDrops = getAllGunDrops()
    for _, gunDrop in ipairs(allDrops) do
        local existing = gunDrop:FindFirstChild("GunDropHighlight")
        if existing then
            existing:Destroy()
        end

        if ESPSettings.GunDropESP then
            createGunDropHighlight(gunDrop)
        end

        if ESPSettings.NotifyGunDrop and not notifiedGunDrops[gunDrop] then
            local placeName = gunDrop.Parent and gunDrop.Parent.Name or "Workspace"
            WindUI:Notify({
                Title = "Gun Drop",
                Content = "Gun dropped at: " .. placeName,
                Duration = 3,
            })
            notifiedGunDrops[gunDrop] = true
        end
    end
end

local function monitorGunDropSpawns()
    for _, mapName in ipairs(mapPaths) do
        local map = workspace:FindFirstChild(mapName)
        if map then
            map.DescendantAdded:Connect(function(desc)
                if table.find(gunDropNames, desc.Name) then
                    task.defer(updateGunDropESP)
                end
            end)
            map.ChildAdded:Connect(function(child)
                if table.find(gunDropNames, child.Name) then
                    task.defer(updateGunDropESP)
                end
            end)
            map.ChildRemoved:Connect(function(child)
                if table.find(gunDropNames, child.Name) then
                    notifiedGunDrops[child] = nil
                end
            end)
        end
    end
    workspace.DescendantAdded:Connect(function(desc)
        if desc.Name == "GunDrop" then
            task.defer(updateGunDropESP)
        end
    end)
    workspace.ChildAdded:Connect(function(child)
        if table.find(mapPaths, child.Name) or table.find(gunDropNames, child.Name) then
            task.defer(updateGunDropESP)
        end
    end)
end

workspace.ChildAdded:Connect(function(child)
    if table.find(mapPaths, child.Name) then
        task.wait(1)
        updateGunDropESP()
    end
end)

monitorGunDropSpawns()

-- Min distance murderer must be from gun before we teleport (studs)
local gunGrabMurdererMinDistance = 20
-- Max time to wait for murderer to move away (seconds)
local gunGrabWaitTimeout = 12

local function GrabNearestGun()
    local activeGunDrops = getAllGunDrops()

    if #activeGunDrops == 0 then
        WindUI:Notify({
            Title = "Gun System",
            Content = "No guns available on the map",
            Icon = "x-circle",
            Duration = 3,
        })
        return false
    end

    local character = LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end

    local nearestGun = nil
    local minDistance = math.huge
    for _, drop in ipairs(activeGunDrops) do
        local pos = drop:IsA("BasePart") and drop.Position or drop:GetPivot().Position
        local distance = (hrp.Position - pos).Magnitude
        if distance < minDistance then
            nearestGun = drop
            minDistance = distance
        end
    end

    if not nearestGun then return false end

    local gunPos
    if nearestGun:IsA("BasePart") then
        gunPos = nearestGun.Position
    else
        local ok, p = pcall(function() return nearestGun:GetPivot().Position end)
        gunPos = (ok and p) or (nearestGun.PrimaryPart and nearestGun.PrimaryPart.Position)
    end
    if not gunPos then return false end
    local initialCFrame = hrp.CFrame

    -- Wait until murderer is far enough from the gun (or timeout)
    local murderer = findMurdererPlayer()
    local startWait = tick()
    while murderer and murderer.Character do
        local mRoot = murderer.Character:FindFirstChild("HumanoidRootPart")
        if mRoot then
            local dist = (mRoot.Position - gunPos).Magnitude
            if dist >= gunGrabMurdererMinDistance then break end
        end
        if tick() - startWait > gunGrabWaitTimeout then break end
        task.wait(0.2)
    end

    -- Teleport to gun (at gun position so ProximityPrompt can fire)
    hrp.CFrame = CFrame.new(gunPos)
    task.wait(0.25)

    local prompt = nearestGun:FindFirstChildOfClass("ProximityPrompt")
    if not prompt then
        for _, d in ipairs(nearestGun:GetDescendants()) do
            if d:IsA("ProximityPrompt") then prompt = d; break end
        end
    end
    if prompt then
        pcall(function()
            fireproximityprompt(prompt)
        end)
        task.wait(0.15)
    end

    -- Teleport back to initial position
    hrp.CFrame = initialCFrame

    if prompt then
        WindUI:Notify({
            Title = "Gun System",
            Content = "Grabbed gun and returned to position",
            Icon = "check-circle",
            Duration = 3,
        })
        return true
    end

    return false
end

-- =========================
-- PING-AWARE AIMBOT (ROLE-AWARE)
-- =========================

local Aimbot = {}

local aimbotRequiredDistance = 2000
local aimbotTyping = false
local aimbotRunning = false
local aimbotAnimation = nil
local aimbotConnections = {}

-- Ping in ms; tries multiple sources so prediction actually updates (GetNetworkPing can be stale)
local function getPingMs()
    -- 1) GetNetworkPing() returns seconds; convert to ms
    local ok, ping = pcall(function()
        return LocalPlayer:GetNetworkPing()
    end)
    if ok and type(ping) == "number" and ping > 0 then
        local ms = math.floor(ping * 1000 + 0.5)
        if ms > 0 then return ms end
    end
    -- 2) Fallback: Stats PerformanceStats (updates more frequently on some clients)
    local stats = game:GetService("Stats")
    local perf = stats:FindFirstChild("PerformanceStats")
    if perf then
        local net = perf:FindFirstChild("Network")
        if net and net:FindFirstChild("Ping") then
            local pingStat = net.Ping
            if type(pingStat) == "number" then return math.floor(pingStat + 0.5) end
            if pingStat and pingStat.GetValue and type(pingStat.GetValue) == "function" then
                local okV, v = pcall(function() return pingStat:GetValue() end)
                if okV and type(v) == "number" and v > 0 then return math.floor(v + 0.5) end
            end
        end
    end
    return 0
end

-- Ping-based prediction: formula so it updates with ping (no fixed table)
Aimbot.Settings = {
    Enabled = false,
    TeamCheck = false,
    AliveCheck = true,
    WallCheck = false,
    AutoPrediction = true,
    ManualPrediction = 0.15, -- when AutoPrediction off
    PredictionScale = 0.55, -- prediction = (ping_sec) * scale; tune if needed
    Sensitivity = 0,
    ThirdPerson = false,
    ThirdPersonSensitivity = 3,
    TriggerKey = "E",
    Toggle = true,
    LockPart = "HumanoidRootPart",
}

-- Prediction time in seconds; scales with current ping so camlock updates when ping changes
local function getPredictionTime()
    if Aimbot.Settings.AutoPrediction then
        local ms = getPingMs()
        local pingSec = ms / 1000
        local scale = Aimbot.Settings.PredictionScale or 0.55
        -- prediction = one-way delay * scale (smooth, updates every time ping changes)
        local t = pingSec * scale
        return math.clamp(t, 0.05, 0.35)
    end
    return Aimbot.Settings.ManualPrediction
end

Aimbot.FOVSettings = {
    Enabled = false, -- Drawing circle is optional; disabled by default for compatibility
    Visible = true,
    Amount = 90,
    Color = Color3.fromRGB(255, 182, 193), -- Light Pink
    LockedColor = Color3.fromRGB(255, 20, 147), -- Deep Pink
    Transparency = 0.5,
    Sides = 60,
    Thickness = 1,
    Filled = false,
}

local hasDrawing = (typeof(Drawing) == "table" or typeof(Drawing) == "userdata") and Drawing.new ~= nil
if hasDrawing then
    Aimbot.FOVCircle = Drawing.new("Circle")
else
    Aimbot.FOVCircle = nil
    Aimbot.FOVSettings.Enabled = false
end

local function aimbotCancelLock()
    Aimbot.Locked = nil
    if aimbotAnimation then
        aimbotAnimation:Cancel()
        aimbotAnimation = nil
    end
    if Aimbot.FOVCircle then
        Aimbot.FOVCircle.Color = Aimbot.FOVSettings.Color
    end
end

local function getMyRole()
    local data = roles[LocalPlayer.Name]
    return data and data.Role or "Innocent"
end

local function isValidAimbotTarget(player)
    if player == LocalPlayer then
        return false
    end

    if not player.Character then
        return false
    end

    local hum = player.Character:FindFirstChildOfClass("Humanoid")
    local lockPart = player.Character:FindFirstChild(Aimbot.Settings.LockPart)
    if not hum or not lockPart then
        return false
    end

    if Aimbot.Settings.AliveCheck and hum.Health <= 0 then
        return false
    end

    if Aimbot.Settings.TeamCheck and player.Team == LocalPlayer.Team then
        return false
    end

    if Aimbot.Settings.WallCheck then
        local parts = Camera:GetPartsObscuringTarget({lockPart.Position}, player.Character:GetDescendants())
        if #parts > 0 then
            return false
        end
    end

    -- Role-aware filtering
    local myRole = getMyRole()

    if myRole == "Sheriff" or myRole == "Hero" then
        -- Sheriff/Hero: prefer murderer only
        return player.Name == Murder
    elseif myRole == "Murderer" then
        -- Murderer: target sheriff / hero / innocents, never self
        return player.Name ~= LocalPlayer.Name
    else
        -- Innocent: generic aimbot (anyone except self)
        return player.Name ~= LocalPlayer.Name
    end
end

local function aimbotGetClosestPlayer()
    -- If already locked, only check if target is still valid (don't switch targets)
    if Aimbot.Locked then
        -- Check if locked target is still valid
        if Aimbot.Locked.Character and Aimbot.Locked.Character:FindFirstChild(Aimbot.Settings.LockPart) then
            local hum = Aimbot.Locked.Character:FindFirstChildOfClass("Humanoid")
            -- Only cancel lock if target is dead, invalid, or left game
            if not hum or hum.Health <= 0 or not isValidAimbotTarget(Aimbot.Locked) then
                aimbotCancelLock()
            end
            -- Stay locked on this target regardless of FOV distance
            return
        else
            -- Target's character is invalid, cancel lock
            aimbotCancelLock()
            return
        end
    end
    
    -- No lock yet, find closest valid target
    if not Aimbot.Locked then
        aimbotRequiredDistance = (Aimbot.FOVSettings.Enabled and Aimbot.FOVSettings.Amount or 2000)

        for _, player in ipairs(Players:GetPlayers()) do
            if isValidAimbotTarget(player) then
                local char = player.Character
                local lockPart = char and char[Aimbot.Settings.LockPart]
                if lockPart then
                    local vector, onScreen = Camera:WorldToViewportPoint(lockPart.Position)
                    if onScreen then
                        local mousePos = UserInputService:GetMouseLocation()
                        local distance = (Vector2.new(mousePos.X, mousePos.Y) - Vector2.new(vector.X, vector.Y)).Magnitude
                        if distance < aimbotRequiredDistance then
                            aimbotRequiredDistance = distance
                            Aimbot.Locked = player
                        end
                    end
                end
            end
        end
    end
end

local function aimbotLoad()
    -- Typing state
    aimbotConnections.typingStart = UserInputService.TextBoxFocused:Connect(function()
        aimbotTyping = true
    end)
    aimbotConnections.typingEnd = UserInputService.TextBoxFocusReleased:Connect(function()
        aimbotTyping = false
    end)

    -- Render loop
    aimbotConnections.render = RunService.RenderStepped:Connect(function()
        if Aimbot.FOVCircle and Aimbot.FOVSettings.Enabled and Aimbot.Settings.Enabled then
            local circle = Aimbot.FOVCircle
            local cfg = Aimbot.FOVSettings
            circle.Radius = cfg.Amount
            circle.Thickness = cfg.Thickness
            circle.Filled = cfg.Filled
            circle.NumSides = cfg.Sides
            circle.Color = cfg.Color
            circle.Transparency = cfg.Transparency
            circle.Visible = cfg.Visible
            local mousePos = UserInputService:GetMouseLocation()
            circle.Position = Vector2.new(mousePos.X, mousePos.Y)
        elseif Aimbot.FOVCircle then
            Aimbot.FOVCircle.Visible = false
        end

        if aimbotRunning and Aimbot.Settings.Enabled then
            -- Only search for new target if not already locked
            if not Aimbot.Locked then
                aimbotGetClosestPlayer()
            else
                -- Already locked, just validate target is still alive/valid
                aimbotGetClosestPlayer()
            end

            if Aimbot.Locked and Aimbot.Locked.Character and Aimbot.Locked.Character:FindFirstChild(Aimbot.Settings.LockPart) then
                local targetPart = Aimbot.Locked.Character[Aimbot.Settings.LockPart]
                local predictionTime = getPredictionTime()
                local predictedPos = targetPart.Position + targetPart.Velocity * predictionTime

                if Aimbot.Settings.ThirdPerson then
                    Aimbot.Settings.ThirdPersonSensitivity = math.clamp(Aimbot.Settings.ThirdPersonSensitivity, 0.1, 5)
                    local vector = Camera:WorldToViewportPoint(predictedPos)
                    local mousePos = UserInputService:GetMouseLocation()
                    local dx = (vector.X - mousePos.X) * Aimbot.Settings.ThirdPersonSensitivity
                    local dy = (vector.Y - mousePos.Y) * Aimbot.Settings.ThirdPersonSensitivity

                    local ok = pcall(function()
                        (mousemoverel or Input and Input.MouseMove)(dx, dy)
                    end)
                    if not ok then
                        -- ignore if executor does not support mouse movement
                    end
                else
                    local newCFrame = CFrame.new(Camera.CFrame.Position, predictedPos)
                    if Aimbot.Settings.Sensitivity > 0 then
                        aimbotAnimation = TweenService:Create(
                            Camera,
                            TweenInfo.new(Aimbot.Settings.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
                            { CFrame = newCFrame }
                        )
                        aimbotAnimation:Play()
                    else
                        Camera.CFrame = newCFrame
                    end
                end

                if Aimbot.FOVCircle then
                    Aimbot.FOVCircle.Color = Aimbot.FOVSettings.LockedColor
                end
            end
        end
    end)

    -- Input handlers (E keybind by default)
    aimbotConnections.inputBegin = UserInputService.InputBegan:Connect(function(input, gp)
        if gp or aimbotTyping or not Aimbot.Settings.Enabled then
            return
        end

        -- Only respect keybind when requested (PC users)
        if input.KeyCode == Enum.KeyCode[Aimbot.Settings.TriggerKey] then
            if Aimbot.Settings.Toggle then
                aimbotRunning = not aimbotRunning
                if not aimbotRunning then
                    -- Unlock: clear the locked target
                    aimbotCancelLock()
                else
                    -- Lock: clear previous lock to allow new target selection
                    aimbotCancelLock()
                end
            else
                aimbotRunning = true
                -- Clear previous lock when starting hold mode
                aimbotCancelLock()
            end
            -- Update aim button appearance if it exists
            if aimButtonFrame and aimButtonFrame.Parent then
                if aimbotRunning then
                    aimButtonFrame.BackgroundColor3 = Color3.fromRGB(255, 105, 180) -- Hot Pink when active
                    aimButtonFrame.Text = "Locked"
                else
                    aimButtonFrame.BackgroundColor3 = Color3.fromRGB(255, 20, 147) -- Deep Pink when inactive
                    aimButtonFrame.Text = "Aim"
                end
            end
        end
    end)

    aimbotConnections.inputEnd = UserInputService.InputEnded:Connect(function(input, gp)
        if gp or aimbotTyping then
            return
        end
        if not Aimbot.Settings.Toggle and input.KeyCode == Enum.KeyCode[Aimbot.Settings.TriggerKey] then
            aimbotRunning = false
            aimbotCancelLock()
            -- Update aim button appearance if it exists
            if aimButtonFrame and aimButtonFrame.Parent then
                aimButtonFrame.BackgroundColor3 = Color3.fromRGB(255, 20, 147) -- Deep Pink when inactive
                aimButtonFrame.Text = "Aim"
            end
        end
    end)
end

Aimbot.Functions = {}

function Aimbot.Functions:SetRunning(state)
    aimbotRunning = not not state
    
    if not aimbotRunning then
        -- Unlock: clear the locked target
        aimbotCancelLock()
    else
        -- Starting fresh: clear any previous lock to allow new target selection
        aimbotCancelLock()
    end
    
    -- Update aim button appearance if it exists
    if aimButtonFrame and aimButtonFrame.Parent then
        if aimbotRunning then
            aimButtonFrame.BackgroundColor3 = Color3.fromRGB(255, 105, 180) -- Hot Pink when active
            aimButtonFrame.Text = "Locked"
        else
            aimButtonFrame.BackgroundColor3 = Color3.fromRGB(255, 20, 147) -- Deep Pink when inactive
            aimButtonFrame.Text = "Aim"
        end
    end
end

function Aimbot.Functions:Exit()
    for _, conn in pairs(aimbotConnections) do
        pcall(function()
            conn:Disconnect()
        end)
    end
    aimbotConnections = {}
    if Aimbot.FOVCircle and Aimbot.FOVCircle.Remove then
        Aimbot.FOVCircle:Remove()
    end
    Aimbot.Locked = nil
end

aimbotLoad()

-- */  Utility Functions  /* --

-- Get players for dropdown
local function GetPlayers()
    local players = {}
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        if player ~= game:GetService("Players").LocalPlayer then
            table.insert(players, player.Name)
        end
    end
    return players
end

-- */  Variables  /* --
local selectedPlayer = nil
local flingMurdererEnabled = false
local hasFlingedThisRound = false
local lastCoinCount = 0
local noCoinsDetected = false

local fastestAutofarmEnabled = false
local fastestAutofarmThread = nil
local fastestAutofarmSpeed = 25
local fastestAutofarmRadius = 200 -- Octree search radius for nearest coin
local collectedCoins = 0
-- Octree for nearest-coin lookup (Zynic-style, no HumanoidRootPart movement)
local OctreeModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sleitnick/rbxts-octo-tree/main/src/init.lua", true))()
local webhookUrl = ""
local webhookEnabled = false
local reportingInterval = "Disabled"
local reportingThread = nil
local startTime = 0
local roundStartTime = 0
local currentRound = 0

-- Noclip helper (used by Coin Detection reporting; autofarm runs above-ground only)
local Clip = true
local NoclippingConnection = nil

local function enableNoclip()
    if not Clip then
        return
    end
    Clip = false
    if NoclippingConnection then
        NoclippingConnection:Disconnect()
        NoclippingConnection = nil
    end
    NoclippingConnection = RunService.Stepped:Connect(function()
        if Clip then
            return
        end
        local char = LocalPlayer.Character
        if not char then
            return
        end
        for _, child in ipairs(char:GetDescendants()) do
            if child:IsA("BasePart") and child.CanCollide then
                child.CanCollide = false
            end
        end
    end)
end

local function disableNoclip()
    Clip = true
    if NoclippingConnection then
        NoclippingConnection:Disconnect()
        NoclippingConnection = nil
    end
end

-- */  Autofarm Tab  /* --
do
    local AutofarmMainSection = Tabs.FastestAutofarmTab:Section({ Title = "Coin Autofarm", Desc = "Collect coins automatically", Box = true, BoxBorder = true, Opened = true })
    AutofarmMainSection:Toggle({
    Title = "Enable Fastest Autofarm",
    Default = false,
    Callback = function(state)
        fastestAutofarmEnabled = state
        if state then
            collectedCoins = 0
            startTime = tick()
            if fastestAutofarmThread then task.cancel(fastestAutofarmThread) end
            if reportingThread then task.cancel(reportingThread) end

            reportingThread = task.spawn(function()
                local HttpService = game:GetService("HttpService")
                local lastReportTime = tick()

                while fastestAutofarmEnabled do
                    task.wait(1) 
                    if reportingInterval ~= "Disabled" then
                        local intervalMinutes = tonumber(reportingInterval)
                        if intervalMinutes and (tick() - lastReportTime) >= (intervalMinutes * 60) then
                            lastReportTime = tick()

                            local elapsedTimeSeconds = tick() - startTime
                            local elapsedTimeHours = elapsedTimeSeconds / 3600
                            local coinsPerHour = 0
                            if elapsedTimeHours > 0 then
                                coinsPerHour = math.floor(collectedCoins / elapsedTimeHours)
                            end

                            local summaryDesc = string.format("Total coins: %d | Est. CPH: %d", collectedCoins, coinsPerHour)
                            WindUI:Notify({ Title = "Autofarm Session Report", Desc = summaryDesc, Duration = 7 })

                            if webhookEnabled and webhookUrl ~= "" and webhookUrl:match("discord.com/api/webhooks") then
                                pcall(function()
                                    local data = {
                                        username = "Trav Hub Autofarm",
                                        embeds = {{
                                            title = "Autofarm Session Report",
                                            description = string.format("**Total Coins Collected:** %d\n**Coins Per Hour (Est.):** %d", collectedCoins, coinsPerHour),
                                            color = 16762880, -- Gold
                                            footer = { text = "Trav Hub | MM2" }
                                        }}
                                    }
                                    request({
                                        Url = webhookUrl,
                                        Method = "POST",
                                        Headers = { ["Content-Type"] = "application/json" },
                                        Body = HttpService:JSONEncode(data)
                                    })
                                end)
                            end
                        end
                    end
                end
            end)

            fastestAutofarmThread = task.spawn(function()
                local LP = game.Players.LocalPlayer
                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                local octree = OctreeModule.new()

                local function GetMap()
                    for _, obj in ipairs(workspace:GetChildren()) do
                        if obj:GetAttribute("MapID") and obj:FindFirstChild("CoinContainer") then
                            return obj
                        end
                    end
                    return nil
                end

                -- Populate octree with uncollected coins (existing detection: CoinVisual + not Collected)
                local function populateOctree()
                    octree:ClearAllNodes()
                    local map = GetMap()
                    if not map or not map:FindFirstChild("CoinContainer") then return end
                    for _, coin in ipairs(map.CoinContainer:GetChildren()) do
                        local v = coin:FindFirstChild("CoinVisual")
                        if v and not v:GetAttribute("Collected") then
                            octree:CreateNode(coin.Position, coin)
                        end
                    end
                end

                -- Nearest coin via Octree (reuses autofarm coin detection)
                local function getNearest(charPosition)
                    if not charPosition then return nil end
                    populateOctree()
                    local nearest = octree:GetNearest(charPosition, fastestAutofarmRadius, 1)[1]
                    return nearest and nearest.Object or nil
                end

                -- Prefer coin farthest from murderer among nearby candidates (move away from murderer to next coin)
                local function getNearestCoinAwayFromMurderer(charPosition)
                    if not charPosition then return nil end
                    populateOctree()
                    local candidates = octree:GetNearest(charPosition, fastestAutofarmRadius, 10)
                    if not candidates or #candidates == 0 then return nil end
                    local murderer = getMurderer()
                    local murdererPos = nil
                    if murderer and murderer.Character then
                        local hrp = murderer.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then murdererPos = hrp.Position end
                    end
                    if not murdererPos then
                        return candidates[1] and candidates[1].Object or nil
                    end
                    local best = nil
                    local bestDistToMurderer = -1
                    for _, node in ipairs(candidates) do
                        local coin = node and node.Object
                        if coin and coin.Position then
                            local d = (coin.Position - murdererPos).Magnitude
                            if d > bestDistToMurderer then
                                bestDistToMurderer = d
                                best = coin
                            end
                        end
                    end
                    return best or (candidates[1] and candidates[1].Object or nil)
                end

                -- Move to position using Character:PivotTo + Lerp (no HumanoidRootPart to avoid character bug)
                local function moveToPositionSlowly(character, targetPosition, duration)
                    if not character or not targetPosition then return end
                    local startPosition = character:GetPivot().Position
                    local moveStartTime = tick()
                    while fastestAutofarmEnabled do
                        local elapsed = tick() - moveStartTime
                        local alpha = math.min(elapsed / duration, 1)
                        local lerpedPos = startPosition:Lerp(targetPosition, alpha)
                        character:PivotTo(CFrame.new(lerpedPos))
                        if alpha >= 1 then
                            task.wait(0.2)
                            break
                        end
                        task.wait()
                    end
                end

                -- Wait for character to spawn
                local function waitForCharacter()
                    while fastestAutofarmEnabled do
                        local Char = LP.Character
                        if Char and LP:GetAttribute("Alive") then
                            local HRP = Char:FindFirstChild("HumanoidRootPart")
                            local Humanoid = Char:FindFirstChild("Humanoid")
                            if HRP and Humanoid then
                                return Char, HRP, Humanoid
                            end
                        end
                        task.wait(0.5)
                    end
                    return nil, nil, nil
                end

                -- Round detection
                local RoundStart = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("RoundStart")
                RoundStart.OnClientEvent:Connect(function()
                    if fastestAutofarmEnabled then
                        currentRound = currentRound + 1
                        roundStartTime = tick()
                        WindUI:Notify({ Title = "Round " .. currentRound, Desc = "New round started - Autofarm continuing...", Duration = 3 })
                    end
                end)

                -- Main autofarm loop with infinite protection
                while fastestAutofarmEnabled do
                    local Char, HRP, Humanoid = waitForCharacter()
                    if not Char then break end

                    -- Wait for map to load
                    local map = GetMap()
                    while fastestAutofarmEnabled and not map do
                        task.wait(1)
                        map = GetMap()
                    end
                    if not fastestAutofarmEnabled then break end

                    -- Coin collection loop (murderer-aware nearest + PivotTo movement)
                    while fastestAutofarmEnabled do
                        -- Check if character is still valid
                        if not (Char and Char.Parent and LP:GetAttribute("Alive")) then
                            break
                        end
                        local Humanoid = Char:FindFirstChild("Humanoid")
                        if not Humanoid then break end

                        local charPos = Char:GetPivot().Position
                        local target = getNearestCoinAwayFromMurderer(charPos)
                        if target then
                            local targetPos = target.Position
                            local distance = (charPos - targetPos).Magnitude
                            local duration = math.max(0.5, distance / fastestAutofarmSpeed)
                            local success, err = pcall(function()
                                moveToPositionSlowly(Char, targetPos, duration)
                            end)
                            if not success then
                                WindUI:Notify({ Title = "Error", Desc = "Move failed, retrying...", Duration = 2 })
                                task.wait(1)
                                continue
                            end

                            -- Wait for coin to be collected
                            local v = target:FindFirstChild("CoinVisual")
                            local waitTime = 0
                            while fastestAutofarmEnabled and v and not v:GetAttribute("Collected") and v.Parent and waitTime < 10 do
                                if not LP:GetAttribute("Alive") then break end
                                local n_target = getNearestCoinAwayFromMurderer(Char:GetPivot().Position)
                                if n_target and n_target ~= target then break end
                                task.wait(0.1)
                                waitTime = waitTime + 0.1
                            end

                            collectedCoins = collectedCoins + 1
                            WindUI:Notify({ Title = "Coin Collected!", Desc = "Total Coins: " .. collectedCoins, Duration = 2 })
                        else
                            task.wait(2)
                        end

                        -- Safety check: if no coins for too long, restart character
                        if not target and (tick() - roundStartTime) > 30 then
                            WindUI:Notify({ Title = "Safety Restart", Desc = "No coins found for 30s, restarting...", Duration = 3 })
                            if LP.Character and LP.Character:FindFirstChild("Humanoid") then
                                LP.Character.Humanoid.Health = 0
                            end
                            task.wait(3)
                            break
                        end
                    end
                end
            end)
            WindUI:Notify({ Title = "Autofarm", Desc = "Autofarm activated!", Icon = "check-circle", Duration = 3 })
        else
            if fastestAutofarmThread then task.cancel(fastestAutofarmThread) end
            if reportingThread then task.cancel(reportingThread) end
            fastestAutofarmThread, reportingThread = nil, nil

            WindUI:Notify({ Title = "Autofarm", Desc = "Autofarm deactivated!", Icon = "x-circle", Duration = 3 })
        end
    end
})

    Tabs.FastestAutofarmTab:Space()

    local SpeedSection = Tabs.FastestAutofarmTab:Section({ Title = "Speed Control", TextSize = 14 })
    Tabs.FastestAutofarmTab:Slider({
    Title = "Autofarm Speed",
    Value = {
        Min = 1,
        Max = 30,
        Default = 25,
    },
    Callback = function(val)
        fastestAutofarmSpeed = val
        WindUI:Notify({ Title = "Speed", Desc = "Speed set to: " .. val, Duration = 2 })
    end
})
end

-- */  Anti AFK Tab  /* --
do
    local AntiAFKSection = Tabs.AntiAFKTab:Section({ Title = "Anti AFK", Box = true, BoxBorder = true, Opened = true })
    local AntiAFKBtn
    AntiAFKBtn = Tabs.AntiAFKTab:Button({
        Title = "Enable Anti AFK",
        Callback = function()
            AntiAFKBtn:Highlight()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/hassanxzayn-lua/Anti-afk/main/antiafkbyhassanxzyn"))();
            WindUI:Notify({ Title = "AFK", Desc = "Anti-AFK activated!", Duration = 3 })
        end
    })
end

-- =========================
-- COMBAT TAB (AIMBOT + SHERIFF TOOLS)
-- =========================

-- Reuse MM2 role data to locate the murderer quickly
local function findMurdererPlayer()
    -- Ensure roles table is fresh
    pcall(UpdateRoles)

    if Murder then
        return Players:FindFirstChild(Murder)
    end

    -- Fallback: pull from GetPlayerData directly if needed
    local ok, result = pcall(function()
        return ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
    end)
    if ok and result then
        for name, data in pairs(result) do
            if data.Role == "Murderer" then
                return Players:FindFirstChild(name)
            end
        end
    end

    return nil
end

-- Sheriff auto-shoot (ported from legacy script, uses current role data)
-- MM2 now uses "Shoot" RemoteEvent with FireServer(cframe1, cframe2) instead of CreateBeam RemoteFunction.
local shotType = "Default"
local shotButtonActive = false
local shotButtonFrame = nil
local shotButtonSize = 50
local silentAimEnabled = false -- When on, any gun shot uses ping-predicted position (no shot button needed)

-- Aim button variables
local aimButtonActive = false
local aimButtonFrame = nil
local aimButtonSize = 50

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Find the Shoot RemoteEvent (game may store it in ReplicatedStorage or in nil instances).
local function getShootRemote()
    local function findIn(parent)
        if not parent then return nil end
        local found = parent:FindFirstChild("Shoot")
        if found and found:IsA("RemoteEvent") then return found end
        found = parent:FindFirstChild("Shoot", true)
        return (found and found:IsA("RemoteEvent")) and found or nil
    end
    local r = findIn(ReplicatedStorage)
    if r then return r end
    if ReplicatedStorage:FindFirstChild("Remotes") then
        r = findIn(ReplicatedStorage.Remotes)
        if r then return r end
    end
    -- getnilinstances (executor-specific): if Shoot is parented to nil
    if getgenv and getgenv().getNil then
        r = getgenv().getNil("Shoot", "RemoteEvent")
        if r then return r end
    end
    if getgenv and getgenv().getnilinstances then
        for _, inst in ipairs(getgenv().getnilinstances()) do
            if inst.Name == "Shoot" and inst:IsA("RemoteEvent") then return inst end
        end
    end
    for _, desc in ipairs(ReplicatedStorage:GetDescendants()) do
        if desc.Name == "Shoot" and desc:IsA("RemoteEvent") then return desc end
    end
    -- Gun tool may hold the remote (e.g. in GunClient or as sibling).
    local gun = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Gun")
    if gun then
        local shoot = gun:FindFirstChild("Shoot")
        if shoot and shoot:IsA("RemoteEvent") then return shoot end
        shoot = gun:FindFirstChild("Shoot", true)
        if shoot and shoot:IsA("RemoteEvent") then return shoot end
    end
    return nil
end

-- Returns predicted world position for silent aim, or nil if no valid target.
local function getPredictedShotPosition()
    if not silentAimEnabled then return nil end
    local murderer = findMurdererPlayer()
    if not murderer or not murderer.Character then return nil end
    local mChar = murderer.Character
    local hum = mChar:FindFirstChildOfClass("Humanoid")
    local targetPart = mChar:FindFirstChild("HumanoidRootPart")
    if not hum or hum.Health <= 0 or not targetPart then return nil end
    local predictionTime = getPredictionTime()
    return targetPart.Position + targetPart.Velocity * predictionTime
end

-- Hook Shoot RemoteEvent: FireServer(cframe1, cframe2) -> replace second CFrame with predicted target when silent aim on.
local function hookShootRemote(remote)
    if not remote or not remote:IsA("RemoteEvent") or remote._shootSilentAimHooked then return end
    local realFire = remote.FireServer
    remote.FireServer = function(self, ...)
        local args = {...}
        if silentAimEnabled and #args >= 2 then
            local pred = getPredictedShotPosition()
            if pred then
                -- Second arg is target CFrame (position); replace with predicted position.
                if typeof(args[2]) == "CFrame" then
                    args[2] = CFrame.new(pred)
                end
            end
        end
        return realFire(self, unpack(args))
    end
    remote._shootSilentAimHooked = true
end

-- Resolve Shoot remote once (or retry when shooting) and hook it.
local cachedShootRemote = nil
local function ensureShootHook()
    if cachedShootRemote and cachedShootRemote.Parent then
        hookShootRemote(cachedShootRemote)
        return cachedShootRemote
    end
    cachedShootRemote = getShootRemote()
    if cachedShootRemote then hookShootRemote(cachedShootRemote) end
    return cachedShootRemote
end

-- Hook when remotes might appear (e.g. after game load).
task.defer(function()
    for _ = 1, 30 do
        ensureShootHook()
        if cachedShootRemote then break end
        task.wait(0.5)
    end
end)
LocalPlayer.CharacterAdded:Connect(function()
    cachedShootRemote = nil
    task.defer(ensureShootHook)
end)

local function ShootMurderer()
    local character = LocalPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then
        return
    end

    local murderer = findMurdererPlayer()
    if not murderer then
        return
    end

    local mChar = murderer.Character
    local mHum = mChar and mChar:FindFirstChildOfClass("Humanoid")
    if not mChar or not mHum or mHum.Health <= 0 then
        return
    end

    local gun = character:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Gun")
    if (shotType == "Default") and not gun then
        return
    end

    if gun and not character:FindFirstChild("Gun") then
        gun.Parent = character
    end

    if shotType == "Teleport" then
        local targetRoot = mChar:FindFirstChild("HumanoidRootPart")
        local localRoot = character:FindFirstChild("HumanoidRootPart")
        if targetRoot and localRoot then
            localRoot.CFrame = targetRoot.CFrame * CFrame.new(0, 0, -4)
        end
    end

    -- New shoot system: Shoot RemoteEvent with FireServer(cframe1, cframe2)
    local targetPart = mChar:FindFirstChild("HumanoidRootPart")
    if not targetPart then return end
    local hitPos = targetPart.Position
    if silentAimEnabled then
        local predictionTime = getPredictionTime()
        hitPos = targetPart.Position + targetPart.Velocity * predictionTime
    end
    local shootRemote = ensureShootHook()
    if shootRemote then
        local cam = workspace.CurrentCamera
        local origin = (cam and cam.CFrame) or (character:FindFirstChild("HumanoidRootPart") and character.HumanoidRootPart.CFrame) or CFrame.new()
        shootRemote:FireServer(origin, CFrame.new(hitPos))
        return
    end

    -- Fallback: old CreateBeam (in case some builds still use it)
    gun = character:FindFirstChild("Gun")
    if gun and gun:FindFirstChild("KnifeLocal") then
        local createBeam = gun.KnifeLocal:FindFirstChild("CreateBeam")
        if createBeam then
            local rf = createBeam:FindFirstChild("RemoteFunction") or (createBeam:IsA("RemoteFunction") and createBeam)
            if rf and rf.InvokeServer then
                rf:InvokeServer(1, hitPos, "AH2")
            end
        end
    end
end

local function RemoveShotButton()
    if shotButtonFrame then
        shotButtonFrame:Destroy()
        shotButtonFrame = nil
        shotButtonActive = false
    end
end

local function RemoveAimButton()
    if aimButtonFrame then
        aimButtonFrame:Destroy()
        aimButtonFrame = nil
        aimButtonActive = false
    end
end

local function CreateAimButton()
    RemoveAimButton()

    local coreGui = game:GetService("CoreGui")
    local screenGui = coreGui:FindFirstChild("WindUI_AimGui") or Instance.new("ScreenGui")
    screenGui.Name = "WindUI_AimGui"
    screenGui.Parent = coreGui

    local button = Instance.new("TextButton")
    button.Name = "AimLockButton"
    button.Size = UDim2.new(0, aimButtonSize, 0, aimButtonSize)
    -- Position on left side, slightly above center to avoid overlap with shot button
    button.Position = UDim2.new(0, 20, 0.5, -aimButtonSize / 2 - 60)
    button.BackgroundColor3 = Color3.fromRGB(255, 20, 147) -- Deep Pink
    button.Text = "Aim"
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    button.Parent = screenGui

    -- Add corner radius for better look
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button

    -- Visual feedback function
    local function updateButtonAppearance()
        if aimbotRunning then
            button.BackgroundColor3 = Color3.fromRGB(255, 105, 180) -- Hot Pink when active
            button.Text = "Locked"
        else
            button.BackgroundColor3 = Color3.fromRGB(255, 20, 147) -- Deep Pink when inactive
            button.Text = "Aim"
        end
    end

    button.MouseButton1Click:Connect(function()
        -- Toggle aimbot on/off
        local newState = not aimbotRunning
        Aimbot.Functions:SetRunning(newState)
        updateButtonAppearance()
        WindUI:Notify({
            Title = "Aimbot",
            Content = newState and "Aim lock activated - searching for target..." or "Aim lock deactivated",
            Icon = newState and "check-circle" or "x-circle",
            Duration = 2,
        })
    end)

    -- Update button appearance periodically to reflect external state changes
    local updateConnection
    updateConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if aimButtonFrame and aimButtonFrame.Parent then
            updateButtonAppearance()
        else
            if updateConnection then
                updateConnection:Disconnect()
            end
        end
    end)

    aimButtonFrame = button
    aimButtonActive = true
    updateButtonAppearance()
end

local function CreateShotButton()
    RemoveShotButton()

    local coreGui = game:GetService("CoreGui")
    local screenGui = coreGui:FindFirstChild("WindUI_SilentAimGui") or Instance.new("ScreenGui")
    screenGui.Name = "WindUI_SilentAimGui"
    screenGui.Parent = coreGui

    local button = Instance.new("TextButton")
    button.Name = "SilentAimShotButton"
    button.Size = UDim2.new(0, shotButtonSize, 0, shotButtonSize)
    button.Position = UDim2.new(1, -shotButtonSize - 20, 0.5, -shotButtonSize / 2)
    button.BackgroundColor3 = Color3.fromRGB(255, 20, 147) -- Deep Pink
    button.Text = "Shoot!"
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.Parent = screenGui

    button.MouseButton1Click:Connect(function()
        ShootMurderer()
        WindUI:Notify({
            Title = "Sheriff System",
            Content = "Shot button activated",
            Icon = "check-circle",
            Duration = 3,
        })
    end)

    shotButtonFrame = button
    shotButtonActive = true
end

do
    local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

    local AimbotSection = Tabs.CombatTab:Section({
        Title = "Aimbot",
        Desc = "Enabled camlock for PC and mobile. Keybind: E (PC). Mobile: use Aim Button below.",
        Box = true,
        BoxBorder = true,
        Opened = true,
    })

    AimbotSection:Toggle({
        Title = "Enable Camlock (PC & mobile)",
        Default = false,
        Callback = function(state)
            Aimbot.Settings.Enabled = state
            if not state then
                Aimbot.Functions:SetRunning(false)
            end
        end,
    })

    AimbotSection:Toggle({
        Title = "Team Check",
        Default = false,
        Callback = function(state)
            Aimbot.Settings.TeamCheck = state
        end,
    })

    AimbotSection:Toggle({
        Title = "Wall Check (heavier)",
        Default = false,
        Callback = function(state)
            Aimbot.Settings.WallCheck = state
        end,
    })

    AimbotSection:Toggle({
        Title = "Auto Prediction (ping-based)",
        Default = true,
        Callback = function(state)
            Aimbot.Settings.AutoPrediction = state
        end,
    })

    AimbotSection:Slider({
        Title = "Prediction Scale",
        Step = 0.01,
        Value = { Min = 0.3, Max = 1.0, Default = 0.55 },
        Callback = function(val)
            Aimbot.Settings.PredictionScale = val
        end,
    })

    AimbotSection:Toggle({
        Title = "Third-person Mode",
        Default = false,
        Callback = function(state)
            Aimbot.Settings.ThirdPerson = state
        end,
    })

    AimbotSection:Slider({
        Title = "Aimbot FOV",
        Step = 1,
        Value = {
            Min = 20,
            Max = 180,
            Default = 90,
        },
        Callback = function(val)
            Aimbot.FOVSettings.Amount = val
        end,
    })

    Tabs.CombatTab:Space()

    local AimSection = Tabs.CombatTab:Section({
        Title = "Aim Controls",
        Desc = "PC: E to toggle camlock. Mobile: use Aim Button to lock.",
        Box = true,
        BoxBorder = true,
        Opened = true,
    })

    AimSection:Toggle({
        Title = "Show Aim Button (In-Game)",
        Desc = "Display a separate aim button on screen for easy access",
        Default = false,
        Callback = function(state)
            if state then
                CreateAimButton()
            else
                RemoveAimButton()
            end
        end,
    })

    AimSection:Slider({
        Title = "Aim Button Size",
        Step = 1,
        Value = {
            Min = 24,
            Max = 100,
            Default = 50,
        },
        Callback = function(size)
            aimButtonSize = size
            if aimButtonActive and aimButtonFrame then
                -- Recreate to apply new size cleanly
                local wasActive = aimButtonActive
                RemoveAimButton()
                if wasActive then
                    CreateAimButton()
                end
            end
        end,
    })

    Tabs.CombatTab:Space()

    local SheriffSection = Tabs.CombatTab:Section({
        Title = "Sheriff Tools",
        Desc = "Auto-aim and auto-shoot at murderer.",
        Box = true,
        BoxBorder = true,
        Opened = true,
    })

    SheriffSection:Dropdown({
        Title = "Shot Type",
        Values = {"Default", "Teleport"},
        Value = "Default",
        Callback = function(selectedType)
            shotType = selectedType
            WindUI:Notify({
                Title = "Sheriff System",
                Content = "Shot Type: " .. selectedType,
                Icon = "check-circle",
                Duration = 3,
            })
        end,
    })

    SheriffSection:Toggle({
        Title = "Silent Aim (ping prediction)",
        Desc = "Mobile + desktop: with gun equipped, all shots use predicted aim. No shot button needed.",
        Default = false,
        Callback = function(state)
            silentAimEnabled = state
        end,
    })

    SheriffSection:Button({
        Title = "Shoot Murderer Now",
        Callback = function()
            ShootMurderer()
        end,
    })

    SheriffSection:Toggle({
        Title = "Mobile Shot Button",
        Default = false,
        Callback = function(state)
            if state then
                CreateShotButton()
            else
                RemoveShotButton()
            end
        end,
    })

    SheriffSection:Slider({
        Title = "Shot Button Size",
        Step = 1,
        Value = {
            Min = 24,
            Max = 100,
            Default = 50,
        },
        Callback = function(size)
            shotButtonSize = size
            if shotButtonActive and shotButtonFrame then
                -- Recreate to apply new size cleanly
                local wasActive = shotButtonActive
                RemoveShotButton()
                if wasActive then
                    CreateShotButton()
                end
            end
        end,
    })
end

-- */  ESP Tab  /* --
do
    local MainESPSection = Tabs.EspTab:Section({
        Title = "ESP Master Toggle",
        Desc = "Enable or disable ESP rendering",
        Box = true,
        BoxBorder = true,
        Opened = true,
    })

    MainESPSection:Toggle({
        Title = "Enable ESP",
        Default = false,
        Callback = function(state)
            ESPSettings.Enabled = state
        end,
    })

    Tabs.EspTab:Space()

    local VisualSection = Tabs.EspTab:Section({
        Title = "Visual Options",
        Desc = "Box, outline, name and distance",
        Box = true,
        BoxBorder = true,
        Opened = true,
    })

    VisualSection:Toggle({
        Title = "Box ESP",
        Default = false,
        Callback = function(state)
            ESPSettings.BoxESP = state
        end,
    })

    VisualSection:Toggle({
        Title = "Outline ESP",
        Default = false,
        Callback = function(state)
            ESPSettings.OutlineESP = state
        end,
    })

    VisualSection:Toggle({
        Title = "Show Name",
        Default = false,
        Callback = function(state)
            ESPSettings.ShowName = state
        end,
    })

    VisualSection:Toggle({
        Title = "Show Distance",
        Default = false,
        Callback = function(state)
            ESPSettings.ShowDistance = state
        end,
    })

    VisualSection:Toggle({
        Title = "ESP Teammates",
        Default = false,
        Callback = function(state)
            ESPSettings.ESPTeammates = state
        end,
    })

    Tabs.EspTab:Space()

    local RoleSection = Tabs.EspTab:Section({
        Title = "MM2 Role Highlights",
        Desc = "Highlight Murderer, gun holder and innocents",
        Box = true,
        BoxBorder = true,
        Opened = true,
    })

    RoleSection:Toggle({
        Title = "Highlight Murderer",
        Default = false,
        Callback = function(state)
            ESPSettings.HighlightMurderer = state
        end,
    })

    RoleSection:Toggle({
        Title = "Highlight Gun Holder (Sheriff/Hero)",
        Default = false,
        Callback = function(state)
            ESPSettings.HighlightSheriff = state
        end,
    })

    RoleSection:Toggle({
        Title = "Highlight Innocents",
        Default = false,
        Callback = function(state)
            ESPSettings.HighlightInnocent = state
        end,
    })

    Tabs.EspTab:Space()

    local GunSection = Tabs.EspTab:Section({
        Title = "Gun ESP & Utilities",
        Desc = "GunDrop ESP, notifications and auto grab",
        Box = true,
        BoxBorder = true,
        Opened = true,
    })

    GunSection:Toggle({
        Title = "GunDrop Highlight",
        Default = false,
        Callback = function(state)
            ESPSettings.GunDropESP = state
            updateGunDropESP()
        end,
    })

    GunSection:Toggle({
        Title = "Notify on Gun Drop",
        Default = true,
        Callback = function(state)
            ESPSettings.NotifyGunDrop = state
        end,
    })

    GunSection:Toggle({
        Title = "Auto Grab Gun",
        Default = false,
        Callback = function(state)
            ESPSettings.AutoGrabGun = state

            if state then
                coroutine.wrap(function()
                    while ESPSettings.AutoGrabGun do
                        if not GrabNearestGun() then
                            task.wait(2)
                        else
                            task.wait(1)
                        end
                    end
                end)()
            end
        end,
    })

    local GrabNowBtn
    GrabNowBtn = GunSection:Button({
        Title = "Grab Gun Now",
        Callback = function()
            GrabNowBtn:Highlight()
            GrabNearestGun()
        end,
    })
end

-- */  Server Crasher Tab  /* --
do
    local CrasherSection = Tabs.ServerCrasher:Section({ Title = "Server Controls", Box = true, BoxBorder = true, Opened = true })
    local CrashServerBtn
    CrashServerBtn = Tabs.ServerCrasher:Button({
        Title = "Crash Server",
        Callback = function()
            CrashServerBtn:Highlight()
            CrashServer()
        WindUI:Notify({ Title = "Crasher", Desc = "Server Will Be Crashed Soon!", Duration = 3 })
    end
})
end

-- Coin Detection and Auto Reset System
local coinDetectionEnabled = false
local coinDetectionThread = nil
local coinCount = 0
local maxCoinsPerRound = 40

local function resetPlayer()
    local LP = game.Players.LocalPlayer
    if LP.Character and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid.Health = 0
        WindUI:Notify({ Title = "Coin Reset", Desc = "Player reset after collecting 40 coins!", Icon = "refresh-cw", Duration = 5 })
    end
end

local function startCoinDetection()
    if coinDetectionThread then task.cancel(coinDetectionThread) end
    
    coinDetectionThread = task.spawn(function()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local CoinCollected = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("CoinCollected")
        
        -- Connect to the CoinCollected remote
        CoinCollected.OnClientEvent:Connect(function()
            if coinDetectionEnabled then
                coinCount = coinCount + 1
                WindUI:Notify({ Title = "Coin Detected", Desc = "Coins collected this round: " .. coinCount .. "/" .. maxCoinsPerRound, Duration = 2 })
                
                if coinCount >= maxCoinsPerRound then
                    resetPlayer()
                    coinCount = 0
                end
            end
        end)
        
        -- Reset coin count when round starts
        local RoundStart = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("RoundStart")
        RoundStart.OnClientEvent:Connect(function()
            if coinDetectionEnabled then
                coinCount = 0
                WindUI:Notify({ Title = "Round Start", Desc = "Coin counter reset for new round", Duration = 2 })
            end
        end)
    end)
end

-- Add Coin Detection Tab
-- Tabs.CoinDetectionTab = Window:Tab({ Title = gradient("Coin Detection", Color3.fromHex("#FFD700"), Color3.fromHex("#FFA500")), Icon = "coins" }) -- This line is removed as per the edit hint

local reportingInterval = "Disabled"
local reportingThread = nil
local webhookUrl = ""
local webhookEnabled = false
local startTime = 0

-- */  Coin Detection Tab  /* --
do
    local DetectionMainSection = Tabs.CoinDetectionTab:Section({ Title = "Coin Detection", Desc = "Track coins and auto-reset at 40", Box = true, BoxBorder = true, Opened = true })
    DetectionMainSection:Toggle({
    Title = "Enable Coin Detection",
    Default = false,
    Callback = function(state)
        coinDetectionEnabled = state
        if state then
            coinCount = 0
            startTime = tick()
            hasFlingedThisRound = false
            WindUI:Notify({ Title = "Coin Detection", Desc = "Coin detection enabled - Auto reset at 40 coins", Icon = "check-circle", Duration = 3 })
            if reportingThread then task.cancel(reportingThread) end
            reportingThread = task.spawn(function()
                local HttpService = game:GetService("HttpService")
                local lastReportTime = tick()
                while coinDetectionEnabled do
                    task.wait(1)
                    if reportingInterval ~= "Disabled" then
                        local intervalMinutes = tonumber(reportingInterval)
                        if intervalMinutes and (tick() - lastReportTime) >= (intervalMinutes * 60) then
                            lastReportTime = tick()
                            local elapsedTimeSeconds = tick() - startTime
                            local elapsedTimeHours = elapsedTimeSeconds / 3600
                            local coinsPerHour = 0
                            if elapsedTimeHours > 0 then
                                coinsPerHour = math.floor(coinCount / elapsedTimeHours)
                            end
                            local summaryDesc = string.format("Total coins: %d | Est. CPH: %d", coinCount, coinsPerHour)
                            WindUI:Notify({ Title = "Session Report", Desc = summaryDesc, Duration = 7 })
                            if webhookEnabled and webhookUrl ~= "" and webhookUrl:match("discord.com/api/webhooks") then
                                pcall(function()
                                    local data = {
                                        username = "Trav Hub Coin Detection",
                                        embeds = {{
                                            title = "Session Report",
                                            description = string.format("**Total Coins Collected:** %d\n**Coins Per Hour (Est.):** %d", coinCount, coinsPerHour),
                                            color = 16762880, -- Gold
                                            footer = { text = "Trav Hub | MM2" }
                                        }}
                                    }
                                    request({
                                        Url = webhookUrl,
                                        Method = "POST",
                                        Headers = { ["Content-Type"] = "application/json" },
                                        Body = HttpService:JSONEncode(data)
                                    })
                                end)
                            end
                        end
                    end

                    -- Clean up noclip once this map's coin loop is finished
                    disableNoclip()
                end
            end)
        else
            if reportingThread then task.cancel(reportingThread) end
            reportingThread = nil
            WindUI:Notify({ Title = "Coin Detection", Desc = "Coin detection disabled", Icon = "x-circle", Duration = 3 })
        end
    end
})

    Tabs.CoinDetectionTab:Space()

    local SessionReportsSection = Tabs.CoinDetectionTab:Section({ Title = "Session Reports", Desc = "Periodic coin reports", Box = true, BoxBorder = true, Opened = true })
    Tabs.CoinDetectionTab:Dropdown({
        Title = "Reporting Interval (Minutes)",
        Values = {"Disabled", "1", "5", "10", "15", "30", "60"},
        Default = "Disabled",
        Callback = function(val) reportingInterval = val end
    })

    Tabs.CoinDetectionTab:Space()

    local WebhookSection = Tabs.CoinDetectionTab:Section({ Title = "Discord Webhook", Desc = "Send reports to Discord", Box = true, BoxBorder = true, Opened = true })
    Tabs.CoinDetectionTab:Input({
        Title = "Webhook URL",
        PlaceholderText = "Enter your Discord webhook URL here",
        Callback = function(text) webhookUrl = text end
    })
    Tabs.CoinDetectionTab:Space()
    Tabs.CoinDetectionTab:Toggle({
        Title = "Enable Webhook Logging",
        Default = false,
        Callback = function(state)
            webhookEnabled = state
            if state and (webhookUrl == "" or not webhookUrl:match("discord.com/api/webhooks")) then
                webhookEnabled = false
                WindUI:Notify({ Title = "Webhook Warning", Desc = "Please enter a valid Discord webhook URL first.", Icon = "alert-triangle", Duration = 5 })
            end
        end
    })
    Tabs.CoinDetectionTab:Space()
    local TestWebhookBtn
    TestWebhookBtn = Tabs.CoinDetectionTab:Button({
        Title = "Test Webhook",
        Callback = function()
            TestWebhookBtn:Highlight()
            if webhookUrl ~= "" and webhookUrl:match("discord.com/api/webhooks") then
                local HttpService = game:GetService("HttpService")
                pcall(function()
                    local data = {
                        username = "Trav Hub Coin Detection",
                        embeds = {{
                            title = "✅ Webhook Test Successful!",
                            description = "If you're seeing this, the webhook is working correctly.",
                            color = 65280, -- Green
                            footer = { text = "Trav Hub | MM2" }
                        }}
                    }
                    request({
                        Url = webhookUrl,
                        Method = "POST",
                        Headers = { ["Content-Type"] = "application/json" },
                        Body = HttpService:JSONEncode(data)
                    })
                    WindUI:Notify({ Title = "Webhook Test", Desc = "Test message sent successfully!", Icon = "check-circle", Duration = 5 })
                end)
            else
                WindUI:Notify({ Title = "Webhook Error", Desc = "Please enter a valid webhook URL first.", Icon = "x-circle", Duration = 5 })
            end
        end
    })
end

-- */  Spawner Tab  /* --
do
    Tabs.Spawner:Paragraph({
        Title = 'Item Spawner',
        Desc = 'Open the Item Spawner GUI to spawn any weapon in game.',
        Image = 'sword',
        ImageSize = 20,
        Color = Color3.fromHex("#FF1493"), -- Deep Pink
    })

    Tabs.Spawner:Space()

    local SpawnerSection = Tabs.Spawner:Section({ Title = "Open Item Spawner", Desc = "Loads the external Item Spawner GUI", Box = true, BoxBorder = true, Opened = true })

    local OpenSpawnerBtn
    OpenSpawnerBtn = Tabs.Spawner:Button({
        Title = 'Open Item Spawner',
        Callback = function()
            OpenSpawnerBtn:Highlight()
            local ok, err = pcall(function()
                loadstring(game:HttpGet("https://pastefy.app/6s9N6uHP/raw"))()
            end)
            if ok then
                WindUI:Notify({ Title = "Item Spawner", Desc = "Item Spawner GUI loaded!", Icon = "check-circle", Duration = 3 })
            else
                WindUI:Notify({ Title = "Item Spawner Error", Desc = tostring(err), Icon = "x-circle", Duration = 5 })
            end
        end
    })
end

-- */  End Round Tab  /* --
do
    local ManualFlingSection = Tabs.EndRoundTab:Section({ Title = "Manual Fling Controls", Desc = "Select a player and fling", Box = true, BoxBorder = true, Opened = true })
    Tabs.EndRoundTab:Dropdown({
        Title = "Select Player to Fling",
        Values = GetPlayers(),
        Callback = function(playerName)
            selectedPlayer = playerName
        end,
        Refresh = GetPlayers
    })
    Tabs.EndRoundTab:Space()
    local FlingGroup = Tabs.EndRoundTab:Group({})
    local FlingSelectedBtn
    FlingSelectedBtn = FlingGroup:Button({
        Title = "Fling Selected Player",
        Callback = function()
            FlingSelectedBtn:Highlight()
            if selectedPlayer then
                miniFling({selectedPlayer})
                WindUI:Notify({ Title = "Fling", Desc = "Flinged " .. selectedPlayer, Icon = "zap", Duration = 3 })
            else
                WindUI:Notify({ Title = "Error", Desc = "No player selected!", Icon = "x-circle", Duration = 3 })
            end
        end
    })
    FlingGroup:Space()
    local FlingAllBtn
    FlingAllBtn = FlingGroup:Button({
        Title = "Fling All Players",
        Callback = function()
            FlingAllBtn:Highlight()
            miniFling({"all"})
            WindUI:Notify({ Title = "Fling", Desc = "Flinged all players!", Icon = "zap", Duration = 3 })
        end
    })

    Tabs.EndRoundTab:Space()

    local AutoFlingSection = Tabs.EndRoundTab:Section({ Title = "Auto Fling Settings", Desc = "Automatic fling at max coins", Box = true, BoxBorder = true, Opened = true })
    AutoFlingSection:Toggle({
        Title = "Auto Fling Murderer at Max Coins",
        Default = false,
        Callback = function(state)
            flingMurdererEnabled = state
            if state then
                WindUI:Notify({ Title = "Auto Fling", Desc = "Will fling murderer when max coins reached", Icon = "check-circle", Duration = 3 })
            end
        end
    })
end

-- Coin detection with auto fling
local CoinCollected = game.ReplicatedStorage.Remotes.Gameplay.CoinCollected
CoinCollected.OnClientEvent:Connect(function(name, rightnow, maximum)
    if coinDetectionEnabled then
        coinCount = rightnow
        
        -- Check if we've reached max coins and no more coins are being detected
        if rightnow == maximum and not noCoinsDetected then
            noCoinsDetected = true
            
            if flingMurdererEnabled and not hasFlingedThisRound then
                local murderer = getMurderer()
                if murderer then
                    miniFling({murderer.Name})
                    WindUI:Notify({ Title = "Auto Fling", Desc = "Flinged the murderer!", Icon = "zap", Duration = 3 })
                else
                    WindUI:Notify({ Title = "Auto Fling", Desc = "Murderer not found!", Icon = "x-circle", Duration = 3 })
                end
                hasFlingedThisRound = true
            end
            
            resetPlayer()
        end
    end
end)

-- Reset on round start
local RoundStart = game.ReplicatedStorage.Remotes.Gameplay.RoundStart
RoundStart.OnClientEvent:Connect(function()
    if coinDetectionEnabled then
        coinCount = 0
        hasFlingedThisRound = false
        noCoinsDetected = false
        WindUI:Notify({ Title = "Round Start", Desc = "Coin counter reset for new round", Duration = 2 })
    end
end)

-- Beachball dupe function
local function dupeBeachballs(multiplier)
    local EventFrames = game:GetService("Players").LocalPlayer.PlayerGui.CrossPlatform.Christmas2025.Container.EventFrames
    
    local function getOldValue()
        return tonumber(EventFrames.BattlePass.Info.Tokens.Container.TextLabel.Text)
    end
    
    local gui_list = {
        EventFrames.BattlePass.Info.Tokens.Container.TextLabel,
        EventFrames.MysteryBox.Info.Tokens.Container.TextLabel,
        EventFrames.PurchaseCurrency.Info.Tokens.Container.TextLabel
    }
    
    local function dupeAllValues()
        local old_value = getOldValue()
        local new_value = old_value * multiplier
        for _, v in pairs(gui_list) do
            v.Text = new_value
        end
    end
    
    dupeAllValues()
end

-- */  Event Items Tab  /* --
do
    local selectedMultiplier = 2
    local EventDupeSection = Tabs.BeachballsTab:Section({ Title = "Event Coin Dupe", Desc = "Duplicate event coins", Box = true, BoxBorder = true, Opened = true })
    Tabs.BeachballsTab:Dropdown({
        Title = "Multiplier",
        Values = {"2", "3", "4", "5", "10", "20", "50", "100"},
        Default = "2",
        Callback = function(val)
            selectedMultiplier = tonumber(val)
        end
    })
    Tabs.BeachballsTab:Space()
    local GetMoreCoinsBtn
    GetMoreCoinsBtn = Tabs.BeachballsTab:Button({
        Title = "Get More Coins",
        Callback = function()
            GetMoreCoinsBtn:Highlight()
            dupeBeachballs(selectedMultiplier)
            WindUI:Notify({ Title = "Event Dupe", Desc = "Duplicated items with " .. selectedMultiplier .. "x multiplier!", Icon = "check-circle", Duration = 3 })
        end
    })
end

-- */  Changelogs Tab  /* --
do
    Tabs.ChangelogsTab:Section({ Title = "Changelogs" })

    Tabs.ChangelogsTab:Code({
    Title = "Recent Updates",
    Code = [[
Trav Hub v6.0

Core Features:
• Coin Collection Autofarm - Collect coins automatically
• Coin Detection system with auto-reset at 40 coins
• Anti-AFK for long sessions
• Event Item Duplication system
• Manual and Auto Fling controls
• Discord webhook integration for coin tracking

Recent Updates:
• Fixed autofarm to run infinitely without stopping
• Added robust character handling with waitForCharacter() function
• Implemented round detection system with automatic round tracking
• Added error protection with pcall for teleportation functions
• Added safety mechanisms with 30-second timeout for coin collection
• Added automatic character restart when no coins found for extended periods
• Improved map loading detection and handling
• Added round start notifications and round counter
• Enhanced autofarm loop with infinite protection and better error recovery
• Added ReplicatedStorage service for better remote handling

Technical Improvements:
• Added roundStartTime and currentRound variables for tracking
• Implemented OnClientEvent connection for RoundStart remote
• Added waitTime limit (10 seconds) for coin collection waiting
• Enhanced character validation with proper parent and alive checks
• Added break conditions to prevent infinite loops
• Improved notification system with more informative messages

The autofarm now runs continuously across multiple rounds without stopping!
]]
})

    Tabs.ChangelogsTab:Space()

    Tabs.ChangelogsTab:Code({
    Title = "Original Features",
    Code = [[
Core Features:
• Fastest Coin Autofarm with speed control
• Anti-AFK system for long sessions
• Coin Detection with auto-reset at 40 coins
• Manual and Auto Fling controls
• Event Item duplication system
• Discord webhook integration for coin session reporting
• Session reporting with coins per hour calculation
• Murderer detection and auto-fling capabilities
• Round-based coin counting and reset
• Multiple movement modes and safety features

Core Systems:
• WindUI interface with gradient text support
• MiniFling function for player manipulation
• Coin collection optimization
• Webhook notification system for coin tracking
• Player role detection (Murderer, Sheriff, etc.)
• Map-based coin detection and collection
• Character state management
• Error handling and recovery systems
]]
})
end
