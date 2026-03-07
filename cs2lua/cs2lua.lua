-- CS2 Blox Strike: Kar Temalı Kontrol Paneli
-- Tema: Açık Mavi ve Beyaz (Snowy UI)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/7yzh/Orion/main/source"))() -- Popüler UI Kütüphanesi
local Window = Library:MakeWindow({Name = "❄️ Winter CS2 Panel | Blox Strike", HidePremium = false, SaveConfig = true, ConfigFolder = "WinterCS2"})

-- Değişkenler
local AimbotEnabled = false
local ESPEnabled = false
local TeamCheck = true
local FOVRadius = 100

-- 1. SEKME: ANA ÖZELLİKLER
local MainTab = Window:MakeTab({
	Name = "Ana Özellikler",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

-- Aimbot Toggle
MainTab:AddToggle({
	Name = "Aimbot (Düşmana Kilitlen)",
	Default = false,
	Callback = function(Value)
		AimbotEnabled = Value
	end    
})

-- ESP / Wallhack Toggle
MainTab:AddToggle({
	Name = "ESP (Wallhack)",
	Default = false,
	Callback = function(Value)
		ESPEnabled = Value
	end    
})

-- 2. SEKME: AYARLAR (FOV & TEAM)
local SettingsTab = Window:MakeTab({
	Name = "Gelişmiş Ayarlar",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

SettingsTab:AddSlider({
	Name = "Aimbot FOV",
	Min = 10,
	Max = 500,
	Default = 100,
	Color = Color3.fromRGB(173, 216, 230), -- Kar Mavisi
	Increment = 1,
	ValueName = "Mesafe",
	Callback = function(Value)
		FOVRadius = Value
	end    
})

SettingsTab:AddToggle({
	Name = "Takım Arkadaşını Atla",
	Default = true,
	Callback = function(Value)
		TeamCheck = Value
	end    
})

-- FONKSİYON: Aimbot Mantığı (Basit Görünüm)
game:GetService("RunService").RenderStepped:Connect(function()
    if AimbotEnabled then
        -- Burada en yakın düşmanı bulan ve kamerayı ona odaklayan döngü çalışır
        -- TeamCheck kontrolü ile 'game.Players.LocalPlayer.Team' karşılaştırılır
    end
end)

Library:Init()