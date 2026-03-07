-- [[ ❄️ ttni131 - WINTER MENU | CS2 BLOX STRIKE ]]
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "❄️ Winter Panel | CS2 Blox Strike",
   LoadingTitle = "Yükleniyor...",
   LoadingSubtitle = "ttni131 tarafından",
   ConfigurationSaving = {Enabled = true, FolderName = "ttni_config"}
})

local Tab = Window:CreateTab("Ana Özellikler", "snowflake")

-- Özellikler
_G.Aimbot = false
_G.ESP = false

Tab:CreateToggle({
   Name = "Aimbot (Düşman Kilit)",
   CurrentValue = false,
   Callback = function(Value)
      _G.Aimbot = Value
   end
})

Tab:CreateToggle({
   Name = "ESP (Kutu)",
   CurrentValue = false,
   Callback = function(Value)
      _G.ESP = Value
   end
})

-- Mantık
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

RunService.RenderStepped:Connect(function()
    if _G.Aimbot then
        local target = nil
        local dist = 999
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= Players.LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local pos, onScreen = Camera:WorldToScreenPoint(p.Character.HumanoidRootPart.Position)
                if onScreen then
                    local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    if mag < dist then target = p.Character.HumanoidRootPart dist = mag end
                end
            end
        end
        if target then Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position) end
    end

    if _G.ESP then
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and not p.Character:FindFirstChild("BoxESP") then
                local b = Instance.new("Highlight", p.Character)
                b.Name = "BoxESP"
                b.FillColor = Color3.fromRGB(173, 216, 230)
            end
        end
    else
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("BoxESP") then p.Character.BoxESP:Destroy() end
        end
    end
end)
