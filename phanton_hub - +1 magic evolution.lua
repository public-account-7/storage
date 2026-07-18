if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Player = game.Players.LocalPlayer
local PlayerGui, UserInputService, RunService = Player:WaitForChild'PlayerGui', game:GetService'UserInputService', game:GetService'RunService'

game:GetService'ReplicatedStorage'

local VirtualUser, TeleportService, HttpService, TweenService, BASE_VIEWPORT_SIZE = game:GetService'VirtualUser', game:GetService'TeleportService', game:GetService'HttpService', game:GetService'TweenService', Vector2.new(1600, 720)

local function getResponsiveScale()
    local camera = workspace.CurrentCamera
    local viewportSize = camera and camera.ViewportSize or BASE_VIEWPORT_SIZE
    local scale = math.min(viewportSize.X / BASE_VIEWPORT_SIZE.X, viewportSize.Y / BASE_VIEWPORT_SIZE.Y)

    return math.clamp(scale, 0.85, 2.15)
end
local function rpx(value)
    if value == 0 then
        return 0
    end

    local scale, sign = getResponsiveScale(), value < 0 and -1 or 1

    return sign * math.max(1, math.floor(math.abs(value) * scale + 0.5))
end

local ALLOWED_GAME_IDS, currentGameId, gameIdCheckDone = {
    [116223724643557] = true,
    [140070560575882] = true,
}, game.PlaceId, false

if not ALLOWED_GAME_IDS[currentGameId] and not gameIdCheckDone then
    gameIdCheckDone = true

    local notificationScreenGui = Instance.new'ScreenGui'

    notificationScreenGui.Name = 'NotificationScreenGui'
    notificationScreenGui.ResetOnSpawn = false
    notificationScreenGui.DisplayOrder = 999999
    notificationScreenGui.Parent = PlayerGui

    local notificationGui = Instance.new'Frame'

    notificationGui.Name = 'NotificationGui'
    notificationGui.Size = UDim2.new(0.28, rpx(0), 0.15, rpx(0))
    notificationGui.Position = UDim2.new(0.71, rpx(0), 0.8, rpx(0))
    notificationGui.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    notificationGui.BorderSizePixel = 2
    notificationGui.BorderColor3 = Color3.fromRGB(128, 128, 128)
    notificationGui.Parent = notificationScreenGui

    local notificationLabel = Instance.new'TextLabel'

    notificationLabel.Name = 'NotificationLabel'
    notificationLabel.Size = UDim2.new(0.9, rpx(0), 0.898, rpx(0))
    notificationLabel.Position = UDim2.new(0.05, rpx(0), 0.06, rpx(0))
    notificationLabel.BackgroundTransparency = 1
    notificationLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    notificationLabel.TextSize = rpx(18)
    notificationLabel.Font = Enum.Font.Gotham
    notificationLabel.Text = 'This script only works in the correct game'
    notificationLabel.TextWrapped = true
    notificationLabel.TextXAlignment = Enum.TextXAlignment.Center
    notificationLabel.Parent = notificationGui

    local progressLine = Instance.new'Frame'

    progressLine.Name = 'ProgressLine'
    progressLine.Size = UDim2.new(1, rpx(0), 0.045, rpx(0))
    progressLine.Position = UDim2.new(0, rpx(0), 1, rpx(0))
    progressLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    progressLine.BorderSizePixel = 0
    progressLine.Parent = notificationGui

    local startTime, totalWidth, duration, progressConnection = tick(), 1, 2.25, nil

    progressConnection = RunService.RenderStepped:Connect(function()
        local elapsed = tick() - startTime
        local progress = math.min(elapsed / duration, 1)

        if notificationGui and notificationGui.Parent then
            progressLine.Size = UDim2.new(totalWidth * progress, rpx(0), 0.045, rpx(0))
        end
        if progress >= 1 then
            progressConnection:Disconnect()

            if notificationGui and notificationGui.Parent then
                local slideOutTween = TweenService:Create(notificationGui, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Position = UDim2.new(0.99, rpx(0), 0.8, rpx(0)),
                })

                slideOutTween:Play()
                slideOutTween.Completed:Connect(function()
                    if notificationGui then
                        notificationGui:Destroy()
                    end
                    if notificationScreenGui then
                        notificationScreenGui:Destroy()
                    end
                end)
            end
        end
    end)

    return
end

local fileName, savedSettings = 'Phantom_' .. tostring(Player.UserId) .. '.json', {}

if type(isfile) == 'function' and isfile(fileName) then
    local success, data = pcall(function()
        return HttpService:JSONDecode(readfile(fileName))
    end)

    if success and type(data) == 'table' then
        savedSettings = data
    end
end

local function saveSettings()
    if type(writefile) == 'function' then
        pcall(function()
            writefile(fileName, HttpService:JSONEncode(savedSettings))
        end)
    end
end

local optionStates = {}

local function createOptionState(name, initialValue)
    if savedSettings[name] ~= nil then
        optionStates[name] = savedSettings[name]
    else
        optionStates[name] = initialValue
    end

    return function()
        return optionStates[name]
    end
end
local function setOptionState(name, value)
    optionStates[name] = value
    savedSettings[name] = value

    saveSettings()
end
local function saveCurrentSettings()
    for name, value in pairs(optionStates)do
        if name ~= '_debounce' then
            savedSettings[name] = value
        end
    end

    saveSettings()
end

local ScreenGui = Instance.new'ScreenGui'

ScreenGui.Name = 'PhantomHub_V2'
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999
ScreenGui.Parent = PlayerGui

local function disableAutoLocalize(guiObject)
    pcall(function()
        guiObject.AutoLocalize = false
    end)
end

disableAutoLocalize(ScreenGui)
ScreenGui.DescendantAdded:Connect(disableAutoLocalize)

local FloatingButton = Instance.new'TextButton'

FloatingButton.Size = UDim2.new(0.054, rpx(0), 0.119, rpx(0))
FloatingButton.Position = UDim2.new(0.02, rpx(0), 0.1, rpx(0))
FloatingButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FloatingButton.Text = ''
FloatingButton.Parent = ScreenGui
FloatingButton.AutoButtonColor = false
FloatingButton.ZIndex = 999999

local FloatingButtonStroke = Instance.new'UIStroke'

FloatingButtonStroke.Color = Color3.fromRGB(60, 60, 60)
FloatingButtonStroke.Thickness = 3
FloatingButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
FloatingButtonStroke.Parent = FloatingButton

local BtnLabel = Instance.new'ImageLabel'

BtnLabel.Size = UDim2.new(1, 0, 1, 0)
BtnLabel.BackgroundTransparency = 1
BtnLabel.Image = 'rbxassetid://121715364276099'
BtnLabel.Parent = FloatingButton
BtnLabel.ZIndex = 999999

local ShadowFrame = Instance.new'Frame'

ShadowFrame.Name = 'ShadowFrame'
ShadowFrame.AnchorPoint = Vector2.new(0.5, 0.5)
ShadowFrame.Position = UDim2.new(0.5, rpx(0), 0.5, rpx(0))
ShadowFrame.Size = UDim2.new(0.545, rpx(0), 0.689, rpx(0))
ShadowFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ShadowFrame.BorderSizePixel = 0
ShadowFrame.Visible = false
ShadowFrame.Parent = ScreenGui
ShadowFrame.ZIndex = 999998

local MainFrame = Instance.new'Frame'

MainFrame.Name = 'MainFrame'
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, rpx(0), 0.5, rpx(0))
MainFrame.Size = UDim2.new(0.54, rpx(0), 0.68, rpx(0))
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui
MainFrame.ZIndex = 999999

local OuterStroke = Instance.new'UIStroke'

OuterStroke.Color = Color3.fromRGB(60, 60, 60)
OuterStroke.Thickness = 3
OuterStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
OuterStroke.Parent = ShadowFrame

local InnerStroke = Instance.new'UIStroke'

InnerStroke.Color = Color3.fromRGB(120, 120, 120)
InnerStroke.Thickness = 2
InnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
InnerStroke.Parent = MainFrame

local TopBar = Instance.new'Frame'

TopBar.Name = 'TopBar'
TopBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, rpx(0), 0.158, rpx(0))
TopBar.Position = UDim2.new(0, rpx(0), 0, rpx(0))
TopBar.Parent = MainFrame
TopBar.ZIndex = 999999

