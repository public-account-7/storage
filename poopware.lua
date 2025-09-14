local UID = 0

if not getcustomasset then
    getgenv().getcustomasset = function()
        return ""
    end
end
local _Instancenew = clonefunction(Instance.new)
local _TweenInfonew = clonefunction(TweenInfo.new)

local _GetService = clonefunction(game.GetService)
local _IsLoaded = clonefunction(game.IsLoaded)
local _Clone = clonefunction(game.Clone)
local _Destroy = clonefunction(game.Destroy)
local _GetChildren = clonefunction(game.GetChildren)
local _GetDescendants = clonefunction(game.GetDescendants)
local _IsDescendantOf = clonefunction(game.IsDescendantOf)
local _IsA = clonefunction(game.IsA)
local _FindFirstChild = clonefunction(game.FindFirstChild)
local _FindFirstChildOfClass = clonefunction(game.FindFirstChildOfClass)
local _HttpGet = clonefunction(game.HttpGet)
local _GetPropertyChangedSignal = clonefunction(game.GetPropertyChangedSignal)
local _GetAttribute = clonefunction(game.GetAttribute)

local _GetPlayers = clonefunction(_GetService(game, "Players").GetPlayers)
local _GetPlayerFromCharacter = clonefunction(_GetService(game, "Players").GetPlayerFromCharacter)
local _GetValue = clonefunction(_GetService(game, "Stats").Network.ServerStatsItem['Data Ping'].GetValue)
local _GetMouseLocation = clonefunction(_GetService(game, "UserInputService").GetMouseLocation)
local _IsKeyDown = clonefunction(_GetService(game, "UserInputService").IsKeyDown)
local _GetMouse = clonefunction(_GetService(game, "Players").LocalPlayer.GetMouse)
local _Kick = clonefunction(_GetService(game, "Players").LocalPlayer.Kick)

local _CFrameNew = clonefunction(CFrame.new)
local _CFrameAngles = clonefunction(CFrame.Angles)
local _CFrameLookAt = clonefunction(CFrame.lookAt)
local _CFrameLerp = clonefunction(_CFrameNew().Lerp)
local _CFramePointToObjectSpace = clonefunction(_CFrameNew().PointToObjectSpace)
local _CFrameToEulerAnglesXYZ = clonefunction(_CFrameNew().ToEulerAnglesXYZ)
local _CFrameToOrientation = clonefunction(_CFrameNew().ToOrientation)

local _Vector3New = clonefunction(Vector3.new)
local _Vector3Lerp = clonefunction(_Vector3New().Lerp)

local _Vector2New = clonefunction(Vector2.new)

local _UDim2New = clonefunction(UDim2.new)
local _UDim2fromOffset = clonefunction(UDim2.fromOffset)
local _UDimNew = clonefunction(UDim.new)

local _Color3New = clonefunction(Color3.new)
local _Color3FromRGB = clonefunction(Color3.fromRGB)
local _Color3FromHSV = clonefunction(Color3.fromHSV)
local _Color3ToHSV = clonefunction(Color3.toHSV)
local _ToHex = clonefunction(_Color3New().ToHex)
local _FromHex = clonefunction(Color3.fromHex)

local _ColorSequenceNew = clonefunction(ColorSequence.new)
local _ColorSequenceKeypointNew = clonefunction(ColorSequenceKeypoint.new)
local _NumberSequenceNew = clonefunction(NumberSequence.new)
local _NumberSequenceKeypointNew = clonefunction(NumberSequenceKeypoint.new)

local _RayNew = clonefunction(Ray.new)
local _RaycastParamsNew = clonefunction(RaycastParams.new)
local _Raycast = clonefunction(workspace.Raycast)

local _StringFormat = clonefunction(string.format)
local _StringUpper = clonefunction(string.upper)
local _StringLower = clonefunction(string.lower)
local _StringFind = clonefunction(string.find)
local _StringLen = clonefunction(string.len)
local _StringGsub = clonefunction(string.gsub)
local _StringSub = clonefunction(string.sub)
local _StringSplit = clonefunction(string.split)
local _tostring = clonefunction(tostring)

local _TableInsert = clonefunction(table.insert)
local _TableRemove = clonefunction(table.remove)
local _TableFind = clonefunction(table.find)
local _TableConcat = clonefunction(table.concat)
local _TableSort = clonefunction(table.sort)
local _TableUnpack = clonefunction(table.unpack)
local _Select = clonefunction(select)

local _MathClamp = clonefunction(math.clamp)
local _MathRandom = clonefunction(math.random)
local _MathRad = clonefunction(math.rad)
local _MathFloor = clonefunction(math.floor)
local _MathMax = clonefunction(math.max)
local _MathMin = clonefunction(math.min)
local _MathSin = clonefunction(math.sin)
local _MathCos = clonefunction(math.cos)
local _MathDeg = clonefunction(math.deg)
local _MathAtan2 = clonefunction(math.atan2)
local _Materials = Enum.Material
local _MathLerp = function(a, b, t)
    return a + (b - a) * t
end
local _tonumber = clonefunction(tonumber)

local _DebugTraceback = clonefunction(debug.traceback)

local _Tick = clonefunction(tick)
local _OsDate = clonefunction(os.date)
local _OsTime = clonefunction(os.time)

local _WorldToViewportPoint = clonefunction(_Instancenew("Camera").WorldToViewportPoint)
local _WorldToScreenPoint = clonefunction(_Instancenew("Camera").WorldToScreenPoint)

local _ChangeState = clonefunction(_Instancenew("Humanoid").ChangeState)

local _Require = clonefunction(require)
local _Type = clonefunction(type)
local _Typeof = clonefunction(typeof)
local _CoroutineWrap = clonefunction(coroutine.wrap)
local _TaskWait = clonefunction(task.wait)
local _Pcall = clonefunction(pcall)
local _Wait = clonefunction(wait)
local _TaskSpawn = clonefunction(task.spawn)

local workspaceRaycast = workspace.Raycast

repeat _TaskWait() until _IsLoaded(game)
if getgenv().Loaded ~= nil then return end

local version = "9.9.3"
local Build = "1000-7"
local LoadTick = _Tick()
local checkcalled = false

-- Core Vars
local HttpService = cloneref(_GetService(game,"HttpService"))
local InputService = cloneref(_GetService(game,"UserInputService"))
local replicatedStorage = cloneref(_GetService(game,"ReplicatedStorage"))
local Stats = cloneref(_GetService(game, "Stats"))
local TextService = cloneref(_GetService(game,"TextService"))
local Teams = cloneref(_GetService(game,"Teams"))
local Players = cloneref(_GetService(game,"Players"))
local RunService = cloneref(_GetService(game,"RunService"))
local TweenService = cloneref(_GetService(game,"TweenService"))
local executor = syn and "Synapse" or nil
local platform = "Windows"
if not executor then
    executor, platform = identifyexecutor()
end
local Lighting = cloneref(_GetService(game,"Lighting"))
local RenderStepped = RunService.RenderStepped
local LocalPlayer = Players.LocalPlayer
local camera = cloneref(workspace.CurrentCamera)
local viewportSize = camera.ViewportSize
local Mouse = _GetMouse(LocalPlayer)
local SoundService = cloneref(_GetService(game,"SoundService"))
local CoreGui = _Instancenew("ScreenGui")
local spring = loadstring(_HttpGet(game, "https://raw.githubusercontent.com/Quenty/NevermoreEngine/5a429e871d54646ba54011c18321e77afa76d657/Modules/Shared/Physics/Spring.lua"))()
local Signaling = loadstring(_HttpGet(game, "https://raw.githubusercontent.com/Quenty/NevermoreEngine/version2/Modules/Shared/Events/Signal.lua"))()
local Events = replicatedStorage:WaitForChild("Events", 1/0)
local HitPart = Events:WaitForChild("HitPart", 1/0)
local playerSpawned = Signaling.new()
local playerDied = Signaling.new()
local Crosshairs = LocalPlayer.PlayerGui.GUI.Crosshairs
local ScriptCacheFolder = _Instancenew("Folder", workspace)
ScriptCacheFolder.Name = "ScriptCacheFolder"
CoreGui.ResetOnSpawn = false

local ChatFrame = LocalPlayer.PlayerGui.GUI.Main.Chats
ChatFrame.DisplayChat:Destroy()
local ChatUI = ChatFrame.Parent

do
    local ProtectGui = protectgui or protect_gui or (syn and syn.protect_gui) or (function(p) 

    end);
    
    local ScreenGui = _Instancenew('ScreenGui');
    ProtectGui(ScreenGui);
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global;
    ScreenGui.Parent = CoreGui
    ScreenGui.DisplayOrder = 0x6fffffff
    ScreenGui.ResetOnSpawn = false
    
    local Toggles = {}
    local Options = {}
    local Flags = setmetatable({},{
        __index = function(self,value)
            if Toggles[value] ~= nil then
                return Toggles[value].Value
            elseif Options[value] ~= nil then
                local success,data = _Pcall(function()
                    return Options[value]:GetState()
                end)
                if success then
                    return data
                end
                return Options[value].Value
            end
        end
    })    
    getgenv().Toggles = Toggles
    getgenv().Options = Options
    getgenv().Flags = Flags
    
    local Library = {
        Registry = {};
        RegistryMap = {};
        HudRegistry = {};
    
        LoadingCFG = false;
        FontColor = _Color3FromRGB(245, 225, 200);
        MainColor = _Color3FromRGB(15, 15, 15);
        BackgroundColor = _Color3FromRGB(13, 13, 13);
        AccentColor = _Color3FromRGB(255, 140, 0);    
        OutlineColor = _Color3FromRGB(40, 20, 0);   
        RiskColor = _Color3FromRGB(255, 36, 36),
        
        Black = _Color3New(0, 0, 0);
        Font = Enum.Font.SourceSans,
        
        OpenedFrames = {};
        DependencyBoxes = {};
        
        Signals = {};
        ScreenGui = ScreenGui;
    };
    
    local RainbowStep = 0
    local Hue = 0
    
    _TableInsert(Library.Signals, RenderStepped:Connect(function(Delta)
        RainbowStep = RainbowStep + Delta
    
        if RainbowStep >= (1 / 60) then
            RainbowStep = 0
    
            Hue = Hue + (1 / 400);
    
            if Hue > 1 then
                Hue = 0;
            end;
    
            Library.CurrentRainbowHue = Hue;
            Library.CurrentRainbowColor = _Color3FromHSV(Hue, 0.8, 1);
        end
    end))
    
    local httpService = HttpService
    local ThemeManager = {} do
            ThemeManager.Folder = 'Raven'
            -- if not isfolder(ThemeManager.Folder) then makefolder(ThemeManager.Folder) end
        
            ThemeManager.Library = nil
	    --	    --
	    	    --
		    	    --
			    	    --
				    	    --
            ThemeManager.BuiltInThemes = {
                ['Sunset Orange Dark'] = { 1, httpService:JSONDecode('{"FontColor":"d7d7d7","OutlineColor":"422603","MainColor":"422603","BackgroundColor":"422603","AccentColor":"422603"}') },
                ['Sunset  Amoled'] = { 2, httpService:JSONDecode('{"FontColor":"d7d7d7","OutlineColor":"422603","MainColor":"422603","BackgroundColor":"422603","AccentColor":"422603"}') },
                ['Royal  Dark'] = { 7, httpService:JSONDecode('{"FontColor":"d7d7d7","OutlineColor":"422603","MainColor":"422603","BackgroundColor":"422603","AccentColor":"422603"}') },
                ['Royal Blue Amoled'] = { 8, httpService:JSONDecode('{"FontColor":"d7d7d7","OutlineColor":"422603","MainColor":"422603","BackgroundColor":"422603","AccentColor":"422603"}') },
                ['Scarlet Dark'] = { 3, httpService:JSONDecode('{"FontColor":"d7d7d7","OutlineColor":"422603","MainColor":"422603","BackgroundColor":"422603","AccentColor":"422603"}') },
                ['Scarlet Amoled'] = { 4, httpService:JSONDecode('{"FontColor":"d7d7d7","OutlineColor":"422603","MainColor":"422603","BackgroundColor":"422603","AccentColor":"422603"}') },
                ['AmethystDark'] = { 5, httpService:JSONDecode('{"FontColor":"d7d7d7","OutlineColor":"422603","MainColor":"422603","BackgroundColor":"422603","AccentColor":"422603"}') },
                ['Amethyst Amoled'] = { 6, httpService:JSONDecode('{"FontColor":"d7d7d7","OutlineColor":"422603","MainColor":"422603","BackgroundColor":"422603","AccentColor":"422603"}') },
        }
        
            function ThemeManager:ApplyTheme(theme)
                local customThemeData = self:GetCustomTheme(theme)
                local data = customThemeData or self.BuiltInThemes[theme]
        
                if not data then return end
        
                local scheme = data[2]
                for idx, col in next, customThemeData or scheme do
                    self.Library[idx] = _FromHex(col)
                    
                    if Options[idx] then
                        Options[idx]:SetValueRGB(_FromHex(col))
                    end
                end
        
                self:ThemeUpdate()
            end
        
            function ThemeManager:ThemeUpdate()
                -- This allows us to force apply themes without loading the themes tab :)
                local options = { "FontColor", "MainColor", "AccentColor", "BackgroundColor", "OutlineColor" }
                for i, field in next, options do
                    if Options and Options[field] then
                        self.Library[field] = Options[field].Value
                    end
                end
        
                self.Library.AccentColorDark = self.Library:GetDarkerColor(self.Library.AccentColor);
                self.Library.AccentColorLight = self.Library:GetLighterColor(self.Library.AccentColor);
                self.Library.FontColorDark = self.Library:GetDarkerColor(self.Library.FontColor);
                self.Library.MainColorLight = self.Library:GetLighterColor(self.Library.MainColor);
                self.Library:UpdateColorsUsingRegistry()
            end
        
            function ThemeManager:LoadDefault()		
                local theme = 'Default'
                local content = isfile(self.Folder .. '/themes/default.txt') and readfile(self.Folder .. '/themes/default.txt')
        
                local isDefault = true
                if content then
                    if self.BuiltInThemes[content] then
                        theme = content
                    elseif self:GetCustomTheme(content) then
                        theme = content
                        isDefault = false;
                    end
                elseif self.BuiltInThemes[self.DefaultTheme] then
                    theme = self.DefaultTheme
                end
        
                if isDefault then
                    Options.ThemeManager_ThemeList:SetValue(theme)
                else
                    self:ApplyTheme(theme)
                end
            end
        
            function ThemeManager:SaveDefault(theme)
                writefile(self.Folder .. '/themes/default.txt', theme)
            end
        
            function ThemeManager:CreateThemeManager(groupbox)
                groupbox:AddLabel('Background color'):AddColorPicker('BackgroundColor', { Default = self.Library.BackgroundColor });
                groupbox:AddLabel('Main color')	:AddColorPicker('MainColor', { Default = self.Library.MainColor });
                groupbox:AddLabel('Accent color'):AddColorPicker('AccentColor', { Default = self.Library.AccentColor });
                groupbox:AddLabel('Outline color'):AddColorPicker('OutlineColor', { Default = self.Library.OutlineColor });
                groupbox:AddLabel('Font color')	:AddColorPicker('FontColor', { Default = self.Library.FontColor });
        
                local ThemesArray = {}
                for Name, Theme in next, self.BuiltInThemes do
                    _TableInsert(ThemesArray, Name)
                end
        
                _TableSort(ThemesArray, function(a, b) return self.BuiltInThemes[a][1] < self.BuiltInThemes[b][1] end)
        
                groupbox:AddDivider()
                groupbox:AddDropdown('ThemeManager_ThemeList', { Text = 'Theme list', Values = ThemesArray, Default = 1 })
        
                groupbox:AddButton('Set as default', function()
                    self:SaveDefault(Options.ThemeManager_ThemeList.Value)
                    self.Library:Notify(_StringFormat('Set default theme to %q', Options.ThemeManager_ThemeList.Value))
                end)
        
                Options.ThemeManager_ThemeList:OnChanged(function()
                    self:ApplyTheme(Options.ThemeManager_ThemeList.Value)
                end)
        
                groupbox:AddDivider()
                groupbox:AddInput('ThemeManager_CustomThemeName', { Text = 'Custom theme name' })
                groupbox:AddDropdown('ThemeManager_CustomThemeList', { Text = 'Custom themes', Values = self:ReloadCustomThemes(), AllowNull = true, Default = 1 })
                groupbox:AddDivider()
                
                groupbox:AddButton('Save theme', function() 
                    self:SaveCustomTheme(Options.ThemeManager_CustomThemeName.Value)
        
                    Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
                    Options.ThemeManager_CustomThemeList:SetValue(nil)
                end):AddButton('Load theme', function() 
                    self:ApplyTheme(Options.ThemeManager_CustomThemeList.Value) 
                end)
        
                groupbox:AddButton('Refresh list', function()
                    Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
                    Options.ThemeManager_CustomThemeList:SetValue(nil)
                end)
        
                groupbox:AddButton('Set as default', function()
                    if Options.ThemeManager_CustomThemeList.Value ~= nil and Options.ThemeManager_CustomThemeList.Value ~= '' then
                        self:SaveDefault(Options.ThemeManager_CustomThemeList.Value)
                        self.Library:Notify(_StringFormat('Set default theme to %q', Options.ThemeManager_CustomThemeList.Value))
                    end
                end)
        
                ThemeManager:LoadDefault()
        
                local function UpdateTheme()
                    self:ThemeUpdate()
                end
        
                Options.BackgroundColor:OnChanged(UpdateTheme)
                Options.MainColor:OnChanged(UpdateTheme)
                Options.AccentColor:OnChanged(UpdateTheme)
                Options.OutlineColor:OnChanged(UpdateTheme)
                Options.FontColor:OnChanged(UpdateTheme)
            end
        
            function ThemeManager:GetCustomTheme(file)
                local path = self.Folder .. '/themes/' .. file
                if not isfile(path) then
                    return nil
                end
        
                local data = readfile(path)
                local success, decoded = _Pcall(httpService.JSONDecode, httpService, data)
                
                if not success then
                    return nil
                end
        
                return decoded
            end
        
            function ThemeManager:SaveCustomTheme(file)
                if _StringGsub(file, ' ', '') == '' then
                    return self.Library:Notify('Invalid file name for theme (empty)', 3)
                end
        
                local theme = {}
                local fields = { "FontColor", "MainColor", "AccentColor", "BackgroundColor", "OutlineColor" }
        
                for _, field in next, fields do
                    theme[field] = _ToHex(Options[field].Value)
                end
        
                writefile(self.Folder .. '/themes/' .. file .. '.json', httpService:JSONEncode(theme))
            end
        
            function ThemeManager:ReloadCustomThemes()
                local list = listfiles(self.Folder .. '/themes')
        
                local out = {}
                for i = 1, #list do
                    local file = list[i]
                    if file:sub(-5) == '.json' then
                        -- i hate this but it has to be done ...
        
                        local pos = _StringFind(file, '.json', 1, true)
                        local char = file:sub(pos, pos)
        
                        while char ~= '/' and char ~= '\\' and char ~= '' do
                            pos = pos - 1
                            char = file:sub(pos, pos)
                        end
        
                        if char == '/' or char == '\\' then
                            _TableInsert(out, file:sub(pos + 1))
                        end
                    end
                end
        
                return out
            end
        
            function ThemeManager:SetLibrary(lib)
                self.Library = lib
            end
        
            function ThemeManager:BuildFolderTree()
                local paths = {}
        
                -- build the entire tree if a path is like some-hub/phantom-forces
                -- makefolder builds the entire tree on Synapse X but not other exploits
        
                local parts = _StringSplit(self.Folder, '/')
                for idx = 1, #parts do
                    paths[#paths + 1] = _TableConcat(parts, '/', 1, idx)
                end
        
                _TableInsert(paths, self.Folder .. '/themes')
                _TableInsert(paths, self.Folder .. '/settings')
        
                for i = 1, #paths do
                    local str = paths[i]
                    if not isfolder(str) then
                        makefolder(str)
                    end
                end
            end
        
            function ThemeManager:SetFolder(folder)
                self.Folder = folder
                self:BuildFolderTree()
            end
        
            function ThemeManager:CreateGroupBox(tab)
                assert(self.Library, 'Must set ThemeManager.Library first!')
                return tab:AddLeftGroupbox('Themes')
            end
        
            function ThemeManager:ApplyToTab(tab)
                assert(self.Library, 'Must set ThemeManager.Library first!')
                local groupbox = self:CreateGroupBox(tab)
                self:CreateThemeManager(groupbox)
            end
        
            function ThemeManager:ApplyToGroupbox(groupbox)
                assert(self.Library, 'Must set ThemeManager.Library first!')
                self:CreateThemeManager(groupbox)
            end
        
            ThemeManager:BuildFolderTree()
        end
        getgenv().ThemeManager = ThemeManager
    
    
    local SaveManager = {} do
            SaveManager.Folder = 'Raven'
            SaveManager.Ignore = {}
            SaveManager.Parser = {
                Toggle = {
                    Save = function(idx, object) 
                        return { type = 'Toggle', idx = idx, value = object.Value } 
                    end,
                    Load = function(idx, data)
                        if Toggles[idx] then 
                            Toggles[idx]:SetValue(data.value)
                        end
                    end,
                },
                Slider = {
                    Save = function(idx, object)
                        return { type = 'Slider', idx = idx, value = _tostring(object.Value) }
                    end,
                    Load = function(idx, data)
                        if Options[idx] then 
                            Options[idx]:SetValue(data.value)
                        end
                    end,
                },
                Dropdown = {
                    Save = function(idx, object)
                        return { type = 'Dropdown', idx = idx, value = object.Value, mutli = object.Multi }
                    end,
                    Load = function(idx, data)
                        if Options[idx] then 
                            Options[idx]:SetValue(data.value)
                        end
                    end,
                },
                ColorPicker = {
                    Save = function(idx, object)
                        return { type = 'ColorPicker', idx = idx, value = _ToHex(object.Value), transparency = object.Transparency }
                    end,
                    Load = function(idx, data)
                        if Options[idx] then 
                            Options[idx]:SetValueRGB(_FromHex(data.value), data.transparency)
                        end
                    end,
                },
                KeyPicker = {
                    Save = function(idx, object)
                        return { type = 'KeyPicker', idx = idx, mode = object.Mode, key = object.Value }
                    end,
                    Load = function(idx, data)
                        if Options[idx] then 
                            Options[idx]:SetValue({ data.key, data.mode })
                        end
                    end,
                },
        
                Input = {
                    Save = function(idx, object)
                        return { type = 'Input', idx = idx, text = object.Value }
                    end,
                    Load = function(idx, data)
                        if Options[idx] and _Type(data.text) == 'string' then
                            Options[idx]:SetValue(data.text)
                        end
                    end,
                },
            }
        
            function SaveManager:SetIgnoreIndexes(list)
                for _, key in next, list do
                    self.Ignore[key] = true
                end
            end
        
            function SaveManager:SetFolder(folder)
                self.Folder = folder;
                self:BuildFolderTree()
            end
        
            function SaveManager:Save(name)
                if (not name) then
                    return false, 'no config file is selected'
                end
        
                local fullPath = self.Folder .. '/settings/' .. name .. '.json'
        
                local data = {
                    objects = {}
                }
        
                for idx, toggle in next, Toggles do
                    if self.Ignore[idx] then continue end
        
                    _TableInsert(data.objects, self.Parser[toggle.Type].Save(idx, toggle))
                end
        
                for idx, option in next, Options do
                    if not self.Parser[option.Type] then continue end
                    if self.Ignore[idx] then continue end
        
                    _TableInsert(data.objects, self.Parser[option.Type].Save(idx, option))
                end	
        
                local success, encoded = _Pcall(httpService.JSONEncode, httpService, data)
                if not success then
                    return false, 'failed to encode data'
                end
        
                writefile(fullPath, encoded)
                return true
            end
        
            function SaveManager:Load(name)
                if (not name) then
                    return false, 'no config file is selected'
                end
                
                local file = self.Folder .. '/settings/' .. name .. '.json'
                if not isfile(file) then return false, 'invalid file' end
        
                local success, decoded = _Pcall(httpService.JSONDecode, httpService, readfile(file))
                if not success then return false, 'decode error' end
                
                Library.LoadingCFG = true
                for _, option in next, decoded.objects do _TaskWait()
                    if self.Parser[option.type] then
                        _TaskSpawn(function()                             
                            self.Parser[option.type].Load(option.idx, option) 
                        end) -- _TaskSpawn() so the config loading wont get stuck.
                    end
                end
                
                Library.LoadingCFG = false
                return true
            end
            function SaveManager:LoadTemp()
                
                local file = self.Folder .. '/TempLoad.json'
                if not isfile(file) then return false, 'invalid file' end
                
                local success, decoded = _Pcall(httpService.JSONDecode, httpService, readfile(file))
                if not success then return false, 'decode error' end
                
                Library.LoadingCFG = true
                for _, option in next, decoded.objects do _TaskWait()
                    if self.Parser[option.type] then
                        _TaskSpawn(function()                             
                            self.Parser[option.type].Load(option.idx, option) 
                        end) -- _TaskSpawn() so the config loading wont get stuck.
                    end
                end
                delfile(file)
                Library.LoadingCFG = false
                return true
            end
            function SaveManager:SaveTemp()                
                local fullPath = self.Folder .. '/TempLoad.json'                

                local data = {
                    objects = {}
                }
        
                for idx, toggle in next, Toggles do
                    if self.Ignore[idx] then continue end
        
                    _TableInsert(data.objects, self.Parser[toggle.Type].Save(idx, toggle))
                end
        
                for idx, option in next, Options do
                    if not self.Parser[option.Type] then continue end
                    if self.Ignore[idx] then continue end
        
                    _TableInsert(data.objects, self.Parser[option.Type].Save(idx, option))
                end	
        
                local success, encoded = _Pcall(httpService.JSONEncode, httpService, data)
                if not success then
                    return false, 'failed to encode data'
                end
        
                writefile(fullPath, encoded)
                return true
            end

            function SaveManager:Remove(name)
                if (not name) then
                    return false, 'no config file is selected'
                end
                
                local file = self.Folder .. '/settings/' .. name .. '.json'
                if not isfile(file) then return false, 'invalid file' end
                delfile(file)
        
                return true
            end
        
            function SaveManager:IgnoreThemeSettings()
                self:SetIgnoreIndexes({ 
                    "BackgroundColor", "MainColor", "AccentColor", "OutlineColor", "FontColor", -- themes
                    "ThemeManager_ThemeList", 'ThemeManager_CustomThemeList', 'ThemeManager_CustomThemeName', -- themes
                })
            end
        
            function SaveManager:BuildFolderTree()
                local paths = {
                    self.Folder,
                    self.Folder .. '/settings'
                }
        
                for i = 1, #paths do
                    local str = paths[i]
                    if not isfolder(str) then
                        makefolder(str)
                    end
                end
            end
        
            function SaveManager:RefreshConfigList()
                local list = listfiles(self.Folder .. '/settings')
        
                local out = {}
                for i = 1, #list do
                    local file = list[i]
                    if file:sub(-5) == '.json' then
                        -- i hate this but it has to be done ...

                        local pos = _StringFind(file, '.json', 1, true)
                        local start = pos
        
                        local char = file:sub(pos, pos)
                        while char ~= '/' and char ~= '\\' and char ~= '' do
                            pos = pos - 1
                            char = file:sub(pos, pos)
                        end
        
                        if char == '/' or char == '\\' then
                            _TableInsert(out, file:sub(pos + 1, start - 1))
                        end
                    end
                end
                
                return out
            end
        
            function SaveManager:SetLibrary(library)
                self.Library = library
            end
        
            function SaveManager:BuildConfigSection(tab)
                assert(self.Library, 'Must set SaveManager.Library')
        
                local section = tab:AddRightGroupbox('Configuration')
        
                section:AddInput('SaveManager_ConfigName',    { Text = 'Config name' })
                section:AddDropdown('SaveManager_ConfigList', { Text = 'Config list', Values = self:RefreshConfigList(), AllowNull = true })
        
                section:AddDivider()
        
                section:AddButton({Text = "Create config", DoubleClick = true, Func = function()
                    local name = Options.SaveManager_ConfigName.Value
        
                    if _StringGsub(name, ' ', '') == '' then 
                        return self.Library:Notify('Invalid config name (empty)', 2)
                    end
        
                    local success, err = self:Save(name)
                    if not success then
                        return self.Library:Notify('Failed to save config: ' .. err)
                    end
        
                    self.Library:Notify(_StringFormat('Created config %q', name))
        
                    Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
                    Options.SaveManager_ConfigList:SetValue(nil)
                end}):AddButton({Text = "Load config", DoubleClick = true, Func = function()
                    local name = Options.SaveManager_ConfigList.Value
        
                    local success, err = self:Load(name)
                    if not success then
                        return self.Library:Notify('Failed to load config: ' .. err)
                    end
        
                    self.Library:Notify(_StringFormat('Loaded config %q', name))
                end})
        
                section:AddButton({Text = "Save config", DoubleClick = true, Func = function()
                    local name = Options.SaveManager_ConfigList.Value
        
                    local success, err = self:Save(name)
                    if not success then
                        return self.Library:Notify('Failed to Save config: ' .. err)
                    end
        
                    self.Library:Notify(_StringFormat('Save config %q', name))
                end}):AddButton({Text = "Remove config", DoubleClick = true, Func = function()
                    local name = Options.SaveManager_ConfigList.Value
                    
                    local success, err = self:Remove(name)
                    if not success then
                        return self.Library:Notify('Failed to Remove config: ' .. err)
                    end
    
                    self.Library:Notify(_StringFormat('Removed config %q', name))
                    Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
                    Options.SaveManager_ConfigList:SetValue(nil)
                end})
                section:AddButton({Text = "Load Latest Config", DoubleClick = true, Func = function()
                    SaveManager:LoadTemp()
                end})
        
                section:AddButton('Refresh list', function()
                    Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
                    Options.SaveManager_ConfigList:SetValue(nil)
                end)
        
                SaveManager:SetIgnoreIndexes({ 'SaveManager_ConfigList', 'SaveManager_ConfigName' })
            end
        
            SaveManager:BuildFolderTree()
        end
        getgenv().SaveManager = SaveManager
    
    local EspPreviewManager = {Window = nil, VisualsTab = nil, MainFrame = nil, CanRender = false} do
            function EspPreviewManager:CreateCharacter()
                local PlayerModel = _Instancenew("Model")

                local Humanoid = _Instancenew("Humanoid")
                Humanoid.Parent = PlayerModel
                Humanoid.Health = 100
                Humanoid.MaxHealth = 100
                Humanoid.DisplayName = "\1"

                local HumanoidRootPart = _Instancenew("Part")
                HumanoidRootPart.Parent = PlayerModel
                HumanoidRootPart.Transparency = 1
                HumanoidRootPart.Anchored = true
                HumanoidRootPart.Name = "HumanoidRootPart"
                HumanoidRootPart.Size = _Vector3New(2, 2, 1)
                PlayerModel.PrimaryPart = HumanoidRootPart

                local Head = _Instancenew("Part")
                Head.Parent = PlayerModel
                Head.Anchored = true
                Head.Name = "Head"
                Head.Size = _Vector3New(2, 1, 1)
                Head.Position = HumanoidRootPart.Position + _Vector3New(0,1.5,0)
                local Face = _Instancenew("Decal")
                Face.Face = "Front"
                Face.Name = "face"
                Face.Texture = "rbxasset://textures/face.png"
                Face.Parent = Head

                local Mesh = _Instancenew("SpecialMesh")
                Mesh.Name = "Mesh"
                Mesh.Scale = _Vector3New(1.25, 1.25, 1.25)
                Mesh.MeshType = Enum.MeshType.Head
                Mesh.Parent = Head

                local Torso = _Instancenew("Part")
                Torso.Parent = PlayerModel
                Torso.Anchored = true
                Torso.Name = "Torso"
                Torso.Size = _Vector3New(2, 2, 1)
                Torso.Position = HumanoidRootPart.Position

                
                local LeftLeg = _Instancenew("Part")
                LeftLeg.Parent = PlayerModel
                LeftLeg.Anchored = true
                LeftLeg.Name = "Left Leg"
                LeftLeg.Size = _Vector3New(1, 2, 1)
                LeftLeg.Position = HumanoidRootPart.Position + _Vector3New(-0.5, -2, 0)
                local RightLeg = _Instancenew("Part")
                RightLeg.Parent = PlayerModel
                RightLeg.Anchored = true
                RightLeg.Name = "Right Leg"
                RightLeg.Size = _Vector3New(1, 2, 1)
                RightLeg.Position = HumanoidRootPart.Position + _Vector3New(0.5, -2, 0)

                local LeftArm = _Instancenew("Part")
                LeftArm.Parent = PlayerModel
                LeftArm.Anchored = true
                LeftArm.Name = "Left Arm"
                LeftArm.Size = _Vector3New(1, 2, 1)
                LeftArm.Position = HumanoidRootPart.Position + _Vector3New(-1.5, 0, 0)
                local RightArm = _Instancenew("Part")
                RightArm.Parent = PlayerModel
                RightArm.Anchored = true
                RightArm.Name = "Right Arm"
                RightArm.Size = _Vector3New(1, 2, 1)
                RightArm.Position = HumanoidRootPart.Position + _Vector3New(1.5, 0, 0)

                return PlayerModel
            end
            function EspPreviewManager:Init(Window, VisualsTab)
                EspPreviewManager.Window = Window
                EspPreviewManager.VisualsTab = VisualsTab
                local Character = EspPreviewManager:CreateCharacter()
                Character.Name = "Dummy"
                local FakePlayer = {
                    Name = "Dummy",
                    FakePlayer = true;
                    Character = Character,
                    Team = _Instancenew("Team"),
                    Parent = Players,
                }

                local MainFrame = Library:Create('Frame', {
                    BackgroundColor3 = Library.MainColor;
                    BorderColor3 = Library.AccentColor;
                    BorderMode = Enum.BorderMode.Inset;
                    Position = _UDim2New(1, 25, 0, 0);
                    Size = _UDim2New(0.4, -2, 0.6, 0);
                    ZIndex = 1;
                    Parent = Window.MainFrame;
                });
                EspPreviewManager.MainFrame = MainFrame
                
                Library:AddToRegistry(MainFrame, {
                    BackgroundColor3 = 'MainColor';
                    BorderColor3 = 'AccentColor';
                });

                local ViewPort = Library:Create('ViewportFrame', {
                    BackgroundTransparency = 1;
                    Parent = MainFrame;
                    Visible = true;
                    Size = _UDim2New(1,0,1,0);
                });

                local CurrentCamera = Library:Create('Camera', {
                    Parent = ViewPort;
                    CFrame = _CFrameNew();
                });
                ViewPort.CurrentCamera = CurrentCamera
                Character.Parent = ViewPort
                Character:SetPrimaryPartCFrame(_CFrameNew(0,0.5,-6.25) * _CFrameAngles(0,_MathRad(180),0))

                Library:AddSignal(RunService.PreRender, function()
                    if VisualsTab.MainFrame.Visible and Window.MainFrame.Visible then
                        MainFrame.Visible = true
                    else
                        MainFrame.Visible = false
                    end
                    EspPreviewManager.CanRender = VisualsTab.MainFrame.Visible and Window.MainFrame.Visible
                end)
                return FakePlayer
            end
        end
        getgenv().EspPreviewManager = EspPreviewManager

    local function GetPlayersString()
        local PlayerList = _GetPlayers(Players);
        for i = 1, #PlayerList do
            PlayerList[i] = PlayerList[i].Name
        end;
    
        _TableSort(PlayerList, function(str1, str2) return str1 < str2 end);
    
        return PlayerList;
    end;
    
    local function GetTeamsString()
        local TeamList = Teams:GetTeams();
    
        for i = 1, #TeamList do
            TeamList[i] = TeamList[i].Name;
        end;
    
        _TableSort(TeamList, function(str1, str2) return str1 < str2 end);
        
        return TeamList;
    end;
    
    function Library:SafeCallback(f, ...)
        if (not f) then
            return;
        end;
    
        if not Library.NotifyOnError then
            return f(...);
        end;
    
        local success, event = _Pcall(f, ...);
    
        if not success then
            local _, i = _StringFind(event, ":%d+: ");
    
            if not i then
                return Library:Notify(event);
            end;
    
            return Library:Notify(event:sub(i + 1), 3);
        end;
    end;
    
    function Library:AttemptSave()
        if Library.SaveManager then
            Library.SaveManager:Save();
        end;
    end;
    
    function Library:Create(Class, Properties)
        local _Instance = Class;
    
        if _Type(Class) == 'string' then
            _Instance = _Instancenew(Class);
        end;
    
        for Property, Value in next, Properties do
            _Instance[Property] = Value;
        end;
    
        return _Instance;
    end;
    
    function Library:ApplyTextStroke(Inst)
        Inst.TextStrokeTransparency = 1;
    
        Library:Create('UIStroke', {
            Color = _Color3New(0, 0, 0);
            Thickness = 1;
            LineJoinMode = Enum.LineJoinMode.Miter;
            Parent = Inst;
        });
    end;
    
    function Library:CreateLabel(Properties, IsHud)
        local _Instance = Library:Create('TextLabel', {
            BackgroundTransparency = 1;
            Font = Library.Font;
            TextColor3 = Library.FontColor;
            TextSize = 16;
            TextStrokeTransparency = 1;
        });
    
        Library:AddToRegistry(_Instance, {
            TextColor3 = 'FontColor';
        }, IsHud);
    
        return Library:Create(_Instance, Properties);
    end;
    
    function Library:MakeDraggable(Instance, Cutoff, Perfomance)
        if not Perfomance then
            Instance.Active = true
        
            local LatestPosition = nil
            local LatestDrag = nil
    
            Instance.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    local ObjPos = _Vector2New(
                        Mouse.X - Instance.AbsolutePosition.X,
                        Mouse.Y - Instance.AbsolutePosition.Y
                    );
                    
                    if ObjPos.Y > (Cutoff or 40) then
                        return
                    end
                    
                    while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                        Instance.Position = _UDim2New(
                            0,
                            Mouse.X - ObjPos.X + (Instance.Size.X.Offset * Instance.AnchorPoint.X),
                            0,
                            Mouse.Y - ObjPos.Y + (Instance.Size.Y.Offset * Instance.AnchorPoint.Y)
                        );
                        
                        _Wait()
                    end
                end
            end) 
        else
            Perfomance.Active = true
            Instance.Active = true
    
            local LatestDrag = nil
    
            Instance.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    local ObjPos = _Vector2New(
                        Mouse.X - Perfomance.AbsolutePosition.X,
                        Mouse.Y - Perfomance.AbsolutePosition.Y
                    );
                    
                    if ObjPos.Y > (Cutoff or 40) then
                        return
                    end
                    
                    while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                        Perfomance.Position = _UDim2New(
                            0,
                            Mouse.X - ObjPos.X + (Perfomance.Size.X.Offset * Perfomance.AnchorPoint.X),
                            0,
                            Mouse.Y - ObjPos.Y + (Perfomance.Size.Y.Offset * Perfomance.AnchorPoint.Y)
                        )
                        Perfomance.Visible = true
                        LatestDrag = Perfomance.Position
                        
                        _Wait()
                    end
                end
            end)
            Instance.InputEnded:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 and LatestDrag then 
                    Perfomance.Visible = false                   
                    Instance.Position = LatestDrag
                end
            end)
        end
        --[[Instance.InputEnded:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                local ObjPos = _Vector2New(
                    Mouse.X - Instance.AbsolutePosition.X,
                    Mouse.Y - Instance.AbsolutePosition.Y
                );
    
                if ObjPos.Y > (Cutoff or 40) then
                    return;
                end;
                
                Instance.Position = LatestDrag
                RenderStepped:Wait();
            end;
        end)]]
    end;
    
    function Library:AddToolTip(InfoStr, HoverInstance)
        -- Tamanho máximo antes de quebrar o texto em uma nova linha
        local MaxWidth = 200
    
        -- Obter o tamanho do texto
        local X, Y = Library:GetTextBounds(InfoStr, Library.Font, 15)
    
        -- Ajusta o texto se ultrapassar o tamanho máximo permitido
        if X > MaxWidth then
            InfoStr = Library:BreakTextIntoLines(InfoStr, MaxWidth, Library.Font, 15) -- Função que quebra o texto
            X, Y = Library:GetTextBounds(InfoStr, Library.Font, 15) -- Recalcula os tamanhos após a quebra
        end
    
        local Tooltip = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor,
            BorderColor3 = Library.OutlineColor,
            Size = _UDim2fromOffset(X + 8, Y + 4),
            ZIndex = 100,
            Parent = Library.ScreenGui,
            Visible = false,
        })
    
        local Label = Library:CreateLabel({
            Position = _UDim2fromOffset(3, 1),
            Size = _UDim2fromOffset(X, Y),
            TextSize = 15,
            Text = InfoStr,
            TextColor3 = Library.FontColor,
            TextXAlignment = Enum.TextXAlignment.Center,
            ZIndex = Tooltip.ZIndex + 1,
            Parent = Tooltip,
        })
    
        Library:AddToRegistry(Tooltip, {
            BackgroundColor3 = 'MainColor',
            BorderColor3 = 'OutlineColor',
        })
    
        Library:AddToRegistry(Label, {
            TextColor3 = 'FontColor',
        })
    
        local IsHovering = false
        local TooltipVisible = false
    
        HoverInstance.MouseEnter:Connect(function()
            if Library:MouseIsOverOpenedFrame() then
                return
            end
    
            IsHovering = true
    
            -- Aguarda o delay de 2 segundos antes de exibir o tooltip
            task.delay(1, function()
                if IsHovering then
                    Tooltip.Position = _UDim2fromOffset(Mouse.X + 15, Mouse.Y + 12)
                    Tooltip.Visible = true
                    TooltipVisible = true
                end
            end)
    
            -- Atualiza a posição do tooltip enquanto o mouse estiver sobre o objeto
            while IsHovering do
                RunService.Heartbeat:Wait()
                Tooltip.Position = _UDim2fromOffset(Mouse.X + 15, Mouse.Y + 12)
            end
        end)
    
        HoverInstance.MouseLeave:Connect(function()
            IsHovering = false
            Tooltip.Visible = false
            TooltipVisible = false
        end)
    end
    
    -- Função auxiliar para quebrar o texto em várias linhas
    function Library:BreakTextIntoLines(text, maxWidth, font, textSize)
        local result = ""
        local currentLine = ""
    
        for word in string.gmatch(text, "%S+") do
            local testLine = currentLine == "" and word or currentLine .. " " .. word
            local lineWidth = Library:GetTextBounds(testLine, font, textSize)
    
            if lineWidth > maxWidth then
                result = result .. (result == "" and currentLine or "\n" .. currentLine)
                currentLine = word
            else
                currentLine = testLine
            end
        end
    
        if currentLine ~= "" then
            result = result .. (result == "" and currentLine or "\n" .. currentLine)
        end
    
        return result
    end
    
    function Library:OnHighlight(HighlightInstance, Instance, Properties, PropertiesDefault)
        HighlightInstance.MouseEnter:Connect(function()
            local Reg = Library.RegistryMap[Instance];
    
            for Property, ColorIdx in next, Properties do
                Instance[Property] = Library[ColorIdx] or ColorIdx;
    
                if Reg and Reg.Properties[Property] then
                    Reg.Properties[Property] = ColorIdx;
                end;
            end;
        end)
    
        HighlightInstance.MouseLeave:Connect(function()
            local Reg = Library.RegistryMap[Instance];
    
            for Property, ColorIdx in next, PropertiesDefault do
                Instance[Property] = Library[ColorIdx] or ColorIdx;
    
                if Reg and Reg.Properties[Property] then
                    Reg.Properties[Property] = ColorIdx;
                end;
            end;
        end)
    end;
    
    function Library:MouseIsOverOpenedFrame()
        for Frame, _ in next, Library.OpenedFrames do
            local AbsPos, AbsSize = Frame.AbsolutePosition, Frame.AbsoluteSize;
    
            if Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X
                and Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y then
    
                return true;
            end;
        end;
    end;
    
    function Library:IsMouseOverFrame(Frame)
        local AbsPos, AbsSize = Frame.AbsolutePosition, Frame.AbsoluteSize;
    
        if Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X
            and Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y then
    
            return true;
        end;
    end;
    
    function Library:UpdateDependencyBoxes()
        for _, Depbox in next, Library.DependencyBoxes do
            Depbox:Update();
        end;
    end;
    
    function Library:MapValue(Value, MinA, MaxA, MinB, MaxB)
        return (1 - ((Value - MinA) / (MaxA - MinA))) * MinB + ((Value - MinA) / (MaxA - MinA)) * MaxB;
    end;
    
    function Library:GetTextBounds(Text, Font, Size, Resolution)
        local Bounds = TextService:GetTextSize(Text, Size, Font, Resolution or _Vector2New(camera.ViewportSize.X, camera.ViewportSize.Y))
        return Bounds.X, Bounds.Y
    end;
    
    function Library:GetDarkerColor(Color)
        local H, S, V = _Color3ToHSV(Color);
        return _Color3FromHSV(H, S, V / 2.5);
    end;
    
    function Library:GetLighterColor(Color)
        local H, S, V = _Color3ToHSV(Color);
        V = _MathClamp(V * 1.5, 0, 1);
        return _Color3FromHSV(H, S, V);
    end;
    
    Library.AccentColorDark = Library:GetDarkerColor(Library.AccentColor);
    Library.AccentColorLight = Library:GetLighterColor(Library.AccentColor);
    Library.FontColorDark = Library:GetDarkerColor(Library.FontColor);
    Library.MainColorLight = Library:GetLighterColor(Library.MainColor);

    function Library:AddToRegistry(Instance, Properties, IsHud)
        local Idx = #Library.Registry + 1;
        local Data = {
            Instance = Instance;
            Properties = Properties;
            Idx = Idx;
        };
    
        _TableInsert(Library.Registry, Data);
        Library.RegistryMap[Instance] = Data;
    
        if IsHud then
            _TableInsert(Library.HudRegistry, Data);
        end;
    end;
    
    function Library:RemoveFromRegistry(Instance)
        local Data = Library.RegistryMap[Instance];
    
        if Data then
            for Idx = #Library.Registry, 1, -1 do
                if Library.Registry[Idx] == Data then
                    _TableRemove(Library.Registry, Idx);
                end;
            end;
    
            for Idx = #Library.HudRegistry, 1, -1 do
                if Library.HudRegistry[Idx] == Data then
                    _TableRemove(Library.HudRegistry, Idx);
                end;
            end;
    
            Library.RegistryMap[Instance] = nil;
        end;
    end;
    
    function Library:UpdateColorsUsingRegistry()
        -- TODO: Could have an 'active' list of objects
        -- where the active list only contains Visible objects.
    
        -- IMPL: Could setup .Changed events on the AddToRegistry function
        -- that listens for the 'Visible' propert being changed.
        -- Visible: true => Add to active list, and call UpdateColors function
        -- Visible: false => Remove from active list.
    
        -- The above would be especially efficient for a rainbow menu color or live color-changing.
    
        for Idx, Object in next, Library.Registry do
            for Property, ColorIdx in next, Object.Properties do
                if _Type(ColorIdx) == 'string' then
                    Object.Instance[Property] = Library[ColorIdx];
                elseif _Type(ColorIdx) == 'function' then
                    Object.Instance[Property] = ColorIdx()
                end
            end;
        end;
    end;
    
    function Library:GiveSignal(Signal)
        -- Only used for signals not attached to library instances, as those should be cleaned up on object destruction by Roblox
        _TableInsert(Library.Signals, Signal)
    end
    function Library:AddSignal(signal, func)

        local connectedsignal = signal:Connect(func)
        Library:GiveSignal(connectedsignal)
        return connectedsignal
    end
    function Library:Unload()
        -- Unload all of the signals
        for Idx = #Library.Signals, 1, -1 do
            local Connection = _TableRemove(Library.Signals, Idx)
            Connection:Disconnect()
        end
        
        -- Call our unload callback, maybe to undo some hooks etc
        if Library.OnUnload then
            Library.OnUnload()
        end
    
        _Destroy(ScreenGui)
    end
    
    function Library:OnUnload(Callback)
        Library.OnUnload = Callback
    end
    
    Library:GiveSignal(ScreenGui.DescendantRemoving:Connect(function(Instance)
        if Library.RegistryMap[Instance] then
            Library:RemoveFromRegistry(Instance);
        end;
    end))
    
    local BaseAddons = {};
    
    do
        local Funcs = {};
    
        function Funcs:AddColorPicker(Idx, Info)
            local ToggleLabel = self.TextLabel;
            -- local Container = self.Container;
    
            assert(Info.Default, 'AddColorPicker: Missing default value.');
    
            local ColorPicker = {
                Value = Info.Default;
                Transparency = Info.Transparency or 0;
                Type = 'ColorPicker';
                Title = _Type(Info.Title) == 'string' and Info.Title or 'Color picker',
                Callback = Info.Callback or function(Color) end;
            };
    
            function ColorPicker:SetHSVFromRGB(Color)
                local H, S, V = _Color3ToHSV(Color);
                
                ColorPicker.Hue = H;
                ColorPicker.Sat = S;
                ColorPicker.Vib = V;
            end;
    
            ColorPicker:SetHSVFromRGB(ColorPicker.Value);
    
            local DisplayFrame = Library:Create('Frame', {
                BackgroundColor3 = ColorPicker.Value;
                BorderColor3 = Library:GetDarkerColor(ColorPicker.Value);
                BorderMode = Enum.BorderMode.Inset;
                Size = _UDim2New(0, 18, 0, 14);
                ZIndex = 6;
                Parent = ToggleLabel;
            });
    
            -- Transparency image taken from https://github.com/matas3535/SplixPrivateDrawingLibrary/blob/main/Library.lua cus i'm lazy
            local CheckerFrame = Library:Create('ImageLabel', {
                BorderSizePixel = 0;
                Size = _UDim2New(0, 17, 0, 13);
                ZIndex = 5;
                Image = 'http://www.roblox.com/asset/?id=12977615774';
                Visible = not not Info.Transparency;
                Parent = DisplayFrame;
            });
    
            -- 1/16/23
            -- Rewrote this to be placed inside the Library ScreenGui
            -- There was some issue which caused RelativeOffset to be way off
            -- Thus the color picker would never show
    
            local PickerFrameOuter = Library:Create('Frame', {
                Name = 'Color';
                BackgroundColor3 = _Color3New(1, 1, 1);
                BorderColor3 = _Color3New(0, 0, 0);
                BorderSizePixel = 0;
                Position = _UDim2fromOffset(DisplayFrame.AbsolutePosition.X, DisplayFrame.AbsolutePosition.Y + 18),
                Size = _UDim2fromOffset(230, Info.Transparency and 271 or 253);
                Visible = false;
                ZIndex = 15;
                Parent = ScreenGui,
            });
    
            _GetPropertyChangedSignal(DisplayFrame, 'AbsolutePosition'):Connect(function()
                PickerFrameOuter.Position = _UDim2fromOffset(DisplayFrame.AbsolutePosition.X, DisplayFrame.AbsolutePosition.Y + 18);
            end)
    
            local PickerFrameInner = Library:Create('Frame', {
                BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = _UDim2New(1, 0, 1, 0);
                ZIndex = 16;
                Parent = PickerFrameOuter;
            });
    
            local Highlight = Library:Create('Frame', {
                BackgroundColor3 = Library.AccentColor;
                BorderSizePixel = 0;
                Size = _UDim2New(1, 0, 0, 2);
                ZIndex = 17;
                Parent = PickerFrameInner;
            });
    
            local SatVibMapOuter = Library:Create('Frame', {
                BorderColor3 = _Color3New(0, 0, 0);
                BorderSizePixel = 0;
                Position = _UDim2New(0, 4, 0, 25);
                Size = _UDim2New(0, 200, 0, 200);
                ZIndex = 17;
                Parent = PickerFrameInner;
            });
    
            local SatVibMapInner = Library:Create('Frame', {
                BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = _UDim2New(1, 0, 1, 0);
                ZIndex = 18;
                Parent = SatVibMapOuter;
            });
    
            local SatVibMap = Library:Create('ImageLabel', {
                BorderSizePixel = 0;
                Size = _UDim2New(1, 0, 1, 0);
                ZIndex = 18;
                Image = 'rbxassetid://4155801252';
                Parent = SatVibMapInner;
            });
    
            local CursorOuter = Library:Create('ImageLabel', {
                AnchorPoint = _Vector2New(0.5, 0.5);
                Size = _UDim2New(0, 6, 0, 6);
                BackgroundTransparency = 1;
                Image = 'http://www.roblox.com/asset/?id=9619665977';
                ImageColor3 = _Color3New(0, 0, 0);
                ZIndex = 19;
                Parent = SatVibMap;
            });
    
            local CursorInner = Library:Create('ImageLabel', {
                Size = _UDim2New(0, CursorOuter.Size.X.Offset - 2, 0, CursorOuter.Size.Y.Offset - 2);
                Position = _UDim2New(0, 1, 0, 1);
                BackgroundTransparency = 1;
                Image = 'http://www.roblox.com/asset/?id=9619665977';
                ZIndex = 20;
                Parent = CursorOuter;
            })
    
            local HueSelectorOuter = Library:Create('Frame', {
                BorderColor3 = _Color3New(0, 0, 0);
                BorderSizePixel = 0;
                Position = _UDim2New(0, 208, 0, 25);
                Size = _UDim2New(0, 15, 0, 200);
                ZIndex = 17;
                Parent = PickerFrameInner;
            });
    
            local HueSelectorInner = Library:Create('Frame', {
                BackgroundColor3 = _Color3New(1, 1, 1);
                BorderSizePixel = 0;
                Size = _UDim2New(1, 0, 1, 0);
                ZIndex = 18;
                Parent = HueSelectorOuter;
            });
    
            local HueCursor = Library:Create('Frame', { 
                BackgroundColor3 = _Color3New(1, 1, 1);
                AnchorPoint = _Vector2New(0, 0.5);
                BorderColor3 = _Color3New(0, 0, 0);
                Size = _UDim2New(1, 0, 0, 1);
                ZIndex = 18;
                Parent = HueSelectorInner;
            });
    
            local HueBoxOuter = Library:Create('Frame', {
                BorderColor3 = _Color3New(0, 0, 0);
                BorderSizePixel = 0;
                Position = _UDim2fromOffset(4, 228),
                Size = _UDim2New(0.5, -6, 0, 20),
                ZIndex = 18,
                Parent = PickerFrameInner;
            });
    
            local HueBoxInner = Library:Create('Frame', {
                BackgroundColor3 = Library.MainColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = _UDim2New(1, 0, 1, 0);
                ZIndex = 18,
                Parent = HueBoxOuter;
            });
    
            Library:Create('UIGradient', {
                Color = _ColorSequenceNew({
                    _ColorSequenceKeypointNew(0, _Color3New(1, 1, 1)),
                    _ColorSequenceKeypointNew(1, _Color3FromRGB(212, 212, 212))
                });
                Rotation = 90;
                Parent = HueBoxInner;
            });
    
            local HueBox = Library:Create('TextBox', {
                BackgroundTransparency = 1;
                Position = _UDim2New(0, 5, 0, 0);
                Size = _UDim2New(1, -5, 1, 0);
                Font = Library.Font;
                PlaceholderColor3 = _Color3FromRGB(190, 190, 190);
                PlaceholderText = 'Hex color',
                Text = '#FFFFFF',
                TextColor3 = Library.FontColor;
                TextSize = 15;
                ClearTextOnFocus = false,
                TextStrokeTransparency = 1;
                TextXAlignment = Enum.TextXAlignment.Left;
                ZIndex = 20,
                Parent = HueBoxInner;
            });
    
            local RgbBoxBase = Library:Create(_Clone(HueBoxOuter), {
                Position = _UDim2New(0.5, 2, 0, 228),
                Size = _UDim2New(0.5, -6, 0, 20),
                Parent = PickerFrameInner
            });

            local RgbBox = Library:Create(_FindFirstChild(RgbBoxBase.Frame,'TextBox'), {
                Text = '255, 255, 255',
                PlaceholderText = 'RGB color',
                ClearTextOnFocus = false,
                TextColor3 = Library.FontColor
            });
    
            local TransparencyBoxOuter, TransparencyBoxInner, TransparencyCursor;
            
            if Info.Transparency then 
                TransparencyBoxOuter = Library:Create('Frame', {
                    BorderColor3 = _Color3New(0, 0, 0);
                    BorderSizePixel = 0;
                    Position = _UDim2fromOffset(4, 251);
                    Size = _UDim2New(1, -8, 0, 15);
                    ZIndex = 19;
                    Parent = PickerFrameInner;
                });
    
                TransparencyBoxInner = Library:Create('Frame', {
                    BackgroundColor3 = ColorPicker.Value;
                    BorderColor3 = Library.OutlineColor;
                    BorderMode = Enum.BorderMode.Inset;
                    Size = _UDim2New(1, 0, 1, 0);
                    ZIndex = 19;
                    Parent = TransparencyBoxOuter;
                });
    
                Library:AddToRegistry(TransparencyBoxInner, { BorderColor3 = 'OutlineColor' });
    
                Library:Create('ImageLabel', {
                    BackgroundTransparency = 1;
                    Size = _UDim2New(1, 0, 1, 0);
                    Image = 'http://www.roblox.com/asset/?id=12978095818';
                    ZIndex = 20;
                    Parent = TransparencyBoxInner;
                });
    
                TransparencyCursor = Library:Create('Frame', { 
                    BackgroundColor3 = _Color3New(1, 1, 1);
                    AnchorPoint = _Vector2New(0.5, 0);
                    BorderColor3 = _Color3New(0, 0, 0);
                    Size = _UDim2New(0, 1, 1, 0);
                    ZIndex = 21;
                    Parent = TransparencyBoxInner;
                });
            end;
    
            local DisplayLabel = Library:CreateLabel({
                Size = _UDim2New(1, 0, 0, 14);
                Position = _UDim2fromOffset(5, 5);
                TextXAlignment = Enum.TextXAlignment.Left;
                TextSize = 15;
                Text = ColorPicker.Title,--Info.Default;
                TextWrapped = false;
                ZIndex = 16;
                Parent = PickerFrameInner;
            });
    
    
            local ContextMenu = {}
            do
                ContextMenu.Options = {}
                ContextMenu.Container = Library:Create('Frame', {
                    BorderColor3 = _Color3New(),
                    ZIndex = 14,
    
                    Visible = false,
                    Parent = ScreenGui
                })
    
                ContextMenu.Inner = Library:Create('Frame', {
                    BackgroundColor3 = Library.BackgroundColor;
                    BorderColor3 = Library.OutlineColor;
                    BorderMode = Enum.BorderMode.Inset;
                    Size = UDim2.fromScale(1, 1);
                    ZIndex = 15;
                    Parent = ContextMenu.Container;
                });
    
                Library:Create('UIListLayout', {
                    Name = 'Layout',
                    FillDirection = Enum.FillDirection.Vertical;
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    Parent = ContextMenu.Inner;
                });
    
                Library:Create('UIPadding', {
                    Name = 'Padding',
                    PaddingLeft = _UDimNew(0, 4),
                    Parent = ContextMenu.Inner,
                });
    
                local function updateMenuPosition()
                    ContextMenu.Container.Position = _UDim2fromOffset(
                        (DisplayFrame.AbsolutePosition.X + DisplayFrame.AbsoluteSize.X) + 4,
                        DisplayFrame.AbsolutePosition.Y + 1
                    )
                end
    
                local function updateMenuSize()
                    local menuWidth = 60
                    for i, label in next, _GetChildren(ContextMenu.Inner) do
                        if _IsA(label, 'TextLabel') then
                            menuWidth = _MathMax(menuWidth, label.TextBounds.X)
                        end
                    end
    
                    ContextMenu.Container.Size = _UDim2fromOffset(
                        menuWidth + 8,
                        ContextMenu.Inner.Layout.AbsoluteContentSize.Y + 4
                    )
                end
    
                _GetPropertyChangedSignal(DisplayFrame, 'AbsolutePosition'):Connect(updateMenuPosition)
                _GetPropertyChangedSignal(ContextMenu.Inner.Layout, 'AbsoluteContentSize'):Connect(updateMenuSize)
    
                _TaskSpawn(updateMenuPosition)
                _TaskSpawn(updateMenuSize)
    
                Library:AddToRegistry(ContextMenu.Inner, {
                    BackgroundColor3 = 'BackgroundColor';
                    BorderColor3 = 'OutlineColor';
                });
    
                function ContextMenu:Show()
                    self.Container.Visible = true
                end
    
                function ContextMenu:Hide()
                    self.Container.Visible = false
                end
    
                function ContextMenu:AddOption(Str, Callback)
                    if _Type(Callback) ~= 'function' then
                        Callback = function() end
                    end
    
                    local Button = Library:CreateLabel({
                        Active = false;
                        Size = _UDim2New(1, 0, 0, 15);
                        TextSize = 14;
                        Text = Str;
                        ZIndex = 16;
                        Parent = self.Inner;
                        TextXAlignment = Enum.TextXAlignment.Left,
                    });
    
                    Library:OnHighlight(Button, Button, 
                        { TextColor3 = 'AccentColor' },
                        { TextColor3 = 'FontColor' }
                    );
    
                    Button.InputBegan:Connect(function(Input)
                        if Input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                            return
                        end
    
                        Callback()
                    end)
                end
    
                ContextMenu:AddOption('Copy color', function()
                    Library.ColorClipboard = ColorPicker.Value
                    Library:Notify('Copied color!', 2)
                end)
    
                ContextMenu:AddOption('Paste color', function()
                    if not Library.ColorClipboard then
                        return Library:Notify('You have not copied a color!', 2)
                    end
                    ColorPicker:SetValueRGB(Library.ColorClipboard)
                end)
    
    
                ContextMenu:AddOption('Copy HEX', function()
                    _Pcall(setclipboard, _ToHex(ColorPicker.Value))
                    Library:Notify('Copied hex code to clipboard!', 2)
                end)
    
                ContextMenu:AddOption('Copy RGB', function()
                    _Pcall(setclipboard, _TableConcat({ _MathFloor(ColorPicker.Value.R * 255), _MathFloor(ColorPicker.Value.G * 255), _MathFloor(ColorPicker.Value.B * 255) }, ', '))
                    Library:Notify('Copied RGB values to clipboard!', 2)
                end)
    
            end
    
            Library:AddToRegistry(PickerFrameInner, { BackgroundColor3 = 'BackgroundColor'; BorderColor3 = 'OutlineColor'; });
            Library:AddToRegistry(Highlight, { BackgroundColor3 = 'AccentColor'; });
            Library:AddToRegistry(SatVibMapInner, { BackgroundColor3 = 'BackgroundColor'; BorderColor3 = 'OutlineColor'; });
    
            Library:AddToRegistry(HueBoxInner, { BackgroundColor3 = 'MainColor'; BorderColor3 = 'OutlineColor'; });
            Library:AddToRegistry(RgbBoxBase.Frame, { BackgroundColor3 = 'MainColor'; BorderColor3 = 'OutlineColor'; });
            Library:AddToRegistry(RgbBox, { TextColor3 = 'FontColor', });
            Library:AddToRegistry(HueBox, { TextColor3 = 'FontColor', });
    
            local SequenceTable = {};
    
            for Hue = 0, 1, 0.1 do
                _TableInsert(SequenceTable, _ColorSequenceKeypointNew(Hue, _Color3FromHSV(Hue, 1, 1)));
            end;
    
            local HueSelectorGradient = Library:Create('UIGradient', {
                Color = _ColorSequenceNew(SequenceTable);
                Rotation = 90;
                Parent = HueSelectorInner;
            });
    
            HueBox.FocusLost:Connect(function(enter)
                if enter then
                    local success, result = _Pcall(_FromHex, HueBox.Text)
                    if success and typeof(result) == 'Color3' then
                        ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib = _Color3ToHSV(result)
                    end
                end
    
                ColorPicker:Display()
            end)
    
            RgbBox.FocusLost:Connect(function(enter)
                if enter then
                    local r, g, b = RgbBox.Text:match('(%d+),%s*(%d+),%s*(%d+)')
                    if r and g and b then
                        ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib = _Color3ToHSV(_Color3FromRGB(r, g, b))
                    end
                end
    
                ColorPicker:Display()
            end)
    
            function ColorPicker:Display()
                ColorPicker.Value = _Color3FromHSV(ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib);
                SatVibMap.BackgroundColor3 = _Color3FromHSV(ColorPicker.Hue, 1, 1);
    
                Library:Create(DisplayFrame, {
                    BackgroundColor3 = ColorPicker.Value;
                    BackgroundTransparency = ColorPicker.Transparency;
                    BorderColor3 = Library:GetDarkerColor(ColorPicker.Value);
                });
    
                if TransparencyBoxInner then
                    TransparencyBoxInner.BackgroundColor3 = ColorPicker.Value;
                    TransparencyCursor.Position = _UDim2New(1 - ColorPicker.Transparency, 0, 0, 0);
                end;
    
                CursorOuter.Position = _UDim2New(ColorPicker.Sat, 0, 1 - ColorPicker.Vib, 0);
                HueCursor.Position = _UDim2New(0, 0, ColorPicker.Hue, 0);
    
                HueBox.Text = '#' .. _ToHex(ColorPicker.Value)
                RgbBox.Text = _TableConcat({ _MathFloor(ColorPicker.Value.R * 255), _MathFloor(ColorPicker.Value.G * 255), _MathFloor(ColorPicker.Value.B * 255) }, ', ')
    
                Library:SafeCallback(ColorPicker.Callback, ColorPicker.Value);
                Library:SafeCallback(ColorPicker.Changed, ColorPicker.Value);
            end;
    
            function ColorPicker:OnChanged(Func)
                ColorPicker.Changed = Func;
                Func(ColorPicker.Value)
            end;
    
            function ColorPicker:Show()
                for Frame, Val in next, Library.OpenedFrames do
                    if Frame.Name == 'Color' then
                        Frame.Visible = false;
                        Library.OpenedFrames[Frame] = nil;
                    end;
                end;
    
                PickerFrameOuter.Visible = true;
                Library.OpenedFrames[PickerFrameOuter] = true;
            end;
    
            function ColorPicker:Hide()
                PickerFrameOuter.Visible = false;
                Library.OpenedFrames[PickerFrameOuter] = nil;
            end;
    
            function ColorPicker:SetValue(HSV, Transparency)
                local Color = _Color3FromHSV(HSV[1], HSV[2], HSV[3]);
    
                ColorPicker.Transparency = Transparency or 0;
                ColorPicker:SetHSVFromRGB(Color);
                ColorPicker:Display();
            end;
    
            function ColorPicker:SetValueRGB(Color, Transparency)
                ColorPicker.Transparency = Transparency or 0;
                ColorPicker:SetHSVFromRGB(Color);
                ColorPicker:Display();
            end;
    
            SatVibMap.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                        local MinX = SatVibMap.AbsolutePosition.X;
                        local MaxX = MinX + SatVibMap.AbsoluteSize.X;
                        local MouseX = _MathClamp(Mouse.X, MinX, MaxX);
    
                        local MinY = SatVibMap.AbsolutePosition.Y;
                        local MaxY = MinY + SatVibMap.AbsoluteSize.Y;
                        local MouseY = _MathClamp(Mouse.Y, MinY, MaxY);
    
                        ColorPicker.Sat = (MouseX - MinX) / (MaxX - MinX);
                        ColorPicker.Vib = 1 - ((MouseY - MinY) / (MaxY - MinY));
                        ColorPicker:Display();
    
                        RenderStepped:Wait();
                    end;
    
                    Library:AttemptSave();
                end;
            end);
    
            HueSelectorInner.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                        local MinY = HueSelectorInner.AbsolutePosition.Y;
                        local MaxY = MinY + HueSelectorInner.AbsoluteSize.Y;
                        local MouseY = _MathClamp(Mouse.Y, MinY, MaxY);
    
                        ColorPicker.Hue = ((MouseY - MinY) / (MaxY - MinY));
                        ColorPicker:Display();
    
                        RenderStepped:Wait();
                    end;
    
                    Library:AttemptSave();
                end;
            end);
    
            DisplayFrame.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
                    if PickerFrameOuter.Visible then
                        ColorPicker:Hide()
                    else
                        ContextMenu:Hide()
                        ColorPicker:Show()
                    end;
                elseif Input.UserInputType == Enum.UserInputType.MouseButton2 and not Library:MouseIsOverOpenedFrame() then
                    ContextMenu:Show()
                    ColorPicker:Hide()
                end
            end);
    
            if TransparencyBoxInner then
                TransparencyBoxInner.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                        while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                            local MinX = TransparencyBoxInner.AbsolutePosition.X;
                            local MaxX = MinX + TransparencyBoxInner.AbsoluteSize.X;
                            local MouseX = _MathClamp(Mouse.X, MinX, MaxX);
    
                            ColorPicker.Transparency = 1 - ((MouseX - MinX) / (MaxX - MinX));
    
                            ColorPicker:Display();
    
                            RenderStepped:Wait();
                        end;
    
                        Library:AttemptSave();
                    end;
                end);
            end;
    
            Library:GiveSignal(InputService.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    local AbsPos, AbsSize = PickerFrameOuter.AbsolutePosition, PickerFrameOuter.AbsoluteSize;
    
                    if Mouse.X < AbsPos.X or Mouse.X > AbsPos.X + AbsSize.X
                        or Mouse.Y < (AbsPos.Y - 20 - 1) or Mouse.Y > AbsPos.Y + AbsSize.Y then
    
                        ColorPicker:Hide();
                    end;
    
                    if not Library:IsMouseOverFrame(ContextMenu.Container) then
                        ContextMenu:Hide()
                    end
                end;
    
                if Input.UserInputType == Enum.UserInputType.MouseButton2 and ContextMenu.Container.Visible then
                    if not Library:IsMouseOverFrame(ContextMenu.Container) and not Library:IsMouseOverFrame(DisplayFrame) then
                        ContextMenu:Hide()
                    end
                end
            end))
    
            ColorPicker:Display();
            ColorPicker.DisplayFrame = DisplayFrame
    
            Options[Idx] = ColorPicker;
    
            return self;
        end;
    
        function Funcs:AddKeyPicker(Idx, Info)
            local ParentObj = self;
            local ToggleLabel = self.TextLabel;
            local Container = self.Container;
    
            assert(Info.Default, 'AddKeyPicker: Missing default value.');
            
            local KeyPicker = {
                Value = Info.Default;
                Toggled = false;
                Mode = Info.Mode or 'Toggle'; -- Always, Toggle, Hold
                Type = 'KeyPicker';
                Callback = Info.Callback or function(Value) end;
                ChangedCallback = Info.ChangedCallback or function(New) end;
                ConnectedToggles = {};
                
                SyncToggleState = Info.SyncToggleState or false;
            };
    
            if KeyPicker.SyncToggleState then
                Info.Modes = { 'Toggle', "Remove" }
                Info.Mode = 'Toggle'
            end
    
            local PickOuter = Library:Create('Frame', {
                BackgroundColor3 = _Color3New(0, 0, 0);
                BorderColor3 = _Color3New(0, 0, 0);
                BorderSizePixel = 0;
                Size = _UDim2New(0, 32, 0, 15);
                ZIndex = 6;
                Parent = ToggleLabel;
            });
    
            local PickInner = Library:Create('Frame', {
                BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = _UDim2New(1, 0, 1, 0);
                ZIndex = 7;
                Parent = PickOuter;
            });
    
            Library:AddToRegistry(PickInner, {
                BackgroundColor3 = 'BackgroundColor';
                BorderColor3 = 'OutlineColor';
            });
    
            local DisplayLabel = Library:CreateLabel({
                Size = _UDim2New(1, 0, 1, 0);
                TextSize = 14;
                Text = Info.Default;
                TextWrapped = true;
                ZIndex = 8;
                Parent = PickInner;
            });
    
            local ModeSelectOuter = Library:Create('Frame', {
                BorderColor3 = _Color3New(0, 0, 0);
                BorderSizePixel = 0;
                Position = _UDim2fromOffset(ToggleLabel.AbsolutePosition.X + ToggleLabel.AbsoluteSize.X + 4, ToggleLabel.AbsolutePosition.Y + 1);
                Size = _UDim2New(0, 60, 0, 60 + 2);
                Visible = false;
                ZIndex = 14;
                Parent = ScreenGui;
            });
    
            _GetPropertyChangedSignal(ToggleLabel, 'AbsolutePosition'):Connect(function()
                ModeSelectOuter.Position = _UDim2fromOffset(ToggleLabel.AbsolutePosition.X + ToggleLabel.AbsoluteSize.X + 4, ToggleLabel.AbsolutePosition.Y + 1);
            end);
    
            local ModeSelectInner = Library:Create('Frame', {
                BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = _UDim2New(1, 0, 1, 0);
                ZIndex = 15;
                Parent = ModeSelectOuter;
            });
    
            Library:AddToRegistry(ModeSelectInner, {
                BackgroundColor3 = 'BackgroundColor';
                BorderColor3 = 'OutlineColor';
            });
    
            Library:Create('UIListLayout', {
                FillDirection = Enum.FillDirection.Vertical;
                SortOrder = Enum.SortOrder.LayoutOrder;
                Parent = ModeSelectInner;
            });
    
            local ContainerLabel = Library:CreateLabel({
                TextXAlignment = Enum.TextXAlignment.Left;
                Size = _UDim2New(1, 0, 0, 18);
                TextSize = 14;
                Visible = false;
                ZIndex = 110;
                Parent = Library.KeybindContainer;
            },  true);
    
            local Modes = Info.Modes or { 'Always', 'Toggle', 'Hold', "Remove" };
            local ModeButtons = {};
    
            for Idx, Mode in next, Modes do
                local ModeButton = {};
    
                local Label = Library:CreateLabel({
                    Active = false;
                    Size = _UDim2New(1, 0, 0, 15);
                    TextSize = 14;
                    Text = Mode;
                    ZIndex = 16;
                    Parent = ModeSelectInner;
                });
    
                function ModeButton:Select()
                    if Mode == "Remove" then
                        KeyPicker:SetValue({"...", KeyPicker.Mode})
                    else
                        for _, Button in next, ModeButtons do
                            Button:Deselect()
                        end
                        KeyPicker.Mode = Mode;
    
                        Label.TextColor3 = Library.AccentColor;
                        Library.RegistryMap[Label].Properties.TextColor3 = 'AccentColor';    
                    end
                    ModeSelectOuter.Visible = false;
                end;
    
                function ModeButton:Deselect()
                    KeyPicker.Mode = nil;
    
                    Label.TextColor3 = Library.FontColor;
                    Library.RegistryMap[Label].Properties.TextColor3 = 'FontColor';
                end;
    
                Label.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                        ModeButton:Select();
                        Library:AttemptSave();
                    end;
                end);
    
                if Mode == KeyPicker.Mode then
                    ModeButton:Select();
                end;
    
                ModeButtons[Mode] = ModeButton;
            end;
            
            local OldState = false
            function KeyPicker:Update()
                local State = KeyPicker:GetState();
                
                if #KeyPicker.ConnectedToggles > 0 and State ~= OldState then
                    for i, v in next, KeyPicker.ConnectedToggles do
                        v:SetValue(State)
                    end
                end

                OldState = State

                if Info.NoUI then
                    return;
                end;

                ContainerLabel.Text = _StringFormat('[%s] %s : %s', KeyPicker.Value, Info.Text, KeyPicker.Mode);
    
                if Library.KeybindListMode == 1 then
                    ContainerLabel.Visible = true;
                    ContainerLabel.TextColor3 = State and Library.AccentColor or Library.FontColor;  
                    Library.RegistryMap[ContainerLabel].Properties.TextColor3 = State and 'AccentColor' or 'FontColor';   
                else
                    ContainerLabel.Visible = State;
                    ContainerLabel.TextColor3 = Library.AccentColor;
                    Library.RegistryMap[ContainerLabel].Properties.TextColor3 = 'AccentColor';
                end
    
    
                Library.RegistryMap[ContainerLabel].Properties.TextColor3 = State and 'AccentColor' or 'FontColor';
    
                local YSize = 0
                local XSize = 0
    
                for _, Label in next, _GetChildren(Library.KeybindContainer) do
                    if _IsA(Label, 'TextLabel') and Label.Visible then
                        YSize = YSize + Label.AbsoluteSize.Y + Library.KeyUilistlayout.Padding.Offset
                        if (Label.TextBounds.X > XSize) then
                            XSize = Label.TextBounds.X
                        end
                    end
                end

                if YSize == 0 then
                    Library.KeybindBackground.Size = _UDim2New(1, 0, 0, 0)
                    Library.KeybindBackground.BackgroundTransparency = 1
                else
                    Library.KeybindBackground.Size = _UDim2New(0, _MathMax(XSize + 20, 210), 0, YSize + 30)
                    Library.KeybindBackground.BackgroundTransparency = 0
                end
            end;
        
            function KeyPicker:GetState()
                if KeyPicker.Mode == 'Always' then
                    return true;
                elseif KeyPicker.Mode == 'Hold' then
                    if KeyPicker.Value == 'None' then
                        return false;
                    end
                    
                    local Key = KeyPicker.Value;
    
                    if Key == 'MB1' or Key == 'MB2' or Key == "MB3" then
                        return Key == 'MB1' and InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
                            or Key == 'MB2' and InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) or
                            Key == 'MB3' and InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton3);
                    else
                        local succ, call = _Pcall(function (...)
                            return Enum.KeyCode[KeyPicker.Value]
                        end)
                        if succ then
                            return _IsKeyDown(InputService, Enum.KeyCode[KeyPicker.Value]);     
                        else
                            return false                       
                        end
                    end;
                else
                    return KeyPicker.Toggled;
                end;
            end;
    
            function KeyPicker:SetValue(Data)
                local Key, Mode = Data[1], Data[2];
                DisplayLabel.Text = Key;
                KeyPicker.Value = Key;
                ModeButtons[Mode]:Select();
                KeyPicker:Update();
            end;
    
            function KeyPicker:OnClick(Callback)
                KeyPicker.Clicked = Callback
            end
    
            function KeyPicker:OnChanged(Callback)
                KeyPicker.Changed = Callback
                Callback(KeyPicker.Value)
            end
    
            if ParentObj.Addons then
                _TableInsert(ParentObj.Addons, KeyPicker)
            end
    
            function KeyPicker:DoClick()
                if ParentObj.Type == 'Toggle' and KeyPicker.SyncToggleState then
                    ParentObj:SetValue(not ParentObj.Value)
                end
    
                Library:SafeCallback(KeyPicker.Callback, KeyPicker.Toggled)
                Library:SafeCallback(KeyPicker.Clicked, KeyPicker.Toggled)
            end
    
            local Picking = false;
    
            PickOuter.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
                    Picking = true;
    
                    DisplayLabel.Text = '';
    
                    local Break;
                    local Text = '';
    
                    _TaskSpawn(function()
                        while (not Break) do
                            if Text == '...' then
                                Text = '';
                            end;
    
                            Text = Text .. '.';
                            DisplayLabel.Text = Text;
    
                            _Wait(0.4);
                        end;
                    end);
    
                    _Wait(0.2);
    
                    local Event;
                    Event = InputService.InputBegan:Connect(function(Input)
                        local Key;
    
                        if Input.UserInputType == Enum.UserInputType.Keyboard then
                            Key = Input.KeyCode.Name;
                        elseif Input.UserInputType == Enum.UserInputType.MouseButton1 then
                            Key = 'MB1';
                        elseif Input.UserInputType == Enum.UserInputType.MouseButton2 then
                            Key = 'MB2';
                        elseif Input.UserInputType == Enum.UserInputType.MouseButton3 then
                            Key = 'MB3';
                        end;
    
                        Break = true;
                        Picking = false;
    
                        DisplayLabel.Text = Key;
                        KeyPicker.Value = Key;
    
                        Library:SafeCallback(KeyPicker.ChangedCallback, Input.KeyCode or Input.UserInputType)
                        Library:SafeCallback(KeyPicker.Changed, Input.KeyCode or Input.UserInputType)
    
                        Library:AttemptSave();
    
                        Event:Disconnect();
                    end);
                elseif Input.UserInputType == Enum.UserInputType.MouseButton2 and not Library:MouseIsOverOpenedFrame() then
                    ModeSelectOuter.Visible = true;
                end;
            end);
    
            Library:GiveSignal(InputService.InputBegan:Connect(function(Input)
                if (not Picking) then
                    if KeyPicker.Mode == 'Toggle' then
                        local Key = KeyPicker.Value;
    
                        if Key == 'MB1' or Key == 'MB2' or Key == 'MB3' then
                            if Key == 'MB1' and Input.UserInputType == Enum.UserInputType.MouseButton1
                            or Key == 'MB2' and Input.UserInputType == Enum.UserInputType.MouseButton2
                            or Key == 'MB3' and Input.UserInputType == Enum.UserInputType.MouseButton3 then
                                KeyPicker.Toggled = not KeyPicker.Toggled
                                KeyPicker:DoClick()
                            end;
                        elseif Input.UserInputType == Enum.UserInputType.Keyboard then
                            if Input.KeyCode.Name == Key then
                                KeyPicker.Toggled = not KeyPicker.Toggled;
                                KeyPicker:DoClick()
                            end;
                        end;
                    end;
                    
                    KeyPicker:Update();
                end;
    
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    local AbsPos, AbsSize = ModeSelectOuter.AbsolutePosition, ModeSelectOuter.AbsoluteSize;
    
                    if Mouse.X < AbsPos.X or Mouse.X > AbsPos.X + AbsSize.X
                        or Mouse.Y < (AbsPos.Y - 20 - 1) or Mouse.Y > AbsPos.Y + AbsSize.Y then
    
                        ModeSelectOuter.Visible = false;
                    end;
                end;
            end))
    
            Library:GiveSignal(InputService.InputEnded:Connect(function(Input)
                if (not Picking) then
                    KeyPicker:Update();
                end;
            end))
    
            KeyPicker:Update();
    
            Options[Idx] = KeyPicker;
    
            return self;
        end;
    
        BaseAddons.__index = Funcs;
        BaseAddons.__namecall = function(Table, Key, ...)
            return Funcs[Key](...);
        end;
    end;
    
    local BaseGroupbox = {};
    
    do
        local Funcs = {};
    
        function Funcs:AddBlank(Size)
            local Groupbox = self;
            local Container = Groupbox.Container;
    
            Library:Create('Frame', {
                BackgroundTransparency = 1;
                Size = _UDim2New(1, 0, 0, Size);
                ZIndex = 1;
                Parent = Container;
            });
        end;
    
        function Funcs:AddLabel(Text, DoesWrap)
            local Label = {};
    
            local Groupbox = self;
            local Container = Groupbox.Container;
    
            local TextLabel = Library:CreateLabel({
                Size = _UDim2New(1, -4, 0, 15);
                TextSize = 15;
                Text = Text;
                TextWrapped = DoesWrap or false,
                TextXAlignment = Enum.TextXAlignment.Left;
                ZIndex = 5;
                Parent = Container;
            });
    
            if DoesWrap then
                local Y = _Select(2, Library:GetTextBounds(Text, Library.Font, 15, _Vector2New(TextLabel.AbsoluteSize.X, math.huge)))
                TextLabel.Size = _UDim2New(1, -4, 0, Y)
            else
                Library:Create('UIListLayout', {
                    Padding = _UDimNew(0, 4);
                    FillDirection = Enum.FillDirection.Horizontal;
                    HorizontalAlignment = Enum.HorizontalAlignment.Right;
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    Parent = TextLabel;
                });
            end
    
            Label.TextLabel = TextLabel;
            Label.Container = Container;
    
            function Label:SetText(Text)
                TextLabel.Text = Text
    
                if DoesWrap then
                    local Y = _Select(2, Library:GetTextBounds(Text, Library.Font, 15, _Vector2New(TextLabel.AbsoluteSize.X, math.huge)))
                    TextLabel.Size = _UDim2New(1, -4, 0, Y)
                end
    
                Groupbox:Resize();
            end
    
            if (not DoesWrap) then
                setmetatable(Label, BaseAddons);
            end
    
            Groupbox:AddBlank(5);
            Groupbox:Resize();
    
            return Label;
        end;
    
        function Funcs:AddButton(...)
            -- TODO: Eventually redo this
            local Button = {};
            local function ProcessButtonParams(Class, Obj, ...)
                local Props = _Select(1, ...)
                if _Type(Props) == 'table' then
                    Obj.Text = Props.Text
                    Obj.Func = Props.Func
                    Obj.DoubleClick = Props.DoubleClick
                    Obj.Tooltip = Props.Tooltip
                else
                    Obj.Text = _Select(1, ...)
                    Obj.Func = _Select(2, ...)
                end
    
                assert(_Type(Obj.Func) == 'function', 'AddButton: `Func` callback is missing.');
            end
    
            ProcessButtonParams('Button', Button, ...)
    
            local Groupbox = self;
            local Container = Groupbox.Container;
    
            local function CreateBaseButton(Button)
                local Outer = Library:Create('Frame', {
                    BackgroundColor3 = _Color3New(0, 0, 0);
                    BorderColor3 = _Color3New(0, 0, 0);
                    BorderSizePixel = 0;
                    Size = _UDim2New(1, -4, 0, 20);
                    ZIndex = 5;
                });
                
                local Inner = Library:Create('Frame', {
                    BackgroundColor3 = Library.MainColor;
                    BorderColor3 = Library.OutlineColor;
                    BorderMode = Enum.BorderMode.Inset;
                    Size = _UDim2New(1, 0, 1, 0);
                    ZIndex = 6;
                    Parent = Outer;
                });
    
                local Label = Library:CreateLabel({
                    Size = _UDim2New(1, 0, 1, 0);
                    TextSize = 15;
                    Text = Button.Text;
                    ZIndex = 6;
                    Parent = Inner;
                });
    
                Library:Create('UIGradient', {
                    Color = _ColorSequenceNew({
                        _ColorSequenceKeypointNew(0, _Color3New(1, 1, 1)),
                        _ColorSequenceKeypointNew(1, _Color3FromRGB(212, 212, 212))
                    });
                    Rotation = 90;
                    Parent = Inner;
                });
    
                Library:AddToRegistry(Outer, {
                    BorderColor3 = 'Black';
                });
    
                Library:AddToRegistry(Inner, {
                    BackgroundColor3 = 'MainColor';
                    BorderColor3 = 'OutlineColor';
                });
    
                Library:OnHighlight(Outer, Outer,
                    { BorderColor3 = 'AccentColor', BorderSizePixel = 1 },
                    { BorderColor3 = 'Black', BorderSizePixel = 0 }
                );
    
                return Outer, Inner, Label
            end
    
            local function InitEvents(Button)
                local function WaitForEvent(event, timeout, validator)
                    local bindable = _Instancenew('BindableEvent')
                    local connection = event:Once(function(...)
    
                        if _Type(validator) == 'function' and validator(...) then
                            bindable:Fire(true)
                        else
                            bindable:Fire(false)
                        end
                    end)
                    task.delay(timeout, function()
                        connection:disconnect()
                        bindable:Fire(false)
                    end)
                    return bindable.Event:Wait()
                end
    
                local function ValidateClick(Input)
                    if Library:MouseIsOverOpenedFrame() then
                        return false
                    end
    
                    if Input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                        return false
                    end
    
                    return true
                end
    
                Button.Outer.InputBegan:Connect(function(Input)
                    if not ValidateClick(Input) then return end
                    if Button.Locked then return end
    
                    if Button.DoubleClick then
                        Library:RemoveFromRegistry(Button.Label)
                        Library:AddToRegistry(Button.Label, { TextColor3 = 'AccentColor' })
    
                        Button.Label.TextColor3 = Library.AccentColor
                        Button.Label.Text = 'Are you sure?'
                        Button.Locked = true
    
                        local clicked = WaitForEvent(Button.Outer.InputBegan, 1, ValidateClick)
    
                        Library:RemoveFromRegistry(Button.Label)
                        Library:AddToRegistry(Button.Label, { TextColor3 = 'FontColor' })
    
                        Button.Label.TextColor3 = Library.FontColor
                        Button.Label.Text = Button.Text
                        task.defer(rawset, Button, 'Locked', false)
    
                        if clicked then
                            Library:SafeCallback(Button.Func)
                        end
    
                        return
                    end
    
                    Library:SafeCallback(Button.Func);
                end)
            end
    
            Button.Outer, Button.Inner, Button.Label = CreateBaseButton(Button)
            Button.Outer.Parent = Container
    
            InitEvents(Button)
    
            function Button:AddTooltip(tooltip)
                if _Type(tooltip) == 'string' then
                    Library:AddToolTip(tooltip, self.Outer)
                end
                return self
            end
    
    
            function Button:AddButton(...)
                local SubButton = {}
    
                ProcessButtonParams('SubButton', SubButton, ...)
    
                self.Outer.Size = _UDim2New(0.5, -2, 0, 20)
    
                SubButton.Outer, SubButton.Inner, SubButton.Label = CreateBaseButton(SubButton)
    
                SubButton.Outer.Position = _UDim2New(1, 3, 0, 0)
                SubButton.Outer.Size = _UDim2fromOffset(self.Outer.AbsoluteSize.X - 2, self.Outer.AbsoluteSize.Y)
                SubButton.Outer.Parent = self.Outer
    
                function SubButton:AddTooltip(tooltip)
                    if _Type(tooltip) == 'string' then
                        Library:AddToolTip(tooltip, self.Outer)
                    end
                    return SubButton
                end
    
                if _Type(SubButton.Tooltip) == 'string' then
                    SubButton:AddTooltip(SubButton.Tooltip)
                end
    
                InitEvents(SubButton)
                return SubButton
            end
    
            if _Type(Button.Tooltip) == 'string' then
                Button:AddTooltip(Button.Tooltip)
            end
    
            Groupbox:AddBlank(5);
            Groupbox:Resize();
    
            return Button;
        end;
    
        function Funcs:AddDivider()
            local Groupbox = self;
            local Container = self.Container
    
            local Divider = {
                Type = 'Divider',
            }
    
            Groupbox:AddBlank(2);
            local DividerOuter = Library:Create('Frame', {
                BackgroundColor3 = _Color3New(0, 0, 0);
                BorderColor3 = _Color3New(0, 0, 0);
                BorderSizePixel = 0;
                Size = _UDim2New(1, -4, 0, 5);
                ZIndex = 5;
                Parent = Container;
            });
    
            local DividerInner = Library:Create('Frame', {
                BackgroundColor3 = Library.MainColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = _UDim2New(1, 0, 1, 0);
                ZIndex = 6;
                Parent = DividerOuter;
            });
    
            Library:AddToRegistry(DividerOuter, {
                BorderColor3 = 'Black';
            });
    
            Library:AddToRegistry(DividerInner, {
                BackgroundColor3 = 'MainColor';
                BorderColor3 = 'OutlineColor';
            });
    
            Groupbox:AddBlank(9);
            Groupbox:Resize();
        end
    
        function Funcs:AddInput(Idx, Info)
            assert(Info.Text, 'AddInput: Missing `Text` string.')
            
            local Textbox = {
                Value = Info.Default or '';
                Numeric = Info.Numeric or false;
                Finished = Info.Finished or false;
                Type = 'Input';
                Callback = Info.Callback or function(Value) end;
            };
    
            local Groupbox = self;
            local Container = Groupbox.Container;
    
            local InputLabel = Library:CreateLabel({
                Size = _UDim2New(1, 0, 0, 15);
                TextSize = 15;
                Text = Info.Text;
                TextXAlignment = Enum.TextXAlignment.Left;
                ZIndex = 5;
                Parent = Container;
            });
    
            Groupbox:AddBlank(1);
    
            local TextBoxOuter = Library:Create('Frame', {
                BackgroundColor3 = _Color3New(0, 0, 0);
                BorderColor3 = _Color3New(0, 0, 0);
                BorderSizePixel = 0;
                Size = _UDim2New(1, -4, 0, 18);
                ZIndex = 5;
                Parent = Container;
            });
    
            local TextBoxInner = Library:Create('Frame', {
                BackgroundColor3 = Library.MainColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = _UDim2New(1, 0, 1, 0);
                ZIndex = 6;
                Parent = TextBoxOuter;
            });
    
            Library:AddToRegistry(TextBoxInner, {
                BackgroundColor3 = 'MainColor';
                BorderColor3 = 'OutlineColor';
            });
    
            Library:OnHighlight(TextBoxOuter, TextBoxOuter,
                { BorderColor3 = 'AccentColor' },
                { BorderColor3 = 'Black' }
            );
    
            if _Type(Info.Tooltip) == 'string' then
                Library:AddToolTip(Info.Tooltip, TextBoxOuter)
            end
    
            Library:Create('UIGradient', {
                Color = _ColorSequenceNew({
                    _ColorSequenceKeypointNew(0, _Color3New(1, 1, 1)),
                    _ColorSequenceKeypointNew(1, _Color3FromRGB(212, 212, 212))
                });
                Rotation = 90;
                Parent = TextBoxInner;
            });
    
            local Container = Library:Create('Frame', {
                BackgroundTransparency = 1;
                ClipsDescendants = true;
    
                Position = _UDim2New(0, 5, 0, 0);
                Size = _UDim2New(1, -5, 1, 0);
    
                ZIndex = 7;
                Parent = TextBoxInner;
            })
    
            local Box = Library:Create('TextBox', {
                BackgroundTransparency = 1;
    
                Position = _UDim2fromOffset(0, 0),
                Size = UDim2.fromScale(5, 1),
    
                Font = Library.Font;
                PlaceholderColor3 = _Color3FromRGB(190, 190, 190);
                PlaceholderText = Info.Placeholder or '';
    
                Text = Info.Default or '';
                TextColor3 = Library.FontColor;
                TextSize = 15;
                TextStrokeTransparency = 1;
                TextXAlignment = Enum.TextXAlignment.Left;
    
                ZIndex = 7;
                Parent = Container;
            });
    
            function Textbox:SetValue(Text)
                if Info.MaxLength and #Text > Info.MaxLength then
                    Text = Text:sub(1, Info.MaxLength);
                end;
    
                if Textbox.Numeric then
                    if (not _tonumber(Text)) and Text:len() > 0 then
                        Text = Textbox.Value
                    end
                end
    
                Textbox.Value = Text;
                Box.Text = Text;
    
                Library:SafeCallback(Textbox.Callback, Textbox.Value);
                Library:SafeCallback(Textbox.Changed, Textbox.Value);
            end;
    
            if Textbox.Finished then
                Box.FocusLost:Connect(function(enter)
                    if not enter then return end
    
                    Textbox:SetValue(Box.Text);
                    Library:AttemptSave();
                end)
            else
                _GetPropertyChangedSignal(Box,'Text'):Connect(function()
                    Textbox:SetValue(Box.Text);
                    Library:AttemptSave();
                end);
            end
    
            -- https://devforum.roblox.com/t/how-to-make-textboxes-follow-current-cursor-position/1368429/6
            -- thank you nicemike40 :)
    
            local function Update()
                local PADDING = 2
                local reveal = Container.AbsoluteSize.X
    
                if not Box:IsFocused() or Box.TextBounds.X <= reveal - 2 * PADDING then
                    -- we aren't focused, or we fit so be normal
                    Box.Position = _UDim2New(0, PADDING, 0, 0)
                else
                    -- we are focused and don't fit, so adjust position
                    local cursor = Box.CursorPosition
                    if cursor ~= -1 then
                        -- calculate pixel width of text from start to cursor
                        local subtext = _StringSub(Box.Text, 1, cursor-1)
                        local width = TextService:GetTextSize(subtext, Box.TextSize, Box.Font, _Vector2New(math.huge, math.huge)).X
    
                        -- check if we're inside the box with the cursor
                        local currentCursorPos = Box.Position.X.Offset + width
    
                        -- adjust if necessary
                        if currentCursorPos < PADDING then
                            Box.Position = _UDim2fromOffset(PADDING-width, 0)
                        elseif currentCursorPos > reveal - PADDING - 1 then
                            Box.Position = _UDim2fromOffset(reveal-width-PADDING-1, 0)
                        end
                    end
                end
            end
    
            _TaskSpawn(Update)
    
            _GetPropertyChangedSignal(Box, 'Text'):Connect(Update)
            _GetPropertyChangedSignal(Box, 'CursorPosition'):Connect(Update)
            Box.FocusLost:Connect(Update)
            Box.Focused:Connect(Update)
    
            Library:AddToRegistry(Box, {
                TextColor3 = 'FontColor';
            });
    
            function Textbox:OnChanged(Func)
                Textbox.Changed = Func;
                Func(Textbox.Value);
            end;
    
            Groupbox:AddBlank(5);
            Groupbox:Resize();
    
            Options[Idx] = Textbox;
    
            return Textbox;
        end;
    
        function Funcs:AddToggle(Idx, Info)
            assert(Info.Text, 'AddInput: Missing `Text` string.')
    
            local Toggle = {
                Value = Info.Default or false;
                Type = 'Toggle';
    
                Callback = Info.Callback or function(Value) end;
                Addons = {},
                Risky = Info.Risky,
            };
    
            local Groupbox = self;
            local Container = Groupbox.Container;
    
            local ToggleOuter = Library:Create('Frame', {
                BackgroundColor3 = _Color3New(0, 0, 0);
                BorderColor3 = _Color3New(0, 0, 0);
                BorderSizePixel = 0;
                Size = _UDim2New(0, 13, 0, 13);
                ZIndex = 5;
                Parent = Container;
            });
    
            Library:AddToRegistry(ToggleOuter, {
                BorderColor3 = 'Black';
            });
    
            local ToggleInner = Library:Create('Frame', {
                BackgroundColor3 = Library.MainColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = _UDim2New(1, 0, 1, 0);
                ZIndex = 6;
                Parent = ToggleOuter;
            });
    
            Library:AddToRegistry(ToggleInner, {
                BackgroundColor3 = 'MainColor';
                BorderColor3 = 'OutlineColor';
            });
    
            local ToggleLabel = Library:CreateLabel({
                Size = _UDim2New(0, 216, 1, 0);
                Position = _UDim2New(1, 6, 0, 0);
                TextSize = 15;
                Text = Info.Text;
                TextXAlignment = Enum.TextXAlignment.Left;
                ZIndex = 6;
                Parent = ToggleInner;
            });  

            Library:Create('UIListLayout', {
                Padding = _UDimNew(0, 4);
                FillDirection = Enum.FillDirection.Horizontal;
                HorizontalAlignment = Enum.HorizontalAlignment.Right;
                SortOrder = Enum.SortOrder.LayoutOrder;
                Parent = ToggleLabel;
            });
    
            local ToggleRegion = Library:Create('Frame', {
                BackgroundTransparency = 1;
                Size = _UDim2New(0, 170, 1, 0);
                ZIndex = 8;
                Parent = ToggleOuter;
            });
    
            Library:OnHighlight(ToggleRegion, ToggleOuter,
                { BorderColor3 = 'AccentColor', BorderSizePixel = 1 },
                { BorderColor3 = 'Black', BorderSizePixel = 0 }
            );
    
            function Toggle:UpdateColors()
                Toggle:Display();
            end;
    
            if _Type(Info.Tooltip) == 'string' then
                Library:AddToolTip(Info.Tooltip, ToggleRegion)
            end
    
            function Toggle:Display()
                ToggleInner.BackgroundColor3 = Toggle.Value and Library.AccentColor or Library.MainColor;
                ToggleInner.BorderColor3 = Toggle.Value and Library.AccentColorDark or Library.OutlineColor;
    
                Library.RegistryMap[ToggleInner].Properties.BackgroundColor3 = Toggle.Value and 'AccentColor' or 'MainColor';
                Library.RegistryMap[ToggleInner].Properties.BorderColor3 = Toggle.Value and 'AccentColorDark' or 'OutlineColor';
            end;
    
            function Toggle:OnChanged(Func)
                Toggle.Changed = Func;
                Func(Toggle.Value);
            end;
    
            function Toggle:SetValue(Bool)
                Bool = (not not Bool);
    
                Toggle.Value = Bool;
                Toggle:Display();
    
                for _, Addon in next, Toggle.Addons do
                    if Addon.Type == 'KeyPicker' and Addon.SyncToggleState then
                        Addon.Toggled = Bool
                        Addon:Update()
                    end
                end
    
                Library:SafeCallback(Toggle.Callback, Toggle.Value);
                Library:SafeCallback(Toggle.Changed, Toggle.Value);
                Library:UpdateDependencyBoxes();
            end;
    
            ToggleRegion.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
                    Toggle:SetValue(not Toggle.Value) -- Why was it not like this from the start?
                    Library:AttemptSave();
                end;
            end);
    
            if Toggle.Risky then
                Library:RemoveFromRegistry(ToggleLabel)
                ToggleLabel.TextColor3 = Library.RiskColor
                Library:AddToRegistry(ToggleLabel, { TextColor3 = 'RiskColor' })
            end
    
            Toggle:Display();
            Groupbox:AddBlank(Info.BlankSize or 5 + 2);
            Groupbox:Resize();
    
            Toggle.TextLabel = ToggleLabel;
            Toggle.Container = Container;
            setmetatable(Toggle, BaseAddons);
    
            Toggles[Idx] = Toggle;
    
            Library:UpdateDependencyBoxes();
    
            return Toggle;
        end;
    
        function Funcs:AddSlider(Idx, Info)
            assert(Info.Default, 'AddSlider: Missing default value.');
            assert(Info.Text, 'AddSlider: Missing slider text.');
            assert(Info.Min, 'AddSlider: Missing minimum value.');
            assert(Info.Max, 'AddSlider: Missing maximum value.');
            assert(Info.Rounding, 'AddSlider: Missing rounding value.');
    
            local Slider = {
                Value = Info.Default;
                Min = Info.Min;
                Max = Info.Max;
                Rounding = Info.Rounding;
                MaxSize = 238;
                Type = 'Slider';
                Callback = Info.Callback or function(Value) end;
            };
    
            local Groupbox = self;
            local Container = Groupbox.Container;
    
            if not Info.Compact then
                local Label = Library:CreateLabel({
                    Size = _UDim2New(1, 0, 0, 10);
                    TextSize = 15;
                    Text = Info.Text;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    TextYAlignment = Enum.TextYAlignment.Bottom;
                    ZIndex = 5;
                    Parent = Container;
                });

                local DisplayLabelPlus = Library:CreateLabel({
                    Size = _UDim2New(0.05, 0, 0, 10);
                    Position = _UDim2New(0.92, 0, 0, 0);
                    TextYAlignment = Enum.TextYAlignment.Bottom;
                    TextSize = 14;
                    Text = '+';
                    ZIndex = 10;
                    Parent = Label;
                });
                local DisplayLabelMinus = Library:CreateLabel({
                    Size = _UDim2New(0.05, 0, 0, 10);
                    Position = _UDim2New(0.88,0,0,0);
                    TextYAlignment = Enum.TextYAlignment.Bottom;
                    TextSize = 14;
                    Text = '-';
                    ZIndex = 10;
                    Parent = Label;
                });
                Library:AddToRegistry(DisplayLabelPlus, {
                    TextColor3 = 'FontColorDark';
                });
                Library:AddToRegistry(DisplayLabelMinus, {
                    TextColor3 = 'FontColorDark';
                });

                Library:OnHighlight(DisplayLabelPlus, DisplayLabelPlus,
                    { TextColor3 = 'AccentColor' },
                    { TextColor3 = 'FontColorDark' }
                );
                Library:OnHighlight(DisplayLabelMinus, DisplayLabelMinus,
                    { TextColor3 = 'AccentColor' },
                    { TextColor3 = 'FontColorDark' }
                );
                
                DisplayLabelMinus.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
                        Slider:SetValue(Slider.Value - (Slider.Rounding == 0 and 1 or 1 / (10 ^ Slider.Rounding)))
                    end
                end)
                DisplayLabelPlus.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
                        Slider:SetValue(Slider.Value + (Slider.Rounding == 0 and 1 or 1 / (10 ^ Slider.Rounding)))
                    end
                end)
    
                Groupbox:AddBlank(3);
            end
    
            local SliderOuter = Library:Create('Frame', {
                BackgroundColor3 = _Color3New(0, 0, 0);
                BorderColor3 = _Color3New(0, 0, 0);
                BorderSizePixel = 0;
                Size = _UDim2New(1, -4, 0, 12);
                ZIndex = 5;
                Parent = Container;
            });
    
            Library:AddToRegistry(SliderOuter, {
                BorderColor3 = 'Black';
            });
    
            local SliderInner = Library:Create('Frame', {
                BackgroundColor3 = Library.MainColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = _UDim2New(1, 0, 1, 0);
                ZIndex = 6;
                Parent = SliderOuter;
            });
    
            Library:AddToRegistry(SliderInner, {
                BackgroundColor3 = 'MainColor';
                BorderColor3 = 'OutlineColor';
            });
    
            local Fill = Library:Create('Frame', {
                BackgroundColor3 = Library.AccentColor;
                BorderColor3 = Library.AccentColorDark;
                Size = _UDim2New(0, 0, 1, 0);
                ZIndex = 7;
                Parent = SliderInner;
            });
    
            Library:AddToRegistry(Fill, {
                BackgroundColor3 = 'AccentColor';
                BorderColor3 = 'AccentColorDark';
            });
    
            local HideBorderRight = Library:Create('Frame', {
                BackgroundColor3 = Library.AccentColor;
                BorderSizePixel = 0;
                Position = _UDim2New(1, 0, 0, 0);
                Size = _UDim2New(0, 1, 1, 0);
                ZIndex = 8;
                Parent = Fill;
            });
    
            Library:AddToRegistry(HideBorderRight, {
                BackgroundColor3 = 'AccentColor';
            });
    
            local DisplayLabel = Library:CreateLabel({
                Size = _UDim2New(1, 0, 1, 0);
                TextSize = 13;
                Text = 'Infinite';
                ZIndex = 9;
                Parent = SliderInner;
            });
    
            Library:OnHighlight(SliderOuter, SliderOuter,
                { BorderColor3 = 'AccentColor', BorderSizePixel = 1 },
                { BorderColor3 = 'Black', BorderSizePixel = 0 }
            );
    
            if _Type(Info.Tooltip) == 'string' then
                Library:AddToolTip(Info.Tooltip, SliderOuter)
            end
    
            function Slider:UpdateColors()
                Fill.BackgroundColor3 = Library.AccentColor;
                Fill.BorderColor3 = Library.AccentColorDark;
            end;
    
            function Slider:Display()
                local Suffix = Info.Suffix or '';
    
                if Info.Compact then
                    DisplayLabel.Text = Info.Text .. ': ' .. Slider.Value .. Suffix
                elseif Info.HideMax then
                    DisplayLabel.Text = _StringFormat('%s', Slider.Value .. Suffix)
                else
                    DisplayLabel.Text = _StringFormat('%s', Slider.Value .. Suffix)
                end
    
                local X = math.ceil(Library:MapValue(Slider.Value, Slider.Min, Slider.Max, 0, Slider.MaxSize));
                Fill.Size = _UDim2New(0, X, 1, 0);
    
                HideBorderRight.Visible = not (X == Slider.MaxSize or X == 0);
            end;
    
            function Slider:OnChanged(Func)
                Slider.Changed = Func;
                Func(Slider.Value);
            end;
    
            local function Round(Value)
                if Slider.Rounding == 0 then
                    return _MathFloor(Value);
                end;
    
    
                return _tonumber(_StringFormat('%.' .. Slider.Rounding .. 'f', Value))
            end;
    
            function Slider:GetValueFromXOffset(X)
                return Round(Library:MapValue(X, 0, Slider.MaxSize, Slider.Min, Slider.Max));
            end;
    
            function Slider:SetValue(Str)
                local Num = _tonumber(Str);
    
                if (not Num) then
                    return;
                end;
                
                if Num < Slider.Min then
                    Num = Slider.Min
                end
                if Num > Slider.Max then
                    Num = Slider.Max
                end

                Num = _MathClamp(Num, Slider.Min, Slider.Max);
    
                Slider.Value = Num;
                Slider:Display();
    
                Library:SafeCallback(Slider.Callback, Slider.Value);
                Library:SafeCallback(Slider.Changed, Slider.Value);
            end;
    
            SliderInner.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
                    local mPos = Mouse.X;
                    local gPos = Fill.Size.X.Offset;
                    local Diff = mPos - (Fill.AbsolutePosition.X + gPos);
    
                    while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                        local nMPos = Mouse.X;
                        local nX = _MathClamp(gPos + (nMPos - mPos) + Diff, 0, Slider.MaxSize);
    
                        local nValue = Slider:GetValueFromXOffset(nX);
                        local OldValue = Slider.Value;
                        Slider.Value = nValue;
    
                        Slider:Display();
    
                        if nValue ~= OldValue then
                            Library:SafeCallback(Slider.Callback, Slider.Value);
                            Library:SafeCallback(Slider.Changed, Slider.Value);
                        end;
    
                        RenderStepped:Wait();
                    end;
    
                    Library:AttemptSave();
                end;
            end);
    
            Slider:Display();
            Groupbox:AddBlank(Info.BlankSize or 6);
            Groupbox:Resize();
    
            Options[Idx] = Slider;
    
            return Slider;
        end;
    
        function Funcs:AddDropdown(Idx, Info)
            if Info.SpecialType == 'Player' then
                Info.Values = GetPlayersString();
                Info.AllowNull = true;
            elseif Info.SpecialType == 'Team' then
                Info.Values = GetTeamsString();
                Info.AllowNull = true;
            end;
    
            assert(Info.Values, 'AddDropdown: Missing dropdown value list.');
            assert(Info.AllowNull or Info.Default, 'AddDropdown: Missing default value. Pass `AllowNull` as true if this was intentional.')
    
            if (not Info.Text) then
                Info.Compact = true;
            end
    
            local Dropdown = {
                Values = Info.Values;
                Value = Info.Multi and {};
                Multi = Info.Multi;
                Type = 'Dropdown';
                SpecialType = Info.SpecialType; -- can be either 'Player' or 'Team'
                Callback = Info.Callback or function(Value) end;
            };
    
            local Groupbox = self;
            local Container = Groupbox.Container;
    
            local RelativeOffset = 0;
    
            if not Info.Compact then
                local DropdownLabel = Library:CreateLabel({
                    Size = _UDim2New(1, 0, 0, 10);
                    TextSize = 15;
                    Text = Info.Text;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    TextYAlignment = Enum.TextYAlignment.Bottom;
                    ZIndex = 5;
                    Parent = Container;
                });
    
                Groupbox:AddBlank(3);
            end
    
            for _, Element in next, _GetChildren(Container) do
                if not _IsA(Element, 'UIListLayout') then
                    RelativeOffset = RelativeOffset + Element.Size.Y.Offset;
                end;
            end;
    
            local DropdownOuter = Library:Create('Frame', {
                BackgroundColor3 = _Color3New(0, 0, 0);
                BorderColor3 = _Color3New(0, 0, 0);
                BorderSizePixel = 0;
                Size = _UDim2New(1, -4, 0, 18);
                ZIndex = 5;
                Parent = Container;
            });
    
            Library:AddToRegistry(DropdownOuter, {
                BorderColor3 = 'Black';
            });
    
            local DropdownInner = Library:Create('Frame', {
                BackgroundColor3 = Library.MainColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = _UDim2New(1, 0, 1, 0);
                ZIndex = 6;
                Parent = DropdownOuter;
            });
    
            Library:AddToRegistry(DropdownInner, {
                BackgroundColor3 = 'MainColor';
                BorderColor3 = 'OutlineColor';
            });
    
            Library:Create('UIGradient', {
                Color = _ColorSequenceNew({
                    _ColorSequenceKeypointNew(0, _Color3New(1, 1, 1)),
                    _ColorSequenceKeypointNew(1, _Color3FromRGB(212, 212, 212))
                });
                Rotation = 90;
                Parent = DropdownInner;
            });
        
            local DropdownArrow = Library:CreateLabel({
                AnchorPoint = _Vector2New(0, 0.5);
                BackgroundTransparency = 1;
                Position = _UDim2New(1, -16, 0.5, 0);
                Size = _UDim2New(0, 12, 0, 12);
                TextSize = 14;
                Text = "+";
                ZIndex = 8;
                Parent = DropdownInner;
            });

            local ItemList = Library:CreateLabel({
                Position = _UDim2New(0, 5, 0, 0);
                Size = _UDim2New(1, -5, 1, 0);
                TextSize = 15;
                Text = '--';
                TextXAlignment = Enum.TextXAlignment.Left;
                TextWrapped = true;
                ZIndex = 7;
                Parent = DropdownInner;
            });
    
            Library:OnHighlight(DropdownOuter, DropdownOuter,
                { BorderColor3 = 'AccentColor', BorderSizePixel = 1 },
                { BorderColor3 = 'Black', BorderSizePixel = 0 }
            );
    
            if _Type(Info.Tooltip) == 'string' then
                Library:AddToolTip(Info.Tooltip, DropdownOuter)
            end
    
            local MAX_DROPDOWN_ITEMS = 8;
    
            local ListOuter = Library:Create('Frame', {
                BackgroundColor3 = _Color3New(0, 0, 0);
                BorderColor3 = _Color3New(0, 0, 0);
                BorderSizePixel = 0;
                ZIndex = 20;
                Visible = false;
                Parent = ScreenGui;
            });
    
            local function RecalculateListPosition()
                ListOuter.Position = _UDim2fromOffset(DropdownOuter.AbsolutePosition.X, DropdownOuter.AbsolutePosition.Y + DropdownOuter.Size.Y.Offset + 1);
            end;
    
            local function RecalculateListSize(YSize)
                ListOuter.Size = _UDim2fromOffset(DropdownOuter.AbsoluteSize.X, YSize or (MAX_DROPDOWN_ITEMS * 20 + 2))
            end;
    
            RecalculateListPosition();
            RecalculateListSize();
    
            _GetPropertyChangedSignal(DropdownOuter, 'AbsolutePosition'):Connect(RecalculateListPosition);
    
            local ListInner = Library:Create('Frame', {
                BackgroundColor3 = Library.MainColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                BorderSizePixel = 0;
                Size = _UDim2New(1, 0, 1, 0);
                ZIndex = 21;
                Parent = ListOuter;
            });
    
            Library:AddToRegistry(ListInner, {
                BackgroundColor3 = 'MainColor';
                BorderColor3 = 'OutlineColor';
            });
    
            local Scrolling = Library:Create('ScrollingFrame', {
                BackgroundTransparency = 1;
                BorderSizePixel = 0;
                CanvasSize = _UDim2New(0, 0, 0, 0);
                Size = _UDim2New(1, 0, 1, 0);
                ZIndex = 21;
                Parent = ListInner;
    
                TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png',
                BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png',
                
                ScrollBarThickness = 3,
                ScrollBarImageColor3 = Library.AccentColor,
            });
    
            Library:AddToRegistry(Scrolling, {
                ScrollBarImageColor3 = 'AccentColor'
            })
    
            Library:Create('UIListLayout', {
                Padding = _UDimNew(0, 0);
                FillDirection = Enum.FillDirection.Vertical;
                SortOrder = Enum.SortOrder.LayoutOrder;
                HorizontalAlignment = Enum.HorizontalAlignment.Center;
                Parent = Scrolling;
            });
            function Dropdown:Display()
                local Values = Dropdown.Values;
                local Str = '';
    
                if Info.Multi then
                    for Idx, Value in next, Values do
                        if Dropdown.Value[Value] then
                            Str = Str .. Value .. ', ';
                        end;
                    end;
                    
                    Str = Str:sub(1, #Str - 2);
                else
                    Str = Dropdown.Value or '';
                end;
    
                ItemList.Text = (Str == '' and '--' or Str);
            end;
    
            function Dropdown:GetActiveValues()
                if Info.Multi then
                    local T = {};
    
                    for Value, Bool in next, Dropdown.Value do
                        _TableInsert(T, Value);
                    end;
    
                    return T;
                else
                    return Dropdown.Value and 1 or 0;
                end;
            end;
    
            function Dropdown:BuildDropdownList()
                local Values = Dropdown.Values;
                local Buttons = {};
    
                for _, Element in next, _GetChildren(Scrolling) do
                    if not _IsA(Element, 'UIListLayout') then
                        _Destroy(Element);
                    end;
                end;
    
                local Count = 0;
    
                for Idx, Value in next, Values do
                    local Table = {};
    
                    Count = Count + 1;
    
                    local Button = Library:Create('Frame', {
                        BackgroundColor3 = Library.MainColor;
                        BorderColor3 = Library.OutlineColor;
                        BorderMode = Enum.BorderMode.Middle;
                        Size = _UDim2New(1, -5, 0, 20);
                        ZIndex = 23;
                        Active = true,
                        Parent = Scrolling;
                    });
    
                    Library:AddToRegistry(Button, {
                        BackgroundColor3 = 'MainColor';
                        BorderColor3 = 'OutlineColor';
                    });
    
                    local ButtonLabel = Library:CreateLabel({
                        Active = false;
                        Size = _UDim2New(1, -6, 1, 0);
                        Position = _UDim2New(0, 6, 0, 0);
                        TextSize = 15;
                        Text = Value;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        ZIndex = 25;
                        Parent = Button;
                    });
    
                    Library:OnHighlight(Button, Button,
                        { BorderColor3 = 'AccentColor', ZIndex = 24 },
                        { BorderColor3 = 'OutlineColor', ZIndex = 23 }
                    );
    
                    local Selected;
    
                    if Info.Multi then
                        Selected = Dropdown.Value[Value];
                    else
                        Selected = Dropdown.Value == Value;
                    end;
    
                    function Table:UpdateButton()
                        if Info.Multi then
                            Selected = Dropdown.Value[Value];
                        else
                            Selected = Dropdown.Value == Value;
                        end;
    
                        ButtonLabel.TextColor3 = Selected and Library.AccentColor or Library.FontColor;
                        Library.RegistryMap[ButtonLabel].Properties.TextColor3 = Selected and 'AccentColor' or 'FontColor';
                    end;
    
                    ButtonLabel.InputBegan:Connect(function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                            local Try = not Selected;
    
                            if Dropdown:GetActiveValues() == 1 and (not Try) and (not Info.AllowNull) then
                            else
                                if Info.Multi then
                                    Selected = Try;
    
                                    if Selected then
                                        Dropdown.Value[Value] = true;
                                    else
                                        Dropdown.Value[Value] = nil;
                                    end;
                                else
                                    Selected = Try;
    
                                    if Selected then
                                        Dropdown.Value = Value;
                                    else
                                        Dropdown.Value = nil;
                                    end;
    
                                    for _, OtherButton in next, Buttons do
                                        OtherButton:UpdateButton();
                                    end;
                                end;
    
                                Table:UpdateButton();
                                Dropdown:Display();
    
                                Library:SafeCallback(Dropdown.Callback, Dropdown.Value);
                                Library:SafeCallback(Dropdown.Changed, Dropdown.Value);
    
                                Library:AttemptSave();
                            end;
                        end;
                    end);
    
                    Table:UpdateButton();
                    Dropdown:Display();
    
                    Buttons[Button] = Table;
                end;
    
                Scrolling.CanvasSize = _UDim2fromOffset(0, (Count * 20) + 1);
    
                local Y = _MathClamp(Count * 20, 0, MAX_DROPDOWN_ITEMS * 20) + 1;
                RecalculateListSize(Y);
            end;
    
            function Dropdown:SetValues(NewValues)
                if NewValues then
                    Dropdown.Values = NewValues;
                end;
    
                Dropdown:BuildDropdownList();
            end;
    
            function Dropdown:OpenDropdown()
                ListOuter.Visible = true;
                Library.OpenedFrames[ListOuter] = true;
                DropdownArrow.Text = "-";
            end;
    
            function Dropdown:CloseDropdown()
                ListOuter.Visible = false;
                Library.OpenedFrames[ListOuter] = nil;
                DropdownArrow.Text = "+";
            end;
    
            function Dropdown:OnChanged(Func)
                Dropdown.Changed = Func;
                Func(Dropdown.Value);
            end;
    
            function Dropdown:SetValue(Val)
                if Dropdown.Multi then
                    local nTable = {};
    
                    for Value, Bool in next, Val do
                        if _TableFind(Dropdown.Values, Value) then
                            nTable[Value] = true
                        end;
                    end;
    
                    Dropdown.Value = nTable;
                else
                    if (not Val) then
                        Dropdown.Value = nil;
                    elseif _TableFind(Dropdown.Values, Val) then
                        Dropdown.Value = Val;
                    end;
                end;
    
                Dropdown:BuildDropdownList();
    
                Library:SafeCallback(Dropdown.Callback, Dropdown.Value);
                Library:SafeCallback(Dropdown.Changed, Dropdown.Value);
            end;
    
            DropdownOuter.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
                    if ListOuter.Visible then
                        Dropdown:CloseDropdown();
                    else
                        Dropdown:OpenDropdown();
                    end;
                end;
            end);
    
            InputService.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    local AbsPos, AbsSize = ListOuter.AbsolutePosition, ListOuter.AbsoluteSize;
    
                    if Mouse.X < AbsPos.X or Mouse.X > AbsPos.X + AbsSize.X
                        or Mouse.Y < (AbsPos.Y - 20 - 1) or Mouse.Y > AbsPos.Y + AbsSize.Y then
    
                        Dropdown:CloseDropdown();
                    end;
                end;
            end);
    
            Dropdown:BuildDropdownList();
            Dropdown:Display();
    
            local Defaults = {}
    
            if _Type(Info.Default) == 'string' then
                local Idx = _TableFind(Dropdown.Values, Info.Default)
                if Idx then
                    _TableInsert(Defaults, Idx)
                end
            elseif _Type(Info.Default) == 'table' then
                for _, Value in next, Info.Default do
                    local Idx = _TableFind(Dropdown.Values, Value)
                    if Idx then
                        _TableInsert(Defaults, Idx)
                    end
                end
            elseif _Type(Info.Default) == 'number' and Dropdown.Values[Info.Default] ~= nil then
                _TableInsert(Defaults, Info.Default)
            end
    
            if next(Defaults) then
                for i = 1, #Defaults do
                    local Index = Defaults[i]
                    if Info.Multi then
                        Dropdown.Value[Dropdown.Values[Index]] = true
                    else
                        Dropdown.Value = Dropdown.Values[Index];
                    end
    
                    if (not Info.Multi) then break end
                end
    
                Dropdown:BuildDropdownList();
                Dropdown:Display();
            end
    
            Groupbox:AddBlank(Info.BlankSize or 5);
            Groupbox:Resize();
    
            Options[Idx] = Dropdown;
    
            return Dropdown;
        end;
    
        function Funcs:AddDependencyBox()
            local Depbox = {
                Dependencies = {};
            };
            
            local Groupbox = self;
            local Container = Groupbox.Container;
    
            local Holder = Library:Create('Frame', {
                BackgroundTransparency = 1;
                Size = _UDim2New(1, 0, 0, 0);
                Visible = false;
                Parent = Container;
            });
    
            local Frame = Library:Create('Frame', {
                BackgroundTransparency = 1;
                Size = _UDim2New(1, 0, 1, 0);
                Visible = true;
                Parent = Holder;
            });
    
            local Layout = Library:Create('UIListLayout', {
                FillDirection = Enum.FillDirection.Vertical;
                SortOrder = Enum.SortOrder.LayoutOrder;
                Parent = Frame;
            });
    
            function Depbox:Resize()
                Holder.Size = _UDim2New(1, 0, 0, Layout.AbsoluteContentSize.Y);
                Groupbox:Resize();
            end;
    
            _GetPropertyChangedSignal(Layout, 'AbsoluteContentSize'):Connect(function()
                Depbox:Resize();
            end);
    
            _GetPropertyChangedSignal(Holder, 'Visible'):Connect(function()
                Depbox:Resize();
            end);
    
            local IsNotHidden = true
            function Depbox:Update()
                for _, Dependency in next, Depbox.Dependencies do
                    local Elem = Dependency[1];
                    local Value = Dependency[2];
    
                    if Elem.Type == 'Toggle' and Elem.Value ~= Value then
                        Holder.Visible = false;
                        Depbox:Resize();
                        return;
                    end;
                end;
                if IsNotHidden then
                    Holder.Visible = true;
                    Depbox:Resize();
                end
            end;
    
            function Depbox:SetupDependencies(Dependencies)
                for _, Dependency in next, Dependencies do
                    assert(_Type(Dependency) == 'table', 'SetupDependencies: Dependency is not of _Type `table`.');
                    assert(Dependency[1], 'SetupDependencies: Dependency is missing element argument.');
                    assert(Dependency[2] ~= nil, 'SetupDependencies: Dependency is missing value argument.');
                end;
    
                Depbox.Dependencies = Dependencies;
                Depbox:Update();
            end;
    
            function Depbox:Show()
                Holder.Visible = true
                IsNotHidden = true
            end
    
            function Depbox:Hide()
                Holder.Visible = false
                IsNotHidden = false
            end
    
            Depbox.Container = Frame;
    
            setmetatable(Depbox, BaseGroupbox);
    
            _TableInsert(Library.DependencyBoxes, Depbox);
    
            return Depbox;
        end;
    
        BaseGroupbox.__index = Funcs;
        BaseGroupbox.__namecall = function(Table, Key, ...)
            return Funcs[Key](...);
        end;
    end;
    	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
    -- < Create other UI elements >
    do
        Library.NotificationArea = Library:Create('Frame', {
            BackgroundTransparency = 1;
            Position = _UDim2New(0, 0, 0, 40);
            Size = _UDim2New(0, 300, 0, 200);
            ZIndex = 100;
            Parent = ScreenGui;
        });
    
        Library:Create('UIListLayout', {
            Padding = _UDimNew(0, 4);
            FillDirection = Enum.FillDirection.Vertical;
            SortOrder = Enum.SortOrder.LayoutOrder;
            Parent = Library.NotificationArea;
        });
    
        Library.NotificationAreaCenter = Library:Create('Frame', {
            BackgroundTransparency = 1;
            AnchorPoint = _Vector2New(0.5,0);
            Position = _UDim2New(0.5, 0, 0.75, 0);
            Size = _UDim2New(0, 300, 0, 200);
            ZIndex = 100;
            Parent = ScreenGui;
        });
        Library:Create('UIListLayout', {
            Padding = _UDimNew(0, 4);
            FillDirection = Enum.FillDirection.Vertical;
            HorizontalAlignment = Enum.HorizontalAlignment.Center;
            SortOrder = Enum.SortOrder.LayoutOrder;
            Parent = Library.NotificationAreaCenter;
        });
    
        local WatermarkOuter = Library:Create('Frame', {
            BorderColor3 = _Color3New(0, 0, 0);
            BorderSizePixel = 0;
            Position = _UDim2New(0, 10, 0, 10);
            Size = _UDim2New(0, 213, 0, 21);
            ZIndex = 200;
            Visible = false;
            Parent = ScreenGui;
        });
        
        local WatermarkInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderSizePixel = 1;
            Size = _UDim2New(1, 0, 1, 0);
            ZIndex = 201;
            Parent = WatermarkOuter;
        });
        
        Library:AddToRegistry(WatermarkInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });
        
        local InnerFrame = Library:Create('Frame', {
            BackgroundColor3 = _Color3New(1, 1, 1);
            BorderSizePixel = 0;
            BackgroundTransparency = 1;
            Position = _UDim2New(0, 1, 0, 1);
            Size = _UDim2New(1, -2, 1, -2);
            ZIndex = 202;
            Parent = WatermarkInner;
        });
        
        local FrameLine = Library:Create('Frame', {
            BorderColor3 = Library.AccentColor;
            BackgroundColor3 = Library.AccentColor;
            BorderSizePixel = 0;
            Position = _UDim2New(0, -1, 1, 0);
            Size = _UDim2New(1, 1, 0, 2);
            ZIndex = 202;
            Parent = WatermarkInner;
        });
        
        Library:AddToRegistry(FrameLine, {
            BorderColor3 = 'AccentColor';
            BackgroundColor3 = "AccentColor";
        });
        
        -- local WatermarkImage = Library:Create('ImageLabel', {
        --     Size = _UDim2New(0, 13, 0, 13);
        --     Position = _UDim2New(0, 5, 0.5, 0);
        --     AnchorPoint = _Vector2New(0, 0.5);
        --     Image = "rbxassetid://140198300701593";
        --     BackgroundTransparency = 1;
        --     ZIndex = 203;
        --     Parent = InnerFrame;
        -- });
        
        local WatermarkLabel = Library:CreateLabel({
            Position = _UDim2New(0, 17, 0, 0);
            Size = _UDim2New(1, -28, 1, 0);
            TextSize = 15;
            RichText = true;
            TextXAlignment = Enum.TextXAlignment.Left;
            ZIndex = 203;
            Parent = InnerFrame;
        });
        
        Library.Watermark = WatermarkOuter;
        Library.WatermarkText = WatermarkLabel;
        Library:MakeDraggable(Library.Watermark);
    
        local KeybindOuter = Library:Create('Frame', {
            BorderSizePixel = 0;
            Position = _UDim2New(0, 10, 0.5, 0);
            Size = _UDim2New(0, 210, 0, 20);
            Visible = false;
            ZIndex = 100;
            Parent = ScreenGui;
        });
        
        local KeybindInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = _UDim2New(1, 0, 1, 7);
            ZIndex = 101;
            Parent = KeybindOuter;
        });

        local KeybindBackground = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = _UDim2New(1, 0, 0, 0);
            Position = _UDim2New(0, 0, 0, 0);
            ZIndex = -1;
            Parent = KeybindOuter;
        });
    
        Library:AddToRegistry(KeybindInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        }, true);

        Library:AddToRegistry(KeybindBackground, {
            BorderColor3 = 'OutlineColor';
            BackgroundColor3 = "MainColor";
        });
    
        local FrameLine2 = Library:Create('Frame', {
            BorderColor3 = Library.AccentColor;
            BackgroundColor3 = Library.AccentColor;
            BorderSizePixel = 0;
            Position = _UDim2New(0, 0, 0, 24);
            Size = _UDim2New(1, 0, 0, 2);
            ZIndex = 202;
            Parent = KeybindInner;
        });
    
        Library:AddToRegistry(FrameLine2, {
            BorderColor3 = 'AccentColor';
            BackgroundColor3 = "AccentColor";
        });
    
        local KeybindLabel = Library:CreateLabel({
            Size = _UDim2New(1, 0, 0, 20);
            Position = _UDim2fromOffset(5, 2),
            TextXAlignment = Enum.TextXAlignment.Center,
            Text = 'Keybinds';
            ZIndex = 104;
            Parent = KeybindInner;
        });
    
        local KeybindContainer = Library:Create('Frame', {
            BackgroundTransparency = 1;
            Size = _UDim2New(1, 0, 1, -20);
            Position = _UDim2New(0, 0, 0, 30);
            ZIndex = 1;
            Parent = KeybindInner;
        });
    
        local KeyListLayout = Library:Create('UIListLayout', {
            FillDirection = Enum.FillDirection.Vertical;
            HorizontalAlignment = Enum.HorizontalAlignment.Left;
            SortOrder = Enum.SortOrder.LayoutOrder;
            Padding = _UDimNew(0, 5);
            Parent = KeybindContainer;
        });
    
        Library:Create('UIPadding', {
            PaddingLeft = _UDimNew(0, 5),
            Parent = KeybindContainer,
        })
    
        Library.KeybindListMode = 1
        Library.KeybindBackground = KeybindBackground;
        Library.KeyUilistlayout = KeyListLayout;
        Library.KeybindFrame = KeybindOuter;
        Library.KeybindContainer = KeybindContainer;
        Library:MakeDraggable(KeybindOuter);
    
        local SpecListOuter = Library:Create('Frame', {
            BorderSizePixel = 0;
            Position = _UDim2New(1, -220, 0.3, 0);
            Size = _UDim2New(0, 210, 0, 20);
            Visible = false;
            ZIndex = 100;
            Parent = ScreenGui;
        });
        
        local SpecListInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = _UDim2New(1, 0, 1, 7);
            ZIndex = 101;
            Parent = SpecListOuter;
        });

        local SpecListBackground = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = _UDim2New(1, 0, 0, 0);
            Position = _UDim2New(0, 0, 0, 0);
            ZIndex = -1;
            Parent = SpecListOuter;
        });
    
        Library:AddToRegistry(SpecListInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        }, true);
    
        Library:AddToRegistry(SpecListBackground, {
            BorderColor3 = 'OutlineColor';
            BackgroundColor3 = 'MainColor';
        });

        local FrameLine3 = Library:Create('Frame', {
            BorderColor3 = Library.AccentColor;
            BackgroundColor3 = Library.AccentColor;
            BorderSizePixel = 0;
            Position = _UDim2New(0, 0, 0, 24);
            Size = _UDim2New(1, 0, 0, 2);
            ZIndex = 202;
            Parent = SpecListInner;
        });
    
        Library:AddToRegistry(FrameLine3, {
            BorderColor3 = 'AccentColor';
            BackgroundColor3 = "AccentColor";
        });
    
        local SpecListLabel = Library:CreateLabel({
            Size = _UDim2New(1, 0, 0, 20);
            Position = _UDim2fromOffset(5, 2),
            TextXAlignment = Enum.TextXAlignment.Center,
            Text = 'Spectators List';
            ZIndex = 104;
            Parent = SpecListInner;
        });
    
        local SpecListContainer = Library:Create('Frame', {
            BackgroundTransparency = 1;
            Size = _UDim2New(1, 0, 1, -20);
            Position = _UDim2New(0, 0, 0, 30);
            ZIndex = 1;
            Parent = SpecListInner;
        });

        local ListLayout = Library:Create('UIListLayout', {
            FillDirection = Enum.FillDirection.Vertical;
            HorizontalAlignment = Enum.HorizontalAlignment.Left;
            SortOrder = Enum.SortOrder.LayoutOrder;
            Padding = _UDimNew(0, 5);
            Parent = SpecListContainer;
        });
    
        Library:Create('UIPadding', {
            PaddingLeft = _UDimNew(0, 5),
            Parent = SpecListContainer,
        })
        
        Library.SpecUIlistlayout = ListLayout;
        Library.SpecListBG = SpecListBackground;
        Library.SpecListFrame = SpecListOuter;
        Library.SpecListContainer = SpecListContainer;
        Library:MakeDraggable(SpecListOuter);
    end;
    

    local PlayersContainerLabels = {}

    function Library:UpdateSpecList(Players)
    
        local YSize = 0
        local XSize = 0

        for i, v in next, PlayersContainerLabels do
            v.Visible = false
            Library.RegistryMap[v].Properties.TextColor3 = 'FontColor'
        end

        for i, v in next, Players do
            if not PlayersContainerLabels[v] then
                PlayersContainerLabels[v] = Library:CreateLabel({
                    TextXAlignment = Enum.TextXAlignment.Center;
                    Size = _UDim2New(1, 0, 0, 18);
                    TextSize = 14;
                    Visible = false;
                    ZIndex = 110;
                    TextColor3 = Library.FontColor;
                    Text = v;
                    Parent = Library.SpecListContainer;
                }, true);
                Library.RegistryMap[PlayersContainerLabels[v]].Properties.TextColor3 = 'FontColor'
            end

            PlayersContainerLabels[v].Visible = true
        end
        
        for _, Label in next, _GetChildren(Library.SpecListContainer) do
            if _IsA(Label, 'TextLabel') and Label.Visible then
                YSize = YSize + Label.AbsoluteSize.Y + Library.SpecUIlistlayout.Padding.Offset
                if (Label.TextBounds.X > XSize) then
                    XSize = Label.TextBounds.X
                end
            end
        end
        if Toggles.Spectator_List.Value then
            if YSize == 0 then
                Library.SpecListBG.Size = _UDim2New(1, 0, 0, 0)
                Library.SpecListBG.BackgroundTransparency = 1
                if Toggles.Speclist_dynamic.Value then
                    if getgenv().ToggleMenu == true then
                        Library.SpecListFrame.Visible = true
                    else
                        Library.SpecListFrame.Visible = false
                    end
                end
            else
                Library.SpecListBG.Size = _UDim2New(0, _MathMax(XSize + 20, 210), 0, YSize + 30)
                Library.SpecListBG.BackgroundTransparency = 0
                Library.SpecListFrame.Visible = true
            end
        end
    end
    function Library:SetSpecListVisibility(Bool)
        Library.SpecListFrame.Visible = Bool;
    end
    function Library:SetWatermarkVisibility(Bool)
        Library.Watermark.Visible = Bool;
    end;
    function Library:SetKeyListVisibility(Bool)
        Library.KeybindFrame.Visible = Bool;
    end;
    
    local function removeHtmlTags(str)
        return _StringGsub(str, "<.->", "")
    end
    function Library:SetWatermark(Text)    
        local X, Y = Library:GetTextBounds(removeHtmlTags(Text), Library.Font, 15);
        Library.Watermark.Size = _UDim2New(0, X + 18, 0, (Y * 1.5) + 0); 
        Library.WatermarkText.Text = Text; 
    end;

    function Library:Notify(Text, Time, Parent)
        local XSize, YSize = Library:GetTextBounds(Text, Library.Font, 15);
        
        YSize = (YSize * 1.5) + 3
    
        local NotifyOuter = Library:Create('Frame', {
            Position = _UDim2New(0, 100, 0, 10);
            BorderColor3 = _Color3New(0,0,0);
            Size = _UDim2New(0, 0, 0, YSize);
            ClipsDescendants = true;
            ZIndex = 100;
            Parent = Library.NotificationArea;
        });
    
        if _StringLower(_tostring(Parent)) == "center" then
            NotifyOuter.Parent = Library.NotificationAreaCenter
        end
    
        local NotifyInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = _UDim2New(1, 0, 1, 0);
            ZIndex = 101;
            Parent = NotifyOuter;
        });
    
        Library:AddToRegistry(NotifyInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        }, true);
    
        local InnerFrame = Library:Create('Frame', {
            BackgroundColor3 = _Color3New(1, 1, 1);
            BorderSizePixel = 0;
            Position = _UDim2New(0, 1, 0, 1);
            Size = _UDim2New(1, -2, 1, -2);
            ZIndex = 102;
            Parent = NotifyInner;
        });
    
        local Gradient = Library:Create('UIGradient', {
            Color = _ColorSequenceNew({
                _ColorSequenceKeypointNew(0, Library:GetDarkerColor(Library.MainColor)),
                _ColorSequenceKeypointNew(1, Library.MainColor),
            });
            Rotation = -90;
            Parent = InnerFrame;
        });
    
        Library:AddToRegistry(Gradient, {
            Color = function()
                return _ColorSequenceNew({
                    _ColorSequenceKeypointNew(0, Library:GetDarkerColor(Library.MainColor)),
                    _ColorSequenceKeypointNew(1, Library.MainColor),
                });
            end
        });
    
        local NotifyLabel = Library:CreateLabel({
            Position = _UDim2New(0, 3, 0, 1);
            Size = _UDim2New(1, -4, 1, -1);
            Text = Text;
            TextXAlignment = Enum.TextXAlignment.Left;
            TextSize = 15;
            ZIndex = 103;
            Parent = InnerFrame;
        });
    
        local TopColor = Library:Create('Frame', {
            BackgroundColor3 = Library.AccentColor;
            BorderSizePixel = 0;
            Position = _UDim2New(0, 1, 0, 1);
            Size = _UDim2New(1, -2, 0, 2);
            ZIndex = 104;
            Parent = NotifyOuter;
        });
    
        Library:AddToRegistry(TopColor, {
            BackgroundColor3 = 'AccentColor';
        }, true);
    
        _Pcall(NotifyOuter.TweenSize, NotifyOuter, _UDim2New(0, XSize + 12, 0, YSize), 'Out', 'Quad', 0.5, true);
    
        _TaskSpawn(function()
            _Wait(Time or 5);
    
            _Pcall(NotifyOuter.TweenSize, NotifyOuter, _UDim2New(0, 0, 0, YSize), 'Out', 'Quad', 0.5, true);
    
            _Wait(0.5)
    
            _Destroy(NotifyOuter);
        end);
    end;
    
    function Library:CreateWindow(...)
        local Arguments = { ... }
        local Config = { AnchorPoint = Vector2.zero }
    
        if _Type(...) == 'table' then
            Config = ...;
        else
            Config.Title = Arguments[1]
            Config.AutoShow = Arguments[2] or false;
        end
    
        if _Type(Config.Title) ~= 'string' then Config.Title = 'No title' end
        if _Type(Config.TabPadding) ~= 'number' then Config.TabPadding = 0 end
        if _Type(Config.MenuFadeTime) ~= 'number' then Config.MenuFadeTime = 0.2 end
    
        if typeof(Config.Position) ~= 'UDim2' then Config.Position = _UDim2fromOffset(175, 50) end
        if typeof(Config.Size) ~= 'UDim2' then Config.Size = _UDim2fromOffset(801, 600) end
        if typeof(Config.Color) ~= 'Color3' then Config.Color = Library.FontColor end

        if Config.Center then
            Config.AnchorPoint = _Vector2New(0.5, 0.5)
            Config.Position = UDim2.fromScale(0.5, 0.5)
        end
    
        local Window = {
            Tabs = {};
            TabButtons = {};
        };
    
        local Outer = Library:Create('Frame', {
            AnchorPoint = Config.AnchorPoint,
            BackgroundColor3 = Library.OutlineColor;
            BorderSizePixel = 0;
            BorderMode = Enum.BorderMode.Outline;
            Position = Config.Position,
            Size = Config.Size,
            Visible = false;
            ZIndex = 1;
            Parent = ScreenGui;
        });
        Window.MainFrame = Outer

    
        local Outer2 = Library:Create('Frame', {
            AnchorPoint = Config.AnchorPoint,
            BackgroundColor3 = Library.MainColor;
            BorderSizePixel = 0;
            BorderMode = Enum.BorderMode.Inset;
            Position = Config.Position,
            Size = Config.Size,
            Visible = false;
            ZIndex = 0;
            Parent = ScreenGui;
        });
        
        Library:MakeDraggable(Outer, 25, Outer2);
        
        local Inner = Library:Create('Frame', {
            BackgroundColor3 = Library.BackgroundColor; -- sirex: why is it Library.Background :WHAT:
            BorderColor3 = Library.OutlineColor;
            BorderSizePixel = 1;
            BorderMode = Enum.BorderMode.Outline;
            Position = _UDim2New(0, 1, 0, 1);
            Size = _UDim2New(1, -2, 1, -2);
            ZIndex = 1;
            Parent = Outer;
        });

        local WindowGlow = Library:Create('ImageLabel', {
            ImageColor3 = Library.AccentColor;
            BackgroundTransparency = 1;
            AnchorPoint = _Vector2New(0.5, 0.5);
            Size =  _UDim2New(0, 849, 0, 650);
            Position = _UDim2New(0.5, 0, 0.5, 0);
            BorderSizePixel = 0;
            Visible = false;
            ZIndex = -90;
            Image = "rbxassetid://73863974528152";
            Parent = Outer;
        });
        

        Library:AddToRegistry(Inner, {
            BackgroundColor3 = 'BackgroundColor';
            BorderColor3 = 'OutlineColor';
        });

        Library:AddToRegistry(Outer, {
            BackgroundColor3 = 'OutlineColor';
        });

        Library:AddToRegistry(WindowGlow, {
            ImageColor3 = 'AccentColor';
        });
    
        Library:AddToRegistry(Outer2, {
            BackgroundColor3 = 'OutlineColor';
        });


        local WindowLabel = Library:CreateLabel({---- window name
            Position = _UDim2New(0.5, 0, 0, 0);
            RichText = true;
            Size = _UDim2New(0, 0, 0, 25);
            TextColor3 = Config.Color;
            Text = Config.Title or '';
            TextXAlignment = Enum.TextXAlignment.Center;
            ZIndex = 1;
            TextSize = 18,
            Parent = Inner;
        });
    
        local MainSectionOuter = Library:Create('Frame', {
            BackgroundColor3 = _Color3FromRGB(255, 0, 0);
            BorderSizePixel = 0;
            Position = _UDim2New(0, 8, 0, 25);
            Size = _UDim2New(1, -16, 1, -33);
            ZIndex = 1;
            Parent = Inner;
        });
    
        --[[Library:AddToRegistry(MainSectionOuter, {
            BackgroundColor3 = 'BackgroundColor';
        });]]
    
        local MainSectionInner = Library:Create('Frame', {
            BackgroundColor3 = _Color3FromRGB(255, 0, 0);
            BorderSizePixel = 0;
            Position = _UDim2New(0, 0, 0, 0);
            Size = _UDim2New(1, 0, 1, 0);
            ZIndex = 1;
            Parent = MainSectionOuter;
        });
    
        --[[[Library:AddToRegistry(MainSectionInner, {
            BackgroundColor3 = 'BackgroundColor';
        });]]
    
        local TabArea = Library:Create('Frame', {
            BackgroundTransparency = 0;
            BorderSizePixel = 1;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Outline;
            Position = _UDim2New(0, 0, 0, 0);
            Size = _UDim2New(1, 0, 0, 28);
            ZIndex = 1;
            Parent = MainSectionInner;
        });

        Library:AddToRegistry(TabArea, {
            BorderColor3 = 'OutlineColor';
        });
    
        local TabListLayout = Library:Create('UIListLayout', {
            Padding = _UDimNew(0, Config.TabPadding);
            FillDirection = Enum.FillDirection.Horizontal;
            HorizontalAlignment = Enum.HorizontalAlignment.Center;
            SortOrder = Enum.SortOrder.LayoutOrder;
            Parent = TabArea;
        });
    
        local TabContainer = Library:Create('Frame', {
            AnchorPoint = _Vector2New(0.5, 0.5);
            BackgroundColor3 = Library.BackgroundColor;
            BorderColor3 = Library.OutlineColor;
            Position = _UDim2New(0.5, 0, 0.5, 14);
            Size = _UDim2New(1, 0, 1, -30);
            ZIndex = 2;
            Parent = MainSectionInner;
        });
        
    
        Library:AddToRegistry(TabContainer, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });
    
        Library.WindowGlow = WindowGlow

        function Library:SetGlowVis(Bool)
            Library.WindowGlow.Visible = Bool;
        end;

        function Window:SetWindowTitle(Title)
            WindowLabel.Text = Title;
        end;
        
        function Window:AddTab(Name)
            local Tab = {
                Groupboxes = {};
                Tabboxes = {};
            };
    
            -- local TabButtonWidth = Library:GetTextBounds(Name, Library.Font, 16);
    
            local TabButton = Library:Create('Frame', {
                BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Library.OutlineColor;
                BorderSizePixel = 1;
                Size = _UDim2New(0, 8, 1, 0);
                ZIndex = 1;
                Parent = TabArea;
            });
            _TableInsert(Window.TabButtons, TabButton)
            for i, v in next, Window.TabButtons do
                v.Size = _UDim2New(1/#Window.TabButtons, -Config.TabPadding, 1, 0)
            end
            
            Library:AddToRegistry(TabButton, {
                BackgroundColor3 = 'BackgroundColor';
                BorderColor3 = 'OutlineColor';
            });
    
            local TabButtonLabel = Library:CreateLabel({
                Position = _UDim2New(0, 0, 0, 0);
                Size = _UDim2New(1, 0, 1, -1);
                Text = Name;
                ZIndex = 1;
                TextSize = 14;
    
                Parent = TabButton;
            });
            
            Library:AddToRegistry(TabButtonLabel, {
                TextColor3 = 'FontColorDark';
            });
            
            local Blocker = Library:Create('Frame', {
                BackgroundColor3 = Library.MainColor;
                BorderSizePixel = 0;
                Position = _UDim2New(0, 0, 1, 0);
                Size = _UDim2New(1, 0, 0, 2);
                BackgroundTransparency = 1;
                ZIndex = 3;
                Parent = TabButton;
            });
    
            Library:AddToRegistry(Blocker, {
                BackgroundColor3 = 'MainColor';
            });
    
            local TabFrame = Library:Create('Frame', {
                Name = 'TabFrame',
                BackgroundTransparency = 1;
                Position = _UDim2New(0, 0, 0, 0);
                Size = _UDim2New(1, 0, 1, 0);
                Visible = false;
                ZIndex = 2;
                Parent = TabContainer;
            });
            Tab.MainFrame = TabFrame
    
            local LeftSide = Library:Create('ScrollingFrame', {
                BackgroundTransparency = 1;
                BorderSizePixel = 0;
                Position = _UDim2New(0, 8 - 1, 0, 8 - 1);
                Size = _UDim2New(0.33525, -12 + 2, 0, 507 + 12);
                CanvasSize = _UDim2New(0, 0, 0, 0);
                BottomImage = '';
                TopImage = '';
                ScrollBarThickness = 0;
                ZIndex = 2;
                Parent = TabFrame;
            });
    
            local CenterSide = Library:Create('ScrollingFrame', {
                BackgroundTransparency = 1;
                BorderSizePixel = 0;
                Position = _UDim2New(0.3325, 4 + 1, 0, 8 - 1);
                Size = _UDim2New(0.33525, -12 + 2, 0, 507 + 12);
                CanvasSize = _UDim2New(0, 0, 0, 0);
                BottomImage = '';
                TopImage = '';
                ScrollBarThickness = 0;
                ZIndex = 2;
                Parent = TabFrame;
            });
    
            local RightSide = Library:Create('ScrollingFrame', {
                BackgroundTransparency = 1;
                BorderSizePixel = 0;
                Position = _UDim2New(0.664, 4 + 1, 0, 8 - 1);
                Size = _UDim2New(0.33525, -12 + 2, 0, 507 + 12);
                CanvasSize = _UDim2New(0, 0, 0, 0);
                BottomImage = '';
                TopImage = '';
                ScrollBarThickness = 0;
                ZIndex = 2;
                Parent = TabFrame;
            });
    
            Library:Create('UIListLayout', {
                Padding = _UDimNew(0, 8);
                FillDirection = Enum.FillDirection.Vertical;
                SortOrder = Enum.SortOrder.LayoutOrder;
                HorizontalAlignment = Enum.HorizontalAlignment.Center;
                Parent = LeftSide;
            });
    
            Library:Create('UIListLayout', {
                Padding = _UDimNew(0, 8);
                FillDirection = Enum.FillDirection.Vertical;
                SortOrder = Enum.SortOrder.LayoutOrder;
                HorizontalAlignment = Enum.HorizontalAlignment.Center;
                Parent = RightSide;
            }); 
    
            Library:Create('UIListLayout', {
                Padding = _UDimNew(0, 8);
                FillDirection = Enum.FillDirection.Vertical;
                SortOrder = Enum.SortOrder.LayoutOrder;
                HorizontalAlignment = Enum.HorizontalAlignment.Center;
                Parent = CenterSide;
            }); 
    
            for _, Side in next, { LeftSide, RightSide, CenterSide } do
                _GetPropertyChangedSignal(Side:WaitForChild('UIListLayout'), 'AbsoluteContentSize'):Connect(function()
                    Side.CanvasSize = _UDim2fromOffset(0, Side.UIListLayout.AbsoluteContentSize.Y);
                end);
            end;
    
            function Tab:ShowTab() ------ showing tab
                for _, Tab in next, Window.Tabs do
                    Tab:HideTab();
                end;

                Blocker.BackgroundTransparency = 0;
                TabButton.BackgroundColor3 = Library.MainColor;
                Library.RegistryMap[TabButton].Properties.BackgroundColor3 = 'MainColor';
                TabButtonLabel.TextColor3 = Library.AccentColor;
                Library.RegistryMap[TabButtonLabel].Properties.TextColor3 = 'AccentColor';
                TabFrame.Visible = true;
            end;
    
            function Tab:HideTab()

                Blocker.BackgroundTransparency = 1;
                TabButton.BackgroundColor3 = Library.BackgroundColor;
                Library.RegistryMap[TabButton].Properties.BackgroundColor3 = 'BackgroundColor';
                TabButtonLabel.TextColor3 = Library.FontColorDark
                Library.RegistryMap[TabButtonLabel].Properties.TextColor3 = 'FontColorDark';
                TabFrame.Visible = false;
            end;
    
            function Tab:SetLayoutOrder(Position)
                TabButton.LayoutOrder = Position;
                TabListLayout:ApplyLayout();
            end;
    
            function Tab:AddGroupbox(Info)
                local Groupbox = {};
    
                local BoxOuter = Library:Create('Frame', {
                    BackgroundColor3 = Library.BackgroundColor;
                    BorderColor3 = Library.BorderColor;
                    BorderMode = Enum.BorderMode.Inset;
                    Size = _UDim2New(1, 0, 0, 507 + 2);
                    ZIndex = 2;
                    Parent = Info.Side == 1 and LeftSide or Info.Side == 3 and CenterSide or RightSide;
                });
    
                Library:AddToRegistry(BoxOuter, {
                    BackgroundColor3 = 'BackgroundColor';
                    BorderColor3 = 'OutlineColor';
                });
    
                local BoxInner = Library:Create('Frame', {
                    BackgroundColor3 = Library.BackgroundColor;
                    BorderColor3 = _Color3New(0, 0, 0);
                    BorderSizePixel = 0;
                    -- BorderMode = Enum.BorderMode.Inset;
                    Size = _UDim2New(1, -2, 1, -2);
                    Position = _UDim2New(0, 1, 0, 1);
                    ZIndex = 4;
                    Parent = BoxOuter;
                });
    
                Library:AddToRegistry(BoxInner, {
                    BackgroundColor3 = 'BackgroundColor';
                });
    
                local Highlight = Library:Create('Frame', {
                    BackgroundColor3 = _Color3FromRGB(255,255,255);
                    BackgroundTransparency = 0.9;
                    BorderSizePixel = 0;
                    Position = _UDim2New(0, 4, 0, 32 - 4);
                    Size = _UDim2New(0.96, 0, 0, 1);
                    ZIndex = 5;
                    Parent = BoxInner;
                });

                local GroupboxLabel = Library:CreateLabel({
                    Size = _UDim2New(1, 0, 0, 18);
                    Position = _UDim2New(0, 6, 0, 5);
                    TextColor3 = Library.AccentColor;
                    TextSize = 14;
                    Text = Info.Name;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    ZIndex = 5;
                    Parent = BoxInner;
                });

                Library:AddToRegistry(GroupboxLabel, {
                    TextColor3 = 'AccentColor';
                });

                local Container = Library:Create('Frame', {
                    BackgroundTransparency = 1;
                    Position = _UDim2New(0, 4, 0, 40-4);
                    Size = _UDim2New(1, -4, 2, -40);
                    ZIndex = 1;
                    Parent = BoxInner;
                });
    
                Library:Create('UIListLayout', {
                    FillDirection = Enum.FillDirection.Vertical;
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    Parent = Container;
                });
    
                function Groupbox:Resize()
                    local Size = 0;
    
                    for _, Element in next, _GetChildren(Groupbox.Container) do
                        if (not _IsA(Element, 'UIListLayout')) and Element.Visible then
                            Size = Size + Element.Size.Y.Offset;
                        end;
                    end;
    
                    BoxOuter.Size = _UDim2New(1, 0, 0, 20 + Size + 2 + 22 - 4);
                end;
    
                Groupbox.Container = Container;
                setmetatable(Groupbox, BaseGroupbox);
    
                Groupbox:AddBlank(3);
                Groupbox:Resize();
    
                Tab.Groupboxes[Info.Name] = Groupbox;
    
                return Groupbox;
            end;
    
            function Tab:AddLeftGroupbox(Name)
                return Tab:AddGroupbox({ Side = 1; Name = Name; });
            end;
    
            function Tab:AddCenterGroupbox(Name)
                return Tab:AddGroupbox({ Side = 3; Name = Name; });
            end;
    
            function Tab:AddRightGroupbox(Name)
                return Tab:AddGroupbox({ Side = 2; Name = Name; });
            end;
    
            function Tab:AddTabbox(Info)
                local Tabbox = {
                    Tabs = {};
                };
    
                local BoxOuter = Library:Create('Frame', {
                    BackgroundColor3 = Library.BackgroundColor;
                    BorderColor3 = Library.OutlineColor;
                    BorderMode = Enum.BorderMode.Inset;
                    Size = _UDim2New(1, 0, 0, 509);
                    ZIndex = 2;
                    Parent = Info.Side == 1 and LeftSide or Info.Side == 3 and CenterSide or RightSide;
                });
    
                Library:AddToRegistry(BoxOuter, {
                    BackgroundColor3 = 'BackgroundColor';
                    BorderColor3 = 'OutlineColor';
                });
    
                local BoxInner = Library:Create('Frame', {
                    BackgroundColor3 = Library.BackgroundColor;
                    BorderColor3 = _Color3New(0, 0, 0);
                    -- BorderMode = Enum.BorderMode.Inset;
                    BorderSizePixel = 0;
                    Size = _UDim2New(1, -2, 1, -2);
                    Position = _UDim2New(0, 1, 0, 1);
                    ZIndex = 4;
                    Parent = BoxOuter;
                });
    
                Library:AddToRegistry(BoxInner, {
                    BackgroundColor3 = 'BackgroundColor';
                });

                local TabboxTitle = Library:CreateLabel({
                    Size = _UDim2New(1, 0, 0, 18);
                    Position = _UDim2New(0, 6, 0, 5);
                    TextColor3 = Library.AccentColor;
                    TextSize = 14;
                    Text = Info.Title or "Tabbox Title";
                    TextXAlignment = Enum.TextXAlignment.Left;
                    ZIndex = 5;
                    Parent = BoxInner;
                });
            
                Library:AddToRegistry(TabboxTitle, {
                    TextColor3 = 'AccentColor';
                });
    
                local Highlight = Library:Create('Frame', {
                    BackgroundColor3 = _Color3FromRGB(255,255,255);
                    BackgroundTransparency = 0.9;
                    BorderSizePixel = 0;
                    Position = _UDim2New(0, 4, 0, 28);
                    Size = _UDim2New(0.96, 0, 0, 1);
                    ZIndex = 10;
                    Parent = BoxInner;
                });
    
                local TabboxButtons = Library:Create('Frame', {
                    BackgroundTransparency = 1;
                    Position = _UDim2New(0, 0, 0, 35 - 4);
                    Size = _UDim2New(1, 0, 0, 18);
                    ZIndex = 5;
                    Parent = BoxInner;
                });
    
                Library:Create('UIListLayout', {
                    FillDirection = Enum.FillDirection.Horizontal;
                    HorizontalAlignment = Enum.HorizontalAlignment.Left;
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    Parent = TabboxButtons;
                });
    
                function Tabbox:AddTab(Name)
                    local Tab = {};
    
                    local TextSizeX, _ = Library:GetTextBounds(Name, Library.Font, 14);

                    local Button = Library:Create('Frame', {
                        BackgroundColor3 = Library.BackgroundColor;
                        BorderColor3 = _Color3New(0, 0, 0);
                        BorderSizePixel = 0;
                        Size = _UDim2New(0, TextSizeX + 10, 1, 0);
                        ZIndex = 6;
                        Parent = TabboxButtons;
                    });
    
                    Library:AddToRegistry(Button, {
                        BackgroundColor3 = 'BackgroundColor';
                    });
    
                    local ButtonLabel = Library:CreateLabel({
                        Size = _UDim2New(1, 0, 1, 0);
                        TextSize = 14;
                        Text = Name;
                        TextXAlignment = Enum.TextXAlignment.Center;
                        ZIndex = 7;
                        Parent = Button;
                    });

                    Library:AddToRegistry(ButtonLabel, {
                        TextColor3 = 'FontColorDark';
                    });
    
                    local Underline = Library:Create('Frame', {
                        BackgroundColor3 = Library.AccentColor;
                        BorderSizePixel = 0;
                        Position = _UDim2New(0.5, -TextSizeX / 2, 1, -1);
                        Size = _UDim2New(0, TextSizeX, 0, 2);
                        Visible = false;
                        ZIndex = 9;
                        Parent = Button;
                    });
    
                    Library:AddToRegistry(Underline, {
                        BackgroundColor3 = 'AccentColor';
                    });
    
                    local Container = Library:Create('Frame', {
                        BackgroundTransparency = 1;
                        Position = _UDim2New(0, 4, 0, 60 - 4);
                        Size = _UDim2New(1, -4, 1, -40);
                        ZIndex = 1;
                        Visible = false;
                        Parent = BoxInner;
                    });
    
                    Library:Create('UIListLayout', {
                        FillDirection = Enum.FillDirection.Vertical;
                        SortOrder = Enum.SortOrder.LayoutOrder;
                        Parent = Container;
                    });
    
                    function Tab:Show()
                        for _, Tab in next, Tabbox.Tabs do
                            Tab:Hide();
                        end;
    
                        Container.Visible = true;
                        Underline.Visible = true;
    
                        ButtonLabel.TextColor3 = Library.FontColor
                        Library.RegistryMap[ButtonLabel].Properties.TextColor3 = 'FontColor';
    
                        
                        Tab:Resize();
                    end;
    
                    function Tab:Hide()
                        Container.Visible = false;
                        Underline.Visible = false;
    
                        ButtonLabel.TextColor3 = Library.FontColorDark
                        Library.RegistryMap[ButtonLabel].Properties.TextColor3 = 'FontColorDark';
    
                    end;
    
                    function Tab:Resize()
                        local TabCount = 0;
    
                        if (not Container.Visible) then
                            return;
                        end;
    
                        local Size = 0;
    
                        for _, Element in next, _GetChildren(Tab.Container) do
                            if (not _IsA(Element, 'UIListLayout')) and Element.Visible then
                                Size = Size + Element.Size.Y.Offset;
                            end;
                        end;
    
                        BoxOuter.Size = _UDim2New(1, 0, 0, 20 + Size + 2 + 40 - 4);
                    end;
    
                    Button.InputBegan:Connect(function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
                            Tab:Show();
                            Tab:Resize();
                        end;
                    end);
    
                    Tab.Container = Container;
                    Tabbox.Tabs[Name] = Tab;
    
                    setmetatable(Tab, BaseGroupbox);
    
                    Tab:AddBlank(3);
                    Tab:Resize();
    
                    -- Show first tab (number is 2 cus of the UIListLayout that also sits in that instance)
                    if #_GetChildren(TabboxButtons) == 2 then
                        Tab:Show();
                    end;
    
                    return Tab;
                end;
    
                Tab.Tabboxes[Info.Name or ''] = Tabbox;
    
                return Tabbox;
            end;
    
            function Tab:AddLeftTabbox(Title)
                return Tab:AddTabbox({ Title = Title, Side = 1; });
            end;
            
            function Tab:AddCenterTabbox(Title)
                return Tab:AddTabbox({ Title = Title, Side = 3; });
            end;
    
            function Tab:AddRightTabbox(Title)
                return Tab:AddTabbox({ Title = Title, Side = 2; });
            end;
    
            TabButton.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Tab:ShowTab();
                end;
            end);
    
            -- This was the first tab added, so we show it by default.
            if #_GetChildren(TabContainer) == 1 then
                Tab:ShowTab();
            end;
    
            Window.Tabs[Name] = Tab;
            return Tab;
        end;
    
        local ModalElement = Library:Create('TextButton', {
            BackgroundTransparency = 1;
            Size = _UDim2New(0, 0, 0, 0);
            Visible = true;
            Text = '';
            Modal = false;
            Parent = ScreenGui;
        });
        
        local TransparencyCache = {};
        local ConnectionCache = {};
        local Toggled = false;
        local Fading = false;
        getgenv().ToggleMenu = Toggled
    
        function Library:Toggle()
            if Fading then
                return;
            end;
    
            local FadeTime = Config.MenuFadeTime;
            Fading = true;
            Toggled = (not Toggled);
            ModalElement.Modal = Toggled;
    
            getgenv().ToggleMenu = Toggled
            
            if Toggled then
                -- A bit scuffed, but if we're going from not toggled -> toggled we want to show the frame immediately so that the fade is visible.
                Outer.Visible = true;
    
                _TaskSpawn(function()
                    -- TODO: add cursor fade?
                    local State = InputService.MouseIconEnabled;
                    local State2 = InputService.MouseBehavior;

                    local Cursor = Drawing.new('Triangle');
                    Cursor.Thickness = 1;
                    Cursor.Filled = true;
                    Cursor.Visible = true;
    
                    local CursorOutline = Drawing.new('Triangle');
                    CursorOutline.Thickness = 1;
                    CursorOutline.Filled = false;
                    CursorOutline.ZIndex = 2
                    CursorOutline.Color = _Color3New(0, 0, 0);
                    CursorOutline.Visible = true;
    
                    local BoxFill = Drawing.new("Square")
                    BoxFill.Thickness = 1;
                    BoxFill.Filled = true;
                    BoxFill.Color = _Color3New(0, 0, 0);
                    BoxFill.Visible = true;
                    BoxFill.Size = _Vector2New(6,6)
    
                    local BoxFill2 = Drawing.new("Square")
                    BoxFill2.Thickness = 1;
                    BoxFill2.Filled = true;
                    BoxFill2.Color = _Color3New(0, 0, 0);
                    BoxFill2.Visible = true;
                    BoxFill2.Size = _Vector2New(10,4)
    
                    local BoxFill3 = Drawing.new("Square")
                    BoxFill3.Thickness = 1;
                    BoxFill3.Filled = true;
                    BoxFill3.Color = _Color3New(0, 0, 0);
                    BoxFill3.Visible = true;
                    BoxFill3.Size = _Vector2New(4,5)
    
                    local BoxFill4 = Drawing.new("Square")
                    BoxFill4.Thickness = 1;
                    BoxFill4.Filled = true;
                    BoxFill4.Color = _Color3New(0, 0, 0);
                    BoxFill4.Visible = true;
                    BoxFill4.Size = _Vector2New(4,4)
    
                    while Toggled and not Library.Unloaded do
                        InputService.MouseIconEnabled = false;
                        InputService.MouseBehavior = Enum.MouseBehavior.Default
    
                        local mPos = _GetMouseLocation(InputService);
    
                        Cursor.Color = Library.AccentColor;
    
                        BoxFill.Color = Library.AccentColor
                        BoxFill.Position = mPos + _Vector2New(3,3)
    
                        BoxFill2.Color = Library.AccentColor
                        BoxFill2.Position = mPos + _Vector2New(3,5)
    
                        BoxFill3.Color = Library.AccentColor
                        BoxFill3.Position = mPos + _Vector2New(5,8)
    
                        BoxFill4.Color = Library.AccentColor
                        BoxFill4.Position = mPos + _Vector2New(7,7)
    
                        local outerA = _Vector2New(mPos.X, mPos.Y)
                        local outerB = _Vector2New(mPos.X + 16, mPos.Y + 6)
                        local outerC = _Vector2New(mPos.X + 6, mPos.Y + 16)
                        
                        CursorOutline.PointA = outerA
                        CursorOutline.PointB = outerB
                        CursorOutline.PointC = outerC
        
                        local centroid = (outerA + outerB + outerC) / 3
                
                        Cursor.PointA = (centroid + (outerA - centroid) * 0.7)
                        Cursor.PointB = (centroid + (outerB - centroid) * 0.7) + _Vector2New(2,1)
                        Cursor.PointC = (centroid + (outerC - centroid) * 0.7) + _Vector2New(1,2)
    
                        RenderStepped:Wait();
                    end;
    
                    InputService.MouseIconEnabled = State;
                    InputService.MouseBehavior = State2
    
                    Cursor:Remove();
                    CursorOutline:Remove();
                    BoxFill:Remove()
                    BoxFill2:Remove()
                    BoxFill3:Remove()
                    BoxFill4:Remove()
                end);
            else
                for Frame, Val in next, Library.OpenedFrames do
                    Frame.Visible = false;
                    Library.OpenedFrames[Frame] = nil;
                end;
            end;
        
            Outer.Visible = Toggled;
    
            Fading = false;
        end
    
        Library:GiveSignal(InputService.InputBegan:Connect(function(Input, Processed)
            if _Type(Library.ToggleKeybind) == 'table' and Library.ToggleKeybind.Type == 'KeyPicker' then
                if Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode.Name == Library.ToggleKeybind.Value then
                    _TaskSpawn(Library.Toggle)
                end
            elseif Input.KeyCode == Enum.KeyCode.RightControl or (Input.KeyCode == Enum.KeyCode.RightShift and (not Processed)) then
                _TaskSpawn(Library.Toggle)
            end
        end))
    
        if Config.AutoShow then _TaskSpawn(Library.Toggle) end
    
        Window.Holder = Outer;
    
        return Window;
    end;
    
    local function OnPlayerChange()
        local PlayerList = GetPlayersString();
    
        for _, Value in next, Options do
            if Value.Type == 'Dropdown' and Value.SpecialType == 'Player' then
                Value:SetValues(PlayerList);
            end;
        end;
    end;
    
    Library:AddSignal(Players.PlayerAdded, OnPlayerChange)
    Library:AddSignal(Players.PlayerRemoving, OnPlayerChange)
    
    getgenv().Library = Library
    
    local function ConnectKeyPickerToToggle(toggle, keypicker)
        local Toggle = Toggles[toggle]
        local Keypicker = Options[keypicker]
        if Toggle and Keypicker and Keypicker.ConnectedToggles then
            _TableInsert(Keypicker.ConnectedToggles, Toggle)
        end
    end
    getgenv().ConnectKeyPickerToToggle = ConnectKeyPickerToToggle
end 

local Library = getgenv().Library
local ThemeManager = getgenv().ThemeManager
local SaveManager = getgenv().SaveManager
local EspPreviewManager = getgenv().EspPreviewManager
local Toggles = getgenv().Toggles
local Options = getgenv().Options
local Flags = getgenv().Flags

local RavenENV = {
    Watermark = {
        ["Fps"] = 1;
        ["StoredFps"] = 1;
        ["Ping"] = 0;
        ["Delta"] = 1;
        ["RefreshRate"] = _Tick();
    },
    Utility = {},
    Cache = {
        Client = getsenv(_FindFirstChild(LocalPlayer, "PlayerGui").Client),
        HitModifiers = {
            ["Head"] = 4,
            ["FakeHead"] = 4,
            ["HeadHB"] = 4,
            ["UpperTorso"] = 1,
            ["LowerTorso"] = 1.25,
            ["LeftUpperArm"] = 1,
            ["LeftLowerArm"] = 1,
            ["LeftHand"] = 1,
            ["RightUpperArm"] = 1,
            ["RightLowerArm"] = 1,
            ["RightHand"] = 1,
            ["LeftUpperLeg"] = 0.75,
            ["LeftLowerLeg"] = 0.75,
            ["LeftFoot"] = 0.75,
            ["RightUpperLeg"] = 0.75,
            ["RightLowerLeg"] = 0.75,
            ["RightFoot"] = 0.75,
            ["ForwardTrack"] = 1,
            ["BackTrack"] = 1,
        },
        hitgroups = {
            ["Head"] = {"Head"},
            ["Chest"] = {"UpperTorso"},
            ["Pelvis"] = {"LowerTorso"},
            ["Arms"] = {"LeftLowerArm", "RightLowerArm", "LeftUpperArm", "RightUpperArm"},
            ["Legs"] = {"LeftLowerLeg", "LeftUpperLeg", "RightLowerLeg", "RightUpperLeg"},
            ["Feet"] = {"LeftFoot", "RightFoot"}
        },
        TracerTextures = {        
            ["None"] = "rbxassetid://0",
            ["Lighting"] = "rbxassetid://7216850022",
            ["Laser"] = "rbxassetid://7136858729",
            ["Twisted Energy"] = "rbxassetid://7071778278",
            ["Anime Lazer"] = "rbxassetid://17441065350",
            ["Interstellar"] = "rbxassetid://128372145766358",
            ["Arrow"] = "rbxassetid://1274378728",
            ["Minecraft"] = "rbxassetid://152410036",
            ["Alien Energy Ray"] = "rbxassetid://6091341618",
            ["Energy Ray"] = "rbxassetid://13832105797",
            ["Matrix"] = "rbxassetid://15097610754",
            ["Cartoony Eletric"] = "rbxassetid://18722421816"
        },
        MaterialNames = (function()
            local tbl = {}
            for i, v in next, Enum.Material:GetEnumItems() do
                _TableInsert(tbl, v.Name)
            end
            return tbl
        end)(),
    },
    RageBot = {
        Target = {
            TargetPosition = nil,
            Origin = nil,
            CryptedPosition = nil,
            HitName = nil,
            TargetPlayer = nil,
            Damage = nil,
            DamageMultiplayer = nil,
            Hit = nil
        },
    },
    Visuals = {},
    Movement = {},
    AntiAim = {},
    Calculations = {},
    PlayerModule = {},
    Misc = {},
    Esp = {},
}
local Watermark = RavenENV.Watermark
local RageBot = RavenENV.RageBot
local Cache = RavenENV.Cache
local AntiAim = RavenENV.AntiAim
local PlayerModule = RavenENV.PlayerModule
local Visuals = RavenENV.Visuals
local Utility = RavenENV.Utility
local Movement = RavenENV.Movement
local Misc = RavenENV.Misc
local Calculations = RavenENV.Calculations
local Esp = RavenENV.Esp
local Window = Library:CreateWindow({
    Title = "SHITwARE.cc",
    Center = true,
    AutoShow = true,
    TabPadding = 0,
    MenuFadeTime = 0
})

local forcefieldAnimations = {["Off"] = "rbxassetid://0",["Web"] = "rbxassetid://301464986",["Scan"] = "rbxassetid://5843010904",["Swirl"] = "rbxassetid://8133639623",["Checkerboard"] = "rbxassetid://5790215150",["Christmas"] = "rbxassetid://6853532738",["Player"] = "rbxassetid://4494641460",["Shield"] = "rbxassetid://361073795",["Dots"] = "rbxassetid://5830615971",["Bubbles"] = "rbxassetid://1461576423",["Matrix"] = "rbxassetid://10713189068",["Groove"] = "rbxassetid://10785404176",["Cloud"] = "rbxassetid://5176277457",["Sky"] = "rbxassetid://1494603972",["Smudge"] = "rbxassetid://6096634060",["Scrapes"] = "rbxassetid://6248583558",["Galaxy"] = "rbxassetid://1120738433",["Stars"] = "rbxassetid://598201818",["Rainbow"] = "rbxassetid://10037165803", ["Triangular"]="rbxassetid://4504368932", ["Wall"] = "rbxassetid://4271279"}
local forcefieldAnimationsDropDown = {}
for i, v in next, forcefieldAnimations do
    forcefieldAnimationsDropDown[1 + #forcefieldAnimationsDropDown] = i
end

local ChrModels = game:GetObjects("rbxassetid://15837369190")[1]
local AllCharacters = {}
for i,v in pairs(ChrModels:GetChildren()) do
    table.insert(AllCharacters, v.Name)
end


local function ChangeCharacter(model)
    local character = LocalPlayer.Character
    if not character then return end

    for _, v in ipairs(_GetChildren(character)) do
        if _IsA(v, "Accessory") then
            _Destroy(v)
        end
    end

    for _, part in ipairs(_GetDescendants(character)) do
        if _IsA(part, "BasePart") then
            local newPart = _FindFirstChild(model, part.Name, true)
            if newPart and _IsA(newPart, "BasePart") then
                part.Color = newPart.Color
                part.Transparency = newPart.Transparency

                local colorVal = _Instancenew("Color3Value")
                colorVal.Name = "OriginalColor"
                colorVal.Value = part.Color
                colorVal.Parent = part

                local materialVal = _Instancenew("StringValue")
                materialVal.Name = "OriginalMaterial"
                materialVal.Value = part.Material.Name
                materialVal.Parent = part
            end
        end
    end
    local head = _FindFirstChild(character, "Head")
    local newHead = _FindFirstChild(model, "Head")
    if head and newHead then
        local headDecal = _FindFirstChildOfClass(head, "Decal")
        local newHeadDecal = _FindFirstChildOfClass(newHead, "Decal")
        if headDecal and newHeadDecal then
            headDecal.Texture = newHeadDecal.Texture
        end
    end
    local function copyClothing(className)
        local old = _FindFirstChildOfClass(character, className)
        if old then _Destroy(old) end
        local new = _FindFirstChildOfClass(model, className)
        if new then
            local clone = _Clone(new)
            clone.Parent = character

            local value = _Instancenew("StringValue")
            value.Name = "OriginalTexture"
            value.Value = clone[className .. "Template"]
            value.Parent = clone
        end
    end

    copyClothing("Shirt")
    copyClothing("Pants")

    for _, accessory in ipairs(_GetChildren(model)) do
        if accessory:IsA("Accessory") then
            local cloned = _Clone(accessory)
            local handle = _FindFirstChild(cloned, "Handle")
            if handle then
                for _, weld in ipairs(_GetChildren(handle)) do
                    if _IsA(weld, "Weld") and weld.Part1 then
                        local match = _FindFirstChild(character, weld.Part1.Name)
                        if match then
                            weld.Part1 = match
                        end
                    end
                end

                local colorVal = _Instancenew("Color3Value")
                colorVal.Name = "OriginalColor"
                colorVal.Value = handle.Color
                colorVal.Parent = handle

                local materialVal = _Instancenew("StringValue")
                materialVal.Name = "OriginalMaterial"
                materialVal.Value = handle.Material.Name
                materialVal.Parent = handle
            end
            cloned.Parent = character
        end
    end
end

local function ChangeCharacterToUserIdAvatar(userId)
    local model = Players:CreateHumanoidModelFromUserId(userId)
    for _, descendant in ipairs(_GetDescendants(model)) do
        if _IsA(descendant, "ParticleEmitter") or
        _IsA(descendant, "Trail") or
        _IsA(descendant, "Beam") or
        _IsA(descendant, "Fire") or
        _IsA(descendant, "Sparkles") or
        _IsA(descendant,"Smoke") or
        _IsA(descendant, "Highlight") then
            _Destroy(descendant)
        end
    end
    if _FindFirstChild(model, "FullOutline") then
        _Destroy(model.FullOutline)
    end
    model.Name = "TargetCharacter"
    model:WaitForChild("Humanoid")
    ChangeCharacter(model)
    _Destroy(model)
end

do
    --Tabs
    	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
    local RageTab = Window:AddTab("Rage")
    local MiscTab = Window:AddTab("Misc")
    local VisualsTab = Window:AddTab("Visuals")
    local SettingsTab = Window:AddTab("Settings")
    --
    local RageBotGroup = RageTab:AddLeftGroupbox("Main")
    local TrackingGroup = RageTab:AddLeftGroupbox("Tracking")
    local RageBotSettingsGroup = RageTab:AddCenterGroupbox("RageBot Settings")
    local AntiHitTabbox = RageTab:AddRightTabbox("Anti hit")
    local AntiAimGroup = AntiHitTabbox:AddTab("Anti Aim")
    local FakeLagsGroup = AntiHitTabbox:AddTab("Fake Lags")

    local MovementGroup = MiscTab:AddRightGroupbox("Movement")
    local AnotherGroup = MiscTab:AddCenterGroupbox("Another")
    
    local ExploitsGroup = MiscTab:AddLeftGroupbox("Exploit")
    RageBotGroup:AddToggle("RageBot_Enabled", {Text = "Enabled"}):AddKeyPicker("RageBotKeyBind", {Default = '...', SyncToggleState = false,Mode = "Toggle",Text = "Rage Bot",NoUI = false})
    RageBotGroup:AddToggle("RageBot_AutoWall", {Text = "Auto Wall"}):AddKeyPicker("AutoWallKeyBind", {Default = '...', SyncToggleState = false,Mode = "Toggle",Text = "Auto Wall",NoUI = false})
    RageBotGroup:AddToggle("RageBot_HitScan", {Text = "Auto Wall HitScan"})  
    ConnectKeyPickerToToggle("RageBot_Enabled", "RageBotKeyBind")
    ConnectKeyPickerToToggle("RageBot_AutoWall", "AutoWallKeyBind")
    RageBotGroup:AddToggle("RageBot_Prediction", {Text = "Prediction"})
    RageBotGroup:AddToggle("RageBot_FakeShoot", {Text = "Shoot SFX"})
    RageBotGroup:AddToggle("RageBot_AutoPeek", {Text = "Auto Peek"}):AddKeyPicker("RageBot_AutoPeekKeyBind", {Default = '...', SyncToggleState = false,Mode = "Toggle",Text = "Auto Peek",NoUI = false})
    ConnectKeyPickerToToggle("RageBot_AutoPeek", "RageBot_AutoPeekKeyBind")
    RageBotGroup:AddToggle("RageBot_FireRate", {Text = "RapidFire"})
    RageBotGroup:AddToggle("RageBot_Auto_Scope", {Text = "Auto Scope"})
    	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
    RageBotGroup:AddToggle("RageBot_Double_Scope", {Text = "Double Scope (Auto Scope)"})
    --RageBotGroup:AddToggle("RageBot_MultiTarget", {Text = "Multi Target"})
    RageBotGroup:AddToggle("RageBot_Preparation", {Text = "Wait for round start"})
    RageBotGroup:AddToggle("RageBot_AtTargets", {Text = "Arms at targets"})
    TrackingGroup:AddToggle("ForwardTrack_Enabled", {Text = "Enable ForwardTrack"})
    TrackingGroup:AddToggle("ForwardTrack_Ignore_Walls", {Text = "Ignore Walls"})
    TrackingGroup:AddSlider("ForwardTrack_Ticks", {Text = 'ForwardTrack Ticks' ,Default = 150, Min = 1, Max = 4000, Rounding = 0, Compact = false})
    TrackingGroup:AddSlider("ForwardTrack_Steps_to_Scan", {Text = 'Steps to Scan' ,Default = 14, Min = 1, Max = 100, Rounding = 0, Compact = false})
    --TrackingGroup:AddToggle("BackTrack_Enabled", {Text = "Enable BackTrack"})
    --TrackingGroup:AddSlider("BackTrack_Ticks", {Text = 'BackTrack Ticks' ,Default = 150, Min = 1, Max = 1000, Rounding = 0, Compact = false})
    TrackingGroup:AddToggle("Camera_Resolver", {Text = "Camera Resolver"})
    RageBotSettingsGroup:AddDropdown("RageBot_TargetParts", {Text = "Target Hitboxes", Values = {"Head", "Chest", "Pelvis", "Arms", "Legs", "Feet"}, Multi = true, Default = 1})
    RageBotSettingsGroup:AddDropdown("RageBot_HitScan_Points", {Text = "HitScan Points", Values = {"Up", "Down", "Left", "Right", "Forward", "Backward", "Towards"}, Multi = true, Default = 1})
    RageBotSettingsGroup:AddSlider("RageBot_HitScan_Modifier", {Text = 'HitScan Modifier' ,Default = 1, Min = 1, Max = 100, Rounding = 0, Compact = false})
    RageBotSettingsGroup:AddDropdown("RageBot_Origins", {Text = "Origins", Values = {"Camera", "Head", "Flash"}, Multi = false, Default = 1})
    RageBotSettingsGroup:AddSlider("RageBot_HitScan_MaximumPoints", {Text = 'Maximum Hitscanning Points' ,Default = 1, Min = 1, Max = 64, Rounding = 0, Compact = false})
    RageBotSettingsGroup:AddSlider("RageBot_MinDmg", {Text = 'Minimum Damage' ,Default = 50, Min = 1, Max = 100, Rounding = 0, Compact = false})
    RageBotSettingsGroup:AddSlider("RageBot_MaxWalls", {Text = 'Maximum Walls' ,Default = 4, Min = 1, Max = 25, Rounding = 0, Compact = false})
    RageBotSettingsGroup:AddSlider("RageBot_FireRateValue", {Text = 'RapidFire Ticks' ,Default = 0, Min = 0, Max = 100, Rounding = 0, Compact = false})
    RageBotSettingsGroup:AddSlider("RageBot_FOV", {Text = 'FIV' ,Default = 180, Min = 1, Max = 180, Rounding = 0, Compact = false})
    RageBotSettingsGroup:AddSlider("RageBot_PenModded", {Text = 'Penetration Mod' ,Default = 1, Min = 1, Max = 1000, Rounding = 0, Compact = false})
    RageBotSettingsGroup:AddSlider("RageBot_PingMultiPlayer", {Text = "Ping MultiPlayer" ,Default = 0, Min = -250, Max = 250, Rounding = 0, Compact = false})

    AntiAimGroup:AddToggle("AntiAim_Enabled", {Text = "Enabled"})
AntiAimGroup:AddDropdown("AntiAim_Pitch", { Text = "Pitch", Values = {"None","Upwards", "Glitch", "Zero","Downwards","Random"}, Default = "Downwards", AllowNull = false})  
AntiAimGroup:AddSlider("AntiAimSpin_Yaw", {Text = "Yaw", Default = 25, Min = 0, Max = 180, Rounding = 0, Compact = false})
AntiAimGroup:AddDropdown("AntiAim_YawBase", {Text = "Yaw Base", Values = {"Spin", "Targets", "Camera", "Random"}, Default = "Camera", AllowNull = false})
AntiAimGroup:AddSlider("AntiAimSpin_Speed", {Text = "Spin Speed", Default = 25, Min = 1, Max = 180, Rounding = 0, Compact = false})
AntiAimGroup:AddDivider()
AntiAimGroup:AddToggle("AntiAim_In_Gravity", {Text = "Enable In Gravity"})
AntiAimGroup:AddSlider("AntiAim_In_Gravity_BaseSpin", {Text = "Base Spin", Default = 25, Min = 1, Max = 180, Rounding = 0, Compact = false})
AntiAimGroup:AddSlider("AntiAim_In_Gravity_MaximumSpin", {Text = "Maximum Spin", Default = 25, Min = 1, Max = 180, Rounding = 0, Compact = false})
AntiAimGroup:AddSlider("AntiAim_In_Gravity_Speed", {Text = "Speed", Default = 3, Min = 1, Max = 50, Rounding = 0, Compact = false})
AntiAimGroup:AddDivider()
AntiAimGroup:AddToggle("AntiAim_СFrame_Manipulation", {Text = "Enable CFrame Manipulation"})
AntiAimGroup:AddSlider("AntiAim_СFrame_Manipulation_X", {Text = "X", Default = 0, Min = -100, Max = 100, Rounding = 0, Compact = false})
AntiAimGroup:AddSlider("AntiAim_СFrame_Manipulation_Y", {Text = "Y", Default = 0, Min = -100, Max = 100, Rounding = 0, Compact = false})
AntiAimGroup:AddSlider("AntiAim_СFrame_Manipulation_Z", {Text = "Z", Default = 0, Min = -100, Max = 100, Rounding = 0, Compact = false})
AntiAimGroup:AddSlider("AntiAim_СFrame_Manipulation_X_Angles", {Text = "X Angles", Default = 0, Min = -360, Max = 360, Rounding = 0, Compact = false})
AntiAimGroup:AddSlider("AntiAim_СFrame_Manipulation_Y_Angles", {Text = "Y Angles", Default = 0, Min = -360, Max = 360, Rounding = 0, Compact = false})
AntiAimGroup:AddSlider("AntiAim_СFrame_Manipulation_Z_Angles", {Text = "Z Angles", Default = 0, Min = -360, Max = 360, Rounding = 0, Compact = false})


	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
FakeLagsGroup:AddToggle("FakeLags_Enabled", {Text = "Enabled"})
FakeLagsGroup:AddToggle("FakeLags_PreventReplication", {Text = "Prevent Replication"}):AddKeyPicker("PreventReplicaKeyBind", {Default = '...', SyncToggleState = false, Mode = "Toggle", Text = "Prevent Replication", NoUI = false})
FakeLagsGroup:AddSlider("FakeLags_Ticks", {Text = "Ticks", Default = 0, Min = 0, Max = 2048, Rounding = 0, Compact = false})
FakeLagsGroup:AddSlider("FakeLags_Limit", {Text = "Limit", Default = 0, Min = 0, Max = 256, Rounding = 0, Compact = false})
ConnectKeyPickerToToggle("FakeLags_PreventReplication", "PreventReplicaKeyBind")

AnotherGroup:AddToggle("KillAll_Enabled", {Text = "Kill All"}):AddKeyPicker("KillAllKeyBind", {Default = '...', SyncToggleState = false, Mode = "Toggle", Text = "Kill All", NoUI = false})
ConnectKeyPickerToToggle("KillAll_Enabled", "KillAllKeyBind")
AnotherGroup:AddSlider("KillAll_PingMultiPlayer", {Text = "Ping MultiPlayer", Default = 0, Min = -250, Max = 250, Rounding = 0, Compact = false})
AnotherGroup:AddDivider()

AnotherGroup:AddToggle("HitSounds_Enabled", {Text = "Enable Hitsounds"})
AnotherGroup:AddDropdown("HitSounds_Ids", {Text = "Select Hitsound", Values = {'Neverlose','Skeet', 'Rust', 'Monster kill', 'Fatality', 'TF2', 'TF2 Pan', 'Beautiful', 'Minecraft', 'Minecraft XP', 'Cod', 'Ray', 'Matchine gun', 'Retro loud', 'CSGO', 'Slap', 'Squash', 'Supersmash', 'Killingspree', 'Godlike', 'Ownage', 'Ultrakill', '1', 'MCOOF', 'Quek', 'Epic', 'Osu', 'Bell', 'Rocket', 'Vine Boom', 'Pow', 'Bag', 'Baimware', 'Overwatch', 'Pop', 'Win', 'Denied', 'Lessgo', 'Headshot', 'Bruh', 'Percussion', 'Space', 'Electro', 'Vortex', 'Retro', 'Osu Mint', 'Snap'}, Default = "Downwards", AllowNull = false})
AnotherGroup:AddSlider("HitSounds_Volume", {Text = "Hitsound Volume", Default = 100, Min = 1, Max = 100, Rounding = 0, Compact = false})

AnotherGroup:AddToggle("KillSounds_Enabled", {Text = "Enable Killsounds"})
AnotherGroup:AddDropdown("KillSounds_Ids", {Text = "Select Killsound", Values = {'Neverlose','Skeet', 'Rust', 'Fatality', 'Monster kill', 'TF2', 'TF2 Pan', 'Beautiful', 'Minecraft', 'Minecraft XP', 'Cod', 'Ray', 'Matchine gun', 'Retro loud', 'CSGO', 'Slap', 'Squash', 'Supersmash', 'Killingspree', 'Godlike', 'Ownage', 'Ultrakill', '1', 'MCOOF', 'Quek', 'Epic', 'Osu', 'Bell', 'Rocket', 'Vine Boom', 'Pow', 'Bag', 'Baimware', 'Overwatch', 'Pop', 'Win', 'Denied', 'Lessgo', 'Headshot', 'Bruh', 'Percussion', 'Space', 'Electro', 'Vortex', 'Retro', 'Osu Mint', 'Snap'}, Default = "Downwards", AllowNull = false})
AnotherGroup:AddSlider("KillSounds_Volume", {Text = "Killsound Volume", Default = 100, Min = 1, Max = 100, Rounding = 0, Compact = false})

local allweapons = {}
if game:GetService("ReplicatedStorage"):FindFirstChild("Weapons") then
    for i, v in next, (game:GetService("ReplicatedStorage").Weapons:GetChildren()) do
        if (v:FindFirstChild("Primary") or v:FindFirstChild("Secondary")) and not v:FindFirstChild("Melee") then
            allweapons[1 + #allweapons] = v.Name
        end
    end
end

ExploitsGroup:AddToggle("Spawn_Weapons", {Text = "Spawn Weapons"})
ExploitsGroup:AddDropdown("Spawn_Weapons_Primary", {Text = "Select Primary Weapon", Values = allweapons, Default = "Downwards", AllowNull = false})
ExploitsGroup:AddDropdown("Spawn_Weapons_Secondary", {Text = "Select Secondary Weapon", Values = allweapons, Default = "Downwards", AllowNull = false})
ExploitsGroup:AddToggle("Anti_Camera_Resolver", {Text = "Anti Camera Resolver"})
ExploitsGroup:AddToggle("Break_Aura", {Text = "Break Aura"})
ExploitsGroup:AddToggle("Damage_Modifier", {Text = "Damage Modifier"})
ExploitsGroup:AddSlider("Damage_ModifierValue", {Text = "Modifier", Default = 100, Min = 1, Max = 100, Rounding = 0, Compact = false})
ExploitsGroup:AddToggle("Chat_Dead", {Text = "Show Dead Messages (chat)"})
ExploitsGroup:AddToggle("Remove_Killers", {Text = "Remove Killers"})
ExploitsGroup:AddDivider()
ExploitsGroup:AddToggle("Inf_Ammo", {Text = "Infinite Ammo"})
ExploitsGroup:AddToggle("Instance_Equip", {Text = "Instant Equip"})
ExploitsGroup:AddToggle("Instant_Reload", {Text = "Instant Reload"})
ExploitsGroup:AddToggle("Fully_Automatic", {Text = "Fully Automatic"})
ExploitsGroup:AddToggle("Remove_Spread", {Text = "Remove Spread"})

MovementGroup:AddToggle("Movement_SlideWalk", {Text = "Slide Walk"})
MovementGroup:AddToggle("Movement_SpeedHack", {Text = "Speed Hack"})
MovementGroup:AddToggle("Movement_AutoHop", {Text = "Auto Hop"})
MovementGroup:AddDropdown("Movement_SpeedHackMethod", {Text = "Speed Hack Method", Values = {"Velocity", "CFrame"}, Default = "Downwards", AllowNull = false})
MovementGroup:AddSlider("Movement_Speed", {Text = "Speed", Default = 25, Min = 0, Max = 150, Rounding = 0, Compact = false})
MovementGroup:AddToggle("Movement_OverrideSpeedHack", {Text = "Override Speed"}):AddKeyPicker("OverrideSpeedHackKeyBind", {Default = '...', SyncToggleState = false, Mode = "Toggle", Text = "Override Speed", NoUI = false})
MovementGroup:AddSlider("Movement_OverrideSpeed", {Text = "Override Speed", Default = 25, Min = 0, Max = 150, Rounding = 0, Compact = false})

    ConnectKeyPickerToToggle("Movement_OverrideSpeedHack", "OverrideSpeedHackKeyBind")

    local Worldtabbox = VisualsTab:AddRightTabbox("World")
    local LightTab = Worldtabbox:AddTab("Light")
    local ParticlesTab = Worldtabbox:AddTab("Particles")
    local LocalTabbox = VisualsTab:AddCenterTabbox("Local")
    local CameraTab = LocalTabbox:AddTab("Camera")
    local ArmsTab = LocalTabbox:AddTab("Arms")
    local BulletsTab = LocalTabbox:AddTab("Bullets")
    local CharacterTab = LocalTabbox:AddTab("Character")
    local CrosshairTab = LocalTabbox:AddTab("Crosshair")

    local EspTabbox = VisualsTab:AddLeftTabbox("Esp")
    
    local EnemiesTab = EspTabbox:AddTab("Enemies")
    local TeamTab = EspTabbox:AddTab("Team")
    local EspSettingsTab = EspTabbox:AddTab("Settings")



    CharacterTab:AddToggle("Character_Changer", {Text = "Character Changer", Default = false, Callback = function(v)
        if v then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Gun") then
                if Flags["Character_Changer_Character"] == "Custom" then
                    ChangeCharacterToUserIdAvatar(Flags["Character_Changer_Character_Custom"])
                else
                    ChangeCharacter(ChrModels:FindFirstChild(Flags["Character_Changer_Character"]))
                end
            end
        end
    end})
    CharacterTab:AddDropdown('Character_Changer_Character', {
        Values = {"Custom", _TableUnpack(AllCharacters)},
        Default = 1,
        Multi = false,
        Text = 'Character',
        Callback = function(Value)
            if Flags["Character_Changer"] then
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Gun") then
                    if Flags["Character_Changer_Character"] == "Custom" then
                        ChangeCharacterToUserIdAvatar(Flags["Character_Changer_Character_Custom"])
                    else
                        ChangeCharacter(ChrModels:FindFirstChild(Flags["Character_Changer_Character"]))
                    end
                    
                end
            end
        end
    })
    CharacterTab:AddInput('Character_Changer_Character_Custom', {Default = '1831554653', Numeric = false, Finished = false, Text = 'Player id', Placeholder = 'Player id', Callback = function(Value)
        if Flags["Character_Changer"] and Flags["Character_Changer_Character"] == "Custom" then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Gun") then
                ChangeCharacterToUserIdAvatar(Value)
            end
        end
    end})

    CharacterTab:AddToggle("Accessory_Enabled", {Text = "Enable Spining Accessory", Default = false})
CharacterTab:AddSlider('Accessory_Distance', {Text = 'Distance', Min = 0, Max = 100, Rounding = 0, Default = 6})
CharacterTab:AddSlider('Accessory_Height', {Text = 'Height', Min = 0, Max = 100, Rounding = 0, Default = 0})
CharacterTab:AddToggle("Accessory_Spin_ItSelf", {Text = "Spin It Self", Default = false})
CharacterTab:AddSlider('Accessory_Spin_Speed', {Text = 'Spin Speed', Min = 0, Max = 360, Rounding = 0, Default = 144})
CharacterTab:AddSlider('Accessory_Rotation_Speed', {Text = 'Rotation Speed', Min = 0, Max = 360, Rounding = 0, Default = 144})
CharacterTab:AddInput('Accessory_ID', {Default = '17899556174', Numeric = false, Finished = false, Text = 'Accessory id', Placeholder = 'Accessory id'})
CharacterTab:AddToggle("Accessory_Highlight_Enabled", {Text = "Highlight", Default = false})
    :AddColorPicker("Accessory_Highlight_FillColor", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})
    :AddColorPicker("Accessory_Highlight_OutlineColor", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})
CharacterTab:AddSlider("Accessory_Highlight_FillTransparency", {Text = 'Fill Transparency', Default = 5, Min = 1, Max = 10, Rounding = 0, Compact = false})
CharacterTab:AddSlider("Accessory_Highlight_OutlineTransparency", {Text = 'Outline Transparency', Default = 5, Min = 1, Max = 10, Rounding = 0, Compact = false})

ArmsTab:AddToggle("Model_Changer_Weapon", {Text = "Weapon Chams", Default = false})
    :AddColorPicker("Model_Changer_Color", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})
ArmsTab:AddDropdown('Model_Changer_Material', {Text = 'Weapon Chams Material', Values = {"Ghost", "Flat", "Custom", "Reflective", "Metallic"}, Default = 1})
ArmsTab:AddDropdown('Model_Changer_Texture', {Text = 'Weapon Chams Material', Values = forcefieldAnimationsDropDown, Default = 1})
ArmsTab:AddSlider('Model_Changer_Transperency', {Text = 'Transparency', Min = 0, Max = 100, Rounding = 0, Default = 1})
ArmsTab:AddSlider('Model_Changer_Reflectance', {Text = 'Reflectance', Min = 0, Max = 100, Rounding = 0, Default = 1})
ArmsTab:AddDivider()
ArmsTab:AddToggle('Arms_Changer', {Text = 'Arms Changer'})
    :AddColorPicker("Arms_Changer_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})
    :AddColorPicker("Arms_Changer_Color2", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})
ArmsTab:AddDropdown('Arms_Changer_Material', {Text = 'Arms Changer Material', Values = {"Ghost", "Flat", "Custom", "Reflective", "Metallic"}, Default = 1})
ArmsTab:AddSlider('Arms_Transparency1', {Text = 'Arms Transparency', Min = 0, Max = 100, Rounding = 0, Default = 1})
ArmsTab:AddSlider('Arms_Transparency2', {Text = 'Sleeve Transparency', Min = 0, Max = 100, Rounding = 0, Default = 1})
ArmsTab:AddSlider('Arms_Reflective', {Text = 'Arms Reflectivity', Min = 0, Max = 100, Rounding = 0, Default = 1})
ArmsTab:AddSlider('Arms_Reflective_Sleeve', {Text = 'Sleeve Reflectivity', Min = 0, Max = 100, Rounding = 0, Default = 1})
ArmsTab:AddDropdown('Arms_Changer_Texture', {Text = 'Arms Texture', Values = forcefieldAnimationsDropDown, Default = 1})


    EnemiesTab:AddToggle("Enemy_Boxes", {Text = "Boxes", Default = false}):AddColorPicker("Enemy_Boxes_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})
EnemiesTab:AddToggle("Enemy_Boxes_Filled", {Text = "Boxes Filled", Default = false}):AddColorPicker("Enemy_Boxes_Filled_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})
EnemiesTab:AddSlider("Enemy_Boxes_Filled_Transperency", {Text = 'Transperency', Default = 5, Min = 1, Max = 10, Rounding = 0, Compact = false})

EnemiesTab:AddToggle("Enemy_Health_Bar", {Text = "Health Bar", Default = false}):AddColorPicker("Enemy_Health_Bar_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0}):AddColorPicker("Enemy_Health_Bar_Color2", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})
EnemiesTab:AddToggle("Enemy_Health_Bar_Gradient", {Text = "Health Bar Gradient", Default = false})
EnemiesTab:AddToggle("Enemy_Health_Number", {Text = "Health Number", Default = false})
EnemiesTab:AddSlider("Enemy_Max_HP_Visibility_Cap", {Text = 'Max HP Visibility Cap', Default = 0, Min = 0, Max = 100, Rounding = 0, Compact = false})

EnemiesTab:AddToggle("Enemy_Held_Weapon", {Text = "Held Weapon", Default = false}):AddColorPicker("Enemy_Held_Weapon_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})

EnemiesTab:AddToggle("Enemy_Distance", {Text = "Distance", Default = false}):AddColorPicker("Enemy_Distance_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})

EnemiesTab:AddToggle("Enemy_Name", {Text = "Name", Default = false}):AddColorPicker("Enemy_Name_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})

EnemiesTab:AddToggle("Enemy_Armor", {Text = "Armor", Default = false}):AddColorPicker("Enemy_Armor_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})

EnemiesTab:AddToggle("Enemy_Bomb", {Text = "Bomb", Default = false}):AddColorPicker("Enemy_Bomb_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})

EnemiesTab:AddToggle("Enemy_Cash", {Text = "Cash", Default = false}):AddColorPicker("Enemy_Cash_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})

EnemiesTab:AddToggle("Enemy_Snap_Lines", {Text = "Snap Lines", Default = false}):AddColorPicker("Enemy_Snap_Lines_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})
EnemiesTab:AddSlider("Enemy_Snap_Lines_Transperency", {Text = 'Snap Lines Transperency', Default = 5, Min = 1, Max = 10, Rounding = 0, Compact = false})

EnemiesTab:AddToggle("Enemy_Chamses", {Text = "Chamses", Default = false}):AddColorPicker("Enemy_Chamses_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0}):AddColorPicker("Enemy_Chamses_Color2", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})
EnemiesTab:AddSlider("Enemy_Chamses_Transperency1", {Text = 'Transperency', Default = 5, Min = 1, Max = 10, Rounding = 0, Compact = false})
EnemiesTab:AddSlider("Enemy_Chamses_Transperency2", {Text = 'Transperency', Default = 5, Min = 1, Max = 10, Rounding = 0, Compact = false})

EnemiesTab:AddToggle("Enemy_Skeletons", {Text = "Skeletons", Default = false}):AddColorPicker("Enemy_Skeletons_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})

EnemiesTab:AddToggle("Enemy_Out_of_View_Arrows", {Text = "Out of View Arrows", Default = false}):AddColorPicker("Enemy_Out_of_View_Arrows_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})
EnemiesTab:AddSlider("Enemy_Arrow_Size", {Text = 'Arrow Size', Default = 16, Min = 4, Max = 30, Rounding = 0, Compact = false})
EnemiesTab:AddSlider("Enemy_Arrow_Distance", {Text = 'Arrow Distance', Default = 100, Min = 10, Max = 100, Rounding = 0, Compact = false})
EnemiesTab:AddToggle("Enemy_Dynamic_Arrow_Size", {Text = "Dynamic Arrow Size", Default = false})

    
TeamTab:AddToggle("Team_Boxes", {Text = "Boxes", Default = false}):AddColorPicker("Team_Boxes_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})
TeamTab:AddToggle("Team_Boxes_Filled", {Text = "Boxes Filled", Default = false}):AddColorPicker("Team_Boxes_Filled_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})
TeamTab:AddSlider("Team_Boxes_Filled_Transperency", {Text = 'Transperency', Default = 5, Min = 1, Max = 10, Rounding = 0, Compact = false})

TeamTab:AddToggle("Team_Health_Bar", {Text = "Health Bar", Default = false}):AddColorPicker("Team_Health_Bar_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0}):AddColorPicker("Team_Health_Bar_Color2", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})
TeamTab:AddToggle("Team_Health_Bar_Gradient", {Text = "Health Bar Gradient", Default = false})
TeamTab:AddToggle("Team_Health_Number", {Text = "Health Number", Default = false})
TeamTab:AddSlider("Team_Max_HP_Visibility_Cap", {Text = 'Max HP Visibility Cap', Default = 0, Min = 0, Max = 100, Rounding = 0, Compact = false})

TeamTab:AddToggle("Team_Held_Weapon", {Text = "Held Weapon", Default = false}):AddColorPicker("Team_Held_Weapon_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})

TeamTab:AddToggle("Team_Distance", {Text = "Distance", Default = false}):AddColorPicker("Team_Distance_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})

TeamTab:AddToggle("Team_Name", {Text = "Name", Default = false}):AddColorPicker("Team_Name_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})

TeamTab:AddToggle("Team_Armor", {Text = "Armor", Default = false}):AddColorPicker("Team_Armor_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})

TeamTab:AddToggle("Team_Bomb", {Text = "Bomb", Default = false}):AddColorPicker("Team_Bomb_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})

TeamTab:AddToggle("Team_Cash", {Text = "Cash", Default = false}):AddColorPicker("Team_Cash_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})

TeamTab:AddToggle("Team_Snap_Lines", {Text = "Snap Lines", Default = false}):AddColorPicker("Team_Snap_Lines_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})
TeamTab:AddSlider("Team_Snap_Lines_Transperency", {Text = 'Snap Lines Transperency', Default = 5, Min = 1, Max = 10, Rounding = 0, Compact = false})

TeamTab:AddToggle("Team_Chamses", {Text = "Chamses", Default = false}):AddColorPicker("Team_Chamses_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0}):AddColorPicker("Team_Chamses_Color2", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})
TeamTab:AddSlider("Team_Chamses_Transperency1", {Text = 'Transperency', Default = 5, Min = 1, Max = 10, Rounding = 0, Compact = false})
TeamTab:AddSlider("Team_Chamses_Transperency2", {Text = 'Transperency', Default = 5, Min = 1, Max = 10, Rounding = 0, Compact = false})

TeamTab:AddToggle("Team_Skeletons", {Text = "Skeletons", Default = false}):AddColorPicker("Team_Skeletons_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})

EspSettingsTab:AddSlider("Esp_Settings_TextSize", {Text = 'Text Size', Default = 13, Min = 8, Max = 24, Rounding = 0, Compact = false})
EspSettingsTab:AddDropdown("Esp_Settings_TextCase", {Text = "Text Case", Values = {"Normal", "UPPERCASE", "lowercase"}, Default = 1, Multi = false})
EspSettingsTab:AddDropdown("Esp_Settings_TextFont", {Text = "Text Font", Values = {"Plex", "Monospace", "UI", "System"}, Default = 1, Multi = false})

EspSettingsTab:AddSlider("Esp_Settings_FlagTextSize", {Text = 'Flag Text Size', Default = 13, Min = 8, Max = 24, Rounding = 0, Compact = false})
EspSettingsTab:AddDropdown("Esp_Settings_FlagTextCase", {Text = "Flag Text Case", Values = {"Normal", "UPPERCASE", "lowercase"}, Default = 1, Multi = false})
EspSettingsTab:AddDropdown("Esp_Settings_FlagTextFont", {Text = "Flag Text Font", Values = {"Plex", "Monospace", "UI", "System"}, Default = 1, Multi = false})

   CameraTab:AddToggle("ThirdPerson_Enabled", {Text = "Third Person", Default = false, Callback = function(v)
    if v then
        RunService:BindToRenderStep("ts", 1, function()
            LocalPlayer.CameraMaxZoomDistance = Flags["ThirdPerson_Distance"]
            LocalPlayer.CameraMinZoomDistance = Flags["ThirdPerson_Distance"]
        end)
    else
        RunService:UnbindFromRenderStep("ts")
        for v = 1, 5 do
            _Wait()
            LocalPlayer.CameraMaxZoomDistance = 0;
            LocalPlayer.CameraMinZoomDistance = 0
        end;
    end
end}):AddKeyPicker("ThirdPersonKeybind", {Default = '...', SyncToggleState = false, Mode = "Toggle", Text = "Third Person", NoUI = false})

CameraTab:AddToggle("ThirdPerson_RemoveArms", {Text = "Remove arms on thirdperson"})
CameraTab:AddSlider("ThirdPerson_Distance", {Text = 'Distance', Default = 5, Min = 1, Max = 10, Rounding = 0, Compact = false})
CameraTab:AddSlider("Camera_FieldOfView", {Text = 'Field Of View', Default = 80, Min = 60, Max = 120, Rounding = 0, Compact = false})

CameraTab:AddDivider()

CameraTab:AddToggle("ViewModel", {Text = "ViewModel Changer", Default = false})
CameraTab:AddSlider('ViewModel_X', {Text = 'Angle X', Default = 180, Min = 1, Max = 360, Rounding = 0, Compact = false})
CameraTab:AddSlider('ViewModel_Y', {Text = 'Angle Y', Default = 180, Min = 1, Max = 360, Rounding = 0, Compact = false})
CameraTab:AddSlider('ViewModel_Z', {Text = 'Angle X', Default = 180, Min = 1, Max = 360, Rounding = 0, Compact = false})

CameraTab:AddSlider('ViewModel_X1', {Text = 'CFrame X', Default = 180, Min = 1, Max = 360, Rounding = 0, Compact = false})
CameraTab:AddSlider('ViewModel_Y2', {Text = 'CFrame Y', Default = 180, Min = 1, Max = 360, Rounding = 0, Compact = false})
CameraTab:AddSlider('ViewModel_Z3', {Text = 'CFrame X', Default = 180, Min = 1, Max = 360, Rounding = 0, Compact = false})

CameraTab:AddDivider()

CameraTab:AddToggle("Remove_Scope", {Text = "Remove Scope Border", Default = false, Callback = function(v)
    for i, v in next, (LocalPlayer.PlayerGui.GUI.Crosshairs:GetChildren()) do
        if v.Name:match("Frame") then
            v.BackgroundTransparency = v and 1 or 0
        elseif v.Name:match("Scope") then
            v.ImageTransparency = v and 1 or 0 
        end
    end
end})

CameraTab:AddToggle("Remove_Flash", {Text = "Remove Flash", Default = false, Callback = function(v)
    LocalPlayer.PlayerGui.Blnd.Blind.Visible = not v
end})

CameraTab:AddToggle("Remove_Recoil", {Text = "Remove Camera Recoil", Default = false})

    ConnectKeyPickerToToggle("ThirdPerson_Enabled", "ThirdPersonKeybind")
    


    LightTab:AddToggle("Ambience_Enabled", {Text = "Ambience", Default = false}):AddColorPicker("Ambience_Color", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})

LightTab:AddToggle("Force_Time", {Text = "Force Time", Default = false})
LightTab:AddSlider("Force_TimeValue", {Text = 'Custom time', Default = 0, Min = 0, Max = 24, Rounding = 0, Compact = false})

LightTab:AddToggle("Custom_Saturation", {Text = "Custom Saturation", Default = false}):AddColorPicker("Custom_SaturationColor", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})
LightTab:AddSlider("Custom_SaturationValue", {Text = 'Saturation Density', Default = 0, Min = 0, Max = 100, Rounding = 0, Compact = false})

LightTab:AddToggle("Custom_Bloom", {Text = "Custom Bloom", Default = false})
LightTab:AddSlider("Custom_BloomIntensity", {Text = 'Intensity', Default = 0, Min = 0, Max = 100, Rounding = 0, Compact = false})
LightTab:AddSlider("Custom_BloomSize", {Text = 'Size', Default = 0, Min = 0, Max = 100, Rounding = 0, Compact = false})
LightTab:AddSlider("Custom_BloomThreshold", {Text = 'Threshold', Default = 0, Min = 0, Max = 100, Rounding = 0, Compact = false})

LightTab:AddToggle("Custom_Atmosphere", {Text = "Custom Atmosphere", Default = false}):AddColorPicker("Atmosphere_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0}):AddColorPicker("Atmosphere_Color2", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})
LightTab:AddSlider("Custom_AtmosphereDensity", {Text = 'Density', Default = 0, Min = 0, Max = 100, Rounding = 0, Compact = false})
LightTab:AddSlider("Custom_AtmosphereGlare", {Text = 'Glare', Default = 0, Min = 0, Max = 100, Rounding = 0, Compact = false})
LightTab:AddSlider("Custom_AtmosphereHaze", {Text = 'Haze', Default = 0, Min = 0, Max = 100, Rounding = 0, Compact = false})

ParticlesTab:AddToggle("Particles_Enabled", {Text = "Enabled", Default = false}):AddColorPicker("Particles_Color", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})
ParticlesTab:AddDropdown("Particles_Texture", {Text = "Texture", Values = {"Random", "Snow", "Rain"}, Default = 1, Multi = false})
ParticlesTab:AddSlider("Particles_LifeTime", {Text = 'Life Time', Default = 1, Min = 1, Max = 10, Rounding = 0, Compact = false})
ParticlesTab:AddSlider("Particles_Speed", {Text = 'Speed', Default = 25, Min = 1, Max = 100, Rounding = 0, Compact = false})

    
    BulletsTab:AddToggle("BulletTracerEnabled", { Text = "Bullet Tracer" }):AddColorPicker("BulletTracerColor", {Default = _Color3FromRGB(255,0,0), Title = 'Tracer Color', Transparency = 0.25})
BulletsTab:AddToggle("BulletTracerEnemyEnabled", { Text = "Enemy Bullet Tracer" }):AddColorPicker("BulletTracerColor1", {Default = _Color3FromRGB(255,0,0), Title = 'Tracer Color', Transparency = 0.25})
BulletsTab:AddToggle("BulletTracerSecondBeam", { Text = "Second Beam" }):AddColorPicker("BulletTracerSecondBeamColor", {Default = _Color3FromRGB(255,255,255), Title = 'Second Tracer Color', Transparency = 0.5})
BulletsTab:AddSlider("BulletTracerLifetime", {Text = "Life Time", Default = 2, Min = 0, Max = 10, Rounding = 1, Compact = false})
BulletsTab:AddSlider("BulletTracerFadetime", {Text = "Fade Time", Default = 2, Min = 0, Max = 10, Rounding = 1, Compact = false})
BulletsTab:AddSlider("BulletTracerWidth", {Text = "Width", Default = 2, Min = 0.1, Max = 50, Rounding = 1, Compact = false})
BulletsTab:AddSlider("BulletTracerBrightness", {Text = "Brightness", Min = 1, Max = 10, Default = 1, Rounding = 0, Compact = false})
BulletsTab:AddSlider("BulletTracerLightEmission", {Text = "Light Emission", Min = 0, Max = 1, Default = 1, Rounding = 1, Compact = false})
BulletsTab:AddSlider("BulletTracerLightInfluence", {Text = "Light Influence", Min = 0, Max = 1, Default = 0, Rounding = 1, Compact = false})
BulletsTab:AddSlider("BulletTracerTextureSpeed", {Text = "Texture Speed", Min = 1, Max = 5, Default = 1, Rounding = 1, Compact = false})
BulletsTab:AddSlider("BulletTracerTextureLength", {Text = "Texture Length", Min = 1, Max = 10, Default = 1, Rounding = 0, Compact = false})
BulletsTab:AddToggle("BulletTracerFaceCamera", {Text = "Face Camera", Default = true})
BulletsTab:AddDropdown("BulletTracerTexture", {Text = "Texture", Values = (function() local tbl = {} for i,v in next,Cache.TracerTextures do _TableInsert(tbl,i) end return tbl end)(), Default = 12, Multi = false})
BulletsTab:AddDivider()
BulletsTab:AddToggle("BulletImpactEnabled", {Text = "Bullet Impact"}):AddColorPicker("BulletImpactColor", {Default = _Color3FromRGB(255,255,255), Title = "Impact Color", Transparency = 0.15}):AddColorPicker("BulletImpactColor2", {Default = _Color3FromRGB(255,255,255), Title = "Impact Color", Transparency = 0.15})
BulletsTab:AddSlider("BulletImpactSize", {Text = "Width", Default = 2, Min = 0.1, Max = 10, Rounding = 1, Compact = false})
BulletsTab:AddSlider("BulletImpactLifetime", {Text = "Lifetime", Default = 2, Min = 0, Max = 10, Rounding = 1, Compact = false})
BulletsTab:AddDropdown("BulletImpactMaterial", {Text = "Material", Values = Cache.MaterialNames, Default = 1, Multi = false})

CrosshairTab:AddToggle("Custom_Crosshair", {Text = "Custom Crosshair", Default = false}):AddColorPicker("Custom_Crosshair_Color1", {Default = _Color3FromRGB(255,255,255), Title = 'Color', Transparency = 0})
CrosshairTab:AddToggle("Impulse_Crosshair", {Text = "Impulse Crosshair", Default = false})
CrosshairTab:AddToggle("Crosshair_Outlines", {Text = "Crosshair Outlines", Default = false})
CrosshairTab:AddSlider("Cycle_Speed", {Text = "Cycle Speed", Default = 2, Min = 0, Max = 10, Rounding = 1, Compact = false})
CrosshairTab:AddSlider("Minimum_Speed", {Text = "Minimum Speed", Default = 10, Min = 0, Max = 100, Rounding = 0, Compact = false})
CrosshairTab:AddSlider("Maximum_Speed", {Text = "Maximum Speed", Default = 10, Min = 0, Max = 100, Rounding = 0, Compact = false})
CrosshairTab:AddSlider("Minimum_Length", {Text = "Minimum Length", Default = 10, Min = 0, Max = 100, Rounding = 0, Compact = false})
CrosshairTab:AddSlider("Maximum_Length", {Text = "Maximum Length", Default = 10, Min = 0, Max = 100, Rounding = 0, Compact = false})
CrosshairTab:AddSlider("Crosshair_Width", {Text = "Crosshair Width", Default = 10, Min = 0, Max = 100, Rounding = 0, Compact = false})
CrosshairTab:AddSlider("Crosshair_Length", {Text = "Crosshair Length", Default = 10, Min = 0, Max = 100, Rounding = 0, Compact = false})
CrosshairTab:AddSlider("Crosshair_Width_Gap", {Text = "Crosshair Width Gap", Default = 5, Min = 0, Max = 100, Rounding = 0, Compact = false})
CrosshairTab:AddSlider("Crosshair_Length_Gap", {Text = "Crosshair Length Gap", Default = 5, Min = 0, Max = 100, Rounding = 0, Compact = false})
CrosshairTab:AddSlider("Crosshair_Thickness", {Text = "Crosshair Thickness", Default = 2, Min = 1, Max = 100, Rounding = 0, Compact = false})
CrosshairTab:AddSlider("Crosshair_Rotation", {Text = "Crosshair Rotation", Default = 0, Min = 0, Max = 360, Rounding = 0, Compact = false})
CrosshairTab:AddSlider("Crosshair_Rotation_Speed", {Text = "Crosshair Rotation Speed", Default = 0, Min = -360, Max = 360, Rounding = 0, Compact = false})

	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
    local WatermarkGroup = SettingsTab:AddCenterGroupbox("Watermark")
    WatermarkGroup:AddToggle("Watermark", { Text = "Watermark", Callback = function (v) 
        Library:SetWatermarkVisibility(v)
    end})
    local MenuGroup = SettingsTab:AddCenterGroupbox("Menu")
    MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", { Default = "End", NoUI = true, Text = "Menu keybind" })
    MenuGroup:AddToggle("UIGlow", { Text = "UI Glow", Callback = function (v)
        Library:SetGlowVis(v)
    end});
    local KeybindListGroup = SettingsTab:AddCenterGroupbox("Keybind List")
    KeybindListGroup:AddToggle("KeyBindList", { Text = "Key Bind List", Callback = function (v)
        Library:SetKeyListVisibility(v)
    end})
    KeybindListGroup:AddDropdown("KeyBindListMode", {Text = "Mode",Values = {"Highlight", "State"},Default = 2,Multi = false, Callback = function(v)
        Library.KeybindListMode = v == "Highlight" and 1 or 2
    end})
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
    Library:SetWatermarkVisibility(false)
    Library:SetKeyListVisibility(false)
    Library:SetSpecListVisibility(false)

    Toggles["Watermark"]:SetValue(true)
    Toggles["UIGlow"]:SetValue(true)
    -- Options["KeyBindListMode"]:SetValue("State") 

    

    Library.ToggleKeybind = Options.MenuKeybind
    ThemeManager:SetFolder("Raven")
    SaveManager:SetFolder("Raven/CounterBlox")
    ThemeManager:SetLibrary(Library)
    SaveManager:SetLibrary(Library) 
    SaveManager:IgnoreThemeSettings()
    SaveManager:BuildConfigSection(SettingsTab)
    ThemeManager:ApplyToTab(SettingsTab)

    getgenv().PreviewPlayer = EspPreviewManager:Init(Window, VisualsTab)
end
do --Funcs
    do -- Player Spawned Signal
        local function apply(plr)
            plr.CharacterAdded:Connect(function(character)
                repeat
                    _TaskWait()
                until plr.Status.Alive.Value
                playerSpawned:Fire(plr, _Tick())
                local hum = character:WaitForChild("Humanoid")
                local sig; sig = hum.HealthChanged:Connect(function(newHealth)
                    if newHealth == newHealth and newHealth <= 0 then
                        sig:Disconnect()
                        sig = nil
                        playerDied:Fire(plr, _Tick())
                    end
                end)
            end)
        end

        for i,v in next, _GetPlayers(Players) do
            apply(v)
        end

        Players.PlayerAdded:Connect(apply)
    end

	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
    do -- PlayerModule
        PlayerModule.storage = {}


        local function refreshEnemyType(data)
            data.enemy = replicatedStorage.gametype.Value == "deathmatch" or (data.player ~= LocalPlayer and data.player.Team ~= LocalPlayer.Team)
        end
        _GetPropertyChangedSignal(LocalPlayer, "Team"):Connect(function()
            for player,data in next, PlayerModule.storage do
                refreshEnemyType(data)
            end
        end)

        function PlayerModule.add(player)
            local data = {}
            data.player = player
            data.lastVelocity = _Vector3New()
            data.velocity = _Vector3New()
            data.character = nil
            data.god = false
            data.currentPosition = _Vector3New()
            data.lastPosition = _Vector3New()
            data.lastcameracf = _CFrameNew()
            data.camcf = _CFrameNew()
            data.updates = {}
            data.enemy = replicatedStorage.gametype.Value == "deathmatch" or (player ~= LocalPlayer and player.Team ~= LocalPlayer.Team)

            _GetPropertyChangedSignal(player, "Team"):Connect(function()
                refreshEnemyType(data)
            end)
            
            data.step = RunService.Stepped:Connect(function(delta)
                local char = player.Character
                data.character = char
                data.humanoid = char and _FindFirstChild(char, "Humanoid")
                data.head = char and _FindFirstChild(char, "Head")
                data.rootpart = char and _FindFirstChild(char, "HumanoidRootPart")
                data.god = data.humanoid and data.humanoid.Health ~= data.humanoid.Health
                data.alive = (char and data.humanoid and data.humanoid.Parent and data.humanoid.Health > 0 and data.humanoid.Health == data.humanoid.Health and data.rootpart and player.Status.Alive.Value)
                
                if data.god or data.alive then
                    data.protected = char and _FindFirstChildOfClass(char, "ForceField") ~= nil
                    if data.currentPosition then
                        data.lastPosition = data.currentPosition
                    end
                    data.currentPosition = data.rootpart and data.rootpart.Position
                    if data.camcf then
                        data.lastcameracf = data.camcf
                    end
                    data.camcf = _FindFirstChild(player, "CameraCF") and _FindFirstChild(player, "CameraCF").Value or _CFrameNew()
                
                    _TableInsert(data.updates, 1, {position = data.currentPosition, velocity = data.velocity, time = _Tick()})

                    local samples = 5
                    local totalDelta = 0
                    local totalDistance = _Vector3New()
                    for i = 2, _MathMin(samples, #data.updates) do
                        local now = data.updates[i]
                        local prev = data.updates[i - 1]

                        totalDelta = totalDelta + (now.time - prev.time)
                        totalDistance = totalDistance + (now.position - prev.position)
                    end

                    data.velocity = totalDistance / totalDelta
                else
                    table.clear(data.updates)
                    data.protected = false
                    data.character = nil
                    data.alive = false
                    data.lastVelocity = _Vector3New()
                    data.velocity = _Vector3New()
                    data.currentPosition = _Vector3New()
                    data.lastPosition = _Vector3New()
                    data.humanoid = nil
                    data.head = nil
                    data.rootpart = nil
                end
            end)
            PlayerModule.storage[player] = data
        end

        function PlayerModule.remove(player)
            if PlayerModule.storage[player] then
                PlayerModule.storage[player].step:Disconnect()
                table.clear(PlayerModule.storage[player])
                PlayerModule.storage[player] = nil
            end
        end

        function PlayerModule:unload()
            for player,data in next, PlayerModule.storage do
                PlayerModule.remove(player)
            end
            table.clear(PlayerModule)
            PlayerModule = {}
        end

        for i,v in next, _GetPlayers(Players) do
            if v ~= LocalPlayer then
                PlayerModule.add(v)
            end
        end
        Players.PlayerAdded:Connect(PlayerModule.add)
        Players.PlayerRemoving:Connect(PlayerModule.remove)
    end
    do  -- Calculations
        function Calculations:truncateNumber(number, decimalPlaces)
            local d = 10^decimalPlaces
            return _MathFloor(number*d)/d
        end

        function Calculations:map(x, start0, stop0, start1, stop1)
            return (x - start0)/(stop0 - start0)*(stop1 - start1) + start1
        end

        function Calculations:safeUnit(vec, epsilon)
            local magnitude = vec.magnitude
            if magnitude > (epsilon or 1e-10) then
                return vec/magnitude
            end
            return typeof(vec) == "Vector2" and _Vector2New() or _Vector3New()
        end

        --Vector3s
        function Calculations:angleBetweenVector3(vec1, vec2)
            local angle = _MathAtan2(vec1:Cross(vec2).magnitude, vec1:Dot(vec2))
            if angle < 0 then
                angle = tau - angle
            end
            return angle
        end

        function Calculations:pitchYawToLookVec(pitch, yaw)
            local cx = _MathCos(pitch)
            return _Vector3New(-cx*_MathSin(yaw), _MathSin(pitch), -cx*_MathCos(yaw))
        end

        function Calculations:lookVecToPitchYaw(lookVec)
            local x, y, z = lookVec.x, lookVec.y, lookVec.z
            return _MathAtan2(y, (x*x + z*z)^0.5), _MathAtan2(-x, -z)
        end

        --Vector2s
        function Calculations:angleBetweenVector2(vec1, vec2)
            local ang = math.acos(Calculations:safeUnit(vec1):Dot(Calculations:safeUnit(vec2)))
            if ang < 0 then
                ang = tau - ang
            end
            return ang
        end

        function Calculations:rotationMatrix(vec, angle)
            local mag = vec.Magnitude
            vec = Calculations:safeUnit(vec)
            local co, si = _MathCos(angle), _MathSin(angle)
            local x, y = vec.x, vec.y
            return Calculations:safeUnit(_Vector2New(x*co - y*si, x*si + y*co))*mag
        end

        function Calculations:normalizeAngle(angle)
            return ((angle + pi) % (2*pi)) - pi
        end

        do 
            local fov
            local viewportX, viewportY
            local frustumYScale
            local frustumXScale
            local rScaleX, rScaleY

            local function refresh()
                viewportSize = camera.ViewportSize
                fov = camera.FieldOfView * math.pi/180
                viewportX, viewportY = viewportSize.x, viewportSize.y
                frustumYScale = math.tan(fov/2)
                frustumXScale = viewportX/viewportY * frustumYScale
                rScaleX = (1 + frustumXScale*frustumXScale)^0.5
                rScaleY = (1 + frustumYScale*frustumYScale)^0.5
            end
            RunService.Stepped:Connect(refresh)

            function Calculations:worldToViewportPoint(worldPosition, clampEdge, clampOffset)
                local projectedPosition = _CFramePointToObjectSpace(camera.CFrame, worldPosition)
                local pX, pY, pZ = projectedPosition.x, projectedPosition.y, -projectedPosition.z
                local screenX = viewportX * (0.5 + pX/(2*pZ*frustumXScale))
                local screenY = viewportY * (0.5 - pY/(2*pZ*frustumYScale))
                local onScreen = pZ > 0 and screenX >= 0 and screenX <= viewportX and screenY >= 0 and screenY <= viewportY
                if not clampEdge then
                    return _Vector3New(screenX, screenY, pZ), onScreen
                end
                if onScreen then
                    return _Vector3New(screenX, screenY, pZ), true
                end
                local widthEdge, heightEdge = pX < 0 and clampOffset or viewportX - clampOffset, -pY < 0 and clampOffset or viewportY - clampOffset
                local m = 0.5*(pY*viewportX + pX*viewportY)
                local newY = (m - pY*widthEdge)/pX
                if newY > clampOffset and newY < (viewportY - clampOffset) then
                    return _Vector3New(widthEdge, newY, pZ), false
                else
                    local newX = (m - pX*heightEdge)/pY
                    return _Vector3New(newX, heightEdge, pZ), false
                end
            end
            function Calculations:spherePoint(worldPosition, radius)
                local projectedPosition = _CFramePointToObjectSpace(camera.CFrame, worldPosition)
                local pX, pY, pZ = projectedPosition.x, projectedPosition.y, -projectedPosition.z
                local rX = rScaleX*radius
                local rY = rScaleY*radius
                return -pZ*frustumXScale < pX+rX and pX-rX < pZ*frustumXScale and -pZ*frustumYScale < pY+rY and pY-rY < pZ*frustumYScale and pZ > -radius
            end
        end
    end
    do --Utility
        Utility.chammedobjects = {
            ["Clothing"] = {},
            ["Arms"] = {},
            ["Weapon Objects"] = {},
            ["Colored Arms"] = {},
            ["Colored Weapons"] = {},
            ["Original"] = {}
        }
        Utility.materials = {
            ["Ghost"] = _Materials.ForceField,
            ["Flat"] = _Materials.Neon,
            ["Custom"] = _Materials.SmoothPlastic,
            ["Reflective"] = _Materials.Glass, 
            ["Metallic"] = _Materials.Glass
        }
        local IsPlayerAlive = function(Player)
            if Player and _FindFirstChild(Player, "Humanoid") and _FindFirstChild(Player, "Humanoid").Health > 0 then
                return true
            else
                return false
            end
        end
        Utility.IsPlayerAlive = IsPlayerAlive
        function Utility.CryptPosition(Pos) 
            local X = (((Pos.X - 74312) * 4) + 1325) * 13
            local Y = ((Pos.Y + 3183421) * 4) - 4201428
            local Z = ((Pos.Z * 41) - 581357) * 2
            return _Vector3New(X,Y,Z)
        end
        function Utility.IsHitBox(Name)
            if Cache.HitModifiers[Name] ~= nil then
                return true
            end
            return false
        end
		    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
        function Utility.UpdAmmo()
            local equipped = Cache.Client.equipped
            local ammo = 0
            local primm = Cache.Client.vars.ammocount
            local secondary = Cache.Client.vars.ammocount2
            if equipped == "primary" and primm >= 1 then
                ammo = primm - 1;
                Cache.Client.vars.ammocount = ammo
            elseif equipped == "secondary" and secondary >= 1 then
                ammo = secondary - 1;
                Cache.Client.vars.ammocount2 = ammo;
            end
            if ammo == 0 and _FindFirstChild(Cache.Client.fgun, "Melee") == nil then
                Cache.Client.autoreload()
            end
            Cache.Client.countammo()        
        end
        function Utility.FakeShoot(Params)
            local client = Cache and Cache.Client
            if not client then return end
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
            local anim1 = debug.getupvalue(client.reloadwep, 9)
            local anim2 = debug.getupvalue(client.usethatgun, 5)
            local fgun = client.fgun
            local gun = _FindFirstChild(LocalPlayer.Character, "Gun")
            local arms = _FindFirstChild(camera, "Arms")

            if anim1 and Cache.Client.fgun ~= "none" then
                anim1:Play()
                replicatedStorage.Events.ReplicateAnimation:FireServer("Fire")

                if gun then
                    local s = _FindFirstChild(gun, "SShoot") or _FindFirstChild(gun, "Shoot") or _FindFirstChild(gun, "Shoot1")
                    if s then
                        local snd = _Instancenew("Sound", camera)
                        snd.SoundId = s.Value
                        snd.PlayOnRemove = true
                        _Destroy(snd)

                        local flash = _FindFirstChild(gun, "Flash")
                        local armsFlash = arms and _FindFirstChild(arms, "Flash")
                        if flash and armsFlash then
                            client.createparticle("muzzle", armsFlash)
                            Events.RemoteEvent:FireServer({ "createparticle", "muzzle", flash })

                            if Params then
                                for _, v in next, Params do
                                    client.hitobject(v["Hit"], v["Enter"], v["Normal"], client.fgun, false)
                                    client.hitobject(v["Hit"], v["Exit"], -v["Normal"], client.fgun, false)
                                end
                            end
                        end
                    end
                end
            end

            if anim2 then anim2:Play() end
            Utility.UpdAmmo()
            _CoroutineWrap(function()
                local updateads = client.updateads
                if not updateads or _Typeof(fgun) ~= "Instance" or not _IsA(fgun, "Folder") then return end

                local ads = _Select(2, _Pcall(debug.getupvalue, updateads, 1))
                local auto = _FindFirstChild(fgun, "Auto")
                local unzoom = false

                if auto and _IsA(auto, "BoolValue") and not auto.Value and ads then
                    _Pcall(debug.setupvalue, updateads, 1, false)
                    _Pcall(updateads)
                    unzoom = true
                end

                local rate = 0.1
                local fr = _FindFirstChild(fgun, "FireRate")
                if fr and _IsA(fr, "NumberValue") then rate = fr.Value end

                local start = _Tick()
                while true do
                    _TaskWait(0.016666666666666666)
                    if fgun ~= client.fgun then
                        return 
                    elseif not (_Tick() - start < rate) then
                        break
                    end
                end
                if unzoom then
                    _Pcall(debug.setupvalue, updateads, 1, true)
                    client.doublezoom = client.doublezoom
                    _Pcall(updateads)
                end
            end)()
        end
        function Utility.DecryptPosition(pos)
        return _Vector3New(((pos.X / 13 - 1325) / 4) + 74312, ((pos.Y + 4201432) / 4) - 3183421, (pos.Z / 2 + 581357) / 41)
        end
        function Utility.CreateTracer(To,From,Color,Transparency,Width,Lifetime,Texture,TextureLength,TextureSpeed,FaceCamera,LightEmission,LightInfluence,Brightness,Beam_2,Color2,Transparency2)
            local part1 = _Instancenew("Part", workspace.Ray_Ignore)
            local part2 = _Instancenew("Part", workspace.Ray_Ignore)
            local beam = _Instancenew("Beam", part1)
            local beam2 = _Instancenew("Beam", part1)
            local attachment1 = _Instancenew("Attachment", part1)
            local attachment2 = _Instancenew("Attachment", part2)
        
            part1.Transparency = 1
            part1.Position = To
            part1.CanCollide = false
            part1.Anchored = true
        
            part2.Position = From
            part2.Transparency = 1
            part2.CanCollide = false
            part2.Anchored = true
        
            beam.Color = _ColorSequenceNew({_ColorSequenceKeypointNew(0, Color), _ColorSequenceKeypointNew(1, Color)})
            beam.Transparency = _NumberSequenceNew({_NumberSequenceKeypointNew(0, Transparency), _NumberSequenceKeypointNew(1, Transparency)})

            beam.Width0 = 0.0275*Width
            beam.Width1 = 0.0275*Width
            beam.FaceCamera = FaceCamera
            beam.Texture = Cache.TracerTextures[Texture]
            beam.TextureLength = TextureLength
            beam.TextureSpeed = TextureSpeed
            beam.LightEmission = LightEmission
            beam.LightInfluence = LightInfluence
            beam.Brightness = Brightness
            beam.Attachment0 = attachment1
            beam.Attachment1 = attachment2
        
            if Beam_2 then
                beam2.Color = _ColorSequenceNew({_ColorSequenceKeypointNew(0, Color2), _ColorSequenceKeypointNew(1, Color2)})
                beam2.Transparency = _NumberSequenceNew({_NumberSequenceKeypointNew(0, Transparency2), _NumberSequenceKeypointNew(1, Transparency2)})
                beam2.Width0 = 0.0125*Width
                beam2.Width1 = 0.0125*Width
                beam2.Brightness = Brightness
                beam2.FaceCamera = FaceCamera
                beam2.LightEmission = LightEmission
                beam2.LightInfluence = LightInfluence
                beam2.TextureLength = TextureLength
                beam2.TextureSpeed = TextureSpeed
                beam2.Texture = Cache.TracerTextures[Texture]
                beam2.Attachment0 = attachment1
                beam2.Attachment1 = attachment2
            else
                _Destroy(beam2)
            end
                
            _TaskSpawn(function()
                _TaskWait(Lifetime)
                local duration = Flags["BulletTracerFadetime"]
                local originalWidth0beam1 = beam.Width0
                local originalWidth1beam1 = beam.Width1
                local originalWidth0beam2 = beam2 and beam2.Width0 or 0
                local originalWidth1beam2 = beam2 and beam2.Width1 or 0

                local passed = 0
                while passed < duration do
                    local ratio = 1 - (passed / duration)
                    beam.Width0 = originalWidth0beam1 * ratio
                    beam.Width1 = originalWidth1beam1 * ratio
                    if beam2 then
                        beam2.Width0 = originalWidth0beam2 * ratio
                        beam2.Width1 = originalWidth1beam2 * ratio
                    end
                    passed = passed + _TaskWait()
                end

                _Destroy(part1)
                _Destroy(part2)
            end)
        end
        function Utility.saveViewmodel()
            Utility.chammedobjects["Weapon Objects"] = {} 
            Utility.chammedobjects["Arms"] = {}
            Utility.chammedobjects["Clothing"] = {}
            Utility.chammedobjects["Original"] = {}
            if LocalPlayer.Status.Alive.Value == false then
                return
            end
            if camera:FindFirstChild("Arms") then
                for i, v in next, (camera.Arms:GetChildren()) do
                    if v:IsA("Model") and v:FindFirstChild("Right Arm") and v:FindFirstChild("Left Arm") then
                        table.insert(Utility.chammedobjects["Arms"], v["Right Arm"])
                        table.insert(Utility.chammedobjects["Arms"], v["Left Arm"])

                        table.insert(Utility.chammedobjects["Clothing"], v["Right Arm"]:FindFirstChild("RGlove") or v["Right Arm"]:FindFirstChild("Glove"))
                        table.insert(Utility.chammedobjects["Clothing"], v["Left Arm"]:FindFirstChild("LGlove") or v["Left Arm"]:FindFirstChild("Glove"))

                        table.insert(Utility.chammedobjects["Clothing"], v["Right Arm"]:FindFirstChild("Sleeve"))
                        table.insert(Utility.chammedobjects["Clothing"], v["Left Arm"]:FindFirstChild("Sleeve"))
                    elseif (v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("SpecialMesh") or v:IsA("SurfaceAppearance")) and v.Transparency == 0 or v.Name == "HumanoidRootPart" then
                        if v.Name == "HumanoidRootPart" then 
                            v.Transparency = 1
                        else
                            table.insert(Utility.chammedobjects["Weapon Objects"], v)
                            if v:FindFirstChild("SurfaceAppearance") then
                                table.insert(Utility.chammedobjects["Weapon Objects"], v:FindFirstChild("SurfaceAppearance"))
                            end
                        end
                    end
                end
            else
                return
            end
            for idx, objects in next, ({Utility.chammedobjects["Arms"], Utility.chammedobjects["Clothing"], Utility.chammedobjects["Weapon Objects"]}) do
                for i, v in next, (objects) do 
                    if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("SpecialMesh") then
                        local property = { 
                            Color = v.Color,
                            Material = v.Material,
                            Reflectance = v.Reflectance,
                            Transparency = v.Transparency
                        }
                        if v:IsA("MeshPart") then
                            property.TextureID = v.TextureID
                        elseif v:IsA("SpecialMesh") then
                            property.TextureId = v.TextureId
                        end
                        Utility.chammedobjects["Original"][v] = property
                        if v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("SpecialMesh") then
                            local HiddenMesh = v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("SpecialMesh")
                            if HiddenMesh:IsA("MeshPart") then
                                Utility.chammedobjects["Original"][HiddenMesh] = {
                                    TextureID = HiddenMesh.TextureID
                                }
                            else
                                Utility.chammedobjects["Original"][HiddenMesh] = {
                                    TextureId = HiddenMesh.TextureId,
                                    VertexColor = HiddenMesh.VertexColor
                                }
                            end
                        end
                    elseif v:IsA("SurfaceAppearance") then
                        Utility.chammedobjects["Original"][v] = {
                            Parent = v.Parent
                        }
                    end
                end
            end
        end

        function Utility.updateWeaponChams()
            for i, v in next, (Utility.chammedobjects["Colored Weapons"]) do
                local originalproperties = Utility.chammedobjects["Original"][v]
                if originalproperties then
                    for i2, v2 in next, (originalproperties) do
                        v[i2] = v2
                    end
                end
            end
            Utility.chammedobjects["Colored Weapons"] = {}

            if Flags["Model_Changer_Weapon"] then
                local Animation = ""
                local thing = Utility.chammedobjects["Colored Weapons"]
                if Flags["Model_Changer_Material"] == "Ghost" then
                    Animation = forcefieldAnimations[Flags["Model_Changer_Texture"]]
                end
                for i, v in next, (Utility.chammedobjects["Weapon Objects"]) do
                    if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("SpecialMesh") then
                        thing[1 + #thing] = v
                        v.Transparency = Flags["Model_Changer_Transperency"]/100
                        if v.Name ~= "Dot" then
                            v.Color = Flags["Model_Changer_Color"]
                            v.Material = Utility.materials[Flags["Model_Changer_Material"]]
                            v.Reflectance = Flags["Model_Changer_Reflectance"]/100
                            if v:IsA("MeshPart") then
                                v.TextureID = Animation
                            end
                            if v:IsA("SpecialMesh") then
                                v.TextureId = Animation
                            end
                            local HiddenMesh = v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("SpecialMesh")
                            if HiddenMesh ~= nil then
                                if HiddenMesh:IsA("MeshPart") then
                                    HiddenMesh.TextureID = Animation
                                    HiddenMesh.Color = v.Color
                                    HiddenMesh.Material = v.Material
                                    HiddenMesh.Reflectance = v.Reflectance
                                else
                                    HiddenMesh.TextureId = Animation
                                    HiddenMesh.VertexColor = _Vector3New(v.Color.r, v.Color.g, v.Color.b)
                                end

                                thing[1 + #thing] = HiddenMesh
                            end
                        end
                    elseif v:IsA("SurfaceAppearance") then
                        thing[1 + #thing] = v
                        v.Parent = nil
                    end
                end
            end
        end

        function Utility.updateArmChams() 
            for i, v in next, (Utility.chammedobjects["Colored Arms"]) do
                local originalproperties = Utility.chammedobjects["Original"][v]
                if originalproperties then
                    for i2, v2 in next, (originalproperties) do
                        v[i2] = v2
                    end
                end
            end
            Utility.chammedobjects["Colored Arms"] = {}
            if Flags["Arms_Changer"] then
                local thing = Utility.chammedobjects["Colored Arms"] 
                local Animation = ""
                if Flags["Arms_Changer_Material"] == "Ghost" then
                    Animation = forcefieldAnimations[Flags["Arms_Changer_Texture"]]
                end
                for idx, objects in next, ({Utility.chammedobjects["Arms"], Utility.chammedobjects["Clothing"]}) do
                    for i, v in next, (objects) do
                        if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("SpecialMesh") then
                            v.Color = Flags["Arms_Changer_Color".. idx]
                            v.Transparency = Flags["Arms_Transparency".. idx]/100
                            v.Material = Utility.materials[Flags["Arms_Changer_Material"]]
                            thing[1 + #thing] = v
                            v.Reflectance = idx == 1 and Flags["Arms_Reflective"]/100 or Flags["Arms_Reflective_Sleeve"]/100
                            if  v:IsA("SpecialMesh") then
                                v.VertexColor = _Vector3New(v.Color.r, v.Color.g, v.Color.b)
                                if v:IsA("MeshPart") then
                                    v.TextureID = Animation
                                else
                                    v.TextureId = Animation
                                end
                            end
                            if v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("SpecialMesh") then
                                local HiddenMesh = v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("SpecialMesh")

                                thing[1 + #thing] = HiddenMesh
                                if HiddenMesh:IsA("MeshPart") then
                                    HiddenMesh.TextureID = Animation
                                else
                                    HiddenMesh.VertexColor = _Vector3New(v.Color.r, v.Color.g, v.Color.b)
                                    HiddenMesh.TextureId = Animation
                                end
                            end
                        end
                    end
                end
            end
        end

        local haltLocalChams = false

        camera.ChildAdded:Connect(function()
            haltLocalChams = true
            _TaskWait(0.1)
            Utility.saveViewmodel()
            haltLocalChams = false
            
        end)
        local everyOther = 0
        RunService.Stepped:Connect(function()
            if haltLocalChams == true then
                return
            end
            everyOther = everyOther + 1
            if everyOther > 4 then
                Utility.updateArmChams()
                everyOther = 0
            end
            Utility.updateWeaponChams()
        end)
        function Utility.CreateImpact(To,Rotation,Color,Transparency,Material,Size,Lifetime)
            local impact = _Instancenew("Part", workspace.Ray_Ignore)
            impact.Transparency = Transparency
            impact.Color = Color
            impact.Size = _Vector3New(Size/2,Size/2,Size/2)
            impact.Position = To
            impact.Rotation = Rotation.Rotation or Rotation or _Vector3New()
            impact.CanCollide = false
            impact.Anchored = true
            impact.Material = Enum.Material[Material]
            _TaskSpawn(function()
                _TaskWait(Lifetime)
                for i=Transparency, 1.05, 0.05 do _TaskWait()
                    impact.Transparency = i
                end     
                _Destroy(impact)
            end)
        end       
    end
    do --RageBot
        local LastShoot = _Tick()

        local CalculateDamageModifier = function(from, to, weapon, ignored)
            local Ignore = table.clone(ignored)
            local maxPen = weapon.Penetration.Value * 0.01
            local maxWalls = Flags.RageBot_AutoWall and Flags.RageBot_MaxWalls or 0
            local penModded = Flags.RageBot_PenModded
            local penPassed, walls = 0, 0
            local realDir = to - from
            local dist = realDir.Magnitude
            local range = weapon.Range.Value * 0.0625
            local dir = realDir.Unit * _MathMin(dist, range)
            local unit = realDir.Unit



            local enterParam = _RaycastParamsNew()
            enterParam.FilterType = Enum.RaycastFilterType.Blacklist
            enterParam.IgnoreWater = true
            enterParam.FilterDescendantsInstances = Ignore

            local exitParam = _RaycastParamsNew()
            exitParam.FilterType = Enum.RaycastFilterType.Whitelist

            local matMod = {
                [Enum.Material.DiamondPlate] = 3,
                [Enum.Material.CorrodedMetal] = 2, [Enum.Material.Metal] = 2,
                [Enum.Material.Concrete] = 2, [Enum.Material.Brick] = 2,
                [Enum.Material.Wood] = 0.1, [Enum.Material.WoodPlanks] = 0.1
            }

            while true do
                local hit = workspaceRaycast(workspace, from, dir, enterParam)
                if not hit then return true, (1 - penPassed / maxPen), walls > 0 end

                local wall, pos, mat = hit.Instance, hit.Position, hit.Instance.Material
                Ignore[#Ignore + 1] = wall
                if wall.Name == "nowallbang" then return end

                local mod = matMod[mat] or 1
                if wall.Name == "Grate" or _FindFirstChild(wall.Parent, "Humanoid") then
                    mod = 0.1
                    local hum = _FindFirstChild(wall.Parent, "Humanoid")
                    if hum then Ignore[#Ignore + 1] = wall.Parent end
                end
                if wall.Transparency == 1 or not wall.CanCollide or wall.Name == "Glass" or wall.Name == "Cardboard" or wall.Parent.Name == "Hitboxes" then
                    mod = 0
                end
                local partMod = _FindFirstChild(wall, "PartModifier")
                if partMod then mod = _tonumber(partMod.Value) end
                if mod >= 100 then return end

                if mod > 0 then
                    mod /= penModded
                    local maxDepth = (maxPen - penPassed) / mod
                    local depth = _MathMin(maxDepth, (pos - to).Magnitude)
                    if depth <= 0 then return end

                    exitParam.FilterDescendantsInstances = { wall }
                    local exit = workspaceRaycast(workspace, pos + unit * depth, -unit * depth, exitParam)
                    if not exit then return end

                    penPassed += (depth - exit.Distance) * mod
                    walls += 1
                end
                if penPassed >= maxPen or walls >= maxWalls then break end
                enterParam.FilterDescendantsInstances = Ignore
            end
        end
        Utility.AutoWall = CalculateDamageModifier
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
        local prepWaitUntil2 = 0
        RunService.RenderStepped:Connect(function()
            if not Flags["KillAll_Enabled"] then return end

            local char = LocalPlayer.Character
            local now = _Tick()

            local MultiPlayer = Flags["KillAll_PingMultiPlayer"] / 1000

            if workspace.Status.Preparation.Value then
                if prepWaitUntil2 == 0 then  
                    local ping = game.Stats.PerformanceStats.Ping:GetValue()
                    local latency = ping / 1000 
                    prepWaitUntil2 = now + 6 - latency - MultiPlayer
                end

                if now < prepWaitUntil2 then
                    killedeveryone = false
                    return 
                end
            else
                prepWaitUntil2 = 0
            end

            if not Utility.IsPlayerAlive(char) then return end 

            local weapon = Cache.Client.fgun
            if not weapon or weapon == "none" then return end
            
            for _, p in next, PlayerModule.storage do
                if p.alive and not p.god then
                    HitPart:FireServer(
                        p.head,
                        {X = 0/0, Y = 0/0, Z = 0/0},
                        "Banana",
                        1,
                        _FindFirstChild(LocalPlayer.Character, "Gun"),
                        nil, math.huge, false, false,
                        _Vector3New(), 1, _Vector3New(), true
                    )
                end
            end
        end)
		    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
        local prepWaitUntil = 0
        RunService.RenderStepped:Connect(function()
            local char = LocalPlayer.Character
            local now = _Tick()

            local MultiPlayer = Flags["RageBot_PingMultiPlayer"] / 1000

            if workspace.Status.Preparation.Value and not Flags.RageBot_Preparation then
                if prepWaitUntil == 0 then
                    local ping = game.Stats.PerformanceStats.Ping:GetValue()
                    local latency = ping / 1000 
                    prepWaitUntil = now + 6 - latency - MultiPlayer
                end

                if now < prepWaitUntil then
                    return 
                end
            else
                prepWaitUntil = 0
            end


            if not Flags.RageBot_Enabled or not Utility.IsPlayerAlive(char) then
                RageBot.Target.TargetPosition = nil
                RageBot.Target.CryptedPosition = nil
                RageBot.Target.Hit = nil
                RageBot.Target.HitName = nil
                RageBot.Target.TargetPlayer = nil
                RageBot.Target.Origin = nil
                return
            end

            local weapon = Cache.Client.fgun
            if not weapon then return end

	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
            local weaponData = _FindFirstChild(replicatedStorage.Weapons, weapon.Name)
            if weaponData and _FindFirstChild(weaponData, "Melee") then return end

            local camCF = camera.CFrame
            local camPos, camLook = camCF.Position, camCF.LookVector
            local origin = (Flags.RageBot_Origins == "Camera" and camPos)
                or (Flags.RageBot_Origins == "Head" and char:FindFirstChild("Head") and char.Head.Position)
                or (char:FindFirstChild("Gun") and char.Gun:FindFirstChild("Flash") and char.Gun.Flash.Position)
            if not origin then return end

            local enemiesFound = false
            local useFov, maxFov = Flags.RageBot_FOV ~= 180, Flags.RageBot_FOV
            
            for _, p in next, PlayerModule.storage do
                if not (p.alive and p.enemy) or p.protected or p.god then continue end

                local root = p.character and p.character:FindFirstChild("HumanoidRootPart")
                if useFov and (not root or _MathDeg(math.acos(camLook:Dot((root.Position - camPos).Unit))) * 2 >= maxFov) then continue end

                local targetChar = p.player.Character
                if not targetChar then continue end
                if workspace.Status.Preparation.Value and Flags.RageBot_Preparation then continue end


                enemiesFound = true

                local fireRate = Flags.RageBot_FireRate and (Flags.RageBot_FireRateValue / 100) or (weapon.FireRate and weapon.FireRate.Value or 0.1)
                if now - LastShoot < fireRate then continue end

                RageBot.Target.TargetPosition = nil
                RageBot.Target.CryptedPosition = nil
                RageBot.Target.Hit = nil
                RageBot.Target.HitName = nil
                RageBot.Target.TargetPlayer = nil
                RageBot.Target.Origin = nil
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
                local ammo = Cache.Client.equipped == "primary" and Cache.Client.vars.ammocount or
                            Cache.Client.equipped == "secondary" and Cache.Client.vars.ammocount2
                if ammo and ammo <= 0 then Cache.Client.autoreload() continue end

                RageBot.Target.TargetPlayer = targetChar
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
                local ignore = {camera, workspace.Ray_Ignore, workspace.Debris, workspace.Map.Clips, workspace.Map.SpawnPoints, char, targetChar}
                local scan, valid = {}, {}

                for partGroup in next, Flags.RageBot_TargetParts do
                    for _, name in next, Cache.hitgroups[partGroup] do
                        local p = _FindFirstChild(targetChar, name)
                        if p then
                            scan[#scan+1], valid[p.Name] = {p, p.Position}, {p, p.Position}
                        end
                    end
                end
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
                if Flags.ForwardTrack_Enabled and p.velocity.Magnitude > 0.01 then
                    local param = RaycastParams.new()
                    param.IgnoreWater = true
                    param.FilterType = Enum.RaycastFilterType.Whitelist
                    param.FilterDescendantsInstances = Flags.ForwardTrack_Ignore_Walls and {} or {workspace.Map}

                    local ping = game.Stats.PerformanceStats.Ping:GetValue() * 2
                    local extrapolate = p.velocity * ((Flags.ForwardTrack_Ticks + ping) / 1000)
                    local steps, target = Flags.ForwardTrack_Steps_to_Scan, p.head

                    if target then
                        for step = 1, steps do  
                            local offset = extrapolate * (step / steps)
                            local data = valid["Head"]
                            if data then
                                local inst, center = data[1], data[2]
                                local hit = workspaceRaycast(workspace, center, offset, param)
                                scan[#scan + 1] = {inst, hit and hit.Position or center + offset, "Extrapolated", step}
                            end
                        end
                    end
                end


                if Flags.Camera_Resolver then
                    local cam = p.player.CameraCF.Value.p
                    if cam == cam and cam ~= _Vector3New() and p.camcf ~= p.lastcameracf and (cam - p.rootpart.CFrame.p).Magnitude > 8 then
                        local ref = scan[1][1]
                        scan[#scan+1], valid[ref.Name] = {ref, cam}, {ref, cam}
                    end
                end

                local origins = { {origin} }
                local base = _CFrameNew(origin, origin + camera.CFrame.LookVector.unit)
                local factor = Flags.RageBot_HitScan_Modifier

                if Flags.RageBot_HitScan then
                    local hsPoints = Flags.RageBot_HitScan_Points
                    if hsPoints.Up then origins[#origins+1] = {(base * _CFrameNew(0, factor, 0)).p} end
                    if hsPoints.Down then origins[#origins+1] = {(base * _CFrameNew(0, -factor, 0)).p} end
                    if hsPoints.Left then origins[#origins+1] = {(base * _CFrameNew(-factor, 0, 0)).p} end
                    if hsPoints.Right then origins[#origins+1] = {(base * _CFrameNew(factor, 0, 0)).p} end
                    if hsPoints.Backward then origins[#origins+1] = {(base * _CFrameNew(0, 0, factor)).p} end
                    if hsPoints.Forward then origins[#origins+1] = {(base * _CFrameNew(0, 0, -factor)).p} end
                    if hsPoints.Towards then origins[#origins+1] = {(base + (_CFrameNew(origin, p.currentPosition).LookVector.Unit * factor)).p} end
                end

                if Flags.RageBot_AutoPeek then
                    local _, peekHit = workspace:FindPartOnRayWithWhitelist(_RayNew(origin, camera.CFrame.LookVector.unit * 21), {workspace.Map}, true)
                    if peekHit then origins[#origins+1] = {peekHit - camera.CFrame.LookVector.unit, true} end
                end

                local scanGroups = {}
                do
                    local groups = _MathMin(#origins, 8)
                    local pointsPerGroup = _MathFloor(Flags.RageBot_HitScan_MaximumPoints / groups)
                    for i = 1, groups do
                        local originIndex = #origins > 1 and _MathRandom(#origins) or 1
                        local o = origins[originIndex]
                        local groupPoints = {}

                        for j = 1, _MathMin(#scan, pointsPerGroup) do
                            local pointIndex = #scan > 1 and _MathRandom(#scan) or 1
                            groupPoints[#groupPoints+1] = scan[pointIndex]
                            _TableRemove(scan, pointIndex)
                        end

                        _TableRemove(origins, originIndex)
                        scanGroups[#scanGroups+1] = {origins = {o}, points = groupPoints}
                    end
                end

                local baseDmg, armorPen, rangeMod = weapon.DMG.Value, weapon.ArmorPenetration.Value * 0.01, weapon.RangeModifier.Value
                local kev, helm = _FindFirstChild(targetChar, "Kevlar"), _FindFirstChild(targetChar, "Helmet")
                local minDmg, scans, mods = Flags.RageBot_MinDmg, {}, Cache.HitModifiers

                for _, group in next, scanGroups do
                    for _, originData in next, group.origins do
                        local from, autopeek = originData[1], originData[2]
                        for _, point in next, group.points do
                            local part, pos = point[1], point[2]
                            local mod = mods[part.Name]
                            if mod then
                                local can, dmod, wallbang, params = CalculateDamageModifier(from, pos, weapon, ignore)
                                if can and dmod then
                                    local dmg = baseDmg * mod * dmod
                                    if kev and (not _StringFind(part.Name, "Head") or helm) then
                                        dmg *= armorPen
                                    end
                                    dmg *= _MathClamp((rangeMod / 100) ^ ((from - pos).Magnitude / 34.7), 0.45, 1)
                                    if dmg > minDmg then
                                        scans[#scans+1] = {
                                            to = pos, from = from, instance = part, autopeek = autopeek,
                                            wallbang = wallbang, damagemodifier = dmod, damage = dmg, params = params
                                        }
                                    end
                                end
                            end
                        end
                    end
                end

                if #scans == 0 then continue end
                if #scans > 1 then _TableSort(scans, function(a, b) return a.damage > b.damage end) end

                local best = scans[1]
                if not best then continue end

                RageBot.Target.TargetPosition = best.instance.Position
                RageBot.Target.CryptedPosition = Utility.CryptPosition(best.instance.Position)
                RageBot.Target.HitName = best.instance.Name
                RageBot.Target.Hit = best.instance
                RageBot.Target.Origin = best.from

                HitPart:FireServer(
                    best.instance,
                    Flags.RageBot_Prediction and {X = 0/0, Y = 0/0, Z = 0/0} or RageBot.Target.CryptedPosition,
                    weapon.Name,
                    0,
                    _FindFirstChild(LocalPlayer.Character, "Gun"),
                    nil, 1, false, best.wallbang,
                    _Vector3New(), 0, _Vector3New(), true
                )

                if best.autopeek then
                    char.HumanoidRootPart.Position = best.from
                end
                if Flags.RageBot_FakeShoot then
                    Utility.FakeShoot(best.params)
                end
                if Flags.RageBot_Auto_Scope then
                    if Cache.Client.equipped ~= "none" and Cache.Client.equipped ~= "equipment3" and Cache.Client.gun ~= "none"
                    and Cache.Client.gun and Cache.Client.gun:FindFirstChild("Scoped") then
                        debug.setupvalue(Cache.Client.updateads, 1, true)
                        Cache.Client.doublezoom = Flags.RageBot_Double_Scope
                        Cache.Client.updateads()
                    end
                end
                LastShoot = now --guys rate my bloxsense paste i real skid
            end

            if not enemiesFound then
                RageBot.Target.TargetPosition = nil
                RageBot.Target.CryptedPosition = nil
                RageBot.Target.Hit = nil
                RageBot.Target.HitName = nil
                RageBot.Target.TargetPlayer = nil
            end
        end)
    end
    do --AntiAims
    
        function AntiAim.PitchControl()
            local pitchMode = Flags["AntiAim_Pitch"]
            local angle = 0
    
            if pitchMode == "Upwards" then
                angle = 1
            elseif pitchMode == "Downwards" then
                angle = -1
            elseif pitchMode == "Zero" then
                angle = 0
            elseif pitchMode == "Random" then
                angle = _MathRandom(-10, 10) / 10
            elseif pitchMode == "Glitch" then
                angle = 0/0
            else
                return
            end
    
            local isClimbing = LocalPlayer.Character and _FindFirstChild(LocalPlayer.Character, "Climbing") ~= nil
            Events.ControlTurn:FireServer(angle, isClimbing)
        end
    
    
        function AntiAim.GetTargetPart()
            local closest = math.huge
            local target = nil
        
            for _, plr in ipairs(_GetPlayers(Players)) do
                if plr ~= LocalPlayer and plr.Team ~= LocalPlayer.Team then
                    local char = plr.Character
                    local hrp = char and _FindFirstChild(char, "HumanoidRootPart")
                    local hum = char and _FindFirstChild(char, "Humanoid")
                    if hrp and hum and hum.Health > 0 then
                        local screenPos, onScreen = camera:WorldToViewportPoint(hrp.Position)
                        if onScreen then
                            local dist = (_Vector2New(screenPos.X, screenPos.Y) - _Vector2New(Mouse.X, Mouse.Y)).Magnitude
                            if dist < closest then
                                closest = dist
                                target = hrp
                            end
                        end
                    end
                end
            end
        
            return target
        end
        
        function AntiAim.YawControl()
            local char = LocalPlayer.Character
            local Root = char and _FindFirstChild(char, "HumanoidRootPart")
            if not Root then return end
        
            char.Humanoid.AutoRotate = false
        
            local CamLook = camera.CFrame.LookVector
            local baseYaw = -_MathAtan2(CamLook.Z, CamLook.X) + _MathRad(-90)
        
            local yawBase = Flags["AntiAim_YawBase"]
            local spinSpeed = Flags["AntiAimSpin_Speed"]*36 or 30
            local yawOffset = Flags["AntiAimSpin_Yaw"] or 0
            local offset = _MathRad(-yawOffset)
        
            if yawBase == "Spin" then
                baseYaw = baseYaw + _MathRad(_Tick() * spinSpeed % 360)
            elseif yawBase == "Random" then
                baseYaw = baseYaw + _MathRad(_MathRandom(0, 360))
            end
        
            local cf = _CFrameNew(Root.Position) * _CFrameAngles(0, baseYaw + offset, 0)
        
            if yawBase == "Targets" then
                local targetPart = AntiAim.GetTargetPart()
                if targetPart then
                    local direction = (targetPart.Position - Root.Position).Unit
                    local lookAt = _CFrameNew(Root.Position, _Vector3New(targetPart.Position.X, Root.Position.Y, targetPart.Position.Z))
                    cf = lookAt * _CFrameAngles(0, offset, 0)
                end                
            end
        
            Root.CFrame = cf
        end
        
        RunService.RenderStepped:Connect(function()
            if not Flags["AntiAim_Enabled"] then return end
    
            local char = LocalPlayer.Character
            if not Utility.IsPlayerAlive(char) then
                if char and _FindFirstChild(char, "Humanoid") then
                    char.Humanoid.AutoRotate = true
                end
                return
            end
    
            AntiAim.PitchControl()
            AntiAim.YawControl()
        end)
    end
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
    do --Movement
        function Movement.GetCharacter()
            local character = LocalPlayer.Character
            if not character then return nil end
            local root = _FindFirstChild(character, "HumanoidRootPart")
            local humanoid = _FindFirstChild(character, "Humanoid")
            if not Utility.IsPlayerAlive(character) then return nil end
            if not root or not humanoid then return nil end
            return character, root, humanoid
        end
        
        function Movement.GetYRotation(cframe)
            local _, y = _CFrameToOrientation(cframe)
            return _CFrameNew(cframe.Position) * _CFrameAngles(0, y, 0)
        end
        	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
        function Movement.GetMoveDirection()
            local dir = Vector3.zero
            if _IsKeyDown(InputService, Enum.KeyCode.W) then dir += _Vector3New(0, 0, -1) end
            if _IsKeyDown(InputService, Enum.KeyCode.S) then dir += _Vector3New(0, 0, 1) end
            if _IsKeyDown(InputService, Enum.KeyCode.A) then dir += _Vector3New(-1, 0, 0) end
            if _IsKeyDown(InputService, Enum.KeyCode.D) then dir += _Vector3New(1, 0, 0) end
            return dir.Magnitude > 0 and dir.Unit or nil
        end
        
        RunService.Stepped:Connect(function()
            local character, root, humanoid = Movement.GetCharacter()
            if not character then return end
            if not Flags["Movement_SpeedHack"] then return end   
            if _IsKeyDown(InputService, Enum.KeyCode.Space) then
                humanoid.Jump = true  
            end   
            local moveDir = Movement.GetMoveDirection()
            if not moveDir then return end
    
            local camCF = camera.CFrame
            local forward = Movement.GetYRotation(camCF):VectorToWorldSpace(moveDir)
            local Speed = Flags["Movement_OverrideSpeedHack"] and Flags["Movement_OverrideSpeed"] or Flags["Movement_Speed"]
            if Flags["Movement_SpeedHackMethod"] == "Velocity" then
                local velocity = forward * Speed
                root.Velocity = _Vector3New(velocity.X, root.Velocity.Y, velocity.Z)
            elseif Flags["Movement_SpeedHackMethod"] == "CFrame" then
                local offset = forward * (Speed / 50)
                root.CFrame += _Vector3New(offset.X, 0, offset.Z)
            end
        end)
    end
    Esp.chamsFolder = _Instancenew("Folder", CoreGui)
    Esp.espObjects = {}
    Esp.allDrawingObjects = {}
    Esp.droppedWeaponStorage = {}
    Esp.imagecache = {}
    function Esp.createDrawing(type, prop)
        local obj = Drawing.new(type)
        if prop then
            for index,value in next, prop do
                obj[index] = value
            end
        end
        _TableInsert(Esp.allDrawingObjects, obj)
        return obj
    end

    do --esp and chams
        Esp.gradentHealthBarSegments = 16
        Esp.defaultProp = {
            outlineBox = {
                Visible = false,
                Transparency = 0.7,
                Color = _Color3FromRGB(10, 10, 10),
                Thickness = 3,
                Filled = false
            },
            box = {
                Visible = false,
                Transparency = 1,
                Color = _Color3FromRGB(255, 255, 255),
                Thickness = 1,
                Filled = false
            },
            boxFilled = {
                Visible = false,
                Transparency = 0.1,
                Color = _Color3FromRGB(255, 255, 255),
                Filled = true
            },
            healthBarOutline = {
                Visible = false,
                Transparency = 0.7,
                Color = _Color3FromRGB(10, 10, 10),
                Thickness = 1,
                Filled = true
            },
            healthBarOutlineOutline = {
                Visible = false,
                Transparency = 0.7,
                Color = _Color3FromRGB(10, 10, 10),
                Thickness = 1,
                Filled = false
            },
            healthBar = {
                Visible = false,
                Transparency = 1,
                Color = _Color3FromRGB(0, 255, 0),
                Thickness = 1,
                Filled = true
            },
            nameTag = {
                Visible = false,
                Size = 13,
                Font = Drawing.Fonts.Plex,
                Color = _Color3FromRGB(255, 255, 255),
                Transparency = 1,
                Center = true,
                Outline = true
            },
            heldWeapon = {
                Visible = false,
                Size = 13,
                Font = 2,
                Color = _Color3FromRGB(255, 255, 255),
                Transparency = 1,
                Center = true,
                Outline = true
            },
            healthNumber = {
                Visible = false,
                Size = 13,
                Font = Drawing.Fonts.Plex,
                Color = _Color3FromRGB(255, 255, 255),
                Transparency = 1,
                Center = true,
                Outline = true
            },
            distanceTag = {
                Visible = false,
                Size = 13,
                Font = 2,
                Color = _Color3FromRGB(255, 255, 255),
                Transparency = 1,
                Center = true,
                Outline = true
            },
            oofArrow = {
                Visible = false,
                Filled = true,
                Color = _Color3FromRGB(255, 0, 255),
                Thickness = 2,
                Transparency = 1
            },
            oofArrowOutline = {
                Visible = false,
                Filled = false,
                Color = _Color3FromRGB(255, 255, 255),
                Thickness = 4,
                Transparency = 0.9,
            },
            cameraCircle = {
                Visible = false,
                Thickness = 1,
                Radius = 3,
                Transparency = 1,
                Filled = false
            },
            snapLine = {
                Thickness = 1,
                Color = _Color3FromRGB(255, 255, 255),
                Transparency = 1,
                Visible = false
            },
            flags = {
                Visible = false,
                Size = 13,
                Font = Drawing.Fonts.Plex,
                Color = _Color3FromRGB(255, 255, 255),
                Transparency = 1,
                Center = true,
                Outline = true
            },
        }

        function Esp.initializeDrawingObjects(onScreen, offScreen, general)
            onScreen.outlineBox         = {
                object = Esp.createDrawing("Square", Esp.defaultProp.outlineBox),
                originalTransparency = Esp.defaultProp.outlineBox.Transparency
            }
            onScreen.box                = {
                object = Esp.createDrawing("Square", Esp.defaultProp.box),
                originalTransparency = Esp.defaultProp.box.Transparency
            }
            onScreen.boxFilled          = {
                object = Esp.createDrawing("Square", Esp.defaultProp.boxFilled),
                originalTransparency = Esp.defaultProp.boxFilled.Transparency
            }
            onScreen.healthBarOutline   = {
                object = Esp.createDrawing("Square", Esp.defaultProp.healthBarOutline),
                originalTransparency = Esp.defaultProp.healthBarOutline.Transparency
            }
            onScreen.healthBarOutlineOutline   = {
                object = Esp.createDrawing("Square", Esp.defaultProp.healthBarOutlineOutline),
                originalTransparency = Esp.defaultProp.healthBarOutline.Transparency
            }
            onScreen.healthBar          = {
                object = Esp.createDrawing("Square", Esp.defaultProp.healthBar),
                originalTransparency = Esp.defaultProp.healthBar.Transparency
            }

            for i = 1, Esp.gradentHealthBarSegments do
                onScreen["healthBarSegment" .. i]       = {
                    object = Esp.createDrawing("Square", Esp.defaultProp.healthBar),
                    originalTransparency = Esp.defaultProp.healthBar.Transparency
                }
            end
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
            onScreen.nameTag            = {
                object = Esp.createDrawing("Text", Esp.defaultProp.nameTag),
                originalTransparency = Esp.defaultProp.nameTag.Transparency
            }
            onScreen.heldWeapon         = {
                object = Esp.createDrawing("Text", Esp.defaultProp.heldWeapon),
                originalTransparency = Esp.defaultProp.heldWeapon.Transparency
            }
            onScreen.healthNumber       = {
                object = Esp.createDrawing("Text", Esp.defaultProp.healthNumber),
                originalTransparency = Esp.defaultProp.healthNumber.Transparency
            }
            onScreen.distanceTag        = {
                object = Esp.createDrawing("Text", Esp.defaultProp.distanceTag),
                originalTransparency = Esp.defaultProp.distanceTag.Transparency
            }
            onScreen.armorTag        = {
                object = Esp.createDrawing("Text", Esp.defaultProp.flags),
                originalTransparency = Esp.defaultProp.flags.Transparency
            }
            onScreen.bombTag		= {
                object = Esp.createDrawing("Text", Esp.defaultProp.flags),
                originalTransparency = Esp.defaultProp.flags.Transparency
            }
            onScreen.moneyTag        = {
                object = Esp.createDrawing("Text", Esp.defaultProp.flags),
                originalTransparency = Esp.defaultProp.flags.Transparency
            }
            offScreen.oofArrow          = {
                object = Esp.createDrawing("Triangle", Esp.defaultProp.oofArrow),
                originalTransparency = Esp.defaultProp.oofArrow.Transparency
            }
            offScreen.oofArrowOutline   = {
                object = Esp.createDrawing("Triangle", Esp.defaultProp.oofArrowOutline),
                originalTransparency = Esp.defaultProp.oofArrowOutline.Transparency
            }
            onScreen.cameraCircle        = {
                object = Esp.createDrawing("Circle", Esp.defaultProp.cameraCircle),
                originalTransparency = Esp.defaultProp.cameraCircle.Transparency
            }
            general.snapLine            = {
                object = Esp.createDrawing("Line", Esp.defaultProp.snapLine),
                originalTransparency = Esp.defaultProp.snapLine.Transparency
            }
        end

        function Esp.getBoundingBox(rootCf, headCf, rootSize, headSize, hipHeight, cacheTable)
            if cacheTable and rootCf then
                cacheTable.rootCf = rootCf
                cacheTable.headCf = headCf
                cacheTable.rootSize = rootSize
                cacheTable.headSize = headSize
                cacheTable.hipHeight = hipHeight
            elseif not rootCf then
                rootCf = cacheTable.rootCf
                headCf = cacheTable.headCf
                rootSize = cacheTable.rootSize
                headSize = cacheTable.headSize
                hipHeight = cacheTable.hipHeight
            end
            local th = headCf * _Vector3New(0, headSize.y*0.5 + 0.5, 0)
            local bf = rootCf * _Vector3New(0, -(rootSize.y*0.5 + hipHeight + 0.5), 0)
            local td = (th - rootCf.p).Magnitude
            local bd = (rootCf.p - bf).Magnitude

            local up = rootCf.UpVector
            local tp = rootCf.p + up*td
            local bp = rootCf.p - up*bd

            local top = Calculations:worldToViewportPoint(tp)
            local bottom = Calculations:worldToViewportPoint(bp)

            local width = math.abs(top.x - bottom.x)
            local height = _MathMax(math.abs(top.y - bottom.y), width / 1.75)

            local size = _Vector2New(_MathFloor(_MathMax(height / 1.7, width * 2.5)), _MathFloor(height))
            local pos = _Vector2New(_MathFloor((bottom.x - size.x + top.x) / 2), _MathFloor(_MathMin(top.y, bottom.y)))

            return Rect.new(pos, pos + size)
        end

        function Esp.applyEsp(player)
            repeat _TaskWait() until PlayerModule.storage[player]
            _TaskWait(1)
            local this = {}
            this.drawingObjects = {
                drawOnScreen    = {},
                drawOffScreen   = {},
                drawGeneral     = {}, 
                stoppedRenderingOnScreen    = true,
                stoppedRenderingOffScreen   = true,
                lastData = {
                    headPos = nil,
                    torsoCf = nil,
                    health = nil,
                    maxHealth = nil
                },
            }
            this.transparencyEvent = _Instancenew("BindableEvent")
            this.healthPercentageSpring = spring.new()
            this.healthPercentageSpring.s = 24
            this.timePassed = 0
            this.chamsObjects = {}
            this.skeletons = {}
            this.chamsTransConnections = {}
            this.updatechams = false 
            this.transConnections = {}
            this.theirpInfo = PlayerModule.storage[player]
            
            Esp.initializeDrawingObjects(this.drawingObjects.drawOnScreen, this.drawingObjects.drawOffScreen, this.drawingObjects.drawGeneral)

            for i,v in next, this.drawingObjects.drawOnScreen do
                _TableInsert(this.transConnections, this.transparencyEvent.Event:Connect(function(transparency)
                    v.object.Transparency = v.originalTransparency * (1 - transparency)
                end))
            end
            for i,v in next, this.drawingObjects.drawOffScreen do
                _TableInsert(this.transConnections, this.transparencyEvent.Event:Connect(function(transparency)
                    v.object.Transparency = v.originalTransparency * (1 - transparency)
                end))
            end
            for i,v in next, this.drawingObjects.drawGeneral do
                _TableInsert(this.transConnections, this.transparencyEvent.Event:Connect(function(transparency)
                    v.object.Transparency = v.originalTransparency * (1 - transparency)
                end))
            end

            function this.chamsremoved(character)
                for i = #this.chamsObjects, 1, -1 do
                    local object = _TableRemove(this.chamsObjects, i)
                    if object then
                        _Destroy(object)
                        object = nil
                    end
                end
                for i = #this.skeletons, 1, -1 do
                    local v = _TableRemove(this.skeletons, i)
                    if v then
                        v.step:Disconnect()
                        v.step = nil
                        v.line:Remove()
                        v.line = nil
                        v.weld = nil
                    end
                end
            end
                        
            local transparencyFix = function()
                local character = player.Character
                if not character then return end

                local pInfo = PlayerModule.storage[player]
                if not pInfo then return end

                local section = (this and this.theirpInfo and this.theirpInfo.enemy) and "Enemy_" or "Team_"
                local chamsEnabled = Flags[section .. "Chamses"]
                local targetTransparency = chamsEnabled and 1 or 0

                for _, accessory in ipairs(_GetChildren(character)) do
                    if _IsA(accessory, "Accessory") then
                        for _, part in ipairs(_GetChildren(accessory)) do
                            if _IsA(part, "BasePart") then
                                part.Transparency = targetTransparency
                            end
                        end
                    end
                end
            end


            function this.chamsadded(character)
                repeat 
                    _TaskWait() 
                until character ~= nil
                local humanoid = character:WaitForChild("Humanoid", 1/0)
                local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 1/0)
                if humanoid.Health <= 0 then
                    return
                end
                local pInfo = PlayerModule.storage[player]
                if not pInfo then
                    repeat
                        pInfo = PlayerModule.storage[player]
                        _TaskWait()
                    until pInfo
                end
                --what the dog doing
                local section = this and this.theirpInfo and this.theirpInfo.enemy and "Enemy_" or "Team_"
                humanoidRootPart.AncestryChanged:Connect(function(child, new)
                    if new == nil then
                        this.chamsremoved()
                    end
                end)
                local yeah = _Tick()
                local loop
                loop = RunService.Stepped:Connect(function()
                    if _Tick() - yeah > 5 then
                        loop:Disconnect()
                        loop = nil
                    end
                    transparencyFix()
                end)
                for i,v in next, _GetChildren(character) do
                    if _IsA(v,"MeshPart") or _IsA(v,"BasePart") and _FindFirstChildOfClass(v, "Motor6D") and (v.Transparency ~= 1 or v.Name == "Head") then
                        if v.Name == "BackC4" then return end
                        local weld = _FindFirstChildOfClass(v, "Motor6D")
                        if weld.Part0 == character.HumanoidRootPart or weld.Part1 == character.HumanoidRootPart then
                        else
                            if weld and weld.Part0 and weld.Part1 then
                                local data = {}
                                data.weld = weld
                                data.line = Esp.createDrawing("Line", {
                                    Thickness = 1,
                                    Color = Flags[section.. "Skeletons_Color1"],
                                    Visible = false,
                                    Transparency = 0.5
                                })
                                local hasBeenHidden = false
                                data.step = RunService.Stepped:Connect(function()
                                    local section = this and this.theirpInfo and this.theirpInfo.enemy and "Enemy_" or "Team_"
                                    if Flags[section.. "Skeletons"] then
                                        hasBeenHidden = false
                                        local p0, v0 = Calculations:worldToViewportPoint(data.weld.Part0.Position)
                                        local p1, v1 = Calculations:worldToViewportPoint(data.weld.Part1.Position)
                                        if v0 and v1 then
                                            data.line.From = _Vector2New(_MathFloor(p0.x), _MathFloor(p0.y))
                                            data.line.To = _Vector2New(_MathFloor(p1.x), _MathFloor(p1.y))
                                            data.line.Color = Flags[section.. "Skeletons_Color1"]
                                            data.line.Visible = true
                                        else
                                            data.line.Visible = false
                                        end
                                    else
                                        if hasBeenHidden ~= true then
                                            data.line.Visible = false
                                            hasBeenHidden = true
                                        end
                                    end
                                end)

                                _TableInsert(this.skeletons, data)
                            end
                        end
                    end
                    if _IsA(v,"BasePart") and v.Name ~= "HumanoidRootPart" and v.Name ~= "Gun" and v.Name ~= "BackC4" and v.Name ~= "HeadHB" and v.Name ~= "Head" then
                        local isHead = v.Name == "FakeHead"
                        local inner = _Instancenew(isHead and "CylinderHandleAdornment" or "BoxHandleAdornment")
                        local outline = _Clone(inner)
                        inner.Name = "inner"
                        inner.AlwaysOnTop = true
                        inner.Color3 = Flags[section.. "Chamses_Color1"]
                        inner.Transparency = Flags[section.. "Chamses_Transperency1"]/10
                        inner.Visible = Flags[section.. "Chamses"]
                        inner.ZIndex = 2
                        inner.Adornee = v
                        inner.Parent = Esp.chamsFolder

                        outline.Name = "outer"
                        outline.AlwaysOnTop = false
                        outline.Color3 = Flags[section.. "Chamses_Color2"]
                        outline.Transparency = Flags[section.. "Chamses_Transperency2"]/10
                        outline.Visible = inner.Visible
                        outline.ZIndex = -1
                        outline.Adornee = v
                        outline.Parent = Esp.chamsFolder

                        if isHead then
                            inner.CFrame = _CFrameAngles(math.pi / 2, 0, 0)
                            inner.Radius = v.Size.x * 0.58 + 0.001
                            inner.Height = v.Size.y + 0.17

                            outline.CFrame = inner.CFrame
                            outline.Radius = v.Size.x * 0.58 + 0.15
                            outline.Height = v.Size.y + 0.32
                        else
                            inner.Size = v.Size + _Vector3New(0.001, 0.001, 0.001)
                            outline.Size = v.Size + _Vector3New(0.15, 0.15, 0.15)
                        end

                        _TableInsert(this.chamsObjects, inner)
                        _TableInsert(this.chamsObjects, outline)
                    end
                end
            end

            local lastFlags = {}

            function this.updateChams()
                if not this or not this.theirpInfo then return end

                local isEnemy = this.theirpInfo.enemy
                local section = isEnemy and "Enemy_" or "Team_"
                local chamsEnabled = Flags[section .. "Chamses"]
                local color1 = Flags[section .. "Chamses_Color1"]
                local color2 = Flags[section .. "Chamses_Color2"]
                local transparency1 = Flags[section .. "Chamses_Transperency1"]
                local transparency2 = Flags[section .. "Chamses_Transperency2"]
                local flagKey = section .. "_chamsHash"
                local currentHash = _tostring(chamsEnabled) .. _tostring(color1) .. _tostring(color2) .. transparency1 .. transparency2
                if lastFlags[flagKey] == currentHash then return end
                lastFlags[flagKey] = currentHash
                local chams = this.chamsObjects
                if chams then
                    for _, v in next, chams do
                        v.Visible = chamsEnabled
                        if v.Name == "inner" then
                            v.Color3 = color1
                            v.Transparency = chamsEnabled and transparency1 / 10 or 1
                        elseif v.Name == "outer" then
                            v.Color3 = color2
                            v.Transparency = chamsEnabled and transparency2 / 10 or 1
                        end
                    end
                    transparencyFix()
                end
            end


            function this.renderOnScreen(info)
                if info.pInfo then
                    this.drawingObjects.lastData.pInfo = info.pInfo
                else
                    info.pInfo = this.drawingObjects.lastData.pInfo
                end

                local health = info.health
                local maxHealth = info.maxHealth
                local section = ((this and this.theirpInfo and this.theirpInfo.enemy and "Enemy_") or "Team_")
                local boundingRect = info.boundingRect
                local drawOnScreen = this.drawingObjects.drawOnScreen
                local boxOutline = drawOnScreen.outlineBox.object
                local box = drawOnScreen.box.object
                local boxFilled =  drawOnScreen.boxFilled.object
                local healthBar = drawOnScreen.healthBar.object
                local healthBarOutline = drawOnScreen.healthBarOutline.object
                local healthBarOutlineOutline = drawOnScreen.healthBarOutlineOutline.object
                local healthNumber = drawOnScreen.healthNumber.object
                local heldWeapon = drawOnScreen.heldWeapon.object
                local distanceTag = drawOnScreen.distanceTag.object
                local nameTag = drawOnScreen.nameTag.object
                local armorTag = drawOnScreen.armorTag.object
                local moneyTag = drawOnScreen.moneyTag.object
                local bombTag = drawOnScreen.bombTag.object
                local fakeindicator = 0
                local flagoffset = 0

                local textCase = Flags["Esp_Settings_TextCase"]
                local textSize = Flags["Esp_Settings_TextSize"]
                local textFont = Drawing.Fonts[Flags["Esp_Settings_TextFont"]]
                
                local textFlagCase = Flags["Esp_Settings_FlagTextCase"]
                local textFlagSize = Flags["Esp_Settings_FlagTextSize"]
                local textFlagFont = Drawing.Fonts[Flags["Esp_Settings_FlagTextFont"]]
                
                this.healthPercentageSpring.t = info.pInfo.god == true and 0 or health/maxHealth
                if info.pInfo.character and _FindFirstChild(info.pInfo.character, "EquippedTool") then
                    this.drawingObjects.lastData.weapon = textCase == "lowercase" and info.pInfo.character.EquippedTool.Value:lower() or textCase == "UPPERCASE" and info.pInfo.character.EquippedTool.Value:upper() or info.pInfo.character.EquippedTool.Value
                end
                if Flags[section.. "Boxes"] then
                    box.Position = boundingRect.Min
                    box.Size = boundingRect.Max - boundingRect.Min

                    boxOutline.Position = box.Position
                    boxOutline.Size = box.Size

                    box.Color = Flags[section.. "Boxes_Color1"]
                    boxFilled.Color = Flags[section.. "Boxes_Filled_Color1"]
                    boxFilled.Transparency = 1 - Flags[section.. "Boxes_Filled_Transperency"]/10

                    if Flags[section.. "Boxes_Filled"] then
                        boxFilled.Position = box.Position + _Vector2New(_MathFloor(box.Thickness / 2) + 1, _MathFloor(box.Thickness / 2) + 1)
                        boxFilled.Size = box.Size - _Vector2New(box.Thickness + 1, box.Thickness + 1)
                        boxFilled.Visible = true
                    else
                        boxFilled.Visible = false
                    end
                    box.Visible = true
                    boxOutline.Visible = true
                else
                    box.Visible = false
                    boxFilled.Visible = false
                    boxOutline.Visible = false
                end
                if Flags[section.. "Health_Bar"] then
                    local hpMax = Flags[section.. "Health_Bar_Color1"]
                    local hpLow = Flags[section.. "Health_Bar_Color2"]

                    local healthPercentage = this.healthPercentageSpring.p
                    local fullSize = boundingRect.Height
                    local chunk = fullSize * healthPercentage

                    healthBar.Size = _Vector2New(2, chunk)
                    healthBar.Position = boundingRect.Min + _Vector2New(-5, fullSize - chunk)
                    healthBarOutline.Size = _Vector2New(4, fullSize + 2)
                    healthBarOutline.Position = boundingRect.Min + _Vector2New(-6, -1)
                    healthBarOutlineOutline.Size = healthBarOutline.Size
                    healthBarOutlineOutline.Position = healthBarOutline.Position
                    healthBar.Color = hpLow:Lerp(hpMax, healthPercentage)

                    local isGradient =  Flags[section.. "Health_Bar_Gradient"]

                    healthBar.Visible = not isGradient
                    healthBarOutline.Visible = true
                    healthBarOutlineOutline.Visible = true

                    if isGradient then
                        local sizePerSegment = math.ceil(fullSize / Esp.gradentHealthBarSegments)
                        local maxSegments = fullSize / sizePerSegment + 1
                        local minSegments = chunk / sizePerSegment + 1
                        local skipped = maxSegments - minSegments

                        local healthPos = healthBar.Position
                        local healthSizeX = healthBar.Size.x
                        local healthSizeY = healthBar.Size.y

                        for i = 1, Esp.gradentHealthBarSegments do
                            local segment = drawOnScreen["healthBarSegment" .. i].object

                            local projectedPosMin = _Vector2New(0, (i-1) * sizePerSegment)
                            local ProjectedPosMax = projectedPosMin + _Vector2New(0, sizePerSegment)

                            if projectedPosMin.y > chunk then
                                segment.Visible = false
                            else
                                segment.Visible = true
                                segment.Position = healthPos + projectedPosMin
                                segment.Size = _Vector2New(healthSizeX, ProjectedPosMax.y - healthSizeY > 0 and sizePerSegment - (ProjectedPosMax.y - healthSizeY) or sizePerSegment)
                                segment.Color = hpMax:Lerp(hpLow, (i + skipped)/maxSegments)
                            end
                        end
                    else
                        if drawOnScreen["healthBarSegment1"].object.Visible == true then
                            for i = 1, Esp.gradentHealthBarSegments do
                                drawOnScreen["healthBarSegment" .. i].object.Visible = false
                            end 
                        end
                    end
                else
                    healthBar.Visible = false
                    healthBarOutline.Visible = false
                    healthBarOutlineOutline.Visible = false

                    if drawOnScreen["healthBarSegment1"].object.Visible == true then
                        for i = 1, Esp.gradentHealthBarSegments do
                            drawOnScreen["healthBarSegment" .. i].object.Visible = false
                        end 
                    end
                end
                if Flags[section.. "Health_Bar"] and ((Flags[section.. "Health_Number"]  and health <= Flags[section.. "Max_HP_Visibility_Cap"]) or info.pInfo.god) then
                    local godded = info.pInfo.god

                    healthNumber.Text = godded and "God" or _tostring(_MathFloor((this.healthPercentageSpring.p * maxHealth) + 0.5))
                    local offset = godded and 0 or (2 * this.healthPercentageSpring.p) - 1
                    healthNumber.Position = godded and boundingRect.Min + _Vector2New(-5 - healthBar.Size.x - (healthNumber.TextBounds.X/2), (boundingRect.Height*0.5) - healthNumber.TextBounds.Y/2 + (offset * (healthNumber.Size/4)) - (offset * 1)) or healthBar.Position + _Vector2New(-healthBar.Size.x - (healthNumber.TextBounds.X/2) - 1, -healthNumber.TextBounds.Y/2) + _Vector2New(0, (offset * (healthNumber.Size + 1) * 0.25))
                    healthNumber.Color = _Color3New(1, 1, 1)
                    healthNumber.Visible = true
                else
                    healthNumber.Visible = false
                end
                local theOffsetBullshit = 0
                if Flags[section.. "Held_Weapon"] then
                    heldWeapon.Text = this.drawingObjects.lastData.weapon
                    heldWeapon.Size = textSize
                    heldWeapon.Font = textFont
                    heldWeapon.Position = boundingRect.Min + _Vector2New(_MathFloor(boundingRect.Width / 2), boundingRect.Height + 2)
                    heldWeapon.Color = Flags[section.. "Held_Weapon_Color1"]
                    heldWeapon.Visible = true
                    theOffsetBullshit = theOffsetBullshit + textSize
                else
                    heldWeapon.Visible = false
                end
			    	    --
		    	    --
			    	    --
				    	    --
                if Flags[section.. "Distance"] then
                    distanceTag.Text = Calculations:truncateNumber((this.drawingObjects.lastData.headCf.p - camera.CFrame.p).Magnitude, 1) .. (textCase == "lowercase" and " st" or textCase == "UPPERCASE" and " ST" or " st")
                    distanceTag.Position = boundingRect.Min + _Vector2New(_MathFloor(boundingRect.Width / 2), boundingRect.Height + theOffsetBullshit + 2)
                    distanceTag.Size = textSize
                    distanceTag.Font = textFont
                    distanceTag.Color = Flags[section.. "Distance_Color1"]
                    distanceTag.Visible = true
                else
                    distanceTag.Visible = false
                end
			    	    --
		    	    --
			    	    --
				    	    --
                if Flags[section.. "Name"] then
                    nameTag.Color = Flags[section.. "Name_Color1"]
                    nameTag.Text = textCase == "lowercase" and player.Name:lower() or textCase == "UPPERCASE" and player.Name:upper() or player.Name
                    nameTag.Position = boundingRect.Min + _Vector2New(_MathFloor(boundingRect.Width / 2), -2 - nameTag.TextBounds.y)
                    nameTag.Size = textSize
                    nameTag.Font = textFont
                    nameTag.Visible = true
                else
                    nameTag.Visible = false
                end
                if Flags[section.. "Armor"] then
                    armorTag.Color = Flags[section.. "Armor_Color1"]
                    local str = ""
                    if _FindFirstChild(player, "Helmet") then
                        str = str .. "H"
                    end
                    if _FindFirstChild(player, "Kevlar") then
                        str = str .. "K"
                    end

                    local rawText = str
                    local rawTextSplit = _StringSplit(rawText:lower(), "")
                    if rawTextSplit[1] then
                        rawTextSplit[1] = rawTextSplit[1]:upper()
                        for i, char in next, rawTextSplit do
                            if ((char == " " or char == "-") and i < #rawTextSplit) then
                                rawTextSplit[i + 1] = rawTextSplit[i + 1]:upper()
                            end
                        end
                    end
                    local fixedText = _TableConcat(rawTextSplit)

                    armorTag.Text = textFlagCase == "lowercase" and str:lower() or textFlagCase == "UPPERCASE" and str:upper() or fixedText
                    armorTag.Position = boundingRect.Min + _Vector2New(_MathFloor(boundingRect.Width) + (armorTag.TextBounds.X / 2) + 2, -3)
                    if str ~= "" then
                        flagoffset = flagoffset + armorTag.TextBounds.Y
                    end
                    armorTag.Visible = true
                    armorTag.Font = textFlagFont
                    armorTag.Size = textFlagSize
                else
                    armorTag.Visible = false
                end
                if Flags[section.. "Cash"] then
                    moneyTag.Color = Flags[section.. "Cash_Color1"]
                    moneyTag.Text = _tostring(player.Cash.Value) .. "$"

                    moneyTag.Font = textFlagFont
                    moneyTag.Size = textFlagSize

                    moneyTag.Position = boundingRect.Min + _Vector2New(_MathFloor(boundingRect.Width) + (moneyTag.TextBounds.X / 2) + 2, -3 + flagoffset)
                    flagoffset = flagoffset + moneyTag.TextBounds.Y
                    moneyTag.Visible = true
                else
                    moneyTag.Visible = false
                end
                if _FindFirstChild(workspace,"Status") and _FindFirstChild(workspace.Status,"HasBomb") and workspace.Status.HasBomb.Value == player.Name then
                    this.drawingObjects.lastData.hadBomb = true
                else
                    this.drawingObjects.lastData.hadBomb = false
                end
                if Flags[section.. "Bomb"] and this.drawingObjects.lastData.hadBomb then
                    bombTag.Color = Flags[section.. "Bomb_Color1"]
                    bombTag.Text =  textFlagCase == "lowercase" and "bomb" or textFlagCase == "UPPERCASE" and "BOMB" or "Bomb"
                    bombTag.Position = boundingRect.Min + _Vector2New(_MathFloor(boundingRect.Width) + (bombTag.TextBounds.X / 2) + 2, -3 + flagoffset)
                    flagoffset = flagoffset + bombTag.TextBounds.Y
                    bombTag.Visible = true
                else
                    bombTag.Visible = false
                end
                this.updateChams()
            
                this.drawingObjects.stoppedRenderingOnScreen = false

                if not this.drawingObjects.stoppedRenderingOffScreen then
                    this.drawingObjects.stoppedRenderingOffScreen = true
                    for i,v in next, this.drawingObjects.drawOffScreen do
                        v.object.Visible = false
                    end
                end
            end
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
            function this.renderOffScreen(info)
                local pos = CFrame.lookAt(camera.CFrame.p, camera.CFrame.p + camera.CFrame.LookVector * _Vector3New(1, 0, 1)):PointToObjectSpace(info.position)

                if not (executor == "ScriptWare" and platform == "Mac") then
                    local oofArrow = this.drawingObjects.drawOffScreen.oofArrow.object
                    local oofArrowOutline = this.drawingObjects.drawOffScreen.oofArrowOutline.object
                    if Flags["Enemy_Out_of_View_Arrows"] and this and this.theirpInfo and this.theirpInfo.enemy then
                        local angle = _MathAtan2(pos.z, pos.x)

                        local cx, sy = _MathCos(angle), _MathSin(angle)
                        local cx1, sy1 = _MathCos(angle + math.pi/2), _MathSin(angle + math.pi/2)
                        local cx2, sy2 = _MathCos(angle + math.pi/2*3), _MathSin(angle + math.pi/2*3)

                        local viewport = camera.ViewportSize
                        local bigger = _MathMax(viewport.x, viewport.y)
                        local smaller = _MathMin(viewport.x, viewport.y)
                        local arrowSize = _MathClamp(Flags["Enemy_Dynamic_Arrow_Size"] and Calculations:map((info.position - camera.CFrame.p).Magnitude, 1, 100, 30, 10) or Flags["Enemy_Arrow_Size"], 4, 1/0)
                        local arrowPercentage = Flags["Enemy_Arrow_Distance"]

                        local arrowOrigin = viewport/2 + (_Vector2New(cx, sy) * _Vector2New(bigger * arrowPercentage/200, smaller * arrowPercentage/200))

                        oofArrow.PointA = arrowOrigin + _Vector2New(arrowSize*2 * cx, arrowSize*2 * sy)
                        oofArrow.PointB = arrowOrigin + _Vector2New(arrowSize * cx1, arrowSize * sy1)
                        oofArrow.PointC = arrowOrigin + _Vector2New(arrowSize * cx2, arrowSize * sy2)
                        oofArrow.Color = Flags["Enemy_Out_of_View_Arrows_Color1"]

                        oofArrowOutline.PointA = oofArrow.PointA
                        oofArrowOutline.PointB = oofArrow.PointB
                        oofArrowOutline.PointC = oofArrow.PointC
                        
                        oofArrowOutline.Color = _Color3New(_MathMax(0, Flags["Enemy_Out_of_View_Arrows_Color1"].r * 0.5), _MathMax(0,  Flags["Enemy_Out_of_View_Arrows_Color1"].g * 0.5), _MathMax(0,  Flags["Enemy_Out_of_View_Arrows_Color1"].b * 0.5))

                        local trans = ((_MathCos(_Tick() * 2 * math.pi) * (0.75 - (0.25 * (_MathCos(_Tick() * 2 * math.pi))))) / 2) + 0.75
                        this.drawingObjects.drawOffScreen.oofArrow.originalTransparency = trans
                        this.drawingObjects.drawOffScreen.oofArrowOutline.originalTransparency = trans

                        oofArrow.Transparency = trans
                        oofArrowOutline.Transparency = trans

                        oofArrow.Visible = true
                        oofArrowOutline.Visible = true
                    else
                        oofArrowOutline.Visible = false
                        oofArrow.Visible = false
                    end
                end

                this.drawingObjects.stoppedRenderingOffScreen = false

                if not this.drawingObjects.stoppedRenderingOnScreen then
                    this.drawingObjects.stoppedRenderingOnScreen = true
                    for i,v in next, this.drawingObjects.drawOnScreen do
                        v.object.Visible = false
                    end
                end
            end

            function this.renderGeneral(info)
                local snapLine = this.drawingObjects.drawGeneral.snapLine.object
                local pos, onScreen = Calculations:worldToViewportPoint(info.position, false, 50)

                if not onScreen then
                    local angle
                    local centerX, centerY = viewportSize.x/2, viewportSize.y/2
                    if pos.z > 0 then
                        angle = _MathAtan2(pos.y - centerY, pos.x - centerX)
                    else
                        angle = _MathAtan2(centerY - pos.y, centerX - pos.x)
                    end

                    local x = _MathCos(angle)
                    local y = _MathSin(angle)
                    local slope = y/x
                    local xEdge, yEdge = viewportSize.x, viewportSize.y
                    if y < 0 then
                        yEdge = 0
                    end

                    if x < 0 then
                        xEdge = 0
                    end

                    local newY = slope*xEdge + centerY - slope*centerX
                    if newY > 0 and newY < viewportSize.y then
                        pos = _Vector2New(xEdge, newY)
                    else
                        pos = _Vector2New((yEdge - centerY + slope*centerX)/slope, yEdge)
                    end
                end
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
                local section = this and this.theirpInfo and this.theirpInfo.enemy and "Enemy_" or "Team_"
                if Flags[section.. "Snap_Lines"] then
                    local trans = (1 - (Flags[section.. "Snap_Lines_Transperency"])/10) * (onScreen and 1 or 0.5)
                    snapLine.From = _Vector2New(_MathFloor(viewportSize.x / 2), _MathFloor(viewportSize.y - 50))
                    snapLine.To = _Vector2New(pos.x, pos.y)
                    snapLine.Transparency = trans
                    snapLine.Color = Flags[section.. "Snap_Lines_Color1"]
                    snapLine.Visible = true
                else
                    snapLine.Visible = false
                end
            end
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
            function this.onSpawned()
                local pInfo = PlayerModule.storage[player]
                repeat 
                    _TaskWait()
                until pInfo and pInfo.alive 
                if this.step then
                    this.step:Disconnect()
                    this.step = nil
                end
                this.transparencyEvent:Fire(0)
                this.fadefinished = true
                
                this.step = RunService.Stepped:Connect(function(upTime, deltaTime)
                    if pInfo and (pInfo.alive or pInfo.god) then
                        local section = pInfo.enemy and "Enemy_" or "Team_"
                        local health, maxHealth = pInfo.humanoid.Health, pInfo.humanoid.MaxHealth
                        this.drawingObjects.lastData.health = health
                        this.drawingObjects.lastData.maxHealth = maxHealth
                        this.timePassed = 0
                        local onScreen = Calculations:spherePoint(pInfo.head.Position, 4)
                        if onScreen then
                            this.renderOnScreen({
                                boundingRect = Esp.getBoundingBox(pInfo.rootpart.CFrame, pInfo.head.CFrame, pInfo.rootpart.Size, pInfo.head.Size, pInfo.humanoid.HipHeight, this.drawingObjects.lastData),
                                pInfo = pInfo,
                                health = health,
                                maxHealth = maxHealth
                            })
                        else
                            this.renderOffScreen({
                                position = pInfo.currentPosition
                            })
                        end
                        this.renderGeneral({
                            position = pInfo.currentPosition,
                            pInfo = pInfo
                        })
                    else
                        if this and this.onDied then
                            this.onDied()
                        end
                    end
		    	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
                end)
            end
            function this.onDied()
                local pInfo = PlayerModule.storage[player]
                if this.step then
                    this.step:Disconnect()
                    this.step = nil	
                end
                this.fadefinished = false
                this.timePassed = 0
                this.step = RunService.Stepped:Connect(function(upTime, deltaTime)
                    if not this.timePassed then
                        this.timePassed = 1
                    end
                    this.timePassed = this.timePassed + (deltaTime * 4)
                    if this.timePassed >= 1 then
                        if this.step then
                            this.step:Disconnect()
                        end
                        for i,v in next, this.drawingObjects.drawOnScreen do
                            v.object.Visible = false
                        end
                        for i,v in next, this.drawingObjects.drawOffScreen do
                            v.object.Visible = false
                        end
                        for i,v in next, this.drawingObjects.drawGeneral do
                            v.object.Visible = false
                        end
                        this.drawingObjects.stoppedRenderingOffScreen = true
                        this.drawingObjects.stoppedRenderingOnScreen = true

                        for i = #this.chamsTransConnections, 1, -1 do
                            local con = _TableRemove(this.chamsTransConnections, i)
                            if con then
                                con:Disconnect()
                                con = nil
                            end
                        end
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
                        for i = #this.chamsObjects, 1, -1 do
                            local object = _TableRemove(this.chamsObjects, i)
                            if object then
                                _Destroy(object)
                                object = nil
                            end
                        end
                        if this.step then
                            this.step:Disconnect()
                            this.step = nil
                        end
                        this.transparencyEvent:Fire(0)
                        this.fadefinished = true
                    else
                        this.transparencyEvent:Fire(Calculations:map(this.timePassed, 0, 1, 0, 1))
                        if this.drawingObjects.lastData.headCf then
                            local onScreen = Calculations:spherePoint(this.drawingObjects.lastData.headCf.p, 4)
                            if onScreen then
                                this.renderOnScreen({
                                    boundingRect = Esp.getBoundingBox(nil, nil, nil, nil, nil, this.drawingObjects.lastData),
                                    health = 0,
                                    maxHealth = this.drawingObjects.lastData.maxHealth
                                })
                            else
                                this.renderOffScreen({
                                    position = this.drawingObjects.lastData.headCf.p
                                })
                            end
                            this.renderGeneral({
                                position = this.drawingObjects.lastData.headCf.p
                            })	
                        else
                            if not this.drawingObjects.stoppedRenderingOnScreen then
                                this.drawingObjects.stoppedRenderingOnScreen = true
                                for i,v in next, this.drawingObjects.drawOnScreen do
                                    v.object.Visible = false
                                end
                            end
                            if not this.drawingObjects.stoppedRenderingOffScreen then
                                this.drawingObjects.stoppedRenderingOffScreen = true
                                for i,v in next, this.drawingObjects.drawOffScreen do
                                    v.object.Visible = false
                                end
                            end
                            for i,v in next, this.drawingObjects.drawGeneral do
                                v.object.Visible = false
                            end
                        end
                    end
                end)
            end
            if player.Character and _FindFirstChild(player.Character, "HumanoidRootPart") then
                this.onSpawned()
                this.chamsadded(player.Character)
            end
            Esp.espObjects[player] = this
        end

        function Esp.removeEsp(player)
            local this = Esp.espObjects[player]
            if this then
                if this.step then
                    this.step:Disconnect()
                end
                for i,v in next, this.drawingObjects.drawOnScreen do
                    v.object:Remove()
                    v.object = nil
                    table.clear(v)
                end
                for i,v in next, this.drawingObjects.drawOffScreen do
                    v.object:Remove()
                    v.object = nil
                    table.clear(v)
                end
                for i,v in next, this.drawingObjects.drawGeneral do
                    v.object:Remove()
                    v.object = nil
                    table.clear(v)
                end
                for i = #this.chamsTransConnections, 1, -1 do
                    local con = _TableRemove(this.chamsTransConnections, i)
                    if con then
                        con:Disconnect()
                        con = nil
                    end
                end
                for i = #this.transConnections, 1, -1 do
                    local con = _TableRemove(this.transConnections, i)
                    if con then
                        con:Disconnect()
                        con = nil
                    end
                end
                _Destroy(this.transparencyEvent)
                this.healthPercentageSpring = nil
                table.clear(this)
                Esp.espObjects[player] = nil
                this = nil
            end
        end
        playerSpawned:Connect(function(plr, tick)
            local this = Esp.espObjects[plr]
            if this then
                this.chamsadded(plr.Character)
                this.onSpawned()
            end
        end)
    end
    for i,v in next, _GetPlayers(Players) do
        if v ~= LocalPlayer then
            _TaskSpawn(Esp.applyEsp, v)
        end
    end
    Players.PlayerAdded:Connect(Esp.applyEsp)
    Players.PlayerRemoving:Connect(Esp.removeEsp)
    
    
    do --Visuals
        do --Camera
            RunService.RenderStepped:Connect(function()
                if not Utility.IsPlayerAlive(LocalPlayer.Character) then return end
                if Crosshairs.Scope.Visible ~= true then
                    camera.FieldOfView = Flags["Camera_FieldOfView"]
                end
            end)
        end
        Visuals.defaultlighting = { -- fuck it
            ["de_dust2"] = {
                Ambient = Color3.fromRGB(90, 74, 62),
                OutdoorAmbient = Color3.fromRGB(165, 156, 140),
                ClockTime = 13
            },
            ["de_seaside"] = {
                Ambient = Color3.fromRGB(211, 237, 255),
                OutdoorAmbient = Color3.fromRGB(180, 180, 180),
                ClockTime = 14
            },
            ["de_train"] = {
                Ambient = Color3.fromRGB(130, 118, 95),
                OutdoorAmbient = Color3.fromRGB(163, 161, 146),
                ClockTime = 9.5
            },
            ["de_mirage"] = {
                Ambient = Color3.fromRGB(214, 214, 214),
                OutdoorAmbient = Color3.fromRGB(165, 156, 140),
                ClockTime = 15
            },
            ["de_cache"] = {
                Ambient = Color3.fromRGB(214, 214, 214),
                OutdoorAmbient = Color3.fromRGB(165, 156, 140),
                ClockTime = 14
            },
            ["de_nuke"] = {
                Ambient = Color3.fromRGB(90, 74, 62),
                OutdoorAmbient = Color3.fromRGB(165, 156, 140),
                ClockTime = 13
            },
            ["de_vertigo"] = {
                Ambient = Color3.fromRGB(255, 255, 255),
                OutdoorAmbient = Color3.fromRGB(255, 255, 255),
                ClockTime = 15
            },
            ["de_inferno"] = {
                Ambient = Color3.fromRGB(130, 118, 95),
                OutdoorAmbient = Color3.fromRGB(163, 161, 146),
                ClockTime = 9.5
            },
            ["de_aztec"] = {
                Ambient = Color3.fromRGB(149, 175, 179),
                OutdoorAmbient = Color3.fromRGB(149, 159, 191),
                ClockTime = 15
            }
        }
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
        Visuals.crosshair = {}
        Visuals.crosshair.drawingObjects = {}
        Visuals.crosshair.drawingObjects.outlines = {}
        for i = 1, 4 do
            Visuals.crosshair.drawingObjects.outlines[i] = Esp.createDrawing("Line", {
                Thickness = 3,
                Color = Color3.fromRGB(0, 0, 0),
                Transparency = 1,
                Visible = true
            })
        end
        Visuals.crosshair.drawingObjects.objects = {}
        for i = 1, 4 do
            Visuals.crosshair.drawingObjects.objects[i] = Esp.createDrawing("Line", {
                Thickness = 1,
                Color = Color3.fromRGB(255, 255, 255),
                Transparency = 1,
                Visible = true
            })
        end
        Visuals.crosshair.currentaddedrotation = 0
        Visuals.crosshair.currentrotation = 0
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
        function Visuals.updateGUI(upTime, deltaTime)
            if Flags["Custom_Crosshair"] then
                local crosshairColor = Flags["Custom_Crosshair_Color1"]
                local crosshairTrans = 0
                local crosshairThickness = Flags["Crosshair_Thickness"]
                local crosshairOutline = Flags["Crosshair_Outlines"]

                for _, frame in next, LocalPlayer.PlayerGui.GUI.Crosshairs.Crosshair:GetChildren() do
                    if not frame:IsA("ImageLabel") then
                        frame.BackgroundTransparency = 1
                    end
                end

                local screenPos = camera.ViewportSize / 2

                for i, v in next, Visuals.crosshair.drawingObjects.objects do
                    v.Visible = Flags["Custom_Crosshair"]
                    v.Color = crosshairColor
                    v.Thickness = crosshairThickness
                    v.Transparency = LocalPlayer.PlayerGui.GUI.Crosshairs.Scope.Visible and 0 or 1 - crosshairTrans

                    local outline = Visuals.crosshair.drawingObjects.outlines[i]
                    outline.Visible = v.Visible and crosshairOutline or false
                    outline.Thickness = v.Thickness + 2
                end

                local baseWidth = Flags["Crosshair_Width"]
                local baseLength = Flags["Crosshair_Length"]
                local baseWidthGap = Flags["Crosshair_Width_Gap"]
                local baseLengthGap = Flags["Crosshair_Length_Gap"]
                local baseRotation = Flags["Crosshair_Rotation"]
                local baseRotationSpeed = Flags["Crosshair_Rotation_Speed"]

                local animEnabled = Flags["Impulse_Crosshair"]
                local minSpeed = Flags["Minimum_Speed"]
                local maxSpeed = Flags["Maximum_Speed"]
                local minScale = Flags["Minimum_Length"]
                local maxScale = Flags["Maximum_Length"]
                local cycleSpeed = Flags["Cycle_Speed"]

                local time = tick() * cycleSpeed
                local lerpFactor = (math.sin(time) + 1) / 2
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
                local animatedSpeed = animEnabled and (minSpeed + (maxSpeed - minSpeed) * lerpFactor) or baseRotationSpeed
                local animatedScale = animEnabled and (minScale + (maxScale - minScale) * lerpFactor) or 1
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
                local width = baseWidth * animatedScale
                local length = baseLength * animatedScale
                local widthgap = baseWidthGap * animatedScale
                local lengthgap = baseLengthGap * animatedScale

                Visuals.crosshair.currentaddedrotation += (animatedSpeed * deltaTime)
                Visuals.crosshair.currentrotation = math.rad(baseRotation + Visuals.crosshair.currentaddedrotation)

                local outlineOffset = 1

                local dir1 = _Vector2New(math.sin(Visuals.crosshair.currentrotation), math.cos(Visuals.crosshair.currentrotation))
                local from1 = dir1 * lengthgap
                local to1 = from1 + dir1 * length
                local outfrom1 = from1 - dir1.Unit * outlineOffset
                local outto1 = to1 + dir1.Unit * outlineOffset

                local dir2 = _Vector2New(math.sin(Visuals.crosshair.currentrotation + math.pi / 2), math.cos(Visuals.crosshair.currentrotation + math.pi / 2))
                local from2 = dir2 * widthgap
                local to2 = from2 + dir2 * width
                local outfrom2 = from2 - dir2.Unit * outlineOffset
                local outto2 = to2 + dir2.Unit * outlineOffset
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
                local a, a1 = Visuals.crosshair.drawingObjects.objects[1], Visuals.crosshair.drawingObjects.outlines[1]
                a.From = screenPos - from1
                a.To = screenPos - to1
                a1.From = screenPos - outfrom1
                a1.To = screenPos - outto1

                local b, b1 = Visuals.crosshair.drawingObjects.objects[2], Visuals.crosshair.drawingObjects.outlines[2]
                b.From = screenPos + from1
                b.To = screenPos + to1
                b1.From = screenPos + outfrom1
                b1.To = screenPos + outto1

                local c, c1 = Visuals.crosshair.drawingObjects.objects[3], Visuals.crosshair.drawingObjects.outlines[3]
                c.From = screenPos - from2
                c.To = screenPos - to2
                c1.From = screenPos - outfrom2
                c1.To = screenPos - outto2

                local d, d1 = Visuals.crosshair.drawingObjects.objects[4], Visuals.crosshair.drawingObjects.outlines[4]
                d.From = screenPos + from2
                d.To = screenPos + to2
                d1.From = screenPos + outfrom2
                d1.To = screenPos + outto2
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
            else
                for i, v in next, Visuals.crosshair.drawingObjects.objects do
                    v.Visible = false
                    Visuals.crosshair.drawingObjects.outlines[i].Visible = false
                end
            end
        end

	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --



        Visuals.updaterGUI = RunService.Stepped:Connect(Visuals.updateGUI)

        Toggles["Custom_Crosshair"]:OnChanged(function()
            if not Flags["Custom_Crosshair"] and not Flags["ThirdPerson_Enabled"] then
                for _, frame in next, LocalPlayer.PlayerGui.GUI.Crosshairs.Crosshair:GetChildren() do
                    if frame:IsA("ImageLabel") then else frame.BackgroundTransparency = 0 end
                end
            end
        end)
        	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
        local textures = {
            "rbxassetid://304777684",
            "rbxassetid://419625073"
        }

	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
        local model, handle, highlight = nil, nil, nil
        local angle, spin = 0, 0
        local lastAssetId = 0

        function Visuals.destroyAccessory()
 
            if model then
                pcall(function() model:Destroy() end)
                model = nil
            end
            if handle then
                pcall(function() handle:Destroy() end)
                handle = nil
            end
            highlight = nil
        end
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
        function Visuals.applyHighlight()
            if highlight then
                pcall(function() highlight:Destroy() end)
                highlight = nil
            end
            if not handle or not handle:IsA("BasePart") or not handle:IsDescendantOf(workspace) then return end

            local h = Instance.new("Highlight")
            h.Name = "AccessoryHighlight"
            h.Adornee = handle
            h.Enabled = Flags.Accessory_Highlight_Enabled
            h.FillColor = Flags.Accessory_Highlight_FillColor
            h.OutlineColor = Flags.Accessory_Highlight_OutlineColor
            h.FillTransparency = Flags.Accessory_Highlight_FillTransparency/10
            h.OutlineTransparency = Flags.Accessory_Highlight_OutlineTransparency/10
            h.Parent = handle

            highlight = h
        end
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
        function Visuals.loadAccessory()
            Visuals.destroyAccessory()
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
            local rawId = Flags.Accessory_ID
            local assetId = tonumber(rawId)
            if not assetId or assetId <= 0 then
                return
            end

            local success, asset = pcall(function()
                return game:GetObjects("rbxassetid://" .. assetId)[1]
            end)

            if not success or typeof(asset) ~= "Instance" then
                return
            end

            local part = asset:FindFirstChild("Handle", true)
            if not part or not part:IsA("BasePart") then
                return
            end

            part.Anchored = true
            part.CanCollide = false
            part.Transparency = 0
            part.Parent = workspace

            model = asset
            handle = part
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
            Visuals.applyHighlight()
        end
        	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
        RunService.RenderStepped:Connect(function(dt)
            local currentId = tonumber(Flags.Accessory_ID)
            if currentId ~= lastAssetId then
                lastAssetId = currentId or 0
                Visuals.loadAccessory()
            end

            if not Flags.Accessory_Enabled then
                if handle then handle.Transparency = 1 end
                if highlight then highlight.Enabled = false end
                return
            end

            if not handle or not handle:IsDescendantOf(workspace) then
                Visuals.loadAccessory()
                return
            end

            local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not root then return end

            handle.Transparency = 0

            if highlight then
                highlight.Enabled = Flags.Accessory_Highlight_Enabled
                highlight.FillColor = Flags.Accessory_Highlight_FillColor
                highlight.OutlineColor = Flags.Accessory_Highlight_OutlineColor
                highlight.FillTransparency = Flags.Accessory_Highlight_FillTransparency/10
                highlight.OutlineTransparency = Flags.Accessory_Highlight_OutlineTransparency/10
            end
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
            angle += Flags.Accessory_Rotation_Speed * dt
            spin += Flags.Accessory_Spin_Speed * dt

            local orbit = Vector3.new(
                math.cos(math.rad(angle)) * Flags.Accessory_Distance,
                Flags.Accessory_Height,
                math.sin(math.rad(angle)) * Flags.Accessory_Distance
            )

            handle.Position = root.Position + orbit
            handle.Orientation = Flags.Accessory_Spin_ItSelf and Vector3.new(0, spin % 360, 0) or Vector3.zero
        end)

	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
        local Bdm = _Instancenew("Part")
        Bdm.Anchored = true
        Bdm.Transparency = 1
        Bdm.Size = _Vector3New(100, 1, 100)
        Bdm.Parent = ScriptCacheFolder
        local Particles = _Instancenew("ParticleEmitter")
        Particles.Texture = "rbxassetid://304777684"
        Particles.Lifetime = NumberRange.new(Flags["Particles_LifeTime"])
        Particles.Rate = 300
        Particles.Speed = NumberRange.new(Flags["Particles_Speed"])
        Particles.EmissionDirection = "Bottom"
        Particles.LightInfluence = 25
        Particles.Size = _NumberSequenceNew({_NumberSequenceKeypointNew(0, 0.5), _NumberSequenceKeypointNew(1, 0.5)})
        Particles.Parent = Bdm
        RunService.RenderStepped:Connect(function()
            if Utility.IsPlayerAlive(LocalPlayer.Character) then
                Bdm.Position = workspace.CurrentCamera.CFrame.Position + _Vector3New(0, 40, 0)

                Particles.Enabled = Flags["Particles_Enabled"]
                Particles.Color = _ColorSequenceNew(Flags["Particles_Color"])
                if Flags["Particles_Texture"] == "Random" then
                    Particles.Texture = textures[_MathRandom(1, #textures)]
                elseif Flags["Particles_Texture"] == "Snow" then
                    Particles.Texture = "rbxassetid://304777684"
                else
                    Particles.Texture = "rbxassetid://419625073"
                end
                Particles.Lifetime = NumberRange.new(Flags["Particles_LifeTime"])
                Particles.Speed = NumberRange.new(Flags["Particles_Speed"])
            end
        end)
		    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
        _Instancenew("BloomEffect", camera)
        local customAtmosphere = _Instancenew("Atmosphere", Lighting)
        local updateWorldColorStop = _Tick()
        function Visuals.updateworldcolor()
            if _FindFirstChild(Lighting, "Atmosphere") then
                if Lighting.Atmosphere ~= customAtmosphere then
                    _Destroy(Lighting.Atmosphere)
                end
            end
            if _Tick() - updateWorldColorStop < 1/20 then
                return
            end
            updateWorldColorStop = _Tick()
            if Flags["Ambience_Enabled"] then
                Lighting.OutdoorAmbient = Flags["Ambience_Color"]
                Lighting.Ambient = Flags["Ambience_Color"]
            else
			    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
                if _FindFirstChild(workspace, "Map") and _FindFirstChild(workspace.Map, "Origin") then
                    if Visuals.defaultlighting[workspace.Map.Origin.Value] ~= nil then
                        for i, v in next, (Visuals.defaultlighting[workspace.Map.Origin.Value]) do
                            Lighting[i] = v
                        end
                    end
                else
                    Lighting.OutdoorAmbient = Color3.new(0.647059, 0.611765, 0.54902) 
                    Lighting.Ambient = Color3.new(0.509804, 0.462745, 0.372549) 
                end
            end
	    	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
            if Flags["Force_Time"] then
                Lighting.ClockTime = Flags["Force_TimeValue"]
            else
                Lighting.ClockTime = 9
            end
            if Flags["Custom_Saturation"] then
                camera.ColorCorrection.TintColor = Flags["Custom_SaturationColor"]
                camera.ColorCorrection.Saturation = Flags["Custom_SaturationValue"] / 100
            else
                camera.ColorCorrection.Saturation = 0
                camera.ColorCorrection.TintColor = Color3.new(1, 1, 1)
            end
            camera.Bloom.Enabled = Flags["Custom_Bloom"]
            if Flags["Custom_Bloom"] then
                camera.Bloom.Intensity = Flags["Custom_BloomIntensity"] / 100
                camera.Bloom.Size = Flags["Custom_BloomSize"] * 14 / 25
                camera.Bloom.Threshold = Flags["Custom_BloomThreshold"] / 400
            else
                camera.Bloom.Intensity = 0
                camera.Bloom.Size = 0
                camera.Bloom.Threshold = 0
            end
	    	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
            if Flags["Custom_Atmosphere"] then
                customAtmosphere.Color = Flags["Atmosphere_Color1"]
                customAtmosphere.Decay = Flags["Atmosphere_Color2"]
                customAtmosphere.Density = Flags["Custom_AtmosphereDensity"] / 100
                customAtmosphere.Glare = Flags["Custom_AtmosphereGlare"] / 10
                customAtmosphere.Haze = Flags["Custom_AtmosphereHaze"] / 10
            else
                customAtmosphere.Density = 0
                customAtmosphere.Glare = 0
                customAtmosphere.Haze = 0
            end
            --[[if Menu["Visuals"]["Misc"]["Custom Brightness"]["Toggle"]["Enabled"] then
                if Menu["Visuals"]["Misc"]["Brightness Mode"]["Value"] == "Fullbright" then
                    Lighting.Brightness = 1
                    Lighting.GlobalShadows = false
                else
                    Lighting.Brightness = 0
                end
            else
                Lighting.GlobalShadows = true
                Lighting.Brightness = 1 
            end]]
        end

        RunService.Stepped:Connect(Visuals.updateworldcolor)
    end
    do --Misc
        Misc.hitsound = _Instancenew("Sound", camera)
        Misc.olddamage = 0
        Misc.killsound = _Instancenew("Sound", camera)
        Misc.oldkills  = 0

        Misc.fakehrp = nil 
        Misc.realhrp = nil 
        Misc.lasthrpCf = _CFrameNew()
        Misc.hrpfix = nil
        Misc.lastreplicationtick  = _Tick()


        function Misc.setupfakehrp(char)
            local oldhrp = char:WaitForChild("HumanoidRootPart", 1/0)

            Misc.realhrp = oldhrp
            Misc.lasthrpCf = Misc.realhrp.CFrame
            Misc.fakehrp = _Clone(oldhrp) 
            
            Misc.realhrp.Name = "___"
            Misc.fakehrp.Name = "HumanoidRootPart"
            Misc.fakehrp.Parent = char
            cache.replace(Misc.realhrp, Misc.fakehrp)

            Misc.fakehrp.CFrame = Misc.lasthrpCf
            Misc.realhrp.CFrame = Misc.lasthrpCf
        end

        RunService.Stepped:Connect(function(delta)
            local char = LocalPlayer.Character
            if not Misc.realhrp or not Misc.fakehrp or not char then 
                return
            end
            Misc.realhrp.CFrame = Misc.lasthrpCf
            Misc.realhrp.AssemblyLinearVelocity = _Vector3New()
        end)

        function Misc.removefakehrp()
            if Misc.fakehrp == nil then return end
            Misc.fakehrp.Name = "___"
            Misc.realhrp.CFrame = Misc.fakehrp.CFrame 
            Misc.realhrp.Name = "HumanoidRootPart"
            _Destroy(Misc.fakehrp)
            Misc.fakehrp = nil
            Misc.realhrp = nil
        end
	--[[
        if LocalPlayer.Character then
            Misc.setupfakehrp(LocalPlayer.Character)
        end
        LocalPlayer.CharacterAdded:Connect(function()
            repeat _TaskWait() until LocalPlayer.Character and _FindFirstChild(LocalPlayer.Character, "Humanoid") and LocalPlayer.Character.Humanoid.Health > 0
            _TaskWait(.1)
            if LocalPlayer.Character and _FindFirstChild(LocalPlayer.Character, "HumanoidRootPart") then
                Misc.setupfakehrp(LocalPlayer.Character)
            end
        end)]]
        LocalPlayer.CharacterRemoving:Connect(Misc.removefakehrp)

        RunService.Stepped:Connect(function()
            local delayedcf

            if not Misc.fakehrp or not Misc.realhrp or not LocalPlayer.Character then
                return
            end
            local fakehrp = Misc.fakehrp
            if fakehrp then
                delayedcf = fakehrp.CFrame
                if Flags["AntiAim_Enabled"] and Flags["AntiAim_In_Gravity"] then
                    local velocity = fakehrp.Velocity.Magnitude
                    local baseSpin = _MathRad(Flags["AntiAim_In_Gravity_BaseSpin"]) 
                    local maxSpin = _MathRad(Flags["AntiAim_In_Gravity_MaximumSpin"]) 
                    local spinSpeed = Flags["AntiAim_In_Gravity_Speed"]
                    local speedFactor = _MathClamp(velocity / 16, 0, 1)
                    local t = _Tick()
                    local spinRange = baseSpin + (maxSpin - baseSpin) * speedFactor

                    local x = _MathSin(t * spinSpeed) * spinRange
                    local y = _MathCos(t * spinSpeed * 0.6) * spinRange
                    local z = _MathSin(t * spinSpeed * 0.3) * spinRange

                    local spinRotation = _CFrameAngles(x, y, z)
                    delayedcf = delayedcf * spinRotation
                end
                if Flags["AntiAim_СFrame_Manipulation"] then
                    delayedcf = delayedcf + _Vector3New(Flags["AntiAim_СFrame_Manipulation_X"], Flags["AntiAim_СFrame_Manipulation_Y"], Flags["AntiAim_СFrame_Manipulation_Z"])
                    delayedcf = delayedcf * _CFrameAngles(_MathRad(Flags["AntiAim_СFrame_Manipulation_X_Angles"]), _MathRad(Flags["AntiAim_СFrame_Manipulation_Y_Angles"]), _MathRad(Flags["AntiAim_СFrame_Manipulation_Z_Angles"]) )
                end 
                if Flags["FakeLags_Enabled"] then
                    _TaskWait(Flags["FakeLags_Ticks"]/1000)
                    local limit = Flags["FakeLags_Limit"] / 64
                    local timesincelastrefresh = _Tick() - Misc.lastreplicationtick
                    if timesincelastrefresh < limit then
                        return
                    end
                end
                if Flags["FakeLags_PreventReplication"] then return end
                Misc.lasthrpCf = delayedcf
                Misc.lastreplicationtick = _Tick()
            end

            if _FindFirstChild(LocalPlayer.Character, "HeadHB") and _FindFirstChild(LocalPlayer.Character, "FakeHead") then
                if not _FindFirstChild(LocalPlayer.Character.HeadHB,"Weld") and not _FindFirstChild(LocalPlayer.Character.FakeHead, "Weld") then
                    LocalPlayer.Character.FakeHead.AssemblyLinearVelocity = _Vector3New(0, 0, 0)
                    LocalPlayer.Character.HeadHB.AssemblyLinearVelocity = _Vector3New(0, 0, 0)

                    LocalPlayer.Character.FakeHead.CFrame = LocalPlayer.Character.Head.CFrame
                    LocalPlayer.Character.HeadHB.CFrame = LocalPlayer.Character.Head.CFrame
                end
            end
        end)
        RunService.Heartbeat:Connect(function()
            if Flags["Inf_Ammo"] then 
                LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Text = 'ShitCheat'
                LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Text = 'NIGGER'
                LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = _Color3FromRGB(255, 165, 0)
                Cache.Client.vars.ammocount = 999999
                Cache.Client.vars.primarystored = 999999
                Cache.Client.vars.ammocount2 = 999999
                Cache.Client.vars.secondarystored = 999999
            end

        end)
		    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
        function Misc.hitplayer()
            if LocalPlayer.Additionals.TotalDamage.Value > Misc.olddamage then
                if Flags["HitSounds_Enabled"] then
                    local hitsoundID = Flags["HitSounds_Ids"]
                    if hitsoundID == 'Skeet' then
                        hitsoundID = '5447626464'
                    elseif hitsoundID == 'Overwatch' then
                        hitsoundID = '18410058858'
                    elseif hitsoundID == 'Rust' then
                        hitsoundID = '5043539486'
                    elseif hitsoundID == 'Minecraft' then
                        hitsoundID = '7273736372'
                    elseif hitsoundID == 'Minecraft XP' then
                        hitsoundID = '1053296915'
                    elseif hitsoundID == 'Retro loud' then
                        hitsoundID = '3976061026'
                    elseif hitsoundID == 'Matchine gun' then
                        hitsoundID = '17705555617'
                    elseif hitsoundID == 'Ray' then
                        hitsoundID = '131179973'
                    elseif hitsoundID == 'Cod' then
                        hitsoundID = '160432334'
                    elseif hitsoundID == 'Beautiful' then
                        hitsoundID = '5709456554'
                    elseif hitsoundID == 'Killingspree' then
                        hitsoundID = '937898383'
                    elseif hitsoundID == 'Squash' then
                        hitsoundID = '3466981613'
                    elseif hitsoundID == 'Supersmash' then
                        hitsoundID = '2039907664'
                    elseif hitsoundID == 'CSGO' then
                        hitsoundID = '7269900245'
                    elseif hitsoundID == 'Slap' then
                        hitsoundID = '4888372697'
                    elseif hitsoundID == 'MCOOF' then
                        hitsoundID = '5869422451'
                    elseif hitsoundID == 'Quek' then
                        hitsoundID = '4868633804'
                    elseif hitsoundID == 'Epic' then
                        hitsoundID = '7344303740'
                    elseif hitsoundID == 'Osu' then
                        hitsoundID = '7149919358'
                    elseif hitsoundID == 'TF2 Pan' then
                        hitsoundID = '3431749479'
                    elseif hitsoundID == '1' then
                        hitsoundID = '7349055654'
                    elseif hitsoundID == 'Godlike' then
				    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
                        hitsoundID = '7463103082'
                    elseif hitsoundID == 'Ownage' then
                        hitsoundID = '6887181639'
                    elseif hitsoundID == 'Ultrakill' then
                        hitsoundID = '937885646'
                    elseif hitsoundID == 'Win' then
                        hitsoundID = '341542437'
                    elseif hitsoundID == 'Denied' then
                        hitsoundID = '7356986865'
                    elseif hitsoundID == 'Lessgo' then
                        hitsoundID = '6782594987'
                    elseif hitsoundID == 'Headshot' then
                        hitsoundID = '5764885927'
                    elseif hitsoundID == 'Bruh' then
                        hitsoundID = '535690488'
                    elseif hitsoundID == 'Bag' then
                        hitsoundID = '364942410'
                    elseif hitsoundID == 'Baimware' then
                        hitsoundID = '6607339542'
                    elseif hitsoundID == 'Neverlose' then
                        hitsoundID = '6607204501'
                    elseif hitsoundID == 'Pop' then
                        hitsoundID = '105543133746827'
                    elseif hitsoundID == 'Space' then
                        hitsoundID = '3466982899'
                    elseif hitsoundID == 'Electro' then
                        hitsoundID = '3458224686'
                    elseif hitsoundID == 'TF2' then
                        hitsoundID = '3455144981'
                    elseif hitsoundID == 'Percussion' then
                        hitsoundID = '3466985670'
                    elseif hitsoundID == 'Osu Mint' then
                        hitsoundID = '81883450827543'
                    elseif hitsoundID == 'Rocket' then
                        hitsoundID = '9087976483'
                    elseif hitsoundID == 'Vine Boom' then
                        hitsoundID = '9088081730'
                    elseif hitsoundID == 'Snap' then
                        hitsoundID = '93172144688075'
                    elseif hitsoundID == 'Vortex' then
                        hitsoundID = '3466980212'
                    elseif hitsoundID == 'Pow' then
                        hitsoundID = '3516546035'
                    elseif hitsoundID == 'Bell' then
                        hitsoundID = '97724019712141'
                    elseif hitsoundID == 'Retro' then
                        hitsoundID = '3466984142'
                    elseif hitsoundID == 'Fatality' then
                        hitsoundID = '115982072912004'
                    elseif hitsoundID == 'Beepo' then
                        hitsoundID = '3466987025'
                    end
                    Misc.hitsound.SoundId = "rbxassetid://" .. hitsoundID
                    Misc.hitsound.Volume = Flags["HitSounds_Volume"] / 10
                    Misc.hitsound:Play()
                end
            end
            Misc.olddamage = LocalPlayer.Additionals.TotalDamage.Value
        end
        LocalPlayer.Additionals.TotalDamage.Changed:Connect(Misc.hitplayer)
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
       function Misc.killplayer()
            if LocalPlayer.Status.Kills.Value > Misc.oldkills then
                if Flags["KillSounds_Enabled"] then
                    local killsoundID = Flags["KillSounds_Ids"]
                    if killsoundID == 'Skeet' then
                        killsoundID = '5447626464'
                    elseif killsoundID == 'Overwatch' then
                        killsoundID = '18410058858'
                    elseif killsoundID == 'Rust' then
                        killsoundID = '5043539486'
                    elseif killsoundID == 'Monster kill' then
                        killsoundID = '130772284'
                    elseif killsoundID == 'Minecraft' then
                        killsoundID = '7273736372'
                    elseif killsoundID == 'Minecraft XP' then
                        killsoundID = '1053296915'
                    elseif killsoundID == 'Retro loud' then
                        killsoundID = '3976061026'
                    elseif killsoundID == 'Matchine gun' then
                        killsoundID = '17705555617'
                    elseif killsoundID == 'Ray' then
                        killsoundID = '131179973'
                    elseif killsoundID == 'Cod' then
                        killsoundID = '160432334'
                    elseif killsoundID == 'Beautiful' then
                        killsoundID = '5709456554'
                    elseif killsoundID == 'Killingspree' then
                        killsoundID = '937898383'
                    elseif killsoundID == 'Squash' then
                        killsoundID = '3466981613'
                    elseif killsoundID == 'Supersmash' then
                        killsoundID = '2039907664'
                    elseif killsoundID == 'CSGO' then
                        killsoundID = '7269900245'
                    elseif killsoundID == 'Slap' then
                        killsoundID = '4888372697'
                    elseif killsoundID == 'MCOOF' then
                        killsoundID = '5869422451'
                    elseif killsoundID == 'Quek' then
                        killsoundID = '4868633804'
                    elseif killsoundID == 'Epic' then
                        killsoundID = '7344303740'
                    elseif killsoundID == 'Osu' then
                        killsoundID = '7149919358'
                    elseif killsoundID == 'TF2 Pan' then
                        killsoundID = '3431749479'
                    elseif killsoundID == '1' then
                        killsoundID = '7349055654'
                    elseif killsoundID == 'Godlike' then
                        killsoundID = '7463103082'
                    elseif killsoundID == 'Ownage' then
                        killsoundID = '6887181639'
                    elseif killsoundID == 'Ultrakill' then
                        killsoundID = '937885646'
                    elseif killsoundID == 'Win' then
                        killsoundID = '341542437'
                    elseif killsoundID == 'Denied' then
                        killsoundID = '7356986865'
                    elseif killsoundID == 'Lessgo' then
                        killsoundID = '6782594987'
                    elseif killsoundID == 'Headshot' then
                        killsoundID = '5764885927'
                    elseif killsoundID == 'Bruh' then
                        killsoundID = '535690488'
                    elseif killsoundID == 'Bag' then
                        killsoundID = '364942410'
                    elseif killsoundID == 'Baimware' then
                        killsoundID = '6607339542'
                    elseif killsoundID == 'Neverlose' then
                        killsoundID = '6607204501'
                    elseif killsoundID == 'Pop' then
                        killsoundID = '105543133746827'
                    elseif killsoundID == 'Space' then
                        killsoundID = '3466982899'
                    elseif killsoundID == 'Electro' then
                        killsoundID = '3458224686'
                    elseif killsoundID == 'TF2' then
                        killsoundID = '3455144981'
                    elseif killsoundID == 'Percussion' then
                        killsoundID = '3466985670'
                    elseif killsoundID == 'Osu Mint' then
                        killsoundID = '81883450827543'
                    elseif killsoundID == 'Rocket' then
                        killsoundID = '9087976483'
                    elseif killsoundID == 'Vine Boom' then
                        killsoundID = '9088081730'
                    elseif killsoundID == 'Snap' then
                        killsoundID = '93172144688075'
                    elseif killsoundID == 'Vortex' then
                        killsoundID = '3466980212'
                    elseif killsoundID == 'Pow' then
                        killsoundID = '3516546035'
                    elseif killsoundID == 'Bell' then
                        killsoundID = '97724019712141'
                    elseif killsoundID == 'Retro' then
                        killsoundID = '3466984142'
                    elseif killsoundID == 'Fatality' then
                        killsoundID = '115982072912004'
                    elseif killsoundID == 'Beepo' then
                        killsoundID = '3466987025'
                    end
                    Misc.killsound.SoundId = "rbxassetid://" .. killsoundID
                    Misc.killsound.Volume = Flags["KillSounds_Volume"] / 10
                    Misc.killsound:Play()
                end
            end
		    Misc.oldkills = localPlayer.Status.Kills.Value
        end
	    LocalPlayer.Status.Kills.Changed:Connect(Misc.killplayer)
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
        
        function Misc.GiveSecondaryWeapon(name)
            Cache.Client.special2 = false
            Cache.Client.special = false
            Cache.Client.secondary = name
            Cache.Client.secondaryowner = LocalPlayer.Name
            Cache.Client.secondaryskin = "Stock"
            Cache.Client.secondarystattrak = nil
            Cache.Client.vars.ammocount2 = math.huge
            Cache.Client.vars.secondarystored = math.huge

            Cache.Client.equipped = "secondary"
            Cache.Client.gun = game.ReplicatedStorage.Weapons[Cache.Client.secondary]
            Cache.Client.fgun = game.ReplicatedStorage.Weapons[Cache.Client.secondary]

            Cache.Client.changeto(2)
            Cache.Client.updateInventory()
            Cache.Client.usethatgun(Cache.Client.secondaryowner)
        end
		    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
        function Misc.GivePrimaryWeapon(name)
            Cache.Client.special = false
            Cache.Client.realgun = name
            Cache.Client.primary = name
            Cache.Client.primaryowner = LocalPlayer.Name
            
            Cache.Client.primaryskin = "Stock"
            Cache.Client.primarystattrak = nil
            Cache.Client.vars.ammocount1 = math.huge
            Cache.Client.vars.primarystored = math.huge
            Cache.Client.equipped = "primary"
            Cache.Client.gun = game.ReplicatedStorage.Weapons[Cache.Client.primary]
            Cache.Client.fgun = game.ReplicatedStorage.Weapons[Cache.Client.primary]
            Cache.Client.changeto(1)
            Cache.Client.updateInventory()
            Cache.Client.usethatgun(Cache.Client.primaryowner)
        end
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
        function Misc.CreateGunModel(GunName)
            local gun = replicatedStorage.Weapons[GunName]
            local weaponinhand = gun.Model:clone()
            weaponinhand.Parent = LocalPlayer.Character
            local gunweld = _Instancenew("Motor6D")
            gunweld.Parent = weaponinhand
            gunweld.Part0 = LocalPlayer.Character["RightHand"]
            gunweld.Part1 = weaponinhand
            gunweld.Name = "GunWeld"
            weaponinhand.Name = "Gun"
            if gun.Name == "DualBerettas" then
                local weaponinhand2 = gun.Model2:clone()
                weaponinhand2.Parent = LocalPlayer.Character
                local gunweld = _Instancenew("Motor6D")
                gunweld.Parent = weaponinhand2
                gunweld.Part0 = LocalPlayer.Character["LeftHand"]
                gunweld.Part1 = weaponinhand2
                gunweld.Name = "GunWeld"
                weaponinhand2.Name = "Gun2"
            end
            local string = _Instancenew("StringValue")
            string.Parent = weaponinhand
            string.Name = "AnimateValue"
            if gun.Name == "MP7" then
                gunweld.C0 = _CFrameNew(0.15, 0, 0.15)
            end
            if gun.Name == "Negev" then
                gunweld.C0 = _CFrameNew(-0.15, 0, 0.3)
            end
            if gun.Name == "Bizon" then
                gunweld.C0 = _CFrameNew(0.3, -0.45, 0.15) * _CFrameAngles(_MathRad(-45), _MathRad(50), _MathRad(200))
            end
            if gun.Name == "T Knife" or gun.Name == "CT Knife" then
                gunweld.C1 = _CFrameAngles(0, 0, _MathRad(180))
            end
            if gun.Name == "Scout" or gun.Name == "AWP" or gun.Name == "G3SG1" then
                gunweld.Part0 = LocalPlayer.Character["LeftHand"]
                gunweld.C0 = _CFrameNew(0.5, -0.6, -0.5) * _CFrameAngles(_MathRad(155), _MathRad(0), _MathRad(-75))
            end
        end
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
        RunService.RenderStepped:Connect(function()
            if not Utility.IsPlayerAlive(LocalPlayer.Character) then return end
            local SecondaryToGive = Flags["Spawn_Weapons_Secondary"]
            local PrimaryToGive = Flags["Spawn_Weapons_Primary"]

            if PrimaryToGive  then
                if PrimaryToGive ~= Cache.Client.primary and Flags["Spawn_Weapons"] then
                    Misc.GivePrimaryWeapon(PrimaryToGive)
                end
                if Cache.Client.equipped == "primary" and not _FindFirstChild(LocalPlayer.Character, "Gun") and Flags["Spawn_Weapons"] then
                    Misc.CreateGunModel(PrimaryToGive)
                elseif _FindFirstChild(LocalPlayer.Character, "Gun") and not Cache.Client.equipped == "primary" then
                    _Destroy(_FindFirstChild(LocalPlayer.Character, "Gun"))
                end
            end
            if SecondaryToGive then
                if SecondaryToGive ~= Cache.Client.secondary and Flags["Spawn_Weapons"] then
                    Misc.GiveSecondaryWeapon(SecondaryToGive)
                end
                if Cache.Client.equipped == "secondary" and not _FindFirstChild(LocalPlayer.Character, "Gun") and Flags["Spawn_Weapons"] then
                    Misc.CreateGunModel(SecondaryToGive)
                elseif _FindFirstChild(LocalPlayer.Character, "Gun") and not Cache.Client.equipped == "secondary" then
                    _Destroy(_FindFirstChild(LocalPlayer.Character, "Gun"))
                end
            end
        end)

        local ActiveTweens = {}

        local function ToggleTweenPlayback(tween, isVisible)
            if not tween or not tween.PlaybackState then return end
            if isVisible and tween.PlaybackState == Enum.PlaybackState.Playing then
                tween:Pause()
            elseif not isVisible and tween.PlaybackState == Enum.PlaybackState.Paused then
                tween:Play()
            end
        end

        local function StartFadeOut(label)
            if not label or ActiveTweens[label] then return end

            ActiveTweens[label] = {}
            local fadeTween = TweenService:Create(label, TweenInfo.new(1), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            })

            local connections = ActiveTweens[label]

            table.insert(connections, ChatUI.GlobalChat:GetPropertyChangedSignal("Visible"):Connect(function()
                ToggleTweenPlayback(fadeTween, ChatUI.GlobalChat.Visible)
            end))

            table.insert(connections, ChatUI.TeamChat:GetPropertyChangedSignal("Visible"):Connect(function()
                ToggleTweenPlayback(fadeTween, ChatUI.TeamChat.Visible)
            end))

            table.insert(connections, fadeTween:GetPropertyChangedSignal("PlaybackState"):Connect(function()
                if fadeTween.PlaybackState == Enum.PlaybackState.Completed then
                    for _, conn in ipairs(connections) do
                        conn:Disconnect()
                    end
                    ActiveTweens[label] = nil
                end
            end))

            fadeTween:Play()
        end

        local function ShiftChatLines()
            for _, child in ipairs(ChatFrame:GetChildren()) do
                if child:IsA("TextLabel") and child.Name:sub(1, 4) == "Line" then
                    local index = tonumber(child.Name:sub(5))
                    if index then
                        local newIndex = index + 1
                        child.Name = "Line" .. newIndex
                        child.LayoutOrder = -newIndex
                        if newIndex >= 37 then
                            ActiveTweens[child] = nil
                            child:Destroy()
                        end
                    end
                end
            end

            local layout = ChatFrame:FindFirstChildWhichIsA("UIListLayout")
            if layout then
                local contentHeight = layout.AbsoluteContentSize.Y
                local scrollAmount = math.max(0, contentHeight - ChatFrame.AbsoluteSize.Y)
                ChatFrame.CanvasSize = UDim2.new(0, 0, 0, contentHeight)
                if scrollAmount - ChatFrame.CanvasPosition.Y < 50 then
                    ChatFrame.CanvasPosition = Vector2.new(0, scrollAmount)
                end
            end
        end

        local function MeasureTextHeight(text, width, font, size)
            local tempLabel = Instance.new("TextLabel")
            tempLabel.Size = UDim2.new(0, width, 0, 1000)
            tempLabel.TextWrapped = true
            tempLabel.RichText = true
            tempLabel.Font = font
            tempLabel.TextSize = size
            tempLabel.Text = text
            tempLabel.Parent = ChatFrame

            local height = math.ceil(tempLabel.TextBounds.Y) + 4
            tempLabel:Destroy()
            return height
        end

        local function AddMessage(name, message, nameColor, textColor, tags, tagColors)
            ShiftChatLines()

            local label = Instance.new("TextLabel")
            label.Name = "Line1"
            label.BackgroundTransparency = 1
            label.BorderSizePixel = 0
            label.TextWrapped = true
            label.RichText = true
            label.Font = Enum.Font.ArialBold
            label.TextSize = 14
            label.AutomaticSize = Enum.AutomaticSize.Y
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.TextYAlignment = Enum.TextYAlignment.Top
            label.TextColor3 = textColor
            label.TextStrokeColor3 = Color3.new(0, 0, 0)
            label.TextStrokeTransparency = 0
            label.Parent = ChatFrame

            local content = ""

            for i, tag in ipairs(tags) do
                local color = tagColors[i]
                local hex = string.format("#%02X%02X%02X", color.R * 255, color.G * 255, color.B * 255)
                content = content .. string.format("<font color=\"%s\">%s</font> ", hex, tag)
            end

            if name then
                local hex = string.format("#%02X%02X%02X", nameColor.R * 255, nameColor.G * 255, nameColor.B * 255)
                content = content .. string.format("<font color=\"%s\">%s</font>: ", hex, name)
            end

            content = content .. message
            label.Text = content

            local height = MeasureTextHeight(content, 493, label.Font, label.TextSize)
            label.Size = UDim2.new(0, 493, 0, height)
            label.LayoutOrder = 0

            task.delay(15, StartFadeOut, label)
            return label
        end
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
        local function HandlePlayerChat(player, message, isTeam, isRadio)
            local status = player:FindFirstChild("Status")
            if not status then return end

            local team = status:FindFirstChild("Team") and status.Team.Value
            local alive = status:FindFirstChild("Alive") and status.Alive.Value
            local myTeam = LocalPlayer.Status.Team.Value
            local myAlive = LocalPlayer.Status.Alive.Value

            local isSpectator = team == "Spectator"
            local amSpectator = myTeam == "Spectator"
            local isCompetitive = replicatedStorage.gametype.Value == "competitive"
            local isVisible = isTeam or isRadio or (alive and (player == LocalPlayer or alive)) or (isCompetitive or not myAlive)

            if not Flags["Chat_Dead"] and not isVisible then return end

            local colorSettings = ChatUI.Color
            local tags, tagColors = {}, {}

            if isTeam and not isRadio then
                table.insert(tags, "(TEAM)")
                table.insert(tagColors, colorSettings.TeamValueColor.Value)
            end
            if not alive and not isSpectator then
                table.insert(tags, "*DEAD*")
                table.insert(tagColors, colorSettings.DeadColor.Value)
            end
            if isSpectator then
                table.insert(tags, "(SPECTATOR)")
                table.insert(tagColors, colorSettings.SpectatorColor.Value)
            end
            if isRadio then
                table.insert(tags, "*RADIO*")
                table.insert(tagColors, Color3.fromRGB(80, 120, 120))
            end

            local nameColor = team == "T" and BrickColor.new("Bright yellow").Color
                or team == "CT" and BrickColor.new("Bright blue").Color
                or Color3.new(1, 1, 1)

            if ChatUI.Visible then
                ShiftChatLines()
                AddMessage(player.Name, message, nameColor, Color3.new(1, 1, 1), tags, tagColors)
            end
        end

        Events.PlayerChatted.OnClientEvent:Connect(function(senderName, message, isTeam, isRadio)
            local sender = Players:FindFirstChild(senderName)
            if sender then
                HandlePlayerChat(sender, message, isTeam, isRadio)
            end
        end)

        Events.SendMsg.OnClientEvent:Connect(function(message, color)
            if message and typeof(message) == "string" and message ~= "" then
                if not (message:find(" has joined the server.") and message:find(LocalPlayer.Name)) then
                    ShiftChatLines()
                    AddMessage(nil, message, nil, color or Color3.new(1, 1, 1), {}, {})
                end
            end
        end)
        
        LocalPlayer.CharacterAdded:Connect(function(char) 
            repeat
                task.wait(1.8)
            until char:FindFirstChild("Gun") 
            SelfObj = {} 
            if Flags["Character_Changer"]  then 
                if Flags["Character_Changer_Character"] == "Custom" then
                    ChangeCharacterToUserIdAvatar(Flags["Character_Changer_Character_Custom"])
                else
                    ChangeCharacter(ChrModels:FindFirstChild(Flags["Character_Changer_Character"]))
                end
            end 
        end) 
        workspace.ChildAdded:Connect(function(obj)
            if obj.Name == "Map" then
                wait(5)
                if Flags["Remove_Killers"] then
					if workspace.Map:FindFirstChild("Clips") and workspace.Map:FindFirstChild("Killers") then
						for _,v in pairs(workspace.Map.Clips:GetChildren()) do
							v:Destroy()
						end
						for _,v in pairs(workspace.Map.Killers:GetChildren()) do
							v:Destroy()
						end
					end
                end
            end
        end)
    end
end



do -- Hooks
    local fakeanim = _Instancenew("Animation")
    fakeanim.AnimationId = "rbxassetid://0"
    local oldNamecall; oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local args = {...}
        local method = getnamecallmethod()
        if method == "FireServer" then
            if self.Name == Events.ControlTurn.Name then
                local pitchMode = Flags["AntiAim_Pitch"]
                local extend = Flags["AntiAim_ExtendPitch"]
                if Flags["AntiAim_Enabled"] then
                    local angle = 0
                    if pitchMode == "None" then
                        angle = args[1]
                    elseif pitchMode == "Upwards" then
                        angle = 1
                    elseif pitchMode == "Downwards" then
                        angle = -1
                    elseif pitchMode == "Zero" then
                        angle = 0
                    elseif pitchMode == "Glitch" then
                        angle = 0/0
                    elseif pitchMode == "Random" then
                        angle = _MathRandom(-10, 10) / 10
                    end
                    args[1] = angle
                    return oldNamecall(self, _TableUnpack(args))
                end
            elseif self.Name == "ReplicateCameraUDP" and Flags["Anti_Camera_Resolver"] then
                args[1] = _CFrameNew()
                return oldNamecall(self, _TableUnpack(args))
            elseif self.Name == HitPart.Name then
                local a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26 = ...
                if not Flags["KillAll_Enabled"] then 
                    _TaskSpawn(function()
                        if Flags["BulletTracerEnabled"] then
                            local hitpos = RageBot.Target.TargetPosition ~= nil and  RageBot.Target.TargetPosition or Utility.DecryptPosition(a2)
                            local origin = RageBot.Target.Origin ~= nil and RageBot.Target.Origin or LocalPlayer.Character.Gun.Flash.Position
                            if _FindFirstChild(LocalPlayer.Character.Gun, "Flash") then
                                Utility.CreateTracer(hitpos, origin, Flags["BulletTracerColor"], Options["BulletTracerColor"].Transparency, Flags["BulletTracerWidth"], Flags["BulletTracerLifetime"], Flags["BulletTracerTexture"], Flags["BulletTracerTextureLength"], Flags["BulletTracerTextureSpeed"], Flags["BulletTracerFaceCamera"], Flags["BulletTracerLightEmission"], Flags["BulletTracerLightInfluence"], Flags["BulletTracerBrightness"], Flags["BulletTracerSecondBeam"], Flags["BulletTracerSecondBeamColor"], Options["BulletTracerSecondBeamColor"].Transparency)
                            end
                        end
                        if Flags["BulletImpactEnabled"] then
                            local hitplayer = _GetPlayerFromCharacter(Players, a1.Parent)
                            local hitpos = RageBot.Target.TargetPosition ~= nil and  RageBot.Target.TargetPosition or Utility.DecryptPosition(a2)
                            if hitplayer and PlayerModule.storage[hitplayer].enemy then
                                Utility.CreateImpact(hitpos,a1,Flags["BulletImpactColor2"],Options["BulletImpactColor"].Transparency,Flags["BulletImpactMaterial"],Flags["BulletImpactSize"],Flags["BulletImpactLifetime"])
                            else
                                Utility.CreateImpact(hitpos,a1,Flags["BulletImpactColor"],Options["BulletImpactColor"].Transparency,Flags["BulletImpactMaterial"],Flags["BulletImpactSize"],Flags["BulletImpactLifetime"])
                            end
                            
                            
                        end
                    end)
                    if Flags["Damage_Modifier"] then
                        a7 = Flags["Damage_ModifierValue"]
                    end
                end
                oldNamecall(self, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26)
                if Flags["Break_Aura"] then
                    oldNamecall(self, a1, a2, "Multimeter", a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26)
                end
                return
            end
        elseif method == "FindPartOnRayWithIgnoreList" then 
            local passed = false
            for i, v in next, args[2] do
                if v.ClassName == "Accessory" then
                    passed = true
                end
            end
            if passed then
                if Flags["Remove_Spread"] and not _FindFirstChild(Cache.Client.fgun, "Melee") then
                    args[1] = _RayNew(camera.CFrame.p, camera.CFrame.lookVector * Cache.Client.gun.Range.Value * 0.0625)
                end
                local enterParam = _RaycastParamsNew()
                enterParam.FilterType = Enum.RaycastFilterType.Blacklist
                enterParam.IgnoreWater = true
                enterParam.FilterDescendantsInstances = args[2]
                local resultOfDepressionAndLonliness = workspaceRaycast(workspace, args[1].Origin, args[1].Direction, enterParam)
                return resultOfDepressionAndLonliness and resultOfDepressionAndLonliness.Instance or nil, resultOfDepressionAndLonliness and resultOfDepressionAndLonliness.Position or (args[1].Origin + args[1].Direction), resultOfDepressionAndLonliness and resultOfDepressionAndLonliness.Normal or _Vector3New(), resultOfDepressionAndLonliness and resultOfDepressionAndLonliness.Material or nil										
            end
	    	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
        elseif method == "SetPrimaryPartCFrame" then
            local arms = args[1]
            if self.Name == "Arms" and LocalPlayer.Character then
                if Flags["ViewModel"] then 
                    arms = arms * _CFrameAngles(_MathRad(Flags["ViewModel_X"]-180), _MathRad(Flags["ViewModel_Y"]-180), _MathRad(Flags["ViewModel_Z"]-180))
                    arms = arms * _CFrameNew(_Vector3New(_MathRad(Flags["ViewModel_X1"]-180),_MathRad(Flags["ViewModel_Y2"]-180),_MathRad(Flags["ViewModel_Z3"]-180))) 
                
                end
                if Flags["ThirdPerson_RemoveArms"] and Flags["ThirdPerson_Enabled"] then
                    arms = arms * _CFrameNew(11212121210000, 1001212121200, 1012121212000)
                end
                if Flags["RageBot_AtTargets"] and RageBot.Target.TargetPosition then
                    arms = _CFrameLookAt(arms.Position, RageBot.Target.TargetPosition)
                end

            end
            return oldNamecall(self, arms, _Select(2, ...))
        elseif method == "LoadAnimation" then
            if Flags["Movement_SlideWalk"] and (args[1].Name == "RunAnim" or args[1].Name == "JumpAnim") then
                args[1] = fakeanim
                return oldNamecall(self, _TableUnpack(args))
            end
        end
        return oldNamecall(self, ...)
    end)
    
    local oldIndex; oldIndex = hookmetamethod(game, "__index", function(self, k)
        if k == "Velocity" and self.Parent == LocalPlayer.Character and Misc.fakehrp then
            return oldIndex(Misc.fakehrp, k)
        end
        return oldIndex(self, k)
    end)
    local oldNIndex; oldNIndex = hookmetamethod(game, "__newindex", function(self, k, v)
        if self == workspace.CurrentCamera and k == "CFrame" then
            if Flags["Remove_Recoil"] and tostring(getcallingscript()) == "Client"  then
                return
            end
        end
        if Flags["Remove_Scope"] and self.Name == "Blur" and self.Parent.Name == "Scope" then
            v = 0
        end
        return oldNIndex(self, k, v)
    end)
    local visualizeshit = require(game.ReplicatedStorage.VisualizeModule)
    local createtrailcloned = visualizeshit.createtrail

	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
    visualizeshit.createtrail = function(p1, p2, p3)
        local originPos = p1.Position

        local character = LocalPlayer.Character
        local hrp   = character and character:FindFirstChild("HumanoidRootPart")
        if not (character and hrp) then
            return createtrailcloned(p1, p2, p3)  
        end

        if originPos then
            local distance = (originPos - camera.CFrame.Position).Magnitude
            if distance <= 15 then
    
            else
                if Flags["BulletTracerEnemyEnabled"] then
                    Utility.CreateTracer(p2,  originPos, Flags["BulletTracerColor1"], Options["BulletTracerColor1"].Transparency, Flags["BulletTracerWidth"], Flags["BulletTracerLifetime"], Flags["BulletTracerTexture"], Flags["BulletTracerTextureLength"], Flags["BulletTracerTextureSpeed"], Flags["BulletTracerFaceCamera"], Flags["BulletTracerLightEmission"], Flags["BulletTracerLightInfluence"], Flags["BulletTracerBrightness"], Flags["BulletTracerSecondBeam"], Flags["BulletTracerSecondBeamColor"], Options["BulletTracerSecondBeamColor"].Transparency)
                end
            end
        end

        return createtrailcloned(p1, p2, p3)
    end
end
	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
do  -- Signals !
    RunService.RenderStepped:Connect(function()
        if (_Tick()-Watermark["RefreshRate"]) >= 1 then
            Watermark["Fps"] = Watermark["StoredFps"]
            Watermark["StoredFps"] = 0
            Watermark["RefreshRate"] = _Tick()     
        end 
        Watermark["StoredFps"] = Watermark["StoredFps"] + 1
        Watermark["Delta"] = dlt  
        _Pcall(function()
            Watermark["Ping"] = _GetValue(Stats.Network.ServerStatsItem["Data Ping"])
        end)
    end)
    	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --	    	    --
		    	    --
			    	    --
				    	    --
    RunService.PreRender:Connect(function()
        if Flags["Watermark"] then
            local sec,min,hrs = _OsDate("*t",_OsTime())["sec"],_OsDate("*t",_OsTime())["min"],_OsDate("*t",_OsTime())["hour"]
            local seconds = _StringLen(sec) == 2 and sec or "0"..sec
            local minutes = _StringLen(min) == 2 and min or "0"..min
            local hours = _StringLen(hrs) == 2 and hrs or "0"..hrs
            
            local daysOfWeek = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" }
            local monthsOfYear = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" }
            local currentTime = _OsDate("*t")
            local dayOfWeek = daysOfWeek[currentTime.wday]
            local month = monthsOfYear[currentTime.month]
            local day = currentTime.day
            local dateStr = dayOfWeek..",  "..month.." "..day
            
            local hex = "#".._StringUpper(_tostring(_ToHex(Library.AccentColor)))
            local hex2 = "#".._StringUpper(_tostring(_ToHex(Library.FontColor)))
            local hex3 = "#".._StringUpper(_tostring(_ToHex(Library.OutlineColor))) 
    
            local fps = _tostring(_MathFloor(Watermark["Fps"]))
            local ping2 = _tostring(_MathFloor(Watermark["Ping"]))
            local Time = hours..":"..minutes
            local Date = dayOfWeek..", "..month.." "..day
            local versionColor = "#".._StringUpper(_tostring(_ToHex(Library.AccentColor)))
            local version = '<font color="'..versionColor..'" size="9">v'..version..'</font>'
            local str = '<font color="'..hex..'">shitasscheat</font> '..version..'   '..fps..' fps 〡 '..ping2..' ms 〡 '..Time..' 〡 '..Date..' 〡 '..Build..' 〡 UID: '.. ''
            Library:SetWatermark(str)
        end
    end)
end
CoreGui.Parent = gethui() or cloneref(LocalPlayer.PlayerGui)
Library:Notify("Loaded shitassware in ".._tostring(_Tick() - LoadTick))
Library:Notify("shitassware.cc Loaded, ???")
Library:Notify("Version: SHIT "..version)
getgenv().Loaded = true
