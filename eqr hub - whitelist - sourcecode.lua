-- [[ Services ]] --
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

-- [[ Configuration ]] --
local Webhook_URL = "https://discord.com/api/webhooks/1421432170962227350/MRf0IES9juXLR4z2F3BNEikuNIwUoogOujLW-h6gaxzCcfGwhn88Bo3x9bQmdMdlrSBZ" -- << NEW WEBHOOK URL >>
local userHwid = RbxAnalyticsService:GetClientId()
local localPlayer = Players.LocalPlayer
local playerName = localPlayer.Name

-- ======================================================================= --
-- || Configure Admin Keys (Bypass HWID check & Expiration)             || --
-- ======================================================================= --
local ADMIN_KEYS = {
    ["eloelo320"] = true, -- Klucze admina nie wygasają
    ["keyisyoursheart"] = true
}
-- ======================================================================= --

-- ======================================================================= --
-- || NOWA STRUKTURA KLUCZY Z DATĄ WAŻNOŚCI                             || --
-- ======================================================================= --
-- || Użyj formatu RRRR-MM-DD dla daty wygaśnięcia.                     || --
-- || Klucz przestaje działać o północy (UTC) dnia podanego w dacie.    || --
-- ======================================================================= --
local VALID_KEYS_HWID_MAP = {
    -- Format: ["klucz"] = { Expiration = "RRRR-MM-DD", HWIDs = { ["HWID_1"] = true, ["HWID_2"] = true } }
    ["keyforaalzinn"] = {
        Expiration = "2026-10-02",
        HWIDs = {
            ["4FD2E641-97C4-420A-B8B0-52CED2924CBE"] = true
        }
    },
    ["fentanylkey"] = {
        Expiration = "2026-10-03",
        HWIDs = {
            ["7A014DD8-EAF3-4D33-A822-78D47E4E1B0B"] = true
        }
    },
    ["origamikey"] = {
        Expiration = "2026-10-03",
        HWIDs = {
            ["28087A64-4F7E-466E-9B70-1ADCA30E5162"] = true
        }
    }, 
    ["keyforcaidy"] = {
        Expiration = "2026-10-03",
        HWIDs = {
            ["630A81E6-189F-4C4B-879D-CFCC8A87DE5E"] = true
        }
    },     
    ["keyforyourussianmate"] = {
        Expiration = "2026-09-29",
        HWIDs = {
            ["A9553F6B-F8E7-4466-A306-D7A4010CEAFE"] = true
        }
    },    
    ["keyisyourslord"] = {
        Expiration = "2026-10-03",
        HWIDs = {
            ["94DFD94B-7D29-4E30-9D17-70B38A13BDDF"] = true
        }
    },        
    ["keyisyoursdev"] = {
        Expiration = "2026-10-03",
        HWIDs = {
            ["AC1588C0-3FE9-4B3E-B831-04F70D526336"] = true
        }
    },      
    ["keyforyouxeri"] = {
        Expiration = "2026-10-03",
        HWIDs = {
            ["F2F4668C-8A9E-4B53-AB96-24C16CAD4D8B"] = true
        }
    },        
    ["keyforyoupoem"] = {
        Expiration = "2026-10-03",
        HWIDs = {
            ["6D87726E-B0B2-4C34-A3D8-DA18C0578316"] = true
        }
    },       
    ["keyforyoupoem"] = {
        Expiration = "2026-10-03",
        HWIDs = {
            ["6D87726E-B0B2-4C34-A3D8-DA18C0578316"] = true
        }
    },        
    ["keyforkrabee"] = {
        Expiration = "2026-10-03",
        HWIDs = {
            ["FB5CAD80-21DF-45DB-94F6-1E7727FB7E2D"] = true
        }
    },        
    ["keyforstegs"] = {
        Expiration = "2026-10-03",
        HWIDs = {
            ["EEF2DD94-ADB3-4B0D-8C0C-9809AC444AD0"] = true
        }
    },      
    ["keyforzenxth"] = {
        Expiration = "2026-10-04",
        HWIDs = {
            ["EA0D96A5-EF20-4AC1-AAA5-ED5EC123C1BB"] = true
        }
    },         
}
-- ======================================================================= --