local Title = Instance.new'TextLabel'

Title.Name = 'Title'
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.02, rpx(0), 0, rpx(0))
Title.Size = UDim2.new(1, rpx(0), 1, rpx(0))
Title.Font = Enum.Font.GothamBold
Title.Text = 'Phantom Hub | +1 Magic Evolution'
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextSize = rpx(22)
Title.Parent = TopBar
Title.ZIndex = 999999

local MinimizeButton = Instance.new'TextButton'

MinimizeButton.Name = 'MinimizeButton'
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Position = UDim2.new(0.84, rpx(0), 0, rpx(0))
MinimizeButton.Size = UDim2.new(0.08, rpx(0), 1, rpx(0))
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = '-'
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = rpx(28)
MinimizeButton.Parent = TopBar
MinimizeButton.ZIndex = 999999

local CloseButton = Instance.new'TextButton'

CloseButton.Name = 'CloseButton'
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(0.92, rpx(0), 0, rpx(0))
CloseButton.Size = UDim2.new(0.08, rpx(0), 1, rpx(0))
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = 'X'
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = rpx(24)
CloseButton.Parent = TopBar
CloseButton.ZIndex = 999999

local ConfirmShadow = Instance.new'Frame'

ConfirmShadow.Name = 'ConfirmShadow'
ConfirmShadow.AnchorPoint = Vector2.new(0.5, 0.5)
ConfirmShadow.Position = UDim2.new(0.5, rpx(0), 0.5, rpx(0))
ConfirmShadow.Size = UDim2.new(0.52, rpx(0), 0.39, rpx(0))
ConfirmShadow.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ConfirmShadow.BorderSizePixel = 0
ConfirmShadow.Visible = false
ConfirmShadow.Parent = MainFrame
ConfirmShadow.ZIndex = 1000000

local ConfirmOuterStroke = Instance.new'UIStroke'

ConfirmOuterStroke.Color = Color3.fromRGB(60, 60, 60)
ConfirmOuterStroke.Thickness = 3
ConfirmOuterStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
ConfirmOuterStroke.Parent = ConfirmShadow

local ConfirmFrame = Instance.new'Frame'

ConfirmFrame.Name = 'ConfirmFrame'
ConfirmFrame.AnchorPoint = Vector2.new(0.5, 0.5)
ConfirmFrame.Position = UDim2.new(0.5, rpx(0), 0.5, rpx(0))
ConfirmFrame.Size = UDim2.new(0.5, rpx(0), 0.37, rpx(0))
ConfirmFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ConfirmFrame.BorderSizePixel = 0
ConfirmFrame.Visible = false
ConfirmFrame.Parent = MainFrame
ConfirmFrame.ZIndex = 1000001

local ConfirmInnerStroke = Instance.new'UIStroke'

ConfirmInnerStroke.Color = Color3.fromRGB(120, 120, 120)
ConfirmInnerStroke.Thickness = 2
ConfirmInnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
ConfirmInnerStroke.Parent = ConfirmFrame

local ConfirmTopBar = Instance.new'Frame'

ConfirmTopBar.Name = 'ConfirmTopBar'
ConfirmTopBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ConfirmTopBar.BorderSizePixel = 0
ConfirmTopBar.Size = UDim2.new(1, rpx(0), 0.28, rpx(0))
ConfirmTopBar.Position = UDim2.new(0, rpx(0), 0, rpx(0))
ConfirmTopBar.Parent = ConfirmFrame
ConfirmTopBar.ZIndex = 1000002

local ConfirmTitle = Instance.new'TextLabel'

ConfirmTitle.Name = 'ConfirmTitle'
ConfirmTitle.BackgroundTransparency = 1
ConfirmTitle.Size = UDim2.new(1, rpx(0), 1, rpx(0))
ConfirmTitle.Position = UDim2.new(0, rpx(0), 0, rpx(0))
ConfirmTitle.Font = Enum.Font.GothamBold
ConfirmTitle.Text = 'Would you like to close the script?'
ConfirmTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmTitle.TextSize = rpx(18)
ConfirmTitle.TextWrapped = true
ConfirmTitle.Parent = ConfirmTopBar
ConfirmTitle.ZIndex = 1000003

local ConfirmDescription = Instance.new'TextLabel'

ConfirmDescription.Name = 'ConfirmDescription'
ConfirmDescription.BackgroundTransparency = 1
ConfirmDescription.Size = UDim2.new(0.88, rpx(0), 0.32, rpx(0))
ConfirmDescription.Position = UDim2.new(0.06, rpx(0), 0.33, rpx(0))
ConfirmDescription.Font = Enum.Font.SourceSans
ConfirmDescription.Text = 'This will remove the menu and stop active features. Run the script again to restore it.'
ConfirmDescription.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmDescription.TextSize = rpx(17)
ConfirmDescription.TextWrapped = true
ConfirmDescription.Parent = ConfirmFrame
ConfirmDescription.ZIndex = 1000002

local ConfirmYesButton = Instance.new'TextButton'

ConfirmYesButton.Name = 'ConfirmYesButton'
ConfirmYesButton.Size = UDim2.new(0.34, rpx(0), 0.2, rpx(0))
ConfirmYesButton.Position = UDim2.new(0.1, rpx(0), 0.72, rpx(0))
ConfirmYesButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ConfirmYesButton.Text = 'Yes'
ConfirmYesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmYesButton.Font = Enum.Font.GothamBold
ConfirmYesButton.TextSize = rpx(17)
ConfirmYesButton.AutoButtonColor = false
ConfirmYesButton.Parent = ConfirmFrame
ConfirmYesButton.ZIndex = 1000002

local ConfirmYesStroke = Instance.new'UIStroke'

ConfirmYesStroke.Color = Color3.fromRGB(120, 120, 120)
ConfirmYesStroke.Thickness = 1
ConfirmYesStroke.Parent = ConfirmYesButton

local ConfirmNoButton = Instance.new'TextButton'

ConfirmNoButton.Name = 'ConfirmNoButton'
ConfirmNoButton.Size = UDim2.new(0.34, rpx(0), 0.2, rpx(0))
ConfirmNoButton.Position = UDim2.new(0.56, rpx(0), 0.72, rpx(0))
ConfirmNoButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ConfirmNoButton.Text = 'No'
ConfirmNoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmNoButton.Font = Enum.Font.GothamBold
ConfirmNoButton.TextSize = rpx(17)
ConfirmNoButton.AutoButtonColor = false
ConfirmNoButton.Parent = ConfirmFrame
ConfirmNoButton.ZIndex = 1000002

local ConfirmNoStroke = Instance.new'UIStroke'

ConfirmNoStroke.Color = Color3.fromRGB(120, 120, 120)
ConfirmNoStroke.Thickness = 1
ConfirmNoStroke.Parent = ConfirmNoButton

local TabContainer = Instance.new'Frame'

TabContainer.Name = 'TabContainer'
TabContainer.BackgroundTransparency = 1
TabContainer.Size = UDim2.new(0.25, 0, 1, -0.158)
TabContainer.Position = UDim2.new(0, rpx(0), 0.158, rpx(0))
TabContainer.Parent = MainFrame
TabContainer.ZIndex = 999999
TabContainer.ClipsDescendants = false

local ContentContainer = Instance.new'Frame'

ContentContainer.Name = 'ContentContainer'
ContentContainer.BackgroundTransparency = 1
ContentContainer.Size = UDim2.new(0.75, 0, 1, -0.158)
ContentContainer.Position = UDim2.new(0.25, rpx(0), 0.158, rpx(0))
ContentContainer.Parent = MainFrame
ContentContainer.ZIndex = 999999
ContentContainer.ClipsDescendants = true

local SearchBar = Instance.new'Frame'

SearchBar.Name = 'SearchBar'
SearchBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SearchBar.BorderSizePixel = 0
SearchBar.Size = UDim2.new(0.959, 0, 0.09, 0)
SearchBar.Position = UDim2.new(0, rpx(0), 0, rpx(0))
SearchBar.Parent = ContentContainer
SearchBar.ZIndex = 999999
SearchBar.ClipsDescendants = true

local SearchBarStroke = Instance.new'UIStroke'

SearchBarStroke.Color = Color3.fromRGB(40, 40, 40)
SearchBarStroke.Thickness = 1
SearchBarStroke.Parent = SearchBar

