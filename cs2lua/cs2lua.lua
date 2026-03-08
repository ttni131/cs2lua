-- [[ ttni131 - JJSploit Uyumlu - ESP, Aimbot & Kill Sound ]]
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

_G.Aimbot = false
_G.ESP = false

-- 1. KILL SOUND (Düşman ölünce ses)
local Sound = Instance.new("Sound")
Sound.SoundId = "rbxassetid://12221967" -- Standart Roblox "Oof" veya kill sesi
Sound.Parent = workspace

local function PlayKillSound()
    Sound:Play()
end

-- 2. AIMBOT (JJSploit için En Sade Hali)
local function GetClosest()
    local Target = nil
    local Dist = 200 -- Mesafe
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
            local Pos, OnScreen = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
            if OnScreen then
                local Mag = (Vector2.new(Pos.X, Pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                if Mag < Dist then Target = v.Character.HumanoidRootPart Dist = Mag end
            end
        end
    end
    return Target
end

-- 3. ANA DÖNGÜ (Panel Yerine Tuşlu Panel Mantığı)
RunService.RenderStepped:Connect(function()
    -- ESP
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local H = p.Character:FindFirstChild("Highlight")
            if _G.ESP then
                if not H then H = Instance.new("Highlight", p.Character) H.FillColor = Color3.fromRGB(173, 216, 230) end
            else
                if H then H:Destroy() end
            end
        end
    end

    -- AIMBOT
    if _G.Aimbot then
        local Target = GetClosest()
        if Target then Camera.CFrame = CFrame.new(Camera.CFrame.Position, Target.Position) end
    end
end)

-- BASİT TUŞLU PANEL (JJSploit'in Konsoluna Yazdırır)
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.X then
        _G.Aimbot = not _G.Aimbot
        print("Aimbot: " .. tostring(_G.Aimbot))
    elseif input.KeyCode == Enum.KeyCode.Z then
        _G.ESP = not _G.ESP
        print("ESP: " .. tostring(_G.ESP))
    end
end)

print("Script Yüklendi! X: Aimbot, Z: ESP")