-- [[ Webhook Function ]] --
local function sendWebhook(title, description, color, fields)
    if not HttpService then warn("HttpService not available!") return end
    if not request then warn("Global 'request' function not available! Webhook not sent.") return end
    local data = { content = "", embeds = {{ title = title, description = description, type = "rich", color = color, fields = fields or {}, footer = { text = "EQR HUB Whitelist | " .. os.date("!%Y-%m-%d %H:%M:%S UTC") } }} }
    local success, err = pcall(function() request({ Url = Webhook_URL, Method = 'POST', Headers = { ['Content-Type'] = 'application/json' }, Body = HttpService:JSONEncode(data) }) end)
    if not success then warn("Webhook error: ", err) end
end

-- [[ Initial Webhook Notification ]] --
sendWebhook( "🚀 Script Executed", "`" .. playerName .. "` executed verification.", 0x5865F2, { { name = "👤 User", value = playerName, inline = true }, { name = "💻 HWID", value = userHwid, inline = true } } )

-- [[ UI Creation (Original Appearance) ]] --
local screenGui = Instance.new("ScreenGui")
screenGui.ResetOnSpawn = false; screenGui.Name = "KeyVerificationUI"; screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; screenGui.Parent = localPlayer:WaitForChild("PlayerGui")
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"; mainFrame.Size = UDim2.new(0,0,0,0); mainFrame.Position = UDim2.new(0.5,0,0.5,0); mainFrame.AnchorPoint = Vector2.new(0.5,0.5); mainFrame.BackgroundColor3 = Color3.fromRGB(15,15,20); mainFrame.BorderSizePixel = 0; mainFrame.ClipsDescendants = true; mainFrame.Parent = screenGui
local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0,12); corner.Parent = mainFrame
local stroke = Instance.new("UIStroke"); stroke.Parent = mainFrame; stroke.Color = Color3.fromRGB(60,60,75); stroke.Thickness = 1; stroke.Transparency = 0.5
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"; titleLabel.Size = UDim2.new(1,-40,0,60); titleLabel.Position = UDim2.new(0,20,0,10); titleLabel.BackgroundTransparency = 1; titleLabel.Text = "VERIFICATION"; titleLabel.Font = Enum.Font.GothamSemibold; titleLabel.TextColor3 = Color3.fromRGB(220,220,220); titleLabel.TextSize = 24; titleLabel.TextXAlignment = Enum.TextXAlignment.Left; titleLabel.Parent = mainFrame
local line = Instance.new("Frame")
line.Name = "Divider"; line.Size = UDim2.new(1,-40,0,1); line.Position = UDim2.new(0,20,0,50); line.BackgroundColor3 = Color3.fromRGB(60,60,75); line.BorderSizePixel = 0; line.Parent = mainFrame
local inputBox = Instance.new("TextBox")
inputBox.Name = "KeyInput"; inputBox.Size = UDim2.new(1,-40,0,40); inputBox.Position = UDim2.new(0,20,0,80); inputBox.BackgroundColor3 = Color3.fromRGB(25,25,30); inputBox.PlaceholderText = "Enter your access key..."; inputBox.Text = ""; inputBox.Font = Enum.Font.Gotham; inputBox.TextColor3 = Color3.fromRGB(220,220,220); inputBox.TextSize = 14; inputBox.ClearTextOnFocus = false; inputBox.Parent = mainFrame
local inputCorner = Instance.new("UICorner"); inputCorner.CornerRadius = UDim.new(0,8); inputCorner.Parent = inputBox
local inputStroke = Instance.new("UIStroke"); inputStroke.Parent = inputBox; inputStroke.Color = Color3.fromRGB(60,60,75); inputStroke.Thickness = 1
local verifyButton = Instance.new("TextButton")
verifyButton.Name = "VerifyButton"; verifyButton.Size = UDim2.new(1,-40,0,40); verifyButton.Position = UDim2.new(0,20,0,140); verifyButton.BackgroundColor3 = Color3.fromRGB(70,180,100); verifyButton.Text = "VERIFY"; verifyButton.Font = Enum.Font.GothamBold; verifyButton.TextColor3 = Color3.fromRGB(255,255,255); verifyButton.TextSize = 14; verifyButton.AutoButtonColor = false; verifyButton.Parent = mainFrame
local buttonCorner = Instance.new("UICorner"); buttonCorner.CornerRadius = UDim.new(0,8); buttonCorner.Parent = verifyButton
local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "Status"; statusLabel.Size = UDim2.new(1,-40,0,20); statusLabel.Position = UDim2.new(0,20,0,190); statusLabel.BackgroundTransparency = 1; statusLabel.Text = ""; statusLabel.Font = Enum.Font.Gotham; statusLabel.TextSize = 12; statusLabel.TextColor3 = Color3.fromRGB(220,100,100); statusLabel.TextXAlignment = Enum.TextXAlignment.Left; statusLabel.Parent = mainFrame
local footerLabel = Instance.new("TextLabel")
footerLabel.Name = "Footer"; footerLabel.Size = UDim2.new(1,-40,0,20); footerLabel.Position = UDim2.new(0,20,0,220); footerLabel.BackgroundTransparency = 1; footerLabel.Text = "© 2025 EQR HUB | v1.11F"; footerLabel.Font = Enum.Font.Gotham; footerLabel.TextSize = 10; footerLabel.TextColor3 = Color3.fromRGB(100,100,120); footerLabel.TextXAlignment = Enum.TextXAlignment.Right; footerLabel.Parent = mainFrame