local SearchInputBackground = Instance.new'Frame'

SearchInputBackground.Name = 'SearchInputBackground'
SearchInputBackground.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SearchInputBackground.BorderSizePixel = 0
SearchInputBackground.Size = UDim2.new(0.998, rpx(0), 0.965, rpx(0))
SearchInputBackground.Position = UDim2.new(0.001, rpx(0), 0.009, rpx(0))
SearchInputBackground.Parent = SearchBar
SearchInputBackground.ZIndex = 999999
SearchInputBackground.ClipsDescendants = true

local SearchTextBox = Instance.new'TextBox'

SearchTextBox.Name = 'SearchTextBox'
SearchTextBox.BackgroundTransparency = 1
SearchTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchTextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
SearchTextBox.PlaceholderText = 'Search...'
SearchTextBox.Size = UDim2.new(0.72, 0, 1, 0)
SearchTextBox.Position = UDim2.new(0.14, 0, 0, 0)
SearchTextBox.Font = Enum.Font.SourceSans
SearchTextBox.TextSize = rpx(24)
SearchTextBox.TextXAlignment = Enum.TextXAlignment.Left
SearchTextBox.TextWrapped = false
SearchTextBox.TextTruncate = Enum.TextTruncate.AtEnd
SearchTextBox.MultiLine = false
SearchTextBox.ClipsDescendants = true
SearchTextBox.Parent = SearchInputBackground
SearchTextBox.ZIndex = 1000000
SearchTextBox.ClearTextOnFocus = false
SearchTextBox.Text = ''

local SearchIcon = Instance.new'ImageLabel'

SearchIcon.Name = 'SearchIcon'
SearchIcon.Size = UDim2.new(0.085, 0, 0.9, 0)
SearchIcon.Position = UDim2.new(0.03, 0, 0.1, 0)
SearchIcon.BackgroundTransparency = 1
SearchIcon.Image = 'rbxassetid://73858257403039'
SearchIcon.Parent = SearchInputBackground
SearchIcon.ZIndex = 1000000

local SearchTextBoxStroke = Instance.new'UIStroke'

SearchTextBoxStroke.Color = Color3.fromRGB(100, 100, 100)
SearchTextBoxStroke.Thickness = 1
SearchTextBoxStroke.Parent = SearchInputBackground

local ClearButton = Instance.new'TextButton'

ClearButton.Name = 'ClearButton'
ClearButton.BackgroundTransparency = 1
ClearButton.Position = UDim2.new(0.92, rpx(0), 0, rpx(0))
ClearButton.Size = UDim2.new(0.08, rpx(0), 1, rpx(0))
ClearButton.Font = Enum.Font.GothamBold
ClearButton.Text = 'X'
ClearButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearButton.TextSize = rpx(24)
ClearButton.Parent = SearchInputBackground
ClearButton.ZIndex = 1000002
ClearButton.Visible = false

ClearButton.MouseButton1Click:Connect(function()
    SearchTextBox.Text = ''
    ClearButton.Visible = false
end)
SearchTextBox.Focused:Connect(function()
    SearchTextBox.TextTruncate = Enum.TextTruncate.None
end)
SearchTextBox.FocusLost:Connect(function()
    SearchTextBox.TextTruncate = Enum.TextTruncate.AtEnd
end)
SearchTextBox:GetPropertyChangedSignal'Text':Connect(function()
    ClearButton.Visible = #SearchTextBox.Text > 0
end)

local MainContent = Instance.new'ScrollingFrame'

MainContent.Name = 'MainContent'
MainContent.BackgroundTransparency = 1
MainContent.Size = UDim2.new(1, 0, 0.72, 0)
MainContent.Position = UDim2.new(0, 0, 0.1, 0)
MainContent.ScrollBarThickness = 2
MainContent.CanvasSize = UDim2.new(0, rpx(0), 0, rpx(0))
MainContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
MainContent.Parent = ContentContainer
MainContent.ZIndex = 999999

local ContentListLayout = Instance.new'UIListLayout'

ContentListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentListLayout.Parent = MainContent

local function getOptionFrameHeight()
    local height = MainContent.AbsoluteSize.Y

    if height > 0 then
        return math.max(rpx(48), math.floor(height * 0.25 + 0.5))
    end

    return rpx(88)
end
local function getOptionFrameSize()
    return UDim2.new(0.959, 0, 0, getOptionFrameHeight())
end
local function getContentPadding()
    local height = MainContent.AbsoluteSize.Y

    if height > 0 then
        return math.max(1, math.floor(height * 0.022 + 0.5))
    end

    return rpx(8)
end

ContentListLayout.Padding = UDim.new(0, getContentPadding())

local function refreshMainCanvas()
    task.defer(function()
        MainContent.CanvasSize = UDim2.new(0, 0, 0, ContentListLayout.AbsoluteContentSize.Y + rpx(20))
    end)
end

ContentListLayout:GetPropertyChangedSignal'AbsoluteContentSize':Connect(refreshMainCanvas)

local tabs, activeTab, notificationTimers, speedValue, flySpeed, connectionStorage, optionElementsMap, optionTabMap, elementCategoryMap, categoryChildren, categoryStates, categoryHeaders, categoryArrows, categoryHeaderKeys, currentCategoryByTab, searchOnlyElements, updateSearchFilter = {}, 'Main', {}, 32, 32, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, nil

local function getCategoryKey(tabName, categoryName)
    return tabName .. '::' .. categoryName
end
local function registerElement(tabName, element, elementName)
    if not tabs[tabName] then
        tabs[tabName] = {
            button = nil,
            elements = {},
        }
    end

    table.insert(tabs[tabName].elements, element)

    optionElementsMap[element] = elementName or ''
    optionTabMap[element] = tabName

    local categoryName = currentCategoryByTab[tabName]

    if categoryName then
        local key = getCategoryKey(tabName, categoryName)

        elementCategoryMap[element] = key

        if not categoryChildren[key] then
            categoryChildren[key] = {}
        end

        table.insert(categoryChildren[key], element)
    end
end
local function showNotification(title, iconId, duration)
    local notificationScreenGui = Instance.new'ScreenGui'

    notificationScreenGui.Name = 'NotificationScreenGui'
    notificationScreenGui.ResetOnSpawn = false
    notificationScreenGui.DisplayOrder = 999999
    notificationScreenGui.Parent = PlayerGui

    local notificationGui = Instance.new'Frame'

    notificationGui.Name = 'NotificationGui'
    notificationGui.Size = UDim2.new(0.28, rpx(0), 0.15, rpx(0))
    notificationGui.Position = UDim2.new(0.71, rpx(0), 0.8, rpx(0))
    notificationGui.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    notificationGui.BorderSizePixel = 2
    notificationGui.BorderColor3 = Color3.fromRGB(128, 128, 128)
    notificationGui.Parent = notificationScreenGui

    local notificationIcon = Instance.new'ImageLabel'

    notificationIcon.Name = 'NotificationIcon'
    notificationIcon.Size = UDim2.new(0.2, rpx(0), 0.699, rpx(0))
    notificationIcon.Position = UDim2.new(0.029, rpx(0), 0.2, rpx(0))
    notificationIcon.BackgroundTransparency = 1
    notificationIcon.Image = 'rbxassetid://' .. iconId
    notificationIcon.Parent = notificationGui

    local notificationLabel = Instance.new'TextLabel'

    notificationLabel.Name = 'NotificationLabel'
    notificationLabel.Size = UDim2.new(0.6, rpx(0), 0.898, rpx(0))
    notificationLabel.Position = UDim2.new(0.25, rpx(0), 0.06, rpx(0))
    notificationLabel.BackgroundTransparency = 1
    notificationLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    notificationLabel.TextSize = rpx(18)
    notificationLabel.Font = Enum.Font.Gotham
    notificationLabel.Text = title
    notificationLabel.TextWrapped = true
    notificationLabel.TextXAlignment = Enum.TextXAlignment.Left
    notificationLabel.Parent = notificationGui

    local progressLine = Instance.new'Frame'

    progressLine.Name = 'ProgressLine'
    progressLine.Size = UDim2.new(1, rpx(0), 0.045, rpx(0))
    progressLine.Position = UDim2.new(0, rpx(0), 1, rpx(0))
    progressLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    progressLine.BorderSizePixel = 0
    progressLine.Parent = notificationGui

    local startTime, totalWidth, notificationId = tick(), 1, tostring(math.random(100000, 999999))

    notificationTimers[notificationId] = {
        startTime = startTime,
        duration = duration,
        gui = notificationGui,
        screenGui = notificationScreenGui,
    }

    local slideInTween = TweenService:Create(notificationGui, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.71, rpx(0), 0.8, rpx(0)),
    })

    slideInTween:Play()

    local progressConnection

    progressConnection = RunService.RenderStepped:Connect(function()
        if notificationTimers[notificationId] == nil then
            progressConnection:Disconnect()

            return
        end

        local elapsed = tick() - notificationTimers[notificationId].startTime
        local progress = math.min(elapsed / notificationTimers[notificationId].duration, 1)

        if notificationGui and notificationGui.Parent then
            progressLine.Size = UDim2.new(totalWidth * progress, rpx(0), 0.045, rpx(0))
        end
        if progress >= 1 then
            progressConnection:Disconnect()

            if notificationGui and notificationGui.Parent then
                local slideOutTween = TweenService:Create(notificationGui, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Position = UDim2.new(0.99, rpx(0), 0.8, rpx(0)),
                })

                slideOutTween:Play()
                slideOutTween.Completed:Connect(function()
                    if notificationGui then
                        notificationGui:Destroy()
                    end
                    if notificationScreenGui then
                        notificationScreenGui:Destroy()
                    end

                    notificationTimers[notificationId] = nil
                end)
            end
        end
    end)
