local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

_G.ESPEnabled = false

-- ESP Kutusu Oluşturucu
local function CreateBox()
    local box = Drawing.new("Square")
    box.Visible = false
    box.Thickness = 2
    box.Color = Color3.fromRGB(173, 216, 230)
    return box
end

-- Tüm oyuncular için kutu hazırlığı
local boxes = {}
Players.PlayerAdded:Connect(function(plr)
    boxes[plr] = CreateBox()
end)

-- Ana Döngü (Çizim)
RunService.RenderStepped:Connect(function()
    for plr, box in pairs(boxes) do
        if _G.ESPEnabled and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr ~= LocalPlayer then
            local pos, onScreen = Camera:WorldToScreenPoint(plr.Character.HumanoidRootPart.Position)
            if onScreen then
                box.Visible = true
                box.Position = Vector2.new(pos.X - 25, pos.Y - 25)
                box.Size = Vector2.new(50, 50)
            else
                box.Visible = false
            end
        else
            box.Visible = false
        end
    end
end)

-- Tuş Ataması (Z ile aç/kapat)
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Z then
        _G.ESPEnabled = not _G.ESPEnabled
        print("ESP Durumu: " .. tostring(_G.ESPEnabled))
    end
end)
