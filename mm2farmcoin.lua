local MainGui = {};

--// MainGui["1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
MainGui["1"] = Instance.new("ScreenGui", gethui()); --// change to gethui
MainGui["1"]["IgnoreGuiInset"] = true;
MainGui["1"]["DisplayOrder"] = 999999999;
MainGui["1"]["ScreenInsets"] = Enum.ScreenInsets.DeviceSafeInsets;
MainGui["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;

MainGui["2"] = Instance.new("ImageLabel", MainGui["1"]);
MainGui["2"]["BorderSizePixel"] = 0;
MainGui["2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
MainGui["2"]["Image"] = [[rbxassetid://130647873334585]];
MainGui["2"]["Size"] = UDim2.new(0, 498, 0, 339);
MainGui["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
MainGui["2"]["BackgroundTransparency"] = 1;
MainGui["2"]["Position"] = UDim2.new(0.18619, 0, 0.25468, 0);

MainGui["3"] = Instance.new("TextLabel", MainGui["2"]);
MainGui["3"]["TextWrapped"] = true;
MainGui["3"]["BorderSizePixel"] = 0;
MainGui["3"]["TextSize"] = 25;
MainGui["3"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
MainGui["3"]["Font"] = Enum.Font.GothamBold;
MainGui["3"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
MainGui["3"]["BackgroundTransparency"] = 1;
MainGui["3"]["Size"] = UDim2.new(0, 93, 0, 22);
MainGui["3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
MainGui["3"]["Text"] = [[0]];
MainGui["3"]["Name"] = [[CoinsCollected]];
MainGui["3"]["Position"] = UDim2.new(0.60241, 0, 0.43068, 0);

MainGui["4"] = Instance.new("TextLabel", MainGui["2"]);
MainGui["4"]["TextWrapped"] = true;
MainGui["4"]["BorderSizePixel"] = 0;
MainGui["4"]["TextSize"] = 25;
MainGui["4"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
MainGui["4"]["Font"] = Enum.Font.GothamBold;
MainGui["4"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
MainGui["4"]["BackgroundTransparency"] = 1;
MainGui["4"]["Size"] = UDim2.new(0, 83, 0, 22);
MainGui["4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
MainGui["4"]["Text"] = [[0]];
MainGui["4"]["Name"] = [[CoinsPerHour]];
MainGui["4"]["Position"] = UDim2.new(0.61245, 0, 0.60177, 0);

MainGui["5"] = Instance.new("TextLabel", MainGui["2"]);
MainGui["5"]["TextWrapped"] = true;
MainGui["5"]["BorderSizePixel"] = 0;
MainGui["5"]["TextSize"] = 25;
MainGui["5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
MainGui["5"]["Font"] = Enum.Font.GothamBold;
MainGui["5"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
MainGui["5"]["BackgroundTransparency"] = 1;
MainGui["5"]["Size"] = UDim2.new(0, 88, 0, 22);
MainGui["5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
MainGui["5"]["Text"] = [[00:00]];
MainGui["5"]["Name"] = [[Timer]];
MainGui["5"]["Position"] = UDim2.new(0.61245, 0, 0.77581, 0);

local UserInputService = game:GetService("UserInputService")
local Dragging = false
local DragStart, StartPos

MainGui["2"].InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = input.Position
        StartPos = MainGui["2"].Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - DragStart
        MainGui["2"].Position = UDim2.new(
            StartPos.X.Scale,
            StartPos.X.Offset + delta.X,
            StartPos.Y.Scale,
            StartPos.Y.Offset + delta.Y
        )
    end
end)

local TweenService = game:GetService("TweenService")
local LP = game.Players.LocalPlayer
local Char = LP.Character or LP.CharacterAdded:Wait()
local HRP = Char:WaitForChild("HumanoidRootPart")
local Humanoid = Char:WaitForChild("Humanoid")

local IsFarming = false
local FarmingConnection = nil
local TimerThread = nil

local function GetMap()
    while true do
        for _, obj in ipairs(workspace:GetChildren()) do
            if obj:GetAttribute("MapID") and obj:FindFirstChild("CoinContainer") then
                return obj
            end
        end
        task.wait()
    end
end

local function GetNearest()
    local map = GetMap()
    local closest, dist = nil, math.huge
    for _, coin in ipairs(map.CoinContainer:GetChildren()) do
        local v = coin:FindFirstChild("CoinVisual")
        if v and not v:GetAttribute("Collected") then
            local d = (HRP.Position - coin.Position).Magnitude
            if d < dist then
                closest = coin
                dist = d
            end
        end
    end
    return closest
end

local function MoveToCoin(hp)
    Humanoid:ChangeState(11)
    local d = (HRP.Position - hp.Position).Magnitude
    local t = TweenService:Create(HRP, TweenInfo.new(d / 25, Enum.EasingStyle.Linear), {CFrame = hp.CFrame})
    t:Play()
    t.Completed:Wait()
end

local function StartFarming()
    if FarmingConnection then return end

    local CoinsCollected = 0
    local StartTime = os.time()
    MainGui["3"].Text = "0"
    MainGui["4"].Text = "0"
    MainGui["5"].Text = "00:00"

    TimerThread = task.spawn(function()
        while IsFarming do
            local elapsed = os.time() - StartTime
            local minutes = string.format("%02d", math.floor(elapsed / 60))
            local seconds = string.format("%02d", elapsed % 60)
            MainGui["5"].Text = minutes .. ":" .. seconds
            task.wait(1)
        end
    end)

    FarmingConnection = task.spawn(function()
        while IsFarming do
            local target = GetNearest()
            if target and LP:GetAttribute("Alive") then
                MoveToCoin(target)

                local v = target:FindFirstChild("CoinVisual")
                local collectedByUs = false

                if v and not v:GetAttribute("Collected") then
                    while v and not v:GetAttribute("Collected") and v.Parent and IsFarming do
                        if not LP:GetAttribute("Alive") then break end
                        local n = GetNearest()
                        if n and n ~= target then
                            break
                        end
                        task.wait()
                    end

                    if not v or not v.Parent or v:GetAttribute("Collected") then
                        collectedByUs = true
                    end
                end

                if collectedByUs then
                    CoinsCollected = CoinsCollected + 1
                    MainGui["3"].Text = tostring(CoinsCollected)
                end

                local elapsed = os.time() - StartTime
                if elapsed > 0 then
                    local cph = math.floor((CoinsCollected / elapsed) * 3600)
                    MainGui["4"].Text = tostring(cph)
                else
                    MainGui["4"].Text = "0"
                end
            else
                task.wait(0.5)
            end
        end
    end)
end

local function StopFarming()
    IsFarming = false
    if FarmingConnection then
        FarmingConnection = nil
    end
    if TimerThread then
        TimerThread = nil
    end
end

local function ToggleFarming()
    IsFarming = not IsFarming
    if IsFarming then
        StartFarming()
    else
        StopFarming()
    end
end

ToggleFarming()

MainGui["1"].AncestryChanged:Connect(function()
    if not MainGui["1"].Parent then
        StopFarming()
    end
end)

return MainGui["1"], require;