end
local function createDebounce(key, duration)
    if not optionStates._debounce then
        optionStates._debounce = {}
    end
    if optionStates._debounce[key] then
        return false
    end

    optionStates._debounce[key] = true

    task.delay(duration or 0.05, function()
        optionStates._debounce[key] = nil
    end)

    return true
end
local function createTab(name, iconId, position)
    local TabButton = Instance.new'TextButton'

    TabButton.Name = name
    TabButton.Size = UDim2.new(0.86, 0, 0.155, 0)
    TabButton.Position = UDim2.new(0.08, 0, position.Y.Scale, position.Y.Offset)
    TabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.Text = ''
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.TextSize = rpx(19)
    TabButton.Parent = TabContainer
    TabButton.AutoButtonColor = false
    TabButton.ZIndex = 999999

    local UICorner = Instance.new'UICorner'

    UICorner.CornerRadius = UDim.new(0, rpx(0))
    UICorner.Parent = TabButton

    local BtnStroke = Instance.new'UIStroke'

    BtnStroke.Color = Color3.fromRGB(60, 60, 60)
    BtnStroke.Thickness = 1
    BtnStroke.Parent = TabButton

    local IconLabel = Instance.new'ImageLabel'

    IconLabel.Size = UDim2.new(0.27, 0, 0.68, 0)
    IconLabel.Position = UDim2.new(0.05, 0, 0.16, 0)
    IconLabel.BackgroundTransparency = 1
    IconLabel.Image = 'rbxassetid://' .. iconId
    IconLabel.Parent = TabButton
    IconLabel.ZIndex = 999999

    local TextLabel = Instance.new'TextLabel'

    TextLabel.Size = UDim2.new(0.62, 0, 1, 0)
    TextLabel.Position = UDim2.new(0.38, 0, 0, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = name
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Font = Enum.Font.SourceSansBold
    TextLabel.TextSize = rpx(18)
    TextLabel.Parent = TabButton
    TextLabel.ZIndex = 999999

    TabButton.MouseButton1Click:Connect(function()
        if activeTab ~= name then
            for _, tab in pairs(tabs)do
                tab.button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            end

            activeTab = name
            TabButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

            for _, child in pairs(MainContent:GetChildren())do
                if child:IsA'GuiObject' and child.Name ~= 'UIListLayout' then
                    child.Visible = false
                end
            end

            SearchTextBox.Text = ''
            ClearButton.Visible = false

            if updateSearchFilter then
                updateSearchFilter()
            end
        end
    end)

    if activeTab == name then
        TabButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    end

    return {
        button = TabButton,
        elements = {},
    }
end

local optionCounter = 0

local function createCategory(tabName, categoryName, iconId)
    if not tabs[tabName] then
        tabs[tabName] = {
            button = nil,
            elements = {},
        }
    end

    optionCounter = optionCounter + 1

    local key = getCategoryKey(tabName, categoryName)

    categoryStates[key] = false
    categoryChildren[key] = categoryChildren[key] or {}
    currentCategoryByTab[tabName] = categoryName

    local Container = Instance.new'Frame'

    Container.Size = getOptionFrameSize()
    Container.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    Container.Parent = MainContent
    Container.Name = tostring(optionCounter)
    Container.LayoutOrder = optionCounter
    Container.ZIndex = 999999
    Container.Visible = (tabName == activeTab)

    local UICorner = Instance.new'UICorner'

    UICorner.CornerRadius = UDim.new(0, rpx(0))
    UICorner.Parent = Container

    local ContainerStroke = Instance.new'UIStroke'

    ContainerStroke.Color = Color3.fromRGB(60, 60, 60)
    ContainerStroke.Thickness = 0
    ContainerStroke.Parent = Container

    local labelPosition, labelSize = UDim2.new(0.05, 0, 0, 0), UDim2.new(0.7, 0, 1, 0)

    if iconId then
        local IconLabel = Instance.new'ImageLabel'

        IconLabel.Size = UDim2.new(0.08, 0, 0.4, 0)
        IconLabel.Position = UDim2.new(0.05, 0, 0.3, 0)
        IconLabel.BackgroundTransparency = 1
        IconLabel.Image = 'rbxassetid://' .. iconId
        IconLabel.Parent = Container
        IconLabel.ZIndex = 999999
        labelPosition = UDim2.new(0.15, 0, 0, 0)
        labelSize = UDim2.new(0.58, 0, 1, 0)
    end

    local Label = Instance.new'TextLabel'

    Label.Size = labelSize
    Label.Position = labelPosition
    Label.Text = categoryName
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.SourceSansBold
    Label.TextSize = rpx(23)
    Label.Parent = Container
    Label.ZIndex = 999999

    local ArrowButton = Instance.new'TextButton'

    ArrowButton.Size = UDim2.new(0.105, 0, 0.7, 0)
    ArrowButton.Position = UDim2.new(0.87, 0, 0.15, 0)
    ArrowButton.BackgroundTransparency = 1
    ArrowButton.Text = '>'
    ArrowButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ArrowButton.TextSize = rpx(30)
    ArrowButton.Font = Enum.Font.GothamBold
    ArrowButton.Parent = Container
    ArrowButton.ZIndex = 999999

    local function toggleCategory()
        Container.Size = getOptionFrameSize()

        if createDebounce('Category_' .. key, 0.05) then
            categoryStates[key] = not categoryStates[key]
            ArrowButton.Text = categoryStates[key] and 'v' or '>'

            if updateSearchFilter then
                updateSearchFilter()
            end
        end
    end

    Container.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            toggleCategory()
        end
    end)
    ArrowButton.Activated:Connect(toggleCategory)

    categoryHeaders[key] = Container
    categoryArrows[key] = ArrowButton
    categoryHeaderKeys[Container] = key

    table.insert(tabs[tabName].elements, Container)

    optionElementsMap[Container] = categoryName
    optionTabMap[Container] = tabName

    return Container
