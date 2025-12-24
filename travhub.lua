local vu1 = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/n9owns/Files/refs/heads/main/antiafk", true))()
    end)
end)
local vu2 = game:GetService("Players")
local v3 = game:GetService("RunService")
local vu4 = game:GetService("ReplicatedStorage")
local _ = game:GetService("Workspace").CurrentCamera
local vu5 = vu2.LocalPlayer
game:GetService("CoreGui")
local vu6 = game:GetService("TweenService")
local vu7 = {
    Orange = Color3.fromHex("#FF6B1A"),
    DarkOrange = Color3.fromHex("#FF4500"),
    Purple = Color3.fromHex("#9D4EDD"),
    DarkPurple = Color3.fromHex("#5A189A"),
    Blood = Color3.fromHex("#8B0000"),
    Ghost = Color3.fromHex("#E0E0E0"),
    Pumpkin = Color3.fromHex("#FF7518"),
    Witch = Color3.fromHex("#6B2E8A"),
    Midnight = Color3.fromHex("#0D0221"),
    Toxic = Color3.fromHex("#39FF14"),
    Red = Color3.fromHex("#FF0000"),
    Green = Color3.fromHex("#00FF00"),
    Gold = Color3.fromHex("#FFD700"),
    Silver = Color3.fromHex("#C0C0C0"),
    Blue = Color3.fromHex("#1E90FF"),
    Innocent = Color3.fromHex("#39FF14"),
    Sheriff = Color3.fromHex("#001e80"),
    Murder = Color3.fromHex("#e80909")
}
local function v15(p8, p9, p10)
    local v11 = # p8
    local v12 = ""
    for v13 = 1, v11 do
        local v14 = (v13 - 1) / math.max(v11 - 1, 1)
        v12 = v12 .. "<font color=\"rgb(" .. math.floor((p9.R + (p10.R - p9.R) * v14) * 255) .. ", " .. math.floor((p9.G + (p10.G - p9.G) * v14) * 255) .. ", " .. math.floor((p9.B + (p10.B - p9.B) * v14) * 255) .. ")\">" .. p8:sub(v13, v13) .. "</font>"
    end
    return v12
end
local vu16 = false
local v17 = vu1
vu1.Popup(v17, {
    Title = v15("TravHub", vu7.Red, vu7.Green),
    Icon = "skull",
    Content = v15("Best MM2 Script - Christmas Edition!", vu7.Gold, vu7.Blue) .. "<br/>" .. v15("Join our discord server! Daily Giveaways", vu7.Blue, vu7.Purple),
    Buttons = {
        {
            Title = "Exit",
            Callback = function()
            end,
            Variant = "Tertiary"
        },
        {
            Title = "Copy Discord",
            Callback = function()
                setclipboard("https://discord.gg/pNfrgHeede")
                vu1:Notify({
                    Title = "Discord Copied!",
                    Content = "Discord invite copied to clipboard!",
                    Icon = "check-circle",
                    Duration = 3
                })
                vu16 = true
            end,
            Variant = "Secondary"
        },
        {
            Title = v15("Continue", vu7.Toxic, vu7.Orange),
            Callback = function()
                vu16 = true
            end,
            Variant = "Primary"
        }
    }
})
local vu18 = vu1
repeat
    task.wait()
until vu16
local vu19 = vu18:CreateWindow({
    Title = v15("TravHub", vu7.Red, vu7.Green),
    Author = "by Trav Scripts \226\128\162 Christmas Update",
    Folder = "Travhub",
    Icon = "skull",
    NewElements = true,
    Size = UDim2.new(0, 580, 0, 480),
    Transparent = true,
    BackgroundTransparency = 0.5,
    Theme = "Dark",
    SideBarWidth = 220,
    HideSearchBar = false,
    ScrollBarEnabled = true,
    OpenButton = {
        Title = "Open TravHub",
        CornerRadius = UDim.new(0.5, 0),
        StrokeThickness = 2,
        Enabled = true,
        Draggable = true,
        OnlyMobile = false,
        Color = ColorSequence.new(vu7.Red, vu7.Green)
    },
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
        end
    }
})
local vu20 = false
local vu21 = false
local vu22 = false
local vu23 = false
local vu24 = false
local vu25 = {}
local vu26 = 25
local vu27 = 0
local vu28 = 0
local vu29 = 40
local vu30 = vu5.Character or vu5.CharacterAdded:Wait()
local vu31 = vu30:WaitForChild("HumanoidRootPart")
local vu32 = false
local vu33 = false
local vu34 = false
local vu35 = nil
local vu36 = game:GetService("MarketplaceService")
local vu37 = 818078531
local function vu40()
    local v38, v39 = pcall(function()
        return vu36:UserOwnsGamePassAsync(vu5.UserId, vu37)
    end)
    if v38 then
        if v39 then
            vu29 = 50
            print("[Gamepass Check] \226\156\133 You own the premium gamepass!")
        else
            vu29 = 40
            print("[Gamepass Check] \226\157\140 You do NOT own the premium gamepass.")
        end
    else
        vu29 = 40
        print("[Gamepass Check] \226\154\160\239\184\143 Failed to check ownership.")
    end
end
vu40()
local vu41 = false
local vu42 = false
local vu43 = {
    "Esp All"
}
local vu44 = true
local vu45 = false
local vu46 = {}
local vu47 = ""
local vu48 = 1
local vu49 = ""
local vu50 = ""
local vu51
if vu5.PlayerGui.MainGUI.Game:FindFirstChild("Inventory") == nil then
    vu51 = vu5.PlayerGui.MainGUI.Lobby.Screens.Inventory.Main
else
    vu51 = vu5.PlayerGui.MainGUI.Game.Inventory.Main
end
local vu52 = {
    WalkSpeed = {
        Value = 16,
        Default = 16,
        Locked = false
    },
    JumpPower = {
        Value = 50,
        Default = 50,
        Locked = false
    }
}
local function vu56(p53)
    local v54 = p53.Character
    if not v54 then
        return nil
    end
    local v55 = p53:FindFirstChild("Backpack")
    return (v54:FindFirstChild("Knife") or v55 and v55:FindFirstChild("Knife")) and "Murderer" or ((v54:FindFirstChild("Gun") or v55 and v55:FindFirstChild("Gun")) and "Sheriff" or "Innocent")
end
local function vu60(p57, p58)
    local v59 = vu56(p57)
    if v59 then
        return table.find(p58, "Esp All") and true or (table.find(p58, "Esp Murder") and v59 == "Murderer" and true or (table.find(p58, "Esp Sheriff") and v59 == "Sheriff" and true or (table.find(p58, "Esp Sheriff / Murder") and (v59 == "Sheriff" or v59 == "Murderer") and true or false)))
    else
        return false
    end
end
local function vu64(p61, p62)
    local v63 = p61:FindFirstChild("RoleHighlight")
    if not v63 then
        v63 = Instance.new("Highlight")
        v63.Name = "RoleHighlight"
        v63.FillTransparency = 0.5
        v63.OutlineTransparency = 1
        v63.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        v63.Adornee = p61
        v63.Parent = p61
    end
    v63.FillColor = p62
end
local function vu67(p65)
    local v66 = p65:FindFirstChild("RoleHighlight")
    if v66 then
        v66:Destroy()
    end
end
local function vu71(p68, p69)
    local v70 = Drawing.new("Line")
    v70.Thickness = 2
    v70.Color = p69 or Color3.new(1, 1, 1)
    v70.Transparency = 1
    vu46[p68] = v70
end
local function vu73(p72)
    if vu46[p72] then
        vu46[p72]:Remove()
        vu46[p72] = nil
    end
end
local function vu89()
    vu41 = false
    vu42 = false
    local v74 = vu2
    local v75, v76, v77 = ipairs(v74:GetPlayers())
    while true do
        local v78
        v77, v78 = v75(v76, v77)
        if v77 == nil then
            break
        end
        if v78 ~= vu5 and v78.Character then
            local v79 = vu56(v78)
            if v79 == "Murderer" then
                vu41 = true
            end
            if v79 == "Sheriff" then
                vu42 = true
            end
        end
    end
    local v80 = vu2
    local v81, v82, v83 = ipairs(v80:GetPlayers())
    while true do
        local v84
        v83, v84 = v81(v82, v83)
        if v83 == nil then
            break
        end
        if v84 ~= vu5 and v84.Character then
            local v85 = vu56(v84)
            local v86 = vu60(v84, vu43)
            if vu44 then
                if v86 then
                    local v87 = v85 == "Murderer" and vu7.Blood or (v85 == "Sheriff" and vu7.Toxic or vu7.Orange)
                    vu64(v84.Character, v87)
                else
                    vu67(v84.Character)
                end
            else
                vu67(v84.Character)
            end
            if vu45 and v86 then
                local v88 = v85 == "Murderer" and vu7.Blood or (v85 == "Sheriff" and vu7.Toxic or vu7.Orange)
                if vu46[v84] then
                    vu46[v84].Color = v88
                else
                    vu71(v84, v88)
                end
            else
                vu73(v84)
            end
        end
    end
end
local function vu91()
    local v90 = vu5.Character:FindFirstChildOfClass("Humanoid")
    if v90 then
        if not vu52.WalkSpeed.Locked then
            v90.WalkSpeed = vu52.WalkSpeed.Value
        end
        if not vu52.JumpPower.Locked then
            v90.JumpPower = vu52.JumpPower.Value
        end
    end
