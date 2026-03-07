-- [[ ❄️ ttni131 - GHOST CS2LUA (Keybind Edition) ❄️ ]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Durum Değişkenleri
_G.Aimbot = false
_G.ESP = false
_G.TeamCheck = true -- Varsayılan olarak açık (Takım arkadaşına sıkmamak için)
_G.FOV = 150

-- Bildirim Fonksiyonu (Sol altta durumunu görmen için)
local function Notify(msg)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "❄️ ttni131 Script",
        Text = msg,
        Duration = 2
    })
end

-- Tuş Atamaları
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end -- Yazı yazarken tetiklenmesin
    
    -- X: Aimbot
    if input.KeyCode == Enum.KeyCode.X then
        _G.Aimbot = not _G.Aimbot
        Notify("Aimbot: " .. (_G.Aimbot and "AÇIK" or "KAPALI"))
    
    -- Z: ESP (Wallhack)
    elseif input.KeyCode == Enum.KeyCode.Z then
        _G.ESP = not _G.ESP
        Notify("ESP: " .. (_G.ESP and "AÇIK" or "KAPALI"))
    
    -- Y: Takım Arkadaşı Vurmama (Team Check)
    elseif input.KeyCode == Enum.KeyCode.Y then
        _G.TeamCheck = not _G.TeamCheck
        Notify("Takım Koruması: " .. (_G.TeamCheck and "AÇIK" or "KAPALI"))
    end
end)

-- En Yakın Düşman Mantığı
local function GetClosest()
    local Target = nil
    local Dist = _G.FOV
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid").Health > 0 then
            if _G.TeamCheck and v.Team == LocalPlayer.Team then continue end
            
            local Pos, OnScreen = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
            if OnScreen then
                local Mag = (Vector2.new(Pos.X, Pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                if Mag < Dist then
                    Target = v.Character.HumanoidRootPart
                    Dist = Mag
                end
            end
        end
    end
    return Target
end

-- Ana Çalışma Döngüsü
RunService.RenderStepped:Connect(function()
    -- AIMBOT ÇALIŞTIR
    if _G.Aimbot then
        local Target = GetClosest()
        if Target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, Target.Position)
        end
    end
    
    -- ESP ÇALIŞTIR
    if _G.ESP then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local isTeammate = (p.Team == LocalPlayer.Team)
                if _G.TeamCheck and isTeammate then 
                    if p.Character:FindFirstChild("WinterESP") then p.Character.WinterESP:Destroy() end
                    continue 
                end
                
                if not p.Character:FindFirstChild("WinterESP") then
                    local H = Instance.new("Highlight", p.Character)
                    H.Name = "WinterESP"
                    H.FillColor = isTeammate and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(173, 216, 230)
                    H.OutlineColor = Color3.fromRGB(255, 255, 255)
                    H.FillTransparency = 0.5
                end
            end
        end
    else
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("WinterESP") then p.Character.WinterESP:Destroy() end
        end
    end
end)

Notify("Script Aktif! X: Aim | Z: ESP | Y: Team")
