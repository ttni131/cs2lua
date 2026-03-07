-- [[ ❄️ ttni131 - STABLE ESP & AIMBOT ]]
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

_G.ESP = false
_G.Aimbot = false

-- ESP (BillboardGui ile - En stabil yöntem)
local function CreateESP(player)
    local esp = Instance.new("BillboardGui", player.Character:WaitForChild("Head"))
    esp.Name = "WinterESP"
    esp.AlwaysOnTop = true
    esp.Size = UDim2.new(0, 100, 0, 100)
    local frame = Instance.new("Frame", esp)
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(173, 216, 230)
    frame.BackgroundTransparency = 0.5
end

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Z then -- ESP Aç/Kapat
        _G.ESP = not _G.ESP
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("Head") then
                if _G.ESP then CreateESP(p) else if p.Character.Head:FindFirstChild("WinterESP") then p.Character.Head.WinterESP:Destroy() end end
            end
        end
    end
    if input.KeyCode == Enum.KeyCode.X then -- Aimbot Aç/Kapat
        _G.Aimbot = not _G.Aimbot
    end
end)

-- AIMBOT (Basit ve etkili)
RunService.RenderStepped:Connect(function()
    if _G.Aimbot then
        local target = nil
        local dist = 999
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local pos, onScreen = Camera:WorldToScreenPoint(p.Character.HumanoidRootPart.Position)
                if onScreen then
                    local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    if mag < dist then
                        target = p.Character.HumanoidRootPart
                        dist = mag
                    end
                end
            end
        end
        if target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
        end
    end
end)