end
local function vu143(p92)
    local vu93 = game:GetService("Players")
    local vu94 = false
    local function v102(p95)
        local v96 = p95:lower()
        if v96 == "all" or v96 == "others" then
            vu94 = true
            return
        elseif v96 == "random" then
            local v97 = vu93:GetPlayers()
            if table.find(v97, vu93.LocalPlayer) then
                table.remove(v97, table.find(v97, vu93.LocalPlayer))
            end
            return v97[math.random(# v97)]
        elseif v96 ~= "random" and (v96 ~= "all" and v96 ~= "others") then
            local v98 = next
            local v99, v100 = vu93:GetPlayers()
            while true do
                local v101
                v100, v101 = v98(v99, v100)
                if v100 == nil then
                    break
                end
                if v101 ~= vu93.LocalPlayer then
                    if v101.Name:lower():match("^" .. v96) then
                        return v101
                    end
                    if v101.DisplayName:lower():match("^" .. v96) then
                        return v101
                    end
                end
            end
        end
    end
    local function v128(pu103)
        local vu104 = vu93.LocalPlayer.Character
        local vu105
        if vu104 then
            vu105 = vu104:FindFirstChildOfClass("Humanoid")
        else
            vu105 = vu104
        end
        local vu106
        if vu105 then
            vu106 = vu105.RootPart
        else
            vu106 = vu105
        end
        local vu107 = pu103.Character
        local vu108 = nil
        local v109 = nil
        local v110 = nil
        local v111 = nil
        local vu112
        if vu107:FindFirstChildOfClass("Humanoid") then
            vu112 = vu107:FindFirstChildOfClass("Humanoid")
        else
            vu112 = nil
        end
        if vu112 and vu112.RootPart then
            vu108 = vu112.RootPart
        end
        if vu107:FindFirstChild("Head") then
            v109 = vu107.Head
        end
        if vu107:FindFirstChildOfClass("Accessory") then
            v110 = vu107:FindFirstChildOfClass("Accessory")
        end
        if v110 and v110:FindFirstChild("Handle") then
            v111 = v110.Handle
        end
        if vu104 and (vu105 and vu106) then
            if vu106.Velocity.Magnitude < 50 then
                getgenv().OldPos = vu106.CFrame
            end
            if vu112 and (vu112.Sit and not vu94) then
                return
            else
                if v109 then
                    game.Workspace.CurrentCamera.CameraSubject = v109
                elseif v109 or not v111 then
                    if vu112 and vu108 then
                        game.Workspace.CurrentCamera.CameraSubject = vu112
                    end
                else
                    game.Workspace.CurrentCamera.CameraSubject = v111
                end
                if vu107:FindFirstChildWhichIsA("BasePart") then
                    local function vu116(p113, p114, p115)
                        vu106.CFrame = CFrame.new(p113.Position) * p114 * p115
                        vu104:SetPrimaryPartCFrame(CFrame.new(p113.Position) * p114 * p115)
                        vu106.Velocity = Vector3.new(90000000, 900000000, 90000000)
                        vu106.RotVelocity = Vector3.new(900000000, 900000000, 900000000)
                    end
                    local function v121(p117)
                        local v118 = tick()
                        local v119 = 2
                        local v120 = 0
                        while vu106 and vu112 do
                            if p117.Velocity.Magnitude >= 50 then
                                vu116(p117, CFrame.new(0, 1.5, vu112.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                                task.wait()
                                vu116(p117, CFrame.new(0, - 1.5, - vu112.WalkSpeed), CFrame.Angles(0, 0, 0))
                                task.wait()
                                vu116(p117, CFrame.new(0, 1.5, vu112.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                                task.wait()
                                vu116(p117, CFrame.new(0, 1.5, vu108.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                                task.wait()
                                vu116(p117, CFrame.new(0, - 1.5, - vu108.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                                task.wait()
                                vu116(p117, CFrame.new(0, 1.5, vu108.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                                task.wait()
                                vu116(p117, CFrame.new(0, - 1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                                task.wait()
                                vu116(p117, CFrame.new(0, - 1.5, 0), CFrame.Angles(0, 0, 0))
                                task.wait()
                                vu116(p117, CFrame.new(0, - 1.5, 0), CFrame.Angles(math.rad(- 90), 0, 0))
                                task.wait()
                                vu116(p117, CFrame.new(0, - 1.5, 0), CFrame.Angles(0, 0, 0))
                                task.wait()
                            else
                                v120 = v120 + 100
                                vu116(p117, CFrame.new(0, 1.5, 0) + vu112.MoveDirection * p117.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(v120), 0, 0))
                                task.wait()
                                vu116(p117, CFrame.new(0, - 1.5, 0) + vu112.MoveDirection * p117.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(v120), 0, 0))
                                task.wait()
                                vu116(p117, CFrame.new(2.25, 1.5, - 2.25) + vu112.MoveDirection * p117.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(v120), 0, 0))
                                task.wait()
                                vu116(p117, CFrame.new(- 2.25, - 1.5, 2.25) + vu112.MoveDirection * p117.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(v120), 0, 0))
                                task.wait()
                                vu116(p117, CFrame.new(0, 1.5, 0) + vu112.MoveDirection, CFrame.Angles(math.rad(v120), 0, 0))
                                task.wait()
                                vu116(p117, CFrame.new(0, - 1.5, 0) + vu112.MoveDirection, CFrame.Angles(math.rad(v120), 0, 0))
                                task.wait()
                            end
                            if p117.Velocity.Magnitude > 500 or (p117.Parent ~= pu103.Character or (pu103.Parent ~= vu93 or (not pu103.Character == vu107 or (vu112.Sit or (vu105.Health <= 0 or tick() > v118 + v119))))) then
                                break
                            end
                        end
                    end
                    game.Workspace.FallenPartsDestroyHeight = 0 / 0
                    local v122 = Instance.new("BodyVelocity")
                    v122.Name = "EpixVel"
                    v122.Parent = vu106
                    v122.Velocity = Vector3.new(900000000, 900000000, 900000000)
                    v122.MaxForce = Vector3.new(1 / 0, 1 / 0, 1 / 0)
                    vu105:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                    if vu108 and v109 then
                        if (vu108.CFrame.p - v109.CFrame.p).Magnitude <= 5 then
                            v121(vu108)
                        else
                            v121(v109)
                        end
                    elseif vu108 and not v109 then
                        v121(vu108)
                    elseif vu108 or not v109 then
                        if vu108 or (v109 or not (v110 and v111)) then
                            return
                        end
                        v121(v111)
                    else
                        v121(v109)
                    end
                    v122:Destroy()
                    vu105:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                    game.Workspace.CurrentCamera.CameraSubject = vu105
                    repeat
                        vu106.CFrame = getgenv().OldPos * CFrame.new(0, 0.5, 0)
                        local v123 = vu104
                        vu104.SetPrimaryPartCFrame(v123, getgenv().OldPos * CFrame.new(0, 0.5, 0))
                        local v124 = vu105
                        vu105.ChangeState(v124, "GettingUp")
                        local v125 = vu104
                        table.foreach(vu104.GetChildren(v125), function(_, p126)
                            if p126:IsA("BasePart") then
                                local v127 = Vector3.new()
                                p126.RotVelocity = Vector3.new()
                                p126.Velocity = v127
                            end
                        end)
                        task.wait()
                    until (vu106.Position - getgenv().OldPos.p).Magnitude < 25
                    game.Workspace.FallenPartsDestroyHeight = - 500
                    game.Workspace.FallenPartsDestroyHeight = - 500
                end
            end
        else
            return
        end
    end
    if p92[1] then
        local v129 = next
        local v130 = p92
        local v131 = vu93
        local v132 = vu94
        local v133 = nil
        while true do
            local v134
            v133, v134 = v129(p92, v133)
            if v133 == nil then
                break
            end
            v102(v134)
        end
        if v132 then
            local v135 = next
            local v136, v137 = v131:GetPlayers()
            while true do
                local v138
                v137, v138 = v135(v136, v137)
                if v137 == nil then
                    break
                end
                v128(v138)
            end
        end
        local v139 = next
        local v140 = nil
        while true do
            local v141
            v140, v141 = v139(v130, v140)
            if v140 == nil then
                break
            end
            if v102(v141) and v102(v141) ~= v131.LocalPlayer then
                local v142 = v102(v141)
                if v142 then
                    v128(v142)
                end
            else
                v102(v141)
            end
        end
    end
end
local function vu151()
    local v144 = vu2
    local v145, v146, v147 = ipairs(v144:GetPlayers())
    local v148 = nil
    while true do
        local v149
        v147, v149 = v145(v146, v147)
        if v147 == nil then
            v149 = v148
            break
        end
        if v149 ~= vu5 and v149.Character then
            if v149.Character:FindFirstChild("Knife") then
                break
            end
            local v150 = v149:FindFirstChild("Backpack")
            if v150 and v150:FindFirstChild("Knife") then
                break
            end
        end
    end
    if not (v149 and v149.Character) then
        vu18:Notify({
            Title = "Fling Error",
            Content = "No murderer found!",
            Icon = "x-circle",
            Duration = 3
        })
        return false
    end
    vu18:Notify({
        Title = "Flinging Murderer",
        Content = "Flinging " .. v149.Name .. "!",
        Icon = "zap",
        Duration = 3
    })
    vu143({
        v149.Name
    })
    vu18:Notify({
        Title = "Fling Complete",
        Content = "Murderer has been flung!",
        Icon = "check-circle",
        Duration = 2
    })
    return true
end
local function vu152()
    return vu5.Character or vu5.CharacterAdded:Wait()
end
local function vu153()
    return vu152():WaitForChild("HumanoidRootPart")
end
local v154 = vu4:FindFirstChild("Remotes") and vu4.Remotes:FindFirstChild("Gameplay")
if v154 then
    v154 = vu4.Remotes.Gameplay:FindFirstChild("CoinCollected")
end
local v155 = vu4:FindFirstChild("Remotes") and vu4.Remotes:FindFirstChild("Gameplay")
if v155 then
    v155 = vu4.Remotes.Gameplay:FindFirstChild("RoundStart")
end
local v156 = vu4:FindFirstChild("Remotes") and vu4.Remotes:FindFirstChild("Gameplay")
if v156 then
    v156 = vu4.Remotes.Gameplay:FindFirstChild("RoundEndFade")
end
if v155 then
    v155.OnClientEvent:Connect(function()
        vu32 = true
        vu35 = vu153().CFrame
        print("[DEBUG] Round started, farming enabled")
    end)
end
if v156 then
    v156.OnClientEvent:Connect(function()
        vu32 = false
        print("[DEBUG] Round ended, farming disabled")
    end)
end
local function vu169()
    local v157 = vu153()
    local v158 = math.huge
    local v159, v160, v161 = pairs(workspace:GetChildren())
    local v162 = nil
    while true do
        local v163
        v161, v163 = v159(v160, v161)
        if v161 == nil then
            break
        end
        if v163:FindFirstChild("CoinContainer") then
            local v164, v165, v166 = pairs(v163.CoinContainer:GetChildren())
            while true do
                local v167
                v166, v167 = v164(v165, v166)
                if v166 == nil then
                    break
                end
                if v167:IsA("BasePart") and v167:FindFirstChild("TouchInterest") then
                    local v168 = (v157.Position - v167.Position).Magnitude
                    if v168 < v158 then
                        v162 = v167
                        v158 = v168
                    end
                end
            end
        end
    end
    return v162, v158
end
local function vu187()
    local v170 = vu153()
    local v171 = math.huge
    local v172, v173, v174 = pairs(workspace:GetChildren())
    local v175 = nil
    while true do
        local v176
        v174, v176 = v172(v173, v174)
        if v174 == nil then
            break
        end
        if v176:FindFirstChild("CoinContainer") then
            local v177, v178, v179 = pairs(v176.CoinContainer:GetChildren())
            while true do
                local v180
                v179, v180 = v177(v178, v179)
                if v179 == nil then
                    break
                end
                if v180:IsA("BasePart") and (v180:GetAttribute("CoinID") == "Candy" and v180:FindFirstChild("TouchInterest")) then
                    local v181 = (v170.Position - v180.Position).Magnitude
                    if v181 < v171 then
                        v175 = v180
                        v171 = v181
                    end
                end
            end
        end
    end
    if not v175 then
        local v182, v183, v184 = ipairs(workspace:GetDescendants())
        while true do
            local v185
            v184, v185 = v182(v183, v184)
            if v184 == nil then
                break
            end
            if v185:IsA("BasePart") and v185.Name == "candy" then
                local v186 = (v170.Position - v185.Position).Magnitude
                if v186 < v171 then
                    v171 = v186
                    v175 = v185
                end
            end
        end
    end
    return v175, v171
end
task.spawn(function()
    while true do
        if (vu20 or vu21) and (vu32 and not vu33) then
            local v188 = vu153()
            local v189 = nil
            local v190 = math.huge
            if vu21 then
                v189, v190 = vu187()
            elseif vu20 then
                v189, v190 = vu169()
            end
            if v189 then
                if v190 > 150 then
                    v188.CFrame = v189.CFrame
                    print("[DEBUG] Teleported to distant coin at distance:", v190)
                else
                    local v191 = vu6:Create(v188, TweenInfo.new(v190 / vu26, Enum.EasingStyle.Linear), {
                        CFrame = v189.CFrame
                    })
                    v191:Play()
                    print("[DEBUG] Tweening to nearby coin at distance:", v190)
                    repeat
                        task.wait()
                    until not (v189:FindFirstChild("TouchInterest") and (vu32 and (vu20 or vu21)))
                    v191:Cancel()
                end
                vu27 = vu27 + 1
                print("[DEBUG] Collected item, total collected:", vu27)
            else
                print("[DEBUG] No valid items found to collect")
            end
        end
        task.wait(0.2)
    end
end)
v3.Stepped:Connect(function()
    if (vu20 or vu21) and (vu32 and not vu33) then
        local v192 = vu5.Character
        if v192 and v192:IsDescendantOf(workspace) then
            local v193, v194, v195 = ipairs(v192:GetDescendants())
            while true do
                local v196
                v195, v196 = v193(v194, v195)
                if v195 == nil then
                    break
                end
                if v196:IsA("BasePart") then
                    v196.CanCollide = false
                end
            end
        end
    end
end)
vu5.CharacterAdded:Connect(function(p197)
    vu30 = p197
    vu31 = p197:WaitForChild("HumanoidRootPart")
    vu25 = {}
    vu28 = 0
    vu33 = false
    vu34 = false
    vu40()
    print("[DEBUG] Character respawned, farming state reset")
end)
if v154 then
    v154.OnClientEvent:Connect(function(p198, p199, _, _)
        if p198 == "Candy" then
            vu28 = p199
            print("[DEBUG] Collected candy! Current amount:", vu28)
            if vu29 <= vu28 then
                print("[DEBUG] Bag is full! (" .. vu29 .. " candies reached)")
                print("[DEBUG] autoEndRound is:", vu22)
                print("[DEBUG] autoFlingMurderer is:", vu24)
                print("[DEBUG] autoKillMurderer is:", autoKillMurderer)
                vu18:Notify({
                    Title = "Bag Full!",
                    Content = "Candy bag is full (" .. vu28 .. "/" .. vu29 .. ")",
                    Icon = "package",
                    Duration = 3
                })
                vu21 = false
                vu20 = false
                print("[DEBUG] Stopped autofarm")
                if vu24 then
                    print("[DEBUG] Auto fling murderer enabled...")
                    vu18:Notify({
                        Title = "Auto Fling Murderer",
                        Content = "Flinging murderer now!",
                        Icon = "zap",
                        Duration = 2
                    })
                    local v200 = vu2
                    local v201, v202, v203 = ipairs(v200:GetPlayers())
                    local v204 = nil
                    while true do
                        local v205
                        v203, v205 = v201(v202, v203)
                        if v203 == nil then
                            v205 = v204
                            break
                        end
                        if v205 ~= vu5 and v205.Character then
                            if v205.Character:FindFirstChild("Knife") then
                                break
                            end
                            local v206 = v205:FindFirstChild("Backpack")
                            if v206 and v206:FindFirstChild("Knife") then
                                break
                            end
                        end
                    end
                    if v205 and v205.Character then
                        print("[DEBUG] Found murderer, flinging:", v205.Name)
                        vu151()
                        print("[DEBUG] Auto murderer fling completed")
                    else
                        print("[DEBUG] No murderer found")
                    end
                end
                if vu22 and not vu34 then
                    vu34 = true
                    vu33 = true
                    local v207 = vu153()
                    if vu35 then
                        print("[DEBUG] Returning to start position...")
                        local v208 = {
                            CFrame = vu35
                        }
                        local v209 = vu6:Create(v207, TweenInfo.new(2, Enum.EasingStyle.Linear), v208)
                        v209:Play()
                        v209.Completed:Wait()
                    end
                    task.wait(0.5)
                    print("[DEBUG] Resetting character...")
                    vu18:Notify({
                        Title = "Auto Reset",
                        Content = "Resetting character instantly!",
                        Icon = "refresh-cw",
                        Duration = 2
                    })
                    if vu5.Character then
                        vu5.Character:BreakJoints()
                        vu5.CharacterAdded:Wait()
                        task.wait(1.5)
                        print("[DEBUG] Character reset completed")
                    end
                    vu34 = false
                    vu33 = false
                    print("[DEBUG] Farming state reset")
                end
            end
        end
    end)
end
if v155 then
    v155.OnClientEvent:Connect(function(_, _)
        vu28 = 0
        vu25 = {}
        vu33 = false
        vu34 = false
        vu32 = true
        vu35 = vu153().CFrame
        print("[DEBUG] Round started, farming enabled")
        local v210 = vu20
        if vu21 then
            vu21 = true
            vu18:Notify({
                Title = "Round Started!",
                Content = "Candy autofarm resumed automatically",
                Icon = "play-circle",
                Duration = 2
            })
        end
        if v210 then
            vu20 = true
            vu18:Notify({
                Title = "Round Started!",
                Content = "Coin autofarm resumed automatically",
                Icon = "play-circle",
                Duration = 2
            })
        end
    end)
end
local function vu227()
    wait(math.random(1, 3))
    local v211, v212, v213 = pairs(vu51.Weapons.Items.Container:GetChildren())
    while true do
        local v214
        v213, v214 = v211(v212, v213)
        if v213 == nil then
            break
        end
        local v215, v216, v217 = pairs(v214.Container:GetChildren())
        while true do
            local v218
            v217, v218 = v215(v216, v217)
            if v217 == nil then
                break
            end
            if v218.Name == "Christmas" or v218.Name == "Halloween" then
                local v219, v220, v221 = pairs(v218.Container:GetChildren())
                while true do
                    local v222
                    v221, v222 = v219(v220, v221)
                    if v221 == nil then
                        break
                    end
                    if v222:IsA("Frame") and v222.ItemName.Label.Text == vu47 then
                        local v223 = v222.Container.Amount.Text
                        if v223 == "" or v223 == "None" then
                            v222.Container.Amount.Text = "x2"
                        else
                            local v224 = tonumber(v223:match("x(%d+)"))
                            if v224 then
                                v222.Container.Amount.Text = "x" .. tostring(v224 + 1)
                            end
                        end
                    end
                end
            elseif v218:IsA("Frame") and v218.ItemName.Label.Text == vu47 then
                local v225 = v218.Container.Amount.Text
                if v225 == "" or v225 == "None" then
                    v218.Container.Amount.Text = "x2"
                else
                    local v226 = tonumber(v225:match("x(%d+)"))
                    if v226 then
                        v218.Container.Amount.Text = "x" .. tostring(v226 + 1)
                    end
                end
            end
        end
    end
end
local function vu250()
    wait(math.random(3, 5))
    local v228, v229, v230 = pairs(vu51.Weapons.Items.Container:GetChildren())
    while true do
        local v231
        v230, v231 = v228(v229, v230)
        if v230 == nil then
            break
        end
        local v232, v233, v234 = pairs(v231.Container:GetChildren())
        while true do
            local v235
            v234, v235 = v232(v233, v234)
            if v234 == nil then
                break
            end
            if v235.Name == "Christmas" or v235.Name == "Halloween" then
                local v236, v237, v238 = pairs(v235.Container:GetChildren())
                while true do
                    local v239
                    v238, v239 = v236(v237, v238)
                    if v238 == nil then
                        break
                    end
                    if v239:IsA("Frame") and (v239.ItemName.Label.Text ~= "Default Knife" and v239.ItemName.Label.Text ~= "Default Gun") then
                        local v240 = v239.Container.Amount.Text
                        if v240 == "" or v240 == "None" then
                            v239.Container.Amount.Text = "x2"
                        else
                            local v241 = tonumber(v240:match("x(%d+)"))
                            if v241 then
                                v239.Container.Amount.Text = "x" .. tostring(v241 * 2)
                            end
                        end
                    end
                end
            elseif v235:IsA("Frame") and (v235.ItemName.Label.Text ~= "Default Knife" and v235.ItemName.Label.Text ~= "Default Gun") then
                local v242 = v235.Container.Amount.Text
                if v242 == "" or v242 == "None" then
                    v235.Container.Amount.Text = "x2"
                else
                    local v243 = tonumber(v242:match("x(%d+)"))
                    if v243 then
                        v235.Container.Amount.Text = "x" .. tostring(v243 * 2)
                    end
                end
            end
        end
    end
    local v244, v245, v246 = pairs(vu51.Pets.Items.Container.Current.Container:GetChildren())
    while true do
        local v247
        v246, v247 = v244(v245, v246)
        if v246 == nil then
            break
        end
        if v247:IsA("Frame") then
            local v248 = v247.Container.Amount.Text
            if v248 == "" or v248 == "None" then
                v247.Container.Amount.Text = "x2"
            else
                local v249 = tonumber(v248:match("x(%d+)"))
                if v249 then
                    v247.Container.Amount.Text = "x" .. tostring(v249 * 2)
                end
            end
        end
    end
end
local function vu253(p251, p252)
    return p251:gsub("_G_%d%d%d%d", ""):gsub("_K_%d%d%d%d", ""):lower():find(p252:lower(), 1, true) ~= nil
end
local function vu254()
    if game:GetService("Players").LocalPlayer.PlayerGui.TradeGUI.Enabled == true or game:GetService("Players").LocalPlayer.PlayerGui.TradeGUI_Phone.Enabled == true then
        wait(1)
        vu18:Notify({
            Title = "Trade Scam Active",
            Content = "Items In Trade Are Now Visual, Remove All Items!",
            Icon = "alert-triangle",
            Duration = 5
        })
    else
        vu18:Notify({
            Title = "Trade Scam Error",
            Content = "You Need To Be In Trade For This To Work!",
            Icon = "x-circle",
            Duration = 5
        })
    end
end
local function vu262()
    local v255, v256 = pcall(function()
        return require(game:GetService("ReplicatedStorage").Database.Sync.MysteryBox)
    end)
    if not v255 or (not v256 or next(v256) == nil) then
        return "StandardBox"
    end
    local v257, v258, v259 = pairs(v256)
    local v260 = {}
    while true do
        local v261
        v259, v261 = v257(v258, v259)
        if v259 == nil then
            break
        end
        table.insert(v260, v259)
    end
    return v260[math.random(1, # v260)]
end
local function vu265(pu263)
    if not pcall(function()
        local v264 = require(game:GetService("ReplicatedStorage").Modules.BoxModule)
        if pu263 and require(game:GetService("ReplicatedStorage").Database.Sync.Item)[pu263] then
            print("Spawning:", pu263)
            v264.OpenBox(vu262(), pu263)
            pcall(function()
                getsenv(game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Inventory.NewItem)._G.NewItem(pu263, nil, nil, "Weapons", 1)
            end)
            vu18:Notify({
                Title = "Success",
                Content = "Successfully spawned: " .. pu263,
                Icon = "check-circle",
                Duration = 3
            })
        else
            vu18:Notify({
                Title = "Error",
                Content = "Invalid item: " .. pu263,
                Icon = "x-circle",
                Duration = 3
            })
        end
    end) then
        vu18:Notify({
            Title = "Error",
            Content = "Error opening crate for: " .. pu263,
            Icon = "x-circle",
            Duration = 3
        })
    end
end
local vu266 = {
    AutoGrabEnabled = false,
    NotifyGunDrop = true,
    GunDropCheckInterval = 1,
    ActiveGunDrops = {}
}
local vu267 = {
    "ResearchFacility",
    "Hospital3",
    "MilBase",
    "House2",
    "Workplace",
    "Mansion2",
    "BioLab",
    "Hotel",
    "Factory",
    "Bank2",
    "PoliceStation"
}
local function vu275()
    vu266.ActiveGunDrops = {}
    local v268, v269, v270 = ipairs(vu267)
    while true do
        local v271
        v270, v271 = v268(v269, v270)
        if v270 == nil then
            break
        end
        local v272 = workspace:FindFirstChild(v271)
        if v272 then
            local v273 = v272:FindFirstChild("GunDrop")
            if v273 then
                table.insert(vu266.ActiveGunDrops, v273)
            end
        end
    end
    local v274 = workspace:FindFirstChild("GunDrop")
    if v274 then
        table.insert(vu266.ActiveGunDrops, v274)
    end
end
local function vu286(p276)
    if not p276 then
        vu275()
        if # vu266.ActiveGunDrops == 0 then
            vu18:Notify({
                Title = "Gun System",
                Content = "No guns available on the map",
                Icon = "x-circle",
                Duration = 3
            })
            return false
        end
        p276 = nil
        local v277 = math.huge
        local v278 = vu5.Character
        if v278 then
            v278 = v278:FindFirstChild("HumanoidRootPart")
        end
        if v278 then
            local v279, v280, v281 = ipairs(vu266.ActiveGunDrops)
            while true do
                local v282
                v281, v282 = v279(v280, v281)
                if v281 == nil then
                    break
                end
                local v283 = (v278.Position - v282.Position).Magnitude
                if v283 < v277 then
                    v277 = v283
                    p276 = v282
                end
            end
        end
    end
    local v284 = p276 and vu5.Character and vu5.Character:FindFirstChild("HumanoidRootPart")
    if v284 then
        v284.CFrame = p276.CFrame
        task.wait(0.3)
        local v285 = p276:FindFirstChildOfClass("ProximityPrompt")
        if v285 then
            fireproximityprompt(v285)
            vu18:Notify({
                Title = "Gun System",
                Content = "Successfully grabbed the gun!",
                Icon = "check-circle",
                Duration = 3
            })
            return true
        end
    end
    return false
end
local function vu296()
    while vu266.AutoGrabEnabled do
        vu275()
        local v287 = (# vu266.ActiveGunDrops > 0 and vu5.Character and true or false) and vu5.Character:FindFirstChild("HumanoidRootPart")
        if v287 then
            local v288 = math.huge
            local v289, v290, v291 = ipairs(vu266.ActiveGunDrops)
            local v292 = nil
            while true do
                local v293
                v291, v293 = v289(v290, v291)
                if v291 == nil then
                    break
                end
                local v294 = (v287.Position - v293.Position).Magnitude
                if v294 < v288 then
                    v292 = v293
                    v288 = v294
                end
            end
            if v292 then
                v287.CFrame = v292.CFrame
                task.wait(0.3)
                local v295 = v292:FindFirstChildOfClass("ProximityPrompt")
                if v295 then
                    fireproximityprompt(v295)
                    task.wait(1)
                end
            end
        end
        task.wait(vu266.GunDropCheckInterval)
    end
end
local vu297 = false
local vu298 = 0.5
local vu299 = {
    "Sheriff",
    "Hero",
    "Innocent"
}
local function vu302(p300)
    local v301 = vu4:FindFirstChild("GetPlayerData", true):InvokeServer()
    if v301 and v301[p300.Name] then
        return v301[p300.Name].Role
    else
        return nil
    end
end
local function vu305()
    local v303 = vu5.Character
    if not v303 then
        return false
    end
    if v303:FindFirstChild("Knife") then
        return true
    end
    local v304 = vu5.Backpack:FindFirstChild("Knife")
    if not v304 then
        return false
    end
    v304.Parent = v303
    return true
end
local function vu318()
    local v306 = {}
    vu4:FindFirstChild("GetPlayerData", true):InvokeServer()
    local v307 = vu5.Character
    if v307 then
        v307 = vu5.Character:FindFirstChild("HumanoidRootPart")
    end
    if not v307 then
        return nil
    end
    local v308 = vu2
    local v309, v310, v311 = ipairs(v308:GetPlayers())
    while true do
        local v312
        v311, v312 = v309(v310, v311)
        if v311 == nil then
            break
        end
        if v312 ~= vu5 and v312.Character then
            local v313 = vu302(v312)
            local v314 = v312.Character:FindFirstChild("Humanoid")
            local v315 = v312.Character:FindFirstChild("HumanoidRootPart")
            if v313 and (v314 and (v314.Health > 0 and (v315 and table.find(vu299, v313)))) then
                table.insert(v306, {
                    Player = v312,
                    Distance = (v307.Position - v315.Position).Magnitude
                })
            end
        end
    end
    table.sort(v306, function(p316, p317)
        return p316.Distance < p317.Distance
    end)
    return v306[1] and v306[1].Player or nil
end
local function vu324(p319)
    if not (p319 and p319.Character) then
        return false
    end
    local v320 = p319.Character:FindFirstChild("Humanoid")
    if not v320 or v320.Health <= 0 then
        return false
    end
    if not vu305() then
        return false
    end
    local v321 = p319.Character:FindFirstChild("HumanoidRootPart")
    local v322 = vu5.Character:FindFirstChild("HumanoidRootPart")
    if v321 and v322 then
        v322.CFrame = CFrame.new(v321.Position + (v322.Position - v321.Position).Unit * 2, v321.Position)
    end
    local v323 = vu5.Character:FindFirstChild("Knife")
    if not (v323 and v323:FindFirstChild("Stab")) then
        return false
    end
    for _ = 1, 3 do
        v323.Stab:FireServer("Down")
    end
    return true
end
local function vu327()
    if not vu297 then
        vu297 = true
        local function v326()
            while vu297 do
                local v325 = vu318()
                if not v325 then
                    vu297 = false
                    break
                end
                vu324(v325)
                task.wait(vu298)
            end
        end
        task.spawn(v326)
    end
end
local function vu328()
    vu297 = false
end
local vu329 = "Default"
local v330 = vu19:Section({
    Title = v15("Trav Functions", vu7.Pumpkin, vu7.Purple),
    Icon = "flame",
    Opened = true
})
local v331 = v330:Tab({
    Title = "ESP",
    Icon = "eye"
})
v331:Section({
    Title = "Player ESP Settings",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})
v331:Toggle({
    Flag = "HighlightESP",
    Title = "Highlight ESP",
    Desc = "Enable player highlighting (shows all by default)",
    Default = true,
    Callback = function(p332)
        vu44 = p332
        if p332 then
            vu43 = {
                "Esp All"
            }
        end
        vu89()
    end
})
v331:Space()
v331:Dropdown({
    Flag = "ESPOptions",
    Title = "Filter ESP",
    Desc = "Filter which players to highlight",
    Values = {
        {
            Title = "Esp All",
            Icon = "users"
        },
        {
            Title = "Esp Sheriff",
            Icon = "shield"
        },
        {
            Title = "Esp Murder",
            Icon = "knife"
        },
        {
            Title = "Esp Sheriff / Murder",
            Icon = "target"
        }
    },
    Value = "Esp All",
    Callback = function(p333)
        vu43 = {
            p333.Title
        }
        vu89()
    end
})
v331:Space()
v331:Toggle({
    Flag = "LineESP",
    Title = "Line ESP (Tracers)",
    Desc = "Draw lines to players",
    Default = false,
    Callback = function(p334)
        vu45 = p334
        if not p334 then
            local v335, v336, v337 = pairs(vu46)
            while true do
                local v338
                v337, v338 = v335(v336, v337)
                if v337 == nil then
                    break
                end
                v338:Remove()
            end
            vu46 = {}
        end
        vu89()
    end
})
local v339 = v330:Tab({
    Title = v15("Auto Farm", vu7.Pumpkin, vu7.DarkOrange),
    Icon = "trending-up"
})
v339:Section({
    Title = "Coin & Candy Collection",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})
v339:Toggle({
    Flag = "CoinAutofarm",
    Title = "Coin Autofarm",
    Desc = "Automatically collect coins from the map",
    Default = false,
    Callback = function(p340)
        vu20 = p340
        if p340 then
            vu25 = {}
            vu27 = 0
            vu18:Notify({
                Title = "Coin Autofarm",
                Content = "Coin farming started!",
                Icon = "dollar-sign",
                Duration = 3
            })
        else
            vu18:Notify({
                Title = "Coin Autofarm",
                Content = "Coin farming stopped",
                Icon = "x-circle",
                Duration = 3
            })
        end
    end
})
v339:Space()
v339:Toggle({
    Flag = "CandyAutofarm",
    Title = "Candy Autofarm",
    Desc = "Collect Halloween candy for event rewards",
    Default = false,
    Callback = function(p341)
        vu21 = p341
        if p341 then
            vu25 = {}
            vu27 = 0
            vu18:Notify({
                Title = "Candy Autofarm",
                Content = "Candy farming started!",
                Icon = "candy",
                Duration = 3
            })
        else
            vu18:Notify({
                Title = "Candy Autofarm",
                Content = "Candy farming stopped",
                Icon = "x-circle",
                Duration = 3
            })
        end
    end
})
v339:Space()
v339:Toggle({
    Flag = "AutoEndRound",
    Title = "Auto Reset Character",
    Desc = "Automatically reset character when bag is full",
    Default = false,
    Callback = function(p342)
        vu22 = p342
        vu23 = p342
        print("[DEBUG] Auto Reset Character toggle changed to:", p342)
        print("[DEBUG] autoEndRound is now:", vu22)
        print("[DEBUG] flingMurdererOnFull is now:", vu23)
        if p342 then
            vu18:Notify({
                Title = "Auto Reset Character",
                Content = "Will reset character at " .. vu29 .. " candy",
                Icon = "refresh-cw",
                Duration = 3
            })
        else
            vu18:Notify({
                Title = "Auto Reset Character",
                Content = "Auto reset character disabled",
                Icon = "x-circle",
                Duration = 3
            })
        end
    end
})
v339:Space()
v339:Toggle({
    Flag = "AutoFlingMurderer",
    Title = "Auto Fling Murderer",
    Desc = "Automatically fling murderer when bag is full",
    Default = false,
    Callback = function(p343)
        vu24 = p343
        print("[DEBUG] Auto Fling Murderer toggle changed to:", p343)
        if p343 then
            vu18:Notify({
                Title = "Auto Fling Murderer",
                Content = "Will fling murderer at " .. vu29 .. " candy",
                Icon = "zap",
                Duration = 3
            })
        else
            vu18:Notify({
                Title = "Auto Fling Murderer",
                Content = "Auto fling murderer disabled",
                Icon = "x-circle",
                Duration = 3
            })
        end
    end
})
v339:Space()
v339:Slider({
    Flag = "FlySpeed",
    Title = "Autofarm Speed",
    Desc = "Adjust collection speed",
    Step = 1,
    Value = {
        Min = 5,
        Max = 50,
        Default = 25
    },
    Callback = function(p344)
        vu26 = p344
    end
})
v339:Space()
v339:Section({
    Title = "\226\154\160\239\184\143 Recommended: 25, higher will probably get you kicked",
    TextSize = 14,
    TextTransparency = 0.3,
    FontWeight = Enum.FontWeight.Medium
})
v339:Space()
v339:Button({
    Title = "Reset Counter",
    Icon = "refresh-cw",
    Justify = "Center",
    Callback = function()
        vu27 = 0
        vu25 = {}
        vu28 = 0
        vu18:Notify({
            Title = "Counter Reset",
            Content = "Collection counter reset!",
            Icon = "check-circle",
            Duration = 3
        })
    end
})
v339:Space()
v339:Button({
    Title = "Fling Murderer",
    Icon = "zap",
    Color = vu7.Blood,
    Justify = "Center",
    Callback = function()
        vu151()
    end
})
v339:Space()
v339:Button({
    Title = "Enable Anti-AFK",
    Icon = "moon",
    Color = vu7.Midnight,
    Justify = "Center",
    Callback = function()
        if pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/hassanxzayn-lua/Anti-afk/main/antiafkbyhassanxzyn"))()
        end) then
            vu18:Notify({
                Title = "Anti-AFK",
                Content = "Anti-AFK enabled!",
                Icon = "check-circle",
                Duration = 3
            })
        else
            vu18:Notify({
                Title = "Anti-AFK Error",
                Content = "Failed to load Anti-AFK!",
                Icon = "x-circle",
                Duration = 5
            })
        end
    end
})
local v345 = v330:Tab({
    Title = "Character",
    Icon = "user"
})
v345:Section({
    Title = "Movement Settings",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})
v345:Slider({
    Flag = "WalkSpeed",
    Title = "Walk Speed",
    Desc = "Adjust your walking speed",
    Step = 1,
    Value = {
        Min = 0,
        Max = 200,
        Default = 16
    },
    Callback = function(p346)
        vu52.WalkSpeed.Value = p346
        vu91()
    end
})
v345:Space()
v345:Toggle({
    Flag = "BlockWalkSpeed",
    Title = "Lock Walk Speed",
    Desc = "Prevent walkspeed changes",
    Default = false,
    Callback = function(p347)
        vu52.WalkSpeed.Locked = p347
    end
})
v345:Space()
v345:Slider({
    Flag = "JumpPower",
    Title = "Jump Power",
    Desc = "Adjust your jump height",
    Step = 1,
    Value = {
        Min = 0,
        Max = 200,
        Default = 50
    },
    Callback = function(p348)
        vu52.JumpPower.Value = p348
        vu91()
    end
})
v345:Space()
v345:Toggle({
    Flag = "BlockJumpPower",
    Title = "Lock Jump Power",
    Desc = "Prevent jump power changes",
    Default = false,
    Callback = function(p349)
        vu52.JumpPower.Locked = p349
    end
})
v345:Space()
v345:Button({
    Title = "Reset to Default",
    Icon = "rotate-ccw",
    Color = vu7.Orange,
    Justify = "Center",
    Callback = function()
        vu52.WalkSpeed.Value = 16
        vu52.JumpPower.Value = 50
        vu91()
        vu18:Notify({
            Title = "Character Reset",
            Content = "Settings reset to default!",
            Icon = "check-circle",
            Duration = 3
        })
    end
})
local v350 = v330:Tab({
    Title = "Teleport",
    Icon = "move"
})
v350:Section({
    Title = "Player Teleportation",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})
local vu351 = nil
local function vu358()
    local v352 = vu2
    local v353, v354, v355 = pairs(v352:GetPlayers())
    local v356 = {}
    while true do
        local v357
        v355, v357 = v353(v354, v355)
        if v355 == nil then
            break
        end
        if v357 ~= vu5 then
            table.insert(v356, {
                Title = v357.Name,
                Icon = "user"
            })
        end
    end
    return v356
end
local vu360 = v350:Dropdown({
    Flag = "TeleportPlayer",
    Title = "Select Player",
    Desc = "Choose a player to teleport to",
    Values = vu358(),
    Callback = function(p359)
        vu351 = vu2:FindFirstChild(p359.Title)
    end
})
v350:Space()
v350:Button({
    Title = "Teleport to Player",
    Icon = "zap",
    Color = vu7.Purple,
    Justify = "Center",
    Callback = function()
        if vu351 and vu351.Character then
            local v361 = vu351.Character:FindFirstChild("HumanoidRootPart")
            local v362 = vu5.Character:FindFirstChild("HumanoidRootPart")
            if v361 and v362 then
                v362.CFrame = v361.CFrame
                vu18:Notify({
                    Title = "Teleport Success",
                    Content = "Teleported to " .. vu351.Name,
                    Icon = "check-circle",
                    Duration = 3
                })
            end
        else
            vu18:Notify({
                Title = "Teleport Error",
                Content = "Target not found!",
                Icon = "x-circle",
                Duration = 3
            })
        end
    end
})
v350:Space()
v350:Button({
    Title = "Refresh Player List",
    Icon = "refresh-cw",
    Justify = "Center",
    Callback = function()
        vu360:Refresh(vu358())
        vu18:Notify({
            Title = "Players Updated",
            Content = "Player list refreshed!",
            Icon = "check-circle",
            Duration = 2
        })
    end
})
v350:Space({
    Columns = 2
})
v350:Section({
    Title = "Role Teleportation",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})
v350:Button({
    Title = "Teleport to Murderer",
    Icon = "knife",
    Color = vu7.Blood,
    Justify = "Center",
    Callback = function()
        local v363 = vu2
        local v364, v365, v366 = ipairs(v363:GetPlayers())
        local v367 = nil
        while true do
            local v368
            v366, v368 = v364(v365, v366)
            if v366 == nil then
                v368 = v367
                break
            end
            if v368 ~= vu5 and v368.Character then
                if v368.Character:FindFirstChild("Knife") then
                    break
                end
                local v369 = v368:FindFirstChild("Backpack")
                if v369 and v369:FindFirstChild("Knife") then
                    break
                end
            end
        end
        if v368 and v368.Character then
            local v370 = v368.Character:FindFirstChild("HumanoidRootPart")
            local v371 = vu5.Character:FindFirstChild("HumanoidRootPart")
            if v370 and v371 then
                v371.CFrame = v370.CFrame
                vu18:Notify({
                    Title = "Teleport Success",
                    Content = "Teleported to murderer: " .. v368.Name,
                    Icon = "check-circle",
                    Duration = 3
                })
            end
        else
            vu18:Notify({
                Title = "Teleport Error",
                Content = "No murderer found!",
                Icon = "x-circle",
                Duration = 3
            })
        end
    end
})
v350:Space()
v350:Button({
    Title = "Teleport to Sheriff",
    Icon = "shield",
    Color = vu7.Toxic,
    Justify = "Center",
    Callback = function()
        local v372 = vu2
        local v373, v374, v375 = ipairs(v372:GetPlayers())
        local v376 = nil
        while true do
            local v377
            v375, v377 = v373(v374, v375)
            if v375 == nil then
                v377 = v376
                break
            end
            if v377 ~= vu5 and v377.Character then
                if v377.Character:FindFirstChild("Gun") then
                    break
                end
                local v378 = v377:FindFirstChild("Backpack")
                if v378 and v378:FindFirstChild("Gun") then
                    break
                end
            end
        end
        if v377 and v377.Character then
            local v379 = v377.Character:FindFirstChild("HumanoidRootPart")
            local v380 = vu5.Character:FindFirstChild("HumanoidRootPart")
            if v379 and v380 then
                v380.CFrame = v379.CFrame
                vu18:Notify({
                    Title = "Teleport Success",
                    Content = "Teleported to sheriff: " .. v377.Name,
                    Icon = "check-circle",
                    Duration = 3
                })
            end
        else
            vu18:Notify({
                Title = "Teleport Error",
                Content = "No sheriff found!",
                Icon = "x-circle",
                Duration = 3
            })
        end
    end
})
local v381 = v330:Tab({
    Title = "Weapon Spawner",
    Icon = "sword"
})
v381:Section({
    Title = "Spawn Weapons",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})
local vu382 = ""
v381:Input({
    Flag = "WeaponName",
    Title = "Weapon Name",
    Desc = "Enter the name of the weapon",
    Placeholder = "e.g., CandyBlade, Raygun",
    Callback = function(p383)
        vu382 = p383
    end
})
v381:Space()
v381:Button({
    Title = "Spawn Weapon",
    Icon = "sparkles",
    Color = vu7.Orange,
    Justify = "Center",
    Callback = function()
        if vu382 == "" then
            vu18:Notify({
                Title = "Error",
                Content = "Please enter a weapon name!",
                Icon = "x-circle",
                Duration = 3
            })
        else
            vu265(vu382)
        end
    end
})
v381:Space({
    Columns = 2
})
v381:Section({
    Title = "Quick Spawn Godlies",
    TextSize = 16,
    FontWeight = Enum.FontWeight.SemiBold
})
v381:Button({
    Title = "Spawn Raygun (Battlepass)",
    Icon = "zap",
    Color = vu7.Toxic,
    Callback = function()
        vu265("Raygun")
    end
})
v381:Space()
v381:Button({
    Title = "Spawn XenoKnife",
    Icon = "knife",
    Color = vu7.Blood,
    Callback = function()
        vu265("XenoKnife")
    end
})
v381:Space()
v381:Button({
    Title = "Spawn XenoGun",
    Icon = "crosshair",
    Color = vu7.DarkPurple,
    Callback = function()
        vu265("XenoGun")
    end
})
local v384 = v330:Tab({
    Title = "Weapon Dupe",
    Icon = "copy"
})
v384:Section({
    Title = "Single Weapon Duplication",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})
v384:Input({
    Flag = "DupeWeaponName",
    Title = "Weapon Name",
    Desc = "Enter weapon to duplicate",
    Placeholder = "e.g., Lightbringer",
    Callback = function(p385)
        vu47 = p385
    end
})
v384:Space()
v384:Input({
    Flag = "DupeAmount",
    Title = "Dupe Amount",
    Desc = "How many times to duplicate",
    Placeholder = "e.g., 5",
    Value = "1",
    Callback = function(p386)
        vu48 = tonumber(p386) or 1
    end
})
v384:Space()
v384:Button({
    Title = "Start Duplication",
    Icon = "layers",
    Color = vu7.DarkOrange,
    Justify = "Center",
    Callback = function()
        if vu47 ~= "" then
            vu18:Notify({
                Title = "Weapon Dupe",
                Content = "Duplicating " .. vu47 .. " " .. vu48 .. " times...",
                Icon = "loader",
                Duration = 3
            })
            for _ = 1, vu48 do
                vu227()
            end
            vu18:Notify({
                Title = "Dupe Complete",
                Content = "Successfully duplicated " .. vu47 .. "!",
                Icon = "check-circle",
                Duration = 5
            })
        else
            vu18:Notify({
                Title = "Weapon Dupe Error",
                Content = "Please enter a weapon name!",
                Icon = "x-circle",
                Duration = 5
            })
        end
    end
})
v384:Space({
    Columns = 3
})
v384:Section({
    Title = "Inventory Duplication",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})
v384:Button({
    Title = "Dupe Entire Inventory",
    Icon = "package",
    Color = vu7.Witch,
    Justify = "Center",
    Callback = function()
        vu18:Notify({
            Title = "Inventory Dupe",
            Content = "Duplicating entire inventory...",
            Icon = "loader",
            Duration = 3
        })
        vu250()
        vu18:Notify({
            Title = "Inventory Dupe Complete",
            Content = "Successfully duplicated inventory!",
            Icon = "check-circle",
            Duration = 5
        })
    end
})
local v387 = v330:Tab({
    Title = "Weapons Replacer",
    Icon = "eye-off"
})
v387:Section({
    Title = "Change Weapon Appearance",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})
v387:Input({
    Flag = "FromWeapon",
    Title = "Weapon to Replace",
    Desc = "Current weapon you have",
    Placeholder = "e.g., Blossom",
    Callback = function(p388)
        vu49 = p388
    end
})
v387:Space()
v387:Input({
    Flag = "ToWeapon",
    Title = "Weapon to Receive",
    Desc = "Weapon appearance you want",
    Placeholder = "e.g., Chroma",
    Callback = function(p389)
        vu50 = p389
    end
})
v387:Space()
v387:Button({
    Title = "Change Visual",
    Icon = "wand-2",
    Color = vu7.Purple,
    Justify = "Center",
    Callback = function()
        if vu49 == "" or vu50 == "" then
            vu18:Notify({
                Title = "Visual Weapons Error",
                Content = "Please enter both weapon names!",
                Icon = "x-circle",
                Duration = 5
            })
        elseif not pcall(function()
            local v390 = require(game:GetService("ReplicatedStorage").Database.Sync.Item)
            local v391, v392, v393 = pairs(v390)
            local v394 = {}
            local v395 = {}
            while true do
                local v396
                v393, v396 = v391(v392, v393)
                if v393 == nil then
                    break
                end
                if vu253(v393, vu49) then
                    table.insert(v395, v393)
                end
                if vu253(v393, vu50) then
                    table.insert(v394, v393)
                end
            end
            if # v395 <= 0 or # v394 <= 0 then
                vu18:Notify({
                    Title = "Visual Error",
                    Content = "Weapon not found!",
                    Icon = "x-circle",
                    Duration = 5
                })
            else
                local v397, v398, v399 = ipairs(v395)
                while true do
                    local v400
                    v399, v400 = v397(v398, v399)
                    if v399 == nil then
                        break
                    end
                    local v401, v402, v403 = ipairs(v394)
                    while true do
                        local v404
                        v403, v404 = v401(v402, v403)
                        if v403 == nil then
                            break
                        end
                        v390[v400] = {}
                        local v405, v406, v407 = pairs(v390[v404])
                        while true do
                            local v408
                            v407, v408 = v405(v406, v407)
                            if v407 == nil then
                                break
                            end
                            v390[v400][v407] = v408
                        end
                        game:GetService("ReplicatedStorage").Remotes.Inventory.Equip:FireServer(v404)
                    end
                end
                vu18:Notify({
                    Title = "Visual Success",
                    Content = "Weapon visual changed!",
                    Icon = "check-circle",
                    Duration = 5
                })
            end
        end) then
            vu18:Notify({
                Title = "Visual Error",
                Content = "Failed to change visual!",
                Icon = "x-circle",
                Duration = 5
            })
        end
    end
})
local v409 = v330:Tab({
    Title = "Trade Scam",
    Icon = "shield-alert"
})
v409:Section({
    Title = "Visual Trade Protection",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})
local vu410 = false
v409:Toggle({
    Flag = "VisualTrade",
    Title = "Enable Visual Trade",
    Desc = "Make items in trade appear visual only",
    Default = false,
    Callback = function(p411)
        vu410 = p411
        vu18:Notify({
            Title = "Visual Trade",
            Content = p411 and "Visual Trade Enabled!" or "Visual Trade Disabled!",
            Icon = p411 and "shield-check" or "shield-off",
            Duration = 3
        })
    end
})
v409:Space()
v409:Button({
    Title = "Activate Visual Trade",
    Icon = "alert-triangle",
    Color = vu7.Blood,
    Justify = "Center",
    Callback = function()
        if vu410 then
            vu254()
        else
            vu18:Notify({
                Title = "Error",
                Content = "Enable Visual Trade first!",
                Icon = "x-circle",
                Duration = 5
            })
        end
    end
})
local v412 = v330:Tab({
    Title = "Utilities",
    Icon = "wrench"
})
v412:Section({
    Title = "Server Utilities",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})
v412:Button({
    Title = "Enable Anti-AFK",
    Icon = "moon",
    Color = vu7.Midnight,
    Justify = "Center",
    Callback = function()
        if pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/hassanxzayn-lua/Anti-afk/main/antiafkbyhassanxzyn"))()
        end) then
            vu18:Notify({
                Title = "Anti-AFK",
                Content = "Anti-AFK enabled!",
                Icon = "check-circle",
                Duration = 3
            })
        else
            vu18:Notify({
                Title = "Anti-AFK Error",
                Content = "Failed to load Anti-AFK!",
                Icon = "x-circle",
                Duration = 5
            })
        end
    end
})
v412:Space()
v412:Button({
    Title = "Server Lagger",
    Icon = "zap",
    Color = vu7.Blood,
    Justify = "Center",
    Callback = function()
        vu18:Notify({
            Title = "Server Lagger",
            Content = "Lagging server... Risk of disconnect!",
            Icon = "alert-triangle",
            Duration = 5
        })
        pcall(function()
            local v413 = game:GetService("ReplicatedStorage").GetSyncData
            local v414 = v413.InvokeServer
            local v415 = task.spawn
            local v416 = 0
            while true do
                for _ = 1, 1 do
                    v415(v414, v413)
                end
                v416 = v416 + 1
                if v416 == 3 then
                    wait(0)
                    v416 = 0
                end
            end
        end)
    end
})
local v417 = v330:Tab({
    Title = v15("Innocent", vu7.Innocent, vu7.Innocent),
    Icon = "user-check"
})
v417:Section({
    Title = "Gun System",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})
v417:Toggle({
    Flag = "AutoGrabGun",
    Title = "Auto Grab Gun",
    Desc = "Automatically collect dropped gun",
    Default = false,
    Callback = function(p418)
        vu266.AutoGrabEnabled = p418
        if p418 then
            coroutine.wrap(vu296)()
            vu18:Notify({
                Title = "Auto Grab Gun",
                Content = "Auto grab enabled!",
                Icon = "check-circle",
                Duration = 3
            })
        else
            vu18:Notify({
                Title = "Auto Grab Gun",
                Content = "Auto grab disabled",
                Icon = "x-circle",
                Duration = 3
            })
        end
    end
})
v417:Space()
v417:Button({
    Title = "Grab Gun Manually",
    Icon = "hand",
    Color = vu7.Toxic,
    Justify = "Center",
    Callback = function()
        vu286()
    end
})
v417:Space()
v417:Toggle({
    Flag = "NotifyGunDrop",
    Title = "Notify Gun Drop",
    Desc = "Get notified when gun drops",
    Default = true,
    Callback = function(p419)
        vu266.NotifyGunDrop = p419
    end
})
local v420 = v330:Tab({
    Title = v15("Murder", vu7.Blood, vu7.Murder),
    Icon = "skull"
})
v420:Section({
    Title = "Kill Functions",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})
v420:Toggle({
    Flag = "KillAll",
    Title = "Kill All Players",
    Desc = "Automatically attack nearby targets",
    Default = false,
    Callback = function(p421)
        if p421 then
            vu327()
            vu18:Notify({
                Title = "Kill All",
                Content = "Attack sequence started!",
                Icon = "skull",
                Duration = 2
            })
        else
            vu328()
            vu18:Notify({
                Title = "Kill All",
                Content = "Attack stopped",
                Icon = "x-circle",
                Duration = 2
            })
        end
    end
})
v420:Space()
v420:Slider({
    Flag = "AttackDelay",
    Title = "Attack Delay",
    Desc = "Time between attacks",
    Step = 0.1,
    Value = {
        Min = 0.1,
        Max = 2,
        Default = 0.5
    },
    Callback = function(p422)
        vu298 = p422
    end
})
v420:Space()
v420:Button({
    Title = "Equip Knife",
    Icon = "knife",
    Color = vu7.Blood,
    Justify = "Center",
    Callback = function()
        if vu305() then
            vu18:Notify({
                Title = "Knife Equipped",
                Content = "Knife is ready!",
                Icon = "check-circle",
                Duration = 2
            })
        else
            vu18:Notify({
                Title = "Error",
                Content = "No knife found!",
                Icon = "x-circle",
                Duration = 2
            })
        end
    end
})
local vu423 = nil
local v424 = v330:Tab({
    Title = v15("Sherrif", vu7.Sherrif, vu7.Sherrif),
    Icon = "shield"
})
v424:Section({
    Title = "Shooting Functions",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})
v424:Dropdown({
    Flag = "ShotType",
    Title = "Shot Type",
    Desc = "Choose shooting method",
    Values = {
        {
            Title = "Default",
            Icon = "target"
        },
        {
            Title = "Teleport",
            Icon = "zap"
        }
    },
    Value = "Default",
    Callback = function(p425)
        vu329 = p425.Title
        vu18:Notify({
            Title = "Shot Type",
            Content = "Set to: " .. p425.Title,
            Icon = "check-circle",
            Duration = 2
        })
    end
})
v424:Space()
v424:Toggle({
    Title = "Shoot Murderer",
    Icon = "crosshair",
    Color = vu7.Toxic,
    Justify = "Center",
    Callback = function(p426)
        local v427 = game:GetService("CoreGui")
        if p426 then
            if not v427:FindFirstChild("GunW") then
                local v428 = Instance.new("ScreenGui", v427)
                v428.Name = "GunW"
                local v429 = Instance.new("TextButton", v428)
                v429.Draggable = true
                v429.Size = UDim2.new(0, 200, 0, 100)
                v429.Position = UDim2.new(0.5, - 100, 0.5, 0)
                v429.TextStrokeTransparency = 0
                v429.BackgroundTransparency = 0.2
                v429.BackgroundColor3 = Color3.fromRGB(44, 44, 45)
                v429.BorderColor3 = Color3.new(1, 1, 1)
                v429.Text = "Shoot Murder"
                v429.TextColor3 = Color3.new(1, 1, 1)
                v429.TextSize = 20
                v429.Visible = true
                v429.AnchorPoint = Vector2.new(0.5, 0.5)
                v429.Active = true
                v429.TextWrapped = true
                Instance.new("UICorner", v429)
                local v430 = Instance.new("UIStroke", v429)
                v430.Color = Color3.new(0, 0, 0)
                v430.Thickness = 4
                v430.Transparency = 0.4
                v429.MouseButton1Click:Connect(function()
                    if vu5.Character and vu5.Character:FindFirstChild("Gun") then
                        pcall(function()
                            vu5.Character.Gun.KnifeLocal.CreateBeam.RemoteFunction:InvokeServer(1, getMurdererTarget(), "AH2")
                        end)
                    end
                end)
                vu423 = v428
            end
        elseif v427:FindFirstChild("GunW") then
            v427:FindFirstChild("GunW"):Destroy()
        end
    end
})
local v431 = v330:Tab({
    Title = "Settings",
    Icon = "settings"
})
v431:Section({
    Title = "GUI Settings",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})
v431:Keybind({
    Flag = "GUIKeybind",
    Title = "GUI Toggle Key",
    Desc = "Press to open/close GUI",
    Value = "G",
    Callback = function(p432)
        vu19:SetToggleKey(Enum.KeyCode[p432])
        vu18:Notify({
            Title = "Keybind Set",
            Content = "GUI toggle key: " .. p432,
            Icon = "keyboard",
            Duration = 3
        })
    end
})
v431:Space({
    Columns = 2
})
v431:Section({
    Title = "Config Management",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})
local vu433 = "default"
local vu434 = vu19.ConfigManager
local vu436 = v431:Input({
    Flag = "ConfigName",
    Title = "Config Name",
    Desc = "Name for your configuration",
    Icon = "file",
    Value = vu433,
    Callback = function(p435)
        vu433 = p435
    end
})
v431:Space()
local v437 = vu434:AllConfigs()
v431:Dropdown({
    Flag = "ConfigSelect",
    Title = "Load Config",
    Desc = "Select existing configuration",
    Values = v437,
    Value = table.find(v437, vu433) and vu433 and vu433 or nil,
    Callback = function(p438)
        vu433 = p438
        vu436:Set(p438)
    end
})
v431:Space()
v431:Button({
    Title = "Save Config",
    Icon = "save",
    Color = vu7.Toxic,
    Justify = "Center",
    Callback = function()
        vu19.CurrentConfig = vu434:CreateConfig(vu433)
        if vu19.CurrentConfig:Save() then
            vu18:Notify({
                Title = "Config Saved",
                Content = "Saved as \'" .. vu433 .. "\'",
                Icon = "check",
                Duration = 3
            })
        end
    end
})
v431:Space()
v431:Button({
    Title = "Load Config",
    Icon = "upload",
    Color = vu7.Purple,
    Justify = "Center",
    Callback = function()
        vu19.CurrentConfig = vu434:CreateConfig(vu433)
        if vu19.CurrentConfig:Load() then
            vu18:Notify({
                Title = "Config Loaded",
                Content = "Loaded \'" .. vu433 .. "\'",
                Icon = "refresh-cw",
                Duration = 3
            })
        end
    end
})
local v439 = v330:Tab({
    Title = "Info & Socials",
    Icon = "info"
})
v439:Section({
    Title = "TravHub",
    TextSize = 20,
    FontWeight = Enum.FontWeight.Bold
})
v439:Space()
v439:Section({
    Title = "Enhanced MM2 script with comprehensive features including ESP, auto-farming, weapon duplication, role-specific functions, and much more! Perfect for Murder Mystery 2 players looking for an edge.",
    TextSize = 16,
    TextTransparency = 0.3,
    FontWeight = Enum.FontWeight.Medium
})
v439:Space({
    Columns = 3
})
v439:Section({
    Title = "Features",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})
v439:Space()
v439:Section({
    Title = "Player ESP \226\128\162 Auto Farm \226\128\162 Character Mods \226\128\162 Teleportation \226\128\162 Weapon Spawner \226\128\162 Weapon Duplication \226\128\162 Visual Weapons \226\128\162 Trade Scam \226\128\162 Role Functions \226\128\162 Anti-AFK \226\128\162 Server Utilities",
    TextSize = 15,
    TextTransparency = 0.4,
    FontWeight = Enum.FontWeight.Medium
})
v439:Space({
    Columns = 3
})
v439:Section({
    Title = "Community & Support",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})
v439:Button({
    Title = "Copy Discord Invite",
    Icon = "message-circle",
    Color = vu7.DarkPurple,
    Justify = "Center",
    Callback = function()
        setclipboard("https://discord.gg/pNfrgHeede")
        vu18:Notify({
            Title = "Discord",
            Content = "Invite copied to clipboard!",
            Icon = "check-circle",
            Duration = 3
        })
    end
})
v439:Space()
v439:Button({
    Title = "Other Scripts",
    Icon = "message-circle",
    Color = vu7.Toxic,
    Justify = "Center",
    Callback = function()
        setclipboard("https://xysfhub.github.io/")
        vu18:Notify({
            Title = "More Scripts",
            Content = "ADM - SAB - GAG Scripts link copied!",
            Icon = "check-circle",
            Duration = 3
        })
    end
})
v439:Space()
v439:Button({
    Title = "YouTube Channel",
    Icon = "youtube",
    Color = vu7.Blood,
    Justify = "Center",
    Callback = function()
        setclipboard("https://www.youtube.com/@xysf")
        vu18:Notify({
            Title = "YouTube",
            Content = "Channel link copied!",
            Icon = "check-circle",
            Duration = 3
        })
    end
})
v439:Space()
v439:Button({
    Title = "TikTok Profile",
    Icon = "music",
    Color = vu7.Pumpkin,
    Justify = "Center",
    Callback = function()
        setclipboard("https://tiktok.com/@xysf_rblx")
        vu18:Notify({
            Title = "TikTok",
            Content = "Profile link copied!",
            Icon = "check-circle",
            Duration = 3
        })
    end
})
vu89()
v3.RenderStepped:Connect(function()
    if vu45 then
        local v440, v441, v442 = pairs(vu46)
        while true do
            local v443
            v442, v443 = v440(v441, v442)
            if v442 == nil then
                break
            end
            if v442.Character and v442.Character:FindFirstChild("HumanoidRootPart") then
                local v444 = v442.Character.HumanoidRootPart
                local v445, v446 = workspace.CurrentCamera:WorldToViewportPoint(v444.Position)
                local v447 = workspace.CurrentCamera.ViewportSize
                if v446 then
                    v443.From = Vector2.new(v447.X / 2, v447.Y)
                    v443.To = Vector2.new(v445.X, v445.Y)
                    v443.Visible = true
                else
                    v443.Visible = false
                end
            else
                v443.Visible = false
            end
        end
    end
end)
local v448, v449, v450 = ipairs(vu2:GetPlayers())
local vu451 = vu296
local vu452 = vu266
local vu453 = vu275
local function v457(pu454)
    pu454.CharacterAdded:Connect(function()
        local v455 = pu454:WaitForChild("Backpack")
        v455.ChildAdded:Connect(vu89)
        v455.ChildRemoved:Connect(vu89)
        vu89()
    end)
    local v456 = pu454.Character and pu454:FindFirstChild("Backpack")
    if v456 then
        v456.ChildAdded:Connect(vu89)
        v456.ChildRemoved:Connect(vu89)
    end
end
while true do
    local v458
    v450, v458 = v448(v449, v450)
    if v450 == nil then
        break
    end
    v457(v458)
end
vu2.PlayerAdded:Connect(v457)
vu2.PlayerRemoving:Connect(function(p459)
    if p459 == vu5 then
        local v460, v461, v462 = pairs(vu46)
        while true do
            local v463
            v462, v463 = v460(v461, v462)
            if v462 == nil then
                break
            end
            if v463 then
                v463:Remove()
            end
        end
        vu46 = {}
    end
end)
task.spawn(function()
    if not vu5.Character then
        vu5.CharacterAdded:Wait()
    end
    vu453()
    if vu452.AutoGrabEnabled then
        coroutine.wrap(vu451)()
    end
end)
vu19:SetToggleKey(Enum.KeyCode.G)
vu19.CurrentConfig = vu19.ConfigManager:CreateConfig("default")
vu19.CurrentConfig:Save()
vu18:Notify({
    Title = v15("TravHub Loaded!", vu7.Pumpkin, vu7.Purple),
    Content = "Welcome to the Christmas Edition! Press G to toggle GUI.",
    Icon = "skull",
    Duration = 5
})
task.spawn(function()
    task.wait(5)
    setclipboard("https://discord.gg/pNfrgHeede")
    vu18:Notify({
        Title = "Discord Copied!",
        Content = "Join our community! Link copied to clipboard.",
        Icon = "message-circle",
        Duration = 4
    })
end)