-- [[ Button Animations (Unchanged) ]] --
verifyButton.MouseEnter:Connect(function() TweenService:Create(verifyButton, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(90, 200, 120) }):Play() end)
verifyButton.MouseLeave:Connect(function() TweenService:Create(verifyButton, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(70, 180, 100) }):Play() end)
verifyButton.MouseButton1Down:Connect(function() TweenService:Create(verifyButton, TweenInfo.new(0.1), { BackgroundColor3 = Color3.fromRGB(60, 160, 90), Size = UDim2.new(1, -45, 0, 38) }):Play() end)
verifyButton.MouseButton1Up:Connect(function() TweenService:Create(verifyButton, TweenInfo.new(0.1), { BackgroundColor3 = Color3.fromRGB(90, 200, 120), Size = UDim2.new(1, -40, 0, 40) }):Play() end)

-- [[ Sound Effects (Unchanged) ]] --
local soundEffects = { success = Instance.new("Sound"), error = Instance.new("Sound"), click = Instance.new("Sound") }
for _,s in pairs(soundEffects) do s.Volume=0.5; s.Parent=SoundService end; soundEffects.success.SoundId="rbxassetid://114326413874741"; soundEffects.error.SoundId="rbxassetid://80099403859001"; soundEffects.click.SoundId="rbxassetid://6895079853"

-- [[ Access Flag ]] --
local accessGrantedFlag = false
local lastReportedFailedKey = nil

