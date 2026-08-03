local Players = game:GetService('Players')

local LocalPlayer = Players.LocalPlayer 
local Camera = workspace.CurrentCamera

local function GetClosestTarget()
    local target, dist = nil, math.huge 
    local mousePos = Camera.ViewportSize / 2 

    for _, player in next, Players:GetPlayers() do 
        if player ~= LocalPlayer and player.Character and player:GetAttribute('Team') ~= LocalPlayer:GetAttribute('Team') then 
            local head = player.Character:FindFirstChild('Head')
            local hum = player.Character:FindFirstChildOfClass('Humanoid')    
            if head and hum and hum.Health > 0 then 
                local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen then 
                    local headPos = Vector2.new(screenPos.X, screenPos.Y)
                    local mag = (mousePos - headPos).magnitude 
                    if mag < dist then 
                        dist = mag 
                        target = head 
                    end 
                end 
            end         
        end 
    end 

    return target
end 

if isfunctionhooked(getrawmetatable(Ray.new()).__index) then 
    restorefunction(getrawmetatable(Ray.new()).__index)
end 

local old; old = hookmetamethod(Ray.new(), '__index', function(...)
    local self, k = ...;
    if k == 'Direction' then 
        local target = GetClosestTarget() 
        if target then 
            local origin = old(self, 'Origin')
            local dir = (target.Position - origin).Unit
            return dir 
        end 
    end 
    return old(...)
end) 
print("hooked")
