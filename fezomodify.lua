-- Gui to Lua
-- Version: 3.2

-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Aimbot = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Toggle = Instance.new("TextButton")

--Properties:

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Aimbot.Name = "Aimbot"
Aimbot.Parent = ScreenGui
Aimbot.BackgroundColor3 = Color3.fromRGB(255, 185, 0)
Aimbot.Position = UDim2.new(0.0599842146, 0, 0.358722359, 0)
Aimbot.Size = UDim2.new(0, 126, 0, 152)

Title.Name = "Title"
Title.Parent = Aimbot
Title.BackgroundColor3 = Color3.fromRGB(255, 185, 0)
Title.Size = UDim2.new(0, 126, 0, 50)
Title.Font = Enum.Font.SourceSans
Title.Text = "Uranium"
Title.TextColor3 = Color3.fromRGB(0, 0, 0)
Title.TextSize = 35.000

Toggle.Name = "Toggle"
Toggle.Parent = Aimbot
Toggle.BackgroundColor3 = Color3.fromRGB(185, 130, 0)
Toggle.BorderSizePixel = 0
Toggle.Position = UDim2.new(0, 0, 0.473684222, 0)
Toggle.Size = UDim2.new(0, 126, 0, 50)
Toggle.Font = Enum.Font.SourceSans
Toggle.Text = "Off"
Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
Toggle.TextSize = 40.000

-- Scripts:

local function PNHLOYF_fake_script() -- Toggle.LocalScript 
	local script = Instance.new('LocalScript', Toggle)

	_G.aimbot = false
	local camera = game.Workspace.CurrentCamera
	local localplayer = game:GetService("Players").LocalPlayer
	
	script.Parent.MouseButton1Click:Connect(function()
		if _G.aimbot == false then
			_G.aimbot = true
			script.Parent.TextColor3 = Color3.fromRGB(255,255,255)
			script.Parent.Text = "On"
			function closestplayer()
				local dist = math.huge -- math.huge means a really large number, 1M+.
				local target = nil --- nil means no value
				for i,v in pairs (game:GetService("Players"):GetPlayers()) do
					if v ~= localplayer then
						if v.Character and v.Character:FindFirstChild("Head") and _G.aimbot and v.Character.Humanoid.Health > 0 then --- creating the checks
							local magnitude = (v.Character.Head.Position - localplayer.Character.Head.Position).magnitude
							if magnitude < dist then
								dist = magnitude
								target = v
							end
							
						end
					end
				end
				return target
			end
			
		else
			_G.aimbot = false
			script.Parent.TextColor3 = Color3.fromRGB(0,0,0)
			script.Parent.Text = "Off"
		end
	end)
	
	local aiming =  true --- this toggle will make it so we lock on to the person when we press our keybind
	
	game:GetService("RunService").RenderStepped:Connect(function()
		if aiming then
			camera.CFrame = CFrame.new(camera.CFrame.Position,closestplayer().Character.HumanoidRootPart.Position) -- locks into the HumanoidRootPart
		end
	end)
end
coroutine.wrap(PNHLOYF_fake_script)()