-- [[ ZMODYFIKOWANA Verification Function (Handles Admin, Expiration Date, Regular Keys + HWID) ]] --
local function verifyAccess()
    if accessGrantedFlag then return end -- Don't re-verify if already granted

    local enteredKey = inputBox.Text:lower():gsub("%s+", "") -- Normalize key
    local grantAccess = false
    local failureReason = "Unknown Error"
    local isAdminKeyUsed = false
    local keyExists = false

    -- Check 1: Is it an Admin Key? (Admins don't expire)
    if ADMIN_KEYS[enteredKey] == true then
        grantAccess = true
        isAdminKeyUsed = true
        keyExists = true
    else
        -- Check 2: If not admin, check regular key, its expiration date, and then the HWID map
        local keyData = VALID_KEYS_HWID_MAP[enteredKey]
        local isKeyStructValid = keyData ~= nil

        if isKeyStructValid then
            keyExists = true -- Key structure is recognized

            -- << POCZĄTEK WERYFIKACJI DATY >> --
            local isExpired = false
            local expirationDateStr = keyData.Expiration
            if expirationDateStr and type(expirationDateStr) == "string" then
                local exYear, exMonth, exDay = expirationDateStr:match("^(%d+)%-(%d+)%-(%d+)$")

                if exYear and exMonth and exDay then
                    exYear, exMonth, exDay = tonumber(exYear), tonumber(exMonth), tonumber(exDay)
                    local now = os.date("!*t") -- Get current time in UTC

                    if now.year > exYear then
                        isExpired = true
                    elseif now.year == exYear and now.month > exMonth then
                        isExpired = true
                    elseif now.year == exYear and now.month == exMonth and now.day > exDay then
                        isExpired = true
                    end
                else
                     failureReason = "Invalid date format in config"
                     isExpired = true -- Treat malformed date as expired to be safe
                end
            else
                failureReason = "Missing expiration date in config"
                isExpired = true -- Treat missing date as expired to be safe
            end

            if isExpired then
                if failureReason == "Unknown Error" then -- Set default reason if not already set by a format error
                    failureReason = "Key has expired"
                end
                grantAccess = false
            else
                -- << KONIEC WERYFIKACJI DATY >> --
                
                -- If not expired, proceed to HWID check
                local allowedHwidsForKey = keyData.HWIDs
                if type(allowedHwidsForKey) == "table" then
                    local isHwidAllowedForKey = allowedHwidsForKey[userHwid] == true
                    if isHwidAllowedForKey then
                        grantAccess = true
                    else
                        failureReason = "HWID not authorized for this key"
                    end
                else
                    failureReason = "Key configuration error (HWIDs)"
                end
            end
        else
            -- If the key is not admin and not in the regular map, it's invalid.
            if enteredKey ~= "" then
                 failureReason = "Invalid Key"
            else
                 failureReason = "Key cannot be empty"
            end
            keyExists = false
        end
    end

    -- Handle Outcome (Grant or Deny)
    if grantAccess then
        accessGrantedFlag = true
        lastReportedFailedKey = nil
        soundEffects.success:Play()
        statusLabel.Text = "✓ Verification successful"
        statusLabel.TextColor3 = Color3.fromRGB(100, 220, 100)

        local successTitle = isAdminKeyUsed and "👑 Admin Access Granted" or "✅ Access Granted"
        local successDescription = isAdminKeyUsed and "`" .. playerName .. "` verified using ADMIN key (`" .. enteredKey .. "`)." or "`" .. playerName .. "` verified using key `" .. enteredKey .. "`."
        local statusFieldValue = isAdminKeyUsed and "Admin Access Granted" or "Access Granted"
        local successColor = isAdminKeyUsed and 0xff00c8 or 0x57F287

        sendWebhook( successTitle, successDescription, successColor, { { name="👤 User",value=playerName,inline=true }, { name="💻 HWID",value=userHwid,inline=true }, { name="🔑 Entered Key",value="`"..enteredKey.."`",inline=false }, { name="🔑 Status",value=statusFieldValue,inline=false } } )

        local pulse1 = TweenService:Create(verifyButton, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(100, 220, 130), Size = UDim2.new(1,-35,0,42) })
        local pulse2 = TweenService:Create(verifyButton, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(70, 180, 100), Size = UDim2.new(1,-40,0,40) })
        pulse1:Play(); pulse1.Completed:Connect(function() pulse2:Play() end)

        task.delay(0.8, function()
            local closeTween = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad), { Size = UDim2.new(0,0,0,0) })
            closeTween:Play()
            closeTween.Completed:Connect(function()
                if screenGui then screenGui:Destroy() end
                pcall(function() game.StarterGui:SetCore("SendNotification", { Title="Access Granted", Text="Welcome, "..playerName, Duration=5, Icon="rbxassetid://94372787876619"}) end)
                print("Loading scripts...")
                task.wait(2)
                task.spawn(function() local s,e=pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/slaby4346-sketch/ee/refs/heads/main/main"))() end) if not s then warn(" fail to load:",e) end end)
            end)
        end)
    end

    return grantAccess, failureReason, keyExists