end
local function createOption(name, startActive, tabName, callback)
    if not tabs[tabName] then
        tabs[tabName] = {
            button = nil,
            elements = {},
        }
    end

    optionCounter = optionCounter + 1

    createOptionState(name, startActive)

    local currentActive, Container = optionStates[name], Instance.new'Frame'

    Container.Size = getOptionFrameSize()
    Container.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    Container.Parent = MainContent
    Container.Name = tostring(optionCounter)
    Container.LayoutOrder = optionCounter
    Container.ZIndex = 999999
    Container.Visible = (tabName == activeTab)

    local UICorner = Instance.new'UICorner'

    UICorner.CornerRadius = UDim.new(0, rpx(0))
    UICorner.Parent = Container

    local ContainerStroke = Instance.new'UIStroke'

    ContainerStroke.Color = Color3.fromRGB(60, 60, 60)
    ContainerStroke.Thickness = 0
    ContainerStroke.Parent = Container

    local Label = Instance.new'TextLabel'

    Label.Size = UDim2.new(0.62, 0, 1, 0)
    Label.Position = UDim2.new(0.05, 0, 0, 0)
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.SourceSans
    Label.TextSize = rpx(23)
    Label.Parent = Container
    Label.ZIndex = 999999

    local SwitchBG = Instance.new'TextButton'

    SwitchBG.Size = UDim2.new(0.15, 0, 0.45, 0)
    SwitchBG.Position = UDim2.new(0.8, 0, 0.275, 0)
    SwitchBG.BackgroundColor3 = currentActive and Color3.fromRGB(100, 150, 200) or Color3.fromRGB(40, 40, 40)
    SwitchBG.Text = ''
    SwitchBG.Parent = Container
    SwitchBG.AutoButtonColor = false
    SwitchBG.ZIndex = 999999

    local SwitchCorner = Instance.new'UICorner'

    SwitchCorner.CornerRadius = UDim.new(0, rpx(0))
    SwitchCorner.Parent = SwitchBG

    local SwitchStroke = Instance.new'UIStroke'

    SwitchStroke.Color = Color3.fromRGB(60, 60, 60)
    SwitchStroke.Thickness = 1
    SwitchStroke.Parent = SwitchBG

    local Circle = Instance.new'Frame'

    Circle.Size = UDim2.new(0.38, 0, 0.76, 0)
    Circle.Position = currentActive and UDim2.new(0.56, 0, 0.12, 0) or UDim2.new(0.06, 0, 0.12, 0)
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Circle.Parent = SwitchBG
    Circle.ZIndex = 999999

    local CircleCorner = Instance.new'UICorner'

    CircleCorner.CornerRadius = UDim.new(0, rpx(0))
    CircleCorner.Parent = Circle

    local function toggleSwitch()
        if createDebounce(name, 0.05) then
            optionStates[name] = not optionStates[name]

            setOptionState(name, optionStates[name])
            Circle:TweenPosition(optionStates[name] and UDim2.new(0.56, 0, 0.12, 0) or UDim2.new(0.06, 0, 0.12, 0), 'Out', 'Quad', 0.2, true)

            SwitchBG.BackgroundColor3 = optionStates[name] and Color3.fromRGB(100, 150, 200) or Color3.fromRGB(40, 40, 40)

            if callback then
                task.wait(0.05)
                task.spawn(function()
                    callback(optionStates[name])
                end)
            end
        end
    end

    if not connectionStorage[name] then
        connectionStorage[name] = {}
    end
    if connectionStorage[name].activated then
        pcall(function()
            connectionStorage[name].activated:Disconnect()
        end)
    end

    connectionStorage[name].activated = SwitchBG.Activated:Connect(toggleSwitch)

    if currentActive and callback then
        task.spawn(function()
            callback(currentActive)
        end)
    end

    registerElement(tabName, Container, name)

    return function()
        return optionStates[name]
    end, Container, SwitchBG
end
local function createSlider(name, min, max, default, tabName, callback)
    if not tabs[tabName] then
        tabs[tabName] = {
            button = nil,
            elements = {},
        }
    end

    optionCounter = optionCounter + 1

    createOptionState(name, default)

    local currentVal, Container = optionStates[name], Instance.new'Frame'

    Container.Size = getOptionFrameSize()
    Container.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    Container.Parent = MainContent
    Container.LayoutOrder = optionCounter
    Container.ZIndex = 999999
    Container.Visible = (tabName == activeTab)

    local UICorner = Instance.new'UICorner'

    UICorner.CornerRadius = UDim.new(0, rpx(0))
    UICorner.Parent = Container

    local SliderStroke = Instance.new'UIStroke'

    SliderStroke.Color = Color3.fromRGB(60, 60, 60)
    SliderStroke.Thickness = 0
    SliderStroke.Parent = Container

    local Label = Instance.new'TextLabel'

    Label.Size = UDim2.new(0.9, 0, 0.42, 0)
    Label.Position = UDim2.new(0.05, 0, 0.02, 0)
    Label.Text = name .. ': ' .. tostring(currentVal)
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.SourceSans
    Label.TextSize = rpx(23)
    Label.Parent = Container
    Label.ZIndex = 999999

    local SliderBG = Instance.new'TextButton'

    SliderBG.Size = UDim2.new(0.9, 0, 0.11, 0)
    SliderBG.Position = UDim2.new(0.05, 0, 0.55, 0)
    SliderBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    SliderBG.Text = ''
    SliderBG.Parent = Container
    SliderBG.AutoButtonColor = false
    SliderBG.ZIndex = 999999

    local SliderCorner = Instance.new'UICorner'

    SliderCorner.CornerRadius = UDim.new(0, rpx(0))
    SliderCorner.Parent = SliderBG

    local SliderFill, startScale = Instance.new'Frame', (currentVal - min) / (max - min)

    SliderFill.Size = UDim2.new(startScale, 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(100, 150, 200)
    SliderFill.Parent = SliderBG
    SliderFill.ZIndex = 999999

    local FillCorner = Instance.new'UICorner'

    FillCorner.CornerRadius = UDim.new(0, rpx(0))
    FillCorner.Parent = SliderFill

    local Circle = Instance.new'Frame'

    Circle.AnchorPoint = Vector2.new(0.5, 0.5)
    Circle.Size = UDim2.new(0, rpx(14), 0, rpx(14))
    Circle.Position = UDim2.new(startScale, 0, 0.5, 0)
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Circle.Parent = SliderBG
    Circle.ZIndex = 1000000

    local CircleCorner = Instance.new'UICorner'

    CircleCorner.CornerRadius = UDim.new(0, rpx(0))
    CircleCorner.Parent = Circle

    if callback then
        task.spawn(function()
            callback(currentVal)
        end)
    end

    local dragging = false

    local function updateSlider(input)
        local relativeX = math.clamp(input.Position.X - SliderBG.AbsolutePosition.X, 0, SliderBG.AbsoluteSize.X)
        local scale = relativeX / SliderBG.AbsoluteSize.X

        SliderFill.Size = UDim2.new(scale, 0, 1, 0)
        Circle.Position = UDim2.new(scale, 0, 0.5, 0)

        local value = math.floor(min + ((max - min) * scale))

        Label.Text = name .. ': ' .. tostring(value)
        optionStates[name] = value

        setOptionState(name, value)

        if callback then
            callback(value)
        end
    end

    SliderBG.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true

            updateSlider(input)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging then
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                updateSlider(input)
            end
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    registerElement(tabName, Container, name)
end
local function createInfoBox(title, desc, tabName, isButton, linkToCopy)
    if not tabs[tabName] then
        tabs[tabName] = {
            button = nil,
            elements = {},
        }
    end

    optionCounter = optionCounter + 1

    local Container = Instance.new'Frame'

    Container.Size = getOptionFrameSize()
    Container.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    Container.Parent = MainContent
    Container.LayoutOrder = optionCounter
    Container.ZIndex = 999999
    Container.Visible = (tabName == activeTab)

    local UICorner = Instance.new'UICorner'

    UICorner.CornerRadius = UDim.new(0, rpx(0))
    UICorner.Parent = Container

    local InfoStroke = Instance.new'UIStroke'

    InfoStroke.Color = Color3.fromRGB(60, 60, 60)
    InfoStroke.Thickness = 0
    InfoStroke.Parent = Container

    local TitleLabel = Instance.new'TextLabel'

    TitleLabel.Size = UDim2.new(0.9, 0, 0.5, 0)
    TitleLabel.Position = UDim2.new(0.05, 0, 0.03, 0)
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.TextSize = rpx(23)
    TitleLabel.Parent = Container
    TitleLabel.ZIndex = 999999

    local DescLabel = Instance.new'TextLabel'

    DescLabel.Size = UDim2.new(0.9, 0, 0.5, 0)
    DescLabel.Position = UDim2.new(0.05, 0, 0.5, 0)
    DescLabel.Text = desc
    DescLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    DescLabel.BackgroundTransparency = 1
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.Font = Enum.Font.SourceSans
    DescLabel.TextSize = rpx(18)
    DescLabel.Parent = Container
    DescLabel.ZIndex = 999999

    if isButton then
        local ClickBtn = Instance.new'TextButton'

        ClickBtn.Size = UDim2.new(1, 0, 1, 0)
        ClickBtn.BackgroundTransparency = 1
        ClickBtn.Text = ''
        ClickBtn.Parent = Container
        ClickBtn.ZIndex = 999999

        ClickBtn.MouseButton1Click:Connect(function()
            if type(setclipboard) == 'function' then
                pcall(function()
                    setclipboard(linkToCopy)
                end)
            end

            showNotification('Discord Link Copied', '132744109593099', 2.85)
        end)
    end

    registerElement(tabName, Container, title)
end
local function createSpecialButton(name, tabName, callback)
    if not tabs[tabName] then
        tabs[tabName] = {
            button = nil,
            elements = {},
        }
    end

    optionCounter = optionCounter + 1

    local Container = Instance.new'Frame'

    Container.Size = getOptionFrameSize()
    Container.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    Container.Parent = MainContent
    Container.Name = tostring(optionCounter)
    Container.LayoutOrder = optionCounter
    Container.ZIndex = 999999
    Container.Visible = (tabName == activeTab)

    local UICorner = Instance.new'UICorner'

    UICorner.CornerRadius = UDim.new(0, rpx(0))
    UICorner.Parent = Container

    local ContainerStroke = Instance.new'UIStroke'

    ContainerStroke.Color = Color3.fromRGB(60, 60, 60)
    ContainerStroke.Thickness = 0
    ContainerStroke.Parent = Container

    local Label = Instance.new'TextLabel'

    Label.Size = UDim2.new(0.62, 0, 1, 0)
    Label.Position = UDim2.new(0.05, 0, 0, 0)
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.SourceSans
    Label.TextSize = rpx(23)
    Label.Parent = Container
    Label.ZIndex = 999999

    local IconButton = Instance.new'ImageButton'

    IconButton.Size = UDim2.new(0.09, 0, 0.55, 0)
    IconButton.Position = UDim2.new(0.835, 0, 0.225, 0)
    IconButton.BackgroundTransparency = 1
    IconButton.Image = 'rbxassetid://97594499544606'
    IconButton.AutoButtonColor = false
    IconButton.Parent = Container
    IconButton.ZIndex = 999999

    local function runButton()
        if createDebounce(name, 0.2) then
            if callback then
                task.spawn(function()
                    callback()
                end)
            end
        end
    end

    Container.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            runButton()
        end
    end)
    IconButton.Activated:Connect(runButton)
    registerElement(tabName, Container, name)
