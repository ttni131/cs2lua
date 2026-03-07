-- [[ ❄️ ttni131 - WINTER CS2LUA ❄️ ]]
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "❄️ ttni131 | CS2 Blox Strike", HidePremium = false, SaveConfig = true, ConfigFolder = "ttni131_cs2"})

-- Değişkenler
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")

_G.Aimbot = false
_G.ESP = false
_G.TeamCheck = true
_G.FOV = 100

-- Arayüz Sekmesi
local Main = Window:MakeTab({Name = "Main", Icon = "rbxassetid://4483345998"})

Main:AddToggle({
    Name = "Aimbot (Düşman Odaklı)",
    Default = false,
    Callback = function(v) _G.Aimbot = v end
})

Main:AddToggle({
    Name = "ESP (Kar Temalı)",
    Default = false,
    Callback = function(v) _G.ESP = v end
})

local Settings = Window:MakeTab({Name = "Ayarlar", Icon = "rbxassetid://4483345998"})

Settings:AddSlider({
    Name = "Aimbot FOV",
    Min = 50, Max = 500, Default = 100,
    Callback = function(v) _G.FOV = v end
})

Settings:AddToggle({
    Name = "Takım Arkadaşına Kilitleme",
    Default = true,
    Callback = function(v) _G.TeamCheck = v end
})

-- Mantıksal Fonksiyonlar
local function GetClosest()
    local Target = nil
    local Dist = _G.FOV
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
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

RunService.RenderStepped:Connect(function()
    if _G.Aimbot then
        local Target = GetClosest()
        if Target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, Target.Position)
        end
    end
    
    if _G.ESP then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and not p.Character:FindFirstChild("WinterESP") then
                if _G.TeamCheck and p.Team == LocalPlayer.Team then continue end
                local H = Instance.new("Highlight", p.Character)
                H.Name = "WinterESP"
                H.FillColor = Color3.fromRGB(173, 216, 230)
                H.OutlineColor = Color3.fromRGB(255, 255, 255)
            end
        end
    else
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("WinterESP") then p.Character.WinterESP:Destroy() end
        end
    end
end)

OrionLib:Init()