end


-- [[ Event Handlers ]] --

-- Auto-verify when text changes *only if* it matches a known key structure
inputBox:GetPropertyChangedSignal("Text"):Connect(function()
    if accessGrantedFlag then return end
    lastReportedFailedKey = nil

    local normalizedKey = inputBox.Text:lower():gsub("%s+", "")
    local isPotentiallyValidKey = (ADMIN_KEYS[normalizedKey] == true) or (VALID_KEYS_HWID_MAP[normalizedKey] ~= nil)

    if isPotentiallyValidKey then
        verifyAccess()
    else
        if not accessGrantedFlag then
            statusLabel.Text = ""
        end
    end
end)


-- Function to handle denial feedback (called by manual triggers)
local function handleDenialFeedback(reason, enteredKey)
    if accessGrantedFlag then return end

    local isRepeatingError = (enteredKey == lastReportedFailedKey)

    soundEffects.error:Play()
    statusLabel.Text = "❌ " .. reason
    statusLabel.TextColor3 = Color3.fromRGB(220, 100, 100)

    if reason ~= "Key cannot be empty" and not isRepeatingError then
        sendWebhook( "❌ Access Denied", "`"..playerName.."` failed verification.", 0xED4245, { { name="👤 User",value=playerName,inline=true }, { name="💻 HWID",value=userHwid,inline=true }, { name="🔑 Entered Key",value="`"..enteredKey.."`",inline=false }, { name="🔧 Reason",value=reason,inline=false }, { name="🔑 Status",value="Access Denied",inline=false } } )
        lastReportedFailedKey = enteredKey
    end

    local notificationText = reason == "Invalid Key" and "Invalid Key." or reason .."."
    pcall(function() game.StarterGui:SetCore("SendNotification", { Title="Access Denied", Text=notificationText, Duration=5, Icon="rbxassetid://108410160969523"}) end)

    local errorColor1 = TweenService:Create(verifyButton, TweenInfo.new(0.1), { BackgroundColor3 = Color3.fromRGB(220,100,100) })
    local errorColor2 = TweenService:Create(verifyButton, TweenInfo.new(0.3), { BackgroundColor3 = Color3.fromRGB(70,180,100) })
    errorColor1:Play(); errorColor1.Completed:Connect(function() errorColor2:Play() end)

    task.delay(2, function() if not accessGrantedFlag then statusLabel.Text = "" end end)
end


-- Manual verification via Button Click
verifyButton.MouseButton1Click:Connect(function()
    if accessGrantedFlag then return end
    soundEffects.click:Play()

    local enteredKey = inputBox.Text:lower():gsub("%s+", "")
    if enteredKey == "" then
        handleDenialFeedback("Key cannot be empty", enteredKey)
        return
    end

    local granted, reason, keyKnown = verifyAccess()

    if not granted then
        handleDenialFeedback(reason, enteredKey)
    end
end)

-- Manual verification via Enter Key
inputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        if accessGrantedFlag then return end
        soundEffects.click:Play()

        local enteredKey = inputBox.Text:lower():gsub("%s+", "")
        if enteredKey == "" then
            handleDenialFeedback("Key cannot be empty", enteredKey)
            return
        end

        local granted, reason, keyKnown = verifyAccess()

        if not granted then
             handleDenialFeedback(reason, enteredKey)
        end
    end
end)


-- [[ Opening Animation ]] --
task.wait(0.5); local openTween = TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), { Size = UDim2.new(0,300,0,250) }); openTween:Play()

-- [[ Cleanup on Player Leaving ]] --
Players.PlayerRemoving:Connect(function(player)
    if player == localPlayer then
        if screenGui then
            screenGui:Destroy()
        end
    end
end)

print("Key & HWID Verification System (v1.4 - Expiration Dates & Anti-Spam Webhook) Loaded.")