end

tabs.Main = createTab('Main', '139357095045310', UDim2.new(0.08, rpx(0), 0, rpx(0)))
tabs['Auto Buy'] = createTab('Auto Buy', '110805385284419', UDim2.new(0.08, rpx(0), 0.16, rpx(0)))
tabs.Farm = createTab('Farm', '102352181267949', UDim2.new(0.08, rpx(0), 0.32, rpx(0)))
tabs.Config = createTab('Config', '114794077382466', UDim2.new(0.08, rpx(0), 0.48, rpx(0)))
tabs.Credits = createTab('Credits', '99243311837005', UDim2.new(0.08, rpx(0), 0.64, rpx(0)))

local autoTrainActive, autoRebirthActive, autoOpenEggsActive, autoFarmActive, autoStaffButtonActive, platformToggleActive, autoDungeonTrainPowerActive, platformStudValue, platformPart, platformHeight, platformLoopId, runeNames, autoFarmCFrame = false, false, false, false, false, false, false, 12, nil, nil, 0, {
    'Acid Rune',
    'Angelic Rune',
    'Defense Rune',
    'Demonic Rune',
    'Desert Rune',
    'Frozen Rune',
    'Health Rune',
    'Lunar Rune',
    'Molten Rune',
    'Power Rune',
    'Speed Rune',
    'Vine Rune',
    'Legendary Power Rune',
    'Legendary Speed Rune',
    'Legendary Defense Rune',
    'Legendary Health Rune',
}, CFrame.new(3568.00781, 2.04499984, 8.18976593, 0, 0, 1, 0, 1, 0, -1, 0, 0)

local function getCharacterParts()
    local character = Player.Character
    local humanoid, hrp = character and character:FindFirstChildOfClass'Humanoid', character and character:FindFirstChild'HumanoidRootPart'

    return character, humanoid, hrp
end
local function getRemote(remoteName)
    return game:GetService'ReplicatedStorage':WaitForChild'Remotes':WaitForChild(remoteName)
end
local function getGroundY(position, ignoreCharacter)
    local params = RaycastParams.new()

    params.FilterType = Enum.RaycastFilterType.Blacklist
    params.FilterDescendantsInstances = ignoreCharacter and {ignoreCharacter} or {}

    local result = workspace:Raycast(position + Vector3.new(0, 8, 0), Vector3.new(0, 
-600, 0), params)

    if result then
        return result.Position.Y
    end

    return position.Y - 3
end
local function destroyPlatform()
    if platformPart then
        pcall(function()
            platformPart:Destroy()
        end)
    end

    platformPart = nil
    platformHeight = nil
end
local function setRootPlatformCFrame(hrp, y)
    local _, _, _, r00, r01, r02, r10, r11, r12, r20, r21, r22 = hrp.CFrame:GetComponents()

    hrp.CFrame = CFrame.new(hrp.Position.X, y, hrp.Position.Z, r00, r01, r02, r10, r11, r12, r20, r21, r22)
end
local function ensurePlatform()
    local character, humanoid, hrp = getCharacterParts()

    if not hrp then
        return
    end
    if not platformPart or not platformPart.Parent then
        platformPart = Instance.new'Part'
        platformPart.Name = 'PhantomPlatform'
        platformPart.Size = Vector3.new(12, 1, 12)
        platformPart.Anchored = true
        platformPart.CanCollide = true
        platformPart.CanTouch = false
        platformPart.Transparency = 1
        platformPart.Parent = workspace
        platformHeight = getGroundY(hrp.Position, character) + platformStudValue

        setRootPlatformCFrame(hrp, platformHeight + 4)
    end

    platformPart.CFrame = CFrame.new(hrp.Position.X, platformHeight, hrp.Position.Z)

    if humanoid then
        humanoid.PlatformStand = false
        humanoid.Sit = false
    end
    if hrp.Position.Y < platformHeight + 2.3 then
        setRootPlatformCFrame(hrp, platformHeight + 4)

        hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, math.max(hrp.AssemblyLinearVelocity.Y, 0), hrp.AssemblyLinearVelocity.Z)
    end
end
local function startPlatformLoop()
    platformLoopId = platformLoopId + 1

    local currentLoop = platformLoopId

    task.spawn(function()
        while platformToggleActive and platformLoopId == currentLoop do
            ensurePlatform()
            task.wait(0.03)
        end

        if platformLoopId == currentLoop then
            destroyPlatform()
        end
    end)
end
local function getStaffTouchPart()
    local staffModel = workspace:FindFirstChild('Staff Button20', true)
    local touchPart = staffModel and staffModel:FindFirstChild('TouchPart', true)

    if touchPart and touchPart:IsA'BasePart' and touchPart:FindFirstChild'TouchInterest' then
        return touchPart
    end

    return nil
end
local function touchStaffButton()
    if type(firetouchinterest) ~= 'function' then
        return
    end

    local _, _, hrp = getCharacterParts()
    local touchPart = getStaffTouchPart()

    if hrp and touchPart then
        pcall(function()
            firetouchinterest(hrp, touchPart, 0)
            task.wait(0.02)
            firetouchinterest(hrp, touchPart, 1)
        end)
    end
end

