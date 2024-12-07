local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local localPlayer = Players.LocalPlayer
local aimAssistActive = false
local aimAssistConnection

-- Create the button
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AimAssistGUI"
screenGui.Parent = localPlayer:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false -- Ensure the GUI persists after death

local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 150, 0, 50)
toggleButton.Position = UDim2.new(1, -160, 0, 10) -- Top-right corner
toggleButton.Text = "ZVZ AA"
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.Parent = screenGui

local function getClosestPlayer()
    local closestDistance = math.huge
    local closestPlayer = nil

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (localPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude
            
            if distance < closestDistance then
                closestDistance = distance
                closestPlayer = player
            end
        end
    end

    return closestPlayer
end

local function activateAimAssist()
    aimAssistActive = true
    toggleButton.Text = "Disable ZVZ AA"
    toggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    print(".gg/7vauyHTZj7") -- Print to console

    aimAssistConnection = RunService.RenderStepped:Connect(function()
        local closestPlayer = getClosestPlayer()

        if closestPlayer and closestPlayer.Character then
            -- Aim at the closest player
            local targetPosition = closestPlayer.Character.HumanoidRootPart.Position
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPosition)
        end
    end)
end

local function deactivateAimAssist()
    aimAssistActive = false
    toggleButton.Text = "ZVZ AA"
    toggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    print(".gg/7vauyHTZj7") -- Print to console

    if aimAssistConnection then
        aimAssistConnection:Disconnect()
        aimAssistConnection = nil
    end
end

-- Toggle aim assist
local function toggleAimAssist()
    if aimAssistActive then
        deactivateAimAssist()
    else
        activateAimAssist()
    end
end

-- Button click event
toggleButton.MouseButton1Click:Connect(toggleAimAssist)

-- Key press event
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Q then
        toggleAimAssist()
    end
end)
