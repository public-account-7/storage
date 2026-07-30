local ShootRemote = nil
for _, v in pairs(getgc(true)) do
    if typeof(v) == "table" and rawget(v, "ShootWeapon") then
        ShootRemote = v
        print("found")
        break
    end
end

if not ShootRemote then return end

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local oldSend = ShootRemote.ShootWeapon.Send
ShootRemote.ShootWeapon.Send = function(data)
    if Camera then
        local target = nil
        local bestDist = math.huge
        local center = Camera.ViewportSize / 2
        
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local head = p.Character:FindFirstChild("Head")
                if head then
                    local screen, onScreen = Camera:WorldToViewportPoint(head.Position)
                    if onScreen then
                        local dist = (Vector2.new(screen.X, screen.Y) - center).Magnitude
                        if dist < bestDist then
                            bestDist = dist
                            target = head
                        end
                    end
                end
            end
        end
        
        if target and data.Bullets then
            local origin = Camera.CFrame.Position
            local dir = (target.Position - origin).Unit
            for _, bullet in ipairs(data.Bullets) do
                bullet.Direction = dir
                bullet.Origin = origin
                bullet.Hits = {{
                    Instance = target,
                    Position = target.Position,
                    Normal = -dir,
                    Material = "Plastic",
                    Distance = (target.Position - origin).Magnitude,
                    Exit = false
                }}
            end
        end
    end
    
    return oldSend(data)
end