createCategory('Main', 'Progression', '99024336494762')
createOption('Auto Train', false, 'Main', function(state)
    autoTrainActive = state

    if state then
        task.spawn(function()
            while autoTrainActive do
                pcall(function()
                    getRemote'GainMagicPower':FireServer()
                end)
                task.wait(0.03)
            end
        end)
    end
end)
createOption('Auto Rebirth', false, 'Main', function(state)
    autoRebirthActive = state

    if state then
        task.spawn(function()
            while autoRebirthActive do
                pcall(function()
                    getRemote'Rebirth':FireServer()
                end)
                task.wait(0.15)
            end
        end)
    end
end)
createCategory('Auto Buy', 'Eggs', '72377406954512')
createOption('Open Eggs', false, 'Auto Buy', function(state)
    autoOpenEggsActive = state

    if state then
        task.spawn(function()
            while autoOpenEggsActive do
                pcall(function()
                    local args = {
                        [1] = 'Demonic Egg',
                    }

                    getRemote'OpenEgg':InvokeServer(unpack(args))
                end)
                task.wait(0.2)
            end
        end)
    end
end)
createCategory('Farm', 'Trophy Farm', '130626492867162')
createOption('Auto Farm', false, 'Farm', function(state)
    autoFarmActive = state

    if state then
        task.spawn(function()
            while autoFarmActive do
                local _, _, hrp = getCharacterParts()

                if hrp then
                    pcall(function()
                        hrp.CFrame = autoFarmCFrame
                    end)
                end

                task.wait(0.1)
            end
        end)
    end
end)
createCategory('Farm', 'Items', '84487893427781')
createOption('Auto Staff Button', false, 'Farm', function(state)
    autoStaffButtonActive = state

    if state then
        task.spawn(function()
            while autoStaffButtonActive do
                touchStaffButton()
                task.wait(0.08)
            end
        end)
    end
end)
createSpecialButton('Collect all Runes', 'Farm', function()
    for _, runeName in ipairs(runeNames)do
        pcall(function()
            local args = {[1] = runeName}

            getRemote'RunePickedUp':FireServer(unpack(args))
        end)
        task.wait(0.03)
    end
end)
createSpecialButton('Collect Items Lunar', 'Farm', function()
    pcall(function()
        local args = {
            [1] = 'Lunar Chestplate',
        }

        game:GetService'ReplicatedStorage':WaitForChild'Remotes':WaitForChild'ArmorPickedUp':FireServer(unpack(args))
    end)
    task.wait(0.1)
    pcall(function()
        local args = {
            [1] = 'Lunar Boots',
        }

        game:GetService'ReplicatedStorage':WaitForChild'Remotes':WaitForChild'ArmorPickedUp':FireServer(unpack(args))
    end)
end)
createCategory('Farm', 'Dungeons', '100214765855009')
createOption('Platform Toggle', false, 'Farm', function(state)
    platformToggleActive = state

    if state then
        destroyPlatform()
        startPlatformLoop()
    else
        platformLoopId = platformLoopId + 1

        destroyPlatform()
    end
end)
createOption('Auto Train Power', false, 'Farm', function(state)
    autoDungeonTrainPowerActive = state

    if state then
        task.spawn(function()
            while autoDungeonTrainPowerActive do
                pcall(function()
                    getRemote'GainMagicPower':FireServer()
                end)
                task.wait(0.03)
            end
        end)
    end
end)
createCategory('Config', 'Player', '102791662357524')
createSpecialButton('Auto Rejoin', 'Config', function()
    TeleportService:Teleport(game.PlaceId)
end)
createOption('Anti AFK', false, 'Config')
createOption('Anti Cheat', false, 'Config')
createOption('Infinite Jump', false, 'Config')
createOption('Enable Speed', false, 'Config', function(state)
    if state then
        speedValue = optionStates.Speed
    end
end)
createSlider('Speed', 1, 500, 32, 'Config', function(value)
    speedValue = value
end)
createOption('Fly', false, 'Config')
createSlider('Fly Speed', 1, 500, 32, 'Config', function(value)
    flySpeed = value
end)
createOption('Noclip', false, 'Config')
createOption('Enable Shift Lock', false, 'Config', function(state)
    getgenv().ShiftLockEnabled = state
end)
createInfoBox('By: Cleiton10HDx', 'Script created by this user.', 'Credits', false)
createInfoBox('Discord', 'My Discord Server', 'Credits', true, 'https://discord.gg/72P6NhC5Pf')

updateSearchFilter = function()
    local searchText = SearchTextBox.Text:lower()
    local isSearching = searchText ~= ''

    for _, element in pairs(MainContent:GetChildren())do
        if element:IsA'GuiObject' and element.Name ~= 'UIListLayout' then
            local tabName, elementName, headerKey, categoryKey = optionTabMap[element], optionElementsMap[element] or '', categoryHeaderKeys[element], elementCategoryMap[element]

            if isSearching then
                if headerKey then
                    element.Visible = false
                elseif searchOnlyElements[element] then
                    element.Visible = elementName:lower():find(searchText, 1, true) ~= nil
                else
                    element.Visible = elementName ~= '' and elementName:lower():find(searchText, 1, true) ~= nil
                end
            elseif tabName == activeTab then
                if headerKey then
                    element.Visible = true
                elseif searchOnlyElements[element] then
                    element.Visible = false
                elseif categoryKey then
                    if elementName == '' then
                        element.Visible = categoryStates[categoryKey] == true and (element.Size.Y.Offset > 0 or element.Size.Y.Scale > 0)
                    else
                        element.Visible = categoryStates[categoryKey] == true
                    end
                else
                    element.Visible = true
                end
            else
                element.Visible = false
            end
        end
    end

    refreshMainCanvas()
end

SearchTextBox:GetPropertyChangedSignal'Text':Connect(function()
    updateSearchFilter()
end)

if updateSearchFilter then
    updateSearchFilter()
end

local function setConfirmVisible(visible)
    ConfirmFrame.Visible = visible
    ConfirmShadow.Visible = visible
end

MinimizeButton.Activated:Connect(function()
    MainFrame.Visible = false
    ShadowFrame.Visible = false
end)
CloseButton.Activated:Connect(function()
    setConfirmVisible(true)
end)
ConfirmNoButton.Activated:Connect(function()
    setConfirmVisible(false)
end)

local draggingBtn, activeDragInput, dragStartBtn, startPosBtn, buttonMoved = false, nil, nil, nil, false

local function toggleMenu()
    MainFrame.Visible = not MainFrame.Visible
    ShadowFrame.Visible = MainFrame.Visible
end
local function updateFloatingButtonPosition(input)
    if activeDragInput and dragStartBtn and startPosBtn then
        local delta = input.Position - dragStartBtn

        if delta.Magnitude > 8 then
            draggingBtn = true
            buttonMoved = true
        end
        if draggingBtn then
            FloatingButton.Position = UDim2.new(startPosBtn.X.Scale, startPosBtn.X.Offset + delta.X, startPosBtn.Y.Scale, startPosBtn.Y.Offset + delta.Y)
        end
    end
end

FloatingButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingBtn = false
        buttonMoved = false
        activeDragInput = input
        dragStartBtn = input.Position
        startPosBtn = FloatingButton.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if activeDragInput then
        if input == activeDragInput or input.UserInputType == Enum.UserInputType.MouseMovement then
            updateFloatingButtonPosition(input)
        end
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if activeDragInput and (input == activeDragInput or input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        if not buttonMoved then
            toggleMenu()
        end

        draggingBtn = false
        buttonMoved = false
        activeDragInput = nil
        dragStartBtn = nil
        startPosBtn = nil
    end
end)

local LP, isFlyActive, bg, bv, noclipEnabled, noclipParts, shiftLockScreenGui, shiftLockIcon, shiftLockActive, shiftLockConnection = game:GetService'Players'.LocalPlayer, false, nil, nil, false, {}, nil, nil, false, nil

UserInputService.JumpRequest:Connect(function()
    local value = optionStates['Infinite Jump']

    if type(value) == 'function' then
        value = value()
    end
    if value then
        local char = LP.Character

        if char then
            local humanoid = char:FindFirstChildOfClass'Humanoid'

            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)
