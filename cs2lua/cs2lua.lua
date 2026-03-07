-- JJS İçin En Basit Versiyon
local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

_G.ESP = false

-- Z Tuşu: ESP (Kutu) Aç/Kapat
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Z then
        _G.ESP = not _G.ESP
        print("ESP Durumu: " .. tostring(_G.ESP))
    end
end)

-- Sürekli Döngü
RunService.RenderStepped:Connect(function()
    -- Basit ESP
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= Player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            if _G.ESP then
                -- Basit bir kutu çizer
                local pos, onScreen = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
                if onScreen then
                    -- JJS'nin anlayacağı en basit yöntem: Görsel efekt
                    local part = v.Character:FindFirstChild("Highlight") or Instance.new("Highlight", v.Character)
                    part.FillColor = Color3.fromRGB(0, 255, 255)
                    part.FillTransparency = 0.5
                end
            else
                local part = v.Character:FindFirstChild("Highlight")
                if part then part:Destroy() end
            end
        end
    end
end)
