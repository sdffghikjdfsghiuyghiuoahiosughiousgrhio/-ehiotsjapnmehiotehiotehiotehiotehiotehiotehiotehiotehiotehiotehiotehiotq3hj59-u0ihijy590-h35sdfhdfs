local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local function keyclick(key)
    local vim = game:GetService("VirtualInputManager")
    vim:SendKeyEvent(true, key, false, game)
    wait(0.1) 
    vim:SendKeyEvent(false, key, false, game)
end

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local ballFolder = Workspace:FindFirstChild("Balls")

local triggeredBalls = {}

local function checkBalls()
 
    RunService.RenderStepped:Connect(function()
       
        local balls = ballFolder:GetChildren()

        for _, ball in ipairs(balls) do
            if ball:IsA("Part") then
                
                local distance = (humanoidRootPart.Position - ball.Position).magnitude

                if distance <= 24 and not triggeredBalls[ball] then
                    
                    keyclick(Enum.KeyCode.F)
                    
                    triggeredBalls[ball] = true
                elseif distance > 4 and triggeredBalls[ball] then
                   
                    triggeredBalls[ball] = nil
                end
            end
        end
    end)
end

checkBalls()