task.spawn(function()
    while task.wait(0.1) do
        local speedEnabled = optionStates['Enable Speed']

        if type(speedEnabled) == 'function' then
            speedEnabled = speedEnabled()
        end

        local char = LP.Character
        local humanoid = char and char:FindFirstChildOfClass'Humanoid'

        if humanoid then
            humanoid.WalkSpeed = speedEnabled and speedValue or 28
        end
        if isFlyActive and bg and bv then
            local cam = workspace.CurrentCamera

            char = LP.Character

            if cam and char and char:FindFirstChild'HumanoidRootPart' then
                humanoid = char:FindFirstChildOfClass'Humanoid'

                if humanoid then
                    local moveDir = humanoid.MoveDirection

                    if moveDir.Magnitude > 0 then
                        local camDir, camRight = cam.CFrame.LookVector, cam.CFrame.RightVector
                        local flatLook = Vector3.new(camDir.X, 0, camDir.Z)

                        if flatLook.Magnitude > 0.001 then
                            flatLook = flatLook.Unit
                        else
                            flatLook = Vector3.new(cam.CFrame.UpVector.X, 0, cam.CFrame.UpVector.Z).Unit * 
-math.sign(camDir.Y)
                        end

                        local flatRight = Vector3.new(camRight.X, 0, camRight.Z)

                        if flatRight.Magnitude > 0.001 then
                            flatRight = flatRight.Unit
                        else
                            flatRight = Vector3.new(1, 0, 0)
                        end

                        local forwardInput, rightInput = moveDir:Dot(flatLook), moveDir:Dot(flatRight)

                        bv.Velocity = (camDir * forwardInput + camRight * rightInput) * flySpeed
                    else
                        bv.Velocity = Vector3.new(0, 0, 0)
                    end

                    bg.CFrame = cam.CFrame
                end
            end
        end
        if noclipEnabled then
            char = LP.Character

            if char then
                for _, part in pairs(char:GetDescendants())do
                    if part:IsA'BasePart' then
                        if noclipParts[part] == nil then
                            noclipParts[part] = part.CanCollide
                        end

                        part.CanCollide = false
                    end
                end
            end
        end
    end
end)
task.spawn(function()
    while task.wait(0.1) do
        local flyEnabled = optionStates.Fly

        if type(flyEnabled) == 'function' then
            flyEnabled = flyEnabled()
        end
        if flyEnabled then
            isFlyActive = true

            local char = LP.Character

            if char and char:FindFirstChild'HumanoidRootPart' then
                local root = char.HumanoidRootPart

                if not root:FindFirstChild'FlyVel' then
                    bv = Instance.new'BodyVelocity'
                    bv.Name = 'FlyVel'
                    bv.Velocity = Vector3.new(0, 0, 0)
                    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                    bv.Parent = root
                else
                    bv = root:FindFirstChild'FlyVel'
                end
                if not root:FindFirstChild'FlyGyro' then
                    bg = Instance.new'BodyGyro'
                    bg.Name = 'FlyGyro'
                    bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                    bg.CFrame = root.CFrame
                    bg.Parent = root
                else
                    bg = root:FindFirstChild'FlyGyro'
                end
            end
        else
            isFlyActive = false

            local char = LP.Character

            if char and char:FindFirstChild'HumanoidRootPart' then
                local root = char.HumanoidRootPart
                local vel, gyro = root:FindFirstChild'FlyVel', root:FindFirstChild'FlyGyro'

                if vel then
                    vel:Destroy()
                end
                if gyro then
                    gyro:Destroy()
                end

                bv = nil
                bg = nil
            end
        end

        local noclipVal = optionStates.Noclip

        if type(noclipVal) == 'function' then
            noclipVal = noclipVal()
        end
        if noclipVal then
            noclipEnabled = true
        else
            noclipEnabled = false

            for part, canCollide in pairs(noclipParts)do
                if part and part.Parent then
                    part.CanCollide = canCollide
                end
            end

            noclipParts = {}
        end
    end
end)
task.spawn(function()
    while task.wait(0.1) do
        local antiAfk = optionStates['Anti AFK']

        if type(antiAfk) == 'function' then
            antiAfk = antiAfk()
        end
        if antiAfk then
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end
    end
end)

if type(hookmetamethod) == 'function' and type(getnamecallmethod) == 'function' then
    local oldNamecall

    oldNamecall = hookmetamethod(game, '__namecall', function(self, ...)
        local antiCheat = optionStates['Anti Cheat']

        if type(antiCheat) == 'function' then
            antiCheat = antiCheat()
        end
        if antiCheat then
            local method = getnamecallmethod()

            if method == 'FireServer' and tostring(self) == 'Cheat' then
                return nil
            end
        end

        return oldNamecall(self, ...)
    end)
end

local function createShiftLockUI()
    if shiftLockScreenGui then
        return
    end

    shiftLockScreenGui = Instance.new'ScreenGui'
    shiftLockScreenGui.Name = 'ShiftLockScreenGui'
    shiftLockScreenGui.ResetOnSpawn = false
    shiftLockScreenGui.DisplayOrder = 999998
    shiftLockScreenGui.Parent = PlayerGui
    shiftLockIcon = Instance.new'ImageLabel'
    shiftLockIcon.Name = 'ShiftLockIcon'
    shiftLockIcon.Size = UDim2.new(0.05, 0, 0.1, 0)
    shiftLockIcon.Position = UDim2.new(0.95, 0, 0.68, 0)
    shiftLockIcon.BackgroundTransparency = 1
    shiftLockIcon.Image = 'rbxassetid://105987953182009'
    shiftLockIcon.Parent = shiftLockScreenGui
    shiftLockIcon.ZIndex = 999998

    shiftLockIcon.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            shiftLockActive = not shiftLockActive
            shiftLockIcon.Image = shiftLockActive and 'rbxassetid://139211296111194' or 'rbxassetid://105987953182009'
        end
    end)
end
local function destroyShiftLockUI()
    if shiftLockScreenGui then
        shiftLockScreenGui:Destroy()

        shiftLockScreenGui = nil
        shiftLockIcon = nil
    end
end

task.spawn(function()
    while task.wait(0.1) do
        local shiftLockEnabled = optionStates['Enable Shift Lock']

        if type(shiftLockEnabled) == 'function' then
            shiftLockEnabled = shiftLockEnabled()
        end
        if shiftLockEnabled and not shiftLockScreenGui then
            createShiftLockUI()
        elseif not shiftLockEnabled and shiftLockScreenGui then
            destroyShiftLockUI()

            shiftLockActive = false

            if shiftLockConnection then
                shiftLockConnection:Disconnect()

                shiftLockConnection = nil
            end
        end
        if shiftLockScreenGui and shiftLockActive then
            local char = LP.Character

            if char and char:FindFirstChild'HumanoidRootPart' then
                local _, humanoid = char.HumanoidRootPart, char:FindFirstChildOfClass'Humanoid'

                if humanoid then
                    humanoid.AutoRotate = false

                    if not shiftLockConnection then
                        shiftLockConnection = RunService.RenderStepped:Connect(function(
                        )
                            local currentChar = LP.Character

                            if currentChar and currentChar:FindFirstChild'HumanoidRootPart' then
                                local currentRoot, camera = currentChar.HumanoidRootPart, workspace.CurrentCamera

                                if camera then
                                    local lookVector = camera.CFrame.LookVector

                                    currentRoot.CFrame = CFrame.new(currentRoot.Position, currentRoot.Position + Vector3.new(lookVector.X, 0, lookVector.Z))
                                end
                            end
                        end)
                    end
                end
            end
        elseif shiftLockScreenGui and not shiftLockActive then
            if shiftLockConnection then
                shiftLockConnection:Disconnect()

                shiftLockConnection = nil
            end

            local char = LP.Character

            if char then
                local humanoid = char:FindFirstChildOfClass'Humanoid'

                if humanoid then
                    humanoid.AutoRotate = true
                end
            end
        end
    end
end)
Player.CharacterAdded:Connect(function()
    if shiftLockConnection then
        shiftLockConnection:Disconnect()

        shiftLockConnection = nil
    end

    isFlyActive = false
    bg = nil
    bv = nil
    noclipParts = {}
end)

local function stopAllScriptFeatures()
    autoTrainActive = false
    autoRebirthActive = false
    autoOpenEggsActive = false
    autoFarmActive = false
    autoStaffButtonActive = false
    platformToggleActive = false
    autoDungeonTrainPowerActive = false

    destroyPlatform()

    isFlyActive = false
    noclipEnabled = false
    getgenv().ShiftLockEnabled = false

    for name, value in pairs(optionStates)do
        if type(value) == 'boolean' then
            optionStates[name] = false
        end
    end

    if bg then
        pcall(function()
            bg:Destroy()
        end)

        bg = nil
    end
    if bv then
        pcall(function()
            bv:Destroy()
        end)

        bv = nil
    end

    for part, canCollide in pairs(noclipParts)do
        if part and part.Parent then
            pcall(function()
                part.CanCollide = canCollide
            end)
        end
    end

    noclipParts = {}

    if destroyShiftLockUI then
        destroyShiftLockUI()
    end
end

ConfirmYesButton.Activated:Connect(function()
    saveCurrentSettings()
    stopAllScriptFeatures()

    if ScreenGui then
        ScreenGui:Destroy()
    end
end)
Player.CharacterAdded:Connect(function() end)
