-- [[ ❄️ WINTER CS2 PANEL | BLOX STRIKE ❄️ ]]
-- Efendimiz için özel olarak hazırlanmıştır.

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "❄️ Winter Panel | CS2 Blox Strike", HidePremium = false, SaveConfig = true, ConfigFolder = "WinterCS2"})

-- [[ DEĞİŞKENLER ]]
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")

_G.AimbotEnabled = false
_G.ESPEnabled = false
_G.TeamCheck = true
_G.AimbotFOV = 100
_G.CircleVisible = true

-- [[ FOV GÖSTERGESİ ]]
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1
FOVCircle.NumSides = 100
FOVCircle.Radius = _G.AimbotFOV
FOVCircle.Filled = false
FOVCircle.Visible = _G.CircleVisible
FOVCircle.Color = Color3.fromRGB(173, 216, 230) -- Kar Mavisi

-- [[ ANA SEKME ]]
local MainTab = Window:MakeTab({
	Name = "Hile Özellikleri",
	Icon = "rbxassetid://4483345998"
})

MainTab:AddToggle({
	Name = "Aimbot (Kilitlenme)",
	Default = false,
	Callback = function(Value)
		_G.AimbotEnabled = Value
	end    
})

MainTab:AddToggle({
	Name = "ESP (Wallhack)",
	Default = false,
	Callback = function(Value)
		_G.ESPEnabled = Value
	end    
})

-- [[ AYARLAR SEKMESİ ]]
local SettingsTab = Window:MakeTab({
	Name = "Gelişmiş Ayarlar",
	Icon = "rbxassetid://4483345998"
})

SettingsTab:AddSlider({
	Name = "Aimbot FOV",
	Min = 50,
	Max = 500,
	Default = 100,
	Color = Color3.fromRGB(255, 255, 255),
	Increment = 1,
	ValueName = "Mesafe",
	Callback = function(Value)
		_G.AimbotFOV = Value
		FOVCircle.Radius = Value
	end    
})

SettingsTab:AddToggle({
	Name = "Takım Arkadaşını Atla",
	Default = true,
	Callback = function(Value)
		_G.TeamCheck = Value
	end    
})

SettingsTab:AddToggle({
	Name = "FOV Çizgisini Göster",
	Default = true,
	Callback = function(Value)
		FOVCircle.Visible = Value
	end    
})

-- [[ LUA FONKSİYONLARI ]]

local function GetClosestPlayer()
    local Target = nil
    local Dist = _G.AimbotFOV

    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid").Health > 0 then
            if _G.TeamCheck and v.Team == LocalPlayer.Team then continue end

            local ScreenPoint = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
            local VectorDist = (Vector2.new(ScreenPoint.X, ScreenPoint.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude

            if VectorDist < Dist then
                Target = v.Character.HumanoidRootPart
                Dist = VectorDist
            end
        end
    end
    return Target
end

-- Ana Döngü (Render)
RunService.RenderStepped:Connect(function()
    -- FOV Dairesini Güncelle
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)

    -- Aimbot Çalıştır
    if _G.AimbotEnabled then
        local Target = GetClosestPlayer()
        if Target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, Target.Position)
        end
    end

    -- ESP Çalıştır
    if _G.ESPEnabled then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and not p.Character:FindFirstChild("WinterESP") then
                if _G.TeamCheck and p.Team == LocalPlayer.Team then continue end
                
                local Highlight = Instance.new("Highlight")
                Highlight.Name = "WinterESP"
                Highlight.FillColor = Color3.fromRGB(173, 216, 230)
                Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                Highlight.FillTransparency = 0.5
                Highlight.Parent = p.Character
            end
        end
    else
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("WinterESP") then
                p.Character.WinterESP:Destroy()
            end
        end
    end
end)

OrionLib:Init()
