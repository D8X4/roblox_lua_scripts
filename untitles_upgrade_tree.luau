-- for the game https://www.roblox.com/games/113814738390716/Untitled-Upgrade-Tree

-- Services & References
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local remotes = ReplicatedStorage:WaitForChild("Remotes")

local buyUpgRemote = remotes:WaitForChild("BuyUpg")
local buyClickerRemote = remotes:WaitForChild("Clicker")
local evilRemote = remotes:WaitForChild("Evil")
local rollRemote = remotes:WaitForChild("Roll")
local prestigeRemote = remotes:WaitForChild("Prestige", 5)

-- Save initial spawn position right when script runs
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")
local spawnCFrame = rootPart.CFrame

-- Update spawn position if character respawns
player.CharacterAdded:Connect(function(newChar)
    local newRoot = newChar:WaitForChild("HumanoidRootPart")
    task.wait(0.5)
    spawnCFrame = newRoot.CFrame
end)

-- Cleanup old GUI if it already exists
if player.PlayerGui:FindFirstChild("UntitledUpgradeTreeHub") then
    player.PlayerGui.UntitledUpgradeTreeHub:Destroy()
end

-- Create GUI Elements
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UntitledUpgradeTreeHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = player.PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 440, 0, 365)
mainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 27)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 8)
frameCorner.Parent = mainFrame

-- Title Bar (Acts as the drag handle for the window)
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -130, 0, 40)
titleLabel.Position = UDim2.new(0, 130, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Untitled Upgrade Tree Hub"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 15
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = mainFrame

-- Custom Window Draggable Logic
local draggingWindow, dragInput, dragStart, startPos
titleLabel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingWindow = true
        dragStart = input.Position
        startPos = mainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingWindow = false
            end
        end)
    end
end)

titleLabel.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and draggingWindow then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Sidebar Container
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 120, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
sidebar.BorderSizePixel = 0
sidebar.Parent = mainFrame

local sidebarCorner = Instance.new("UICorner")
sidebarCorner.CornerRadius = UDim.new(0, 8)
sidebarCorner.Parent = sidebar

local sideHeader = Instance.new("TextLabel")
sideHeader.Size = UDim2.new(1, 0, 0, 40)
sideHeader.BackgroundTransparency = 1
sideHeader.Text = "HUB TABS"
sideHeader.TextColor3 = Color3.fromRGB(120, 120, 130)
sideHeader.TextSize = 12
sideHeader.Font = Enum.Font.SourceSansBold
sideHeader.Parent = sidebar

-- Content Area Container
local contentContainer = Instance.new("Frame")
contentContainer.Size = UDim2.new(1, -130, 1, -50)
contentContainer.Position = UDim2.new(0, 130, 0, 45)
contentContainer.BackgroundTransparency = 1
contentContainer.Parent = mainFrame

-- ================= TAB 1: PLAYER =================
local playerTab = Instance.new("Frame")
playerTab.Size = UDim2.new(1, 0, 1, 0)
playerTab.BackgroundTransparency = 1
playerTab.Visible = true
playerTab.Parent = contentContainer

-- WalkSpeed Controls
local targetWalkSpeed = 16
local wsLabel = Instance.new("TextLabel")
wsLabel.Size = UDim2.new(1, -15, 0, 20)
wsLabel.Position = UDim2.new(0, 0, 0, 0)
wsLabel.BackgroundTransparency = 1
wsLabel.Text = "WalkSpeed: 16"
wsLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
wsLabel.TextSize = 12
wsLabel.Font = Enum.Font.SourceSansBold
wsLabel.TextXAlignment = Enum.TextXAlignment.Left
wsLabel.Parent = playerTab

local wsSliderBg = Instance.new("Frame")
wsSliderBg.Size = UDim2.new(1, -15, 0, 14)
wsSliderBg.Position = UDim2.new(0, 0, 0, 22)
wsSliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
wsSliderBg.BorderSizePixel = 0
wsSliderBg.Parent = playerTab

local wsCorner = Instance.new("UICorner")
wsCorner.CornerRadius = UDim.new(0, 4)
wsCorner.Parent = wsSliderBg

local wsSliderFill = Instance.new("Frame")
wsSliderFill.Size = UDim2.new(16/250, 0, 1, 0)
wsSliderFill.BackgroundColor3 = Color3.fromRGB(60, 140, 220)
wsSliderFill.BorderSizePixel = 0
wsSliderFill.Parent = wsSliderBg

local wsFillCorner = Instance.new("UICorner")
wsFillCorner.CornerRadius = UDim.new(0, 4)
wsFillCorner.Parent = wsSliderFill

-- JumpPower Controls
local targetJumpPower = 50
local jpLabel = Instance.new("TextLabel")
jpLabel.Size = UDim2.new(1, -15, 0, 20)
jpLabel.Position = UDim2.new(0, 0, 0, 46)
jpLabel.BackgroundTransparency = 1
jpLabel.Text = "JumpPower: 50"
jpLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
jpLabel.TextSize = 12
jpLabel.Font = Enum.Font.SourceSansBold
jpLabel.TextXAlignment = Enum.TextXAlignment.Left
jpLabel.Parent = playerTab

local jpSliderBg = Instance.new("Frame")
jpSliderBg.Size = UDim2.new(1, -15, 0, 14)
jpSliderBg.Position = UDim2.new(0, 0, 0, 68)
jpSliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
jpSliderBg.BorderSizePixel = 0
jpSliderBg.Parent = playerTab

local jpCorner = Instance.new("UICorner")
jpCorner.CornerRadius = UDim.new(0, 4)
jpCorner.Parent = jpSliderBg

local jpSliderFill = Instance.new("Frame")
jpSliderFill.Size = UDim2.new(50/250, 0, 1, 0)
jpSliderFill.BackgroundColor3 = Color3.fromRGB(60, 140, 220)
jpSliderFill.BorderSizePixel = 0
jpSliderFill.Parent = jpSliderBg

local jpFillCorner = Instance.new("UICorner")
jpFillCorner.CornerRadius = UDim.new(0, 4)
jpFillCorner.Parent = jpSliderFill

-- Noclip Toggle
local noclipActive = false
local noclipBtn = Instance.new("TextButton")
noclipBtn.Size = UDim2.new(1, -15, 0, 30)
noclipBtn.Position = UDim2.new(0, 0, 0, 96)
noclipBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
noclipBtn.Text = "Noclip: OFF"
noclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipBtn.TextSize = 12
noclipBtn.Font = Enum.Font.SourceSansBold
noclipBtn.Parent = playerTab

local ncCorner = Instance.new("UICorner")
ncCorner.CornerRadius = UDim.new(0, 6)
ncCorner.Parent = noclipBtn

-- Fly Toggle
local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(1, -15, 0, 30)
flyBtn.Position = UDim2.new(0, 0, 0, 132)
flyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
flyBtn.Text = "Fly: OFF"
flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flyBtn.TextSize = 12
flyBtn.Font = Enum.Font.SourceSansBold
flyBtn.Parent = playerTab

local flyCorner = Instance.new("UICorner")
flyCorner.CornerRadius = UDim.new(0, 6)
flyCorner.Parent = flyBtn

-- ================= TAB 2: AUTOMATION =================
local automationTab = Instance.new("Frame")
automationTab.Size = UDim2.new(1, 0, 1, 0)
automationTab.BackgroundTransparency = 1
automationTab.Visible = false
automationTab.Parent = contentContainer

-- Auto-Clicker Toggle
local clickerToggleBtn = Instance.new("TextButton")
clickerToggleBtn.Size = UDim2.new(1, -15, 0, 22)
clickerToggleBtn.Position = UDim2.new(0, 0, 0, 0)
clickerToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
clickerToggleBtn.Text = "Auto-Clicker: OFF"
clickerToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
clickerToggleBtn.TextSize = 11
clickerToggleBtn.Font = Enum.Font.SourceSansBold
clickerToggleBtn.Parent = automationTab

local cBtnCorner = Instance.new("UICorner")
cBtnCorner.CornerRadius = UDim.new(0, 6)
cBtnCorner.Parent = clickerToggleBtn

-- Auto-Buy Upgrades Toggle
local buyToggleBtn = Instance.new("TextButton")
buyToggleBtn.Size = UDim2.new(1, -15, 0, 22)
buyToggleBtn.Position = UDim2.new(0, 0, 0, 25)
buyToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
buyToggleBtn.Text = "Auto-Buy Upgrades: OFF"
buyToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
buyToggleBtn.TextSize = 11
buyToggleBtn.Font = Enum.Font.SourceSansBold
buyToggleBtn.Parent = automationTab

local bBtnCorner = Instance.new("UICorner")
bBtnCorner.CornerRadius = UDim.new(0, 6)
bBtnCorner.Parent = buyToggleBtn

-- Auto-Buy Donation Toggle (Upgrade "76")
local donationToggleBtn = Instance.new("TextButton")
donationToggleBtn.Size = UDim2.new(1, -15, 0, 22)
donationToggleBtn.Position = UDim2.new(0, 0, 0, 50)
donationToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
donationToggleBtn.Text = "Auto-Buy Donation (76): OFF"
donationToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
donationToggleBtn.TextSize = 11
donationToggleBtn.Font = Enum.Font.SourceSansBold
donationToggleBtn.Parent = automationTab

local dBtnCorner = Instance.new("UICorner")
dBtnCorner.CornerRadius = UDim.new(0, 6)
dBtnCorner.Parent = donationToggleBtn

local statsLabel = Instance.new("TextLabel")
statsLabel.Size = UDim2.new(1, -15, 0, 20)
statsLabel.Position = UDim2.new(0, 0, 0, 75)
statsLabel.BackgroundTransparency = 1
statsLabel.Text = "Upgrades: 0 | Clicks: 0"
statsLabel.TextColor3 = Color3.fromRGB(160, 160, 170)
statsLabel.TextSize = 11
statsLabel.Font = Enum.Font.SourceSans
statsLabel.TextXAlignment = Enum.TextXAlignment.Left
statsLabel.Parent = automationTab

-- Auto-Prestige Controls
local prestigeToggleBtn = Instance.new("TextButton")
prestigeToggleBtn.Size = UDim2.new(1, -15, 0, 22)
prestigeToggleBtn.Position = UDim2.new(0, 0, 0, 97)
prestigeToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
prestigeToggleBtn.Text = "Auto-Prestige: OFF"
prestigeToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
prestigeToggleBtn.TextSize = 11
prestigeToggleBtn.Font = Enum.Font.SourceSansBold
prestigeToggleBtn.Parent = automationTab

local presBtnCorner = Instance.new("UICorner")
presBtnCorner.CornerRadius = UDim.new(0, 6)
presBtnCorner.Parent = prestigeToggleBtn

local prestigeStatusLabel = Instance.new("TextLabel")
prestigeStatusLabel.Size = UDim2.new(1, -15, 0, 18)
prestigeStatusLabel.Position = UDim2.new(0, 0, 0, 121)
prestigeStatusLabel.BackgroundTransparency = 1
prestigeStatusLabel.Text = "Prestiges: 0 (Idle)"
prestigeStatusLabel.TextColor3 = Color3.fromRGB(160, 160, 170)
prestigeStatusLabel.TextSize = 10
prestigeStatusLabel.Font = Enum.Font.SourceSans
prestigeStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
prestigeStatusLabel.Parent = automationTab

-- Auto-Evil Clicker Toggle
local evilToggleBtn = Instance.new("TextButton")
evilToggleBtn.Size = UDim2.new(1, -15, 0, 22)
evilToggleBtn.Position = UDim2.new(0, 0, 0, 141)
evilToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
evilToggleBtn.Text = "Auto-Evil: OFF"
evilToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
evilToggleBtn.TextSize = 11
evilToggleBtn.Font = Enum.Font.SourceSansBold
evilToggleBtn.Parent = automationTab

local eBtnCorner = Instance.new("UICorner")
eBtnCorner.CornerRadius = UDim.new(0, 6)
eBtnCorner.Parent = evilToggleBtn

-- Auto-Roll Toggle
local rollToggleBtn = Instance.new("TextButton")
rollToggleBtn.Size = UDim2.new(1, -15, 0, 22)
rollToggleBtn.Position = UDim2.new(0, 0, 0, 165)
rollToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
rollToggleBtn.Text = "Auto-Roll: OFF"
rollToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
rollToggleBtn.TextSize = 11
rollToggleBtn.Font = Enum.Font.SourceSansBold
rollToggleBtn.Parent = automationTab

local rBtnCorner = Instance.new("UICorner")
rBtnCorner.CornerRadius = UDim.new(0, 6)
rBtnCorner.Parent = rollToggleBtn

-- Roll Status Display Label (Inside Automation Tab safely)
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -15, 0, 24)
statusLabel.Position = UDim2.new(0, 0, 0, 192)
statusLabel.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
statusLabel.BorderSizePixel = 0
statusLabel.Text = "Status: Idle"
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.TextSize = 11
statusLabel.Font = Enum.Font.SourceSansBold
statusLabel.Parent = automationTab

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 6)
statusCorner.Parent = statusLabel

-- ================= TAB 3: TELEPORT =================
local teleportTab = Instance.new("Frame")
teleportTab.Size = UDim2.new(1, 0, 1, 0)
teleportTab.BackgroundTransparency = 1
teleportTab.Visible = false
teleportTab.Parent = contentContainer

local spawnBtn = Instance.new("TextButton")
spawnBtn.Size = UDim2.new(1, -15, 0, 32)
spawnBtn.Position = UDim2.new(0, 0, 0, 0)
spawnBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 160)
spawnBtn.Text = "Tp to Spawn / Overworld"
spawnBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
spawnBtn.TextSize = 13
spawnBtn.Font = Enum.Font.SourceSansBold
spawnBtn.Parent = teleportTab

local spawnCorner = Instance.new("UICorner")
spawnCorner.CornerRadius = UDim.new(0, 6)
spawnCorner.Parent = spawnBtn

spawnBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then
        root.CFrame = spawnCFrame + Vector3.new(0, 3, 0)
    end
end)

local function createTpButton(name, yPos, portalName)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -15, 0, 32)
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    btn.Text = "Tp to " .. name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = teleportTab

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local portal = ReplicatedStorage:FindFirstChild(portalName)

        if root and portal then
            local targetPart = portal:IsA("BasePart") and portal or (portal:IsA("Model") and portal.PrimaryPart or portal:FindFirstChildWhichIsA("BasePart", true))
            if targetPart then
                root.CFrame = targetPart.CFrame + Vector3.new(0, 3, 0)
            end
        end
    end)
    return btn
end

createTpButton("BigBang Portal", 40, "BigBangPortal")
createTpButton("Cycle Portal", 80, "CyclePortal")
createTpButton("Void Portal", 120, "VoidPortal")
createTpButton("Xenos Portal", 160, "XenosPortal")

-- ================= SIDEBAR TAB BUTTONS =================
local function createSidebarButton(name, yPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -16, 0, 32)
    btn.Position = UDim2.new(0, 8, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(140, 140, 150)
    btn.TextSize = 13
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = sidebar

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    return btn
end

local playerBtn = createSidebarButton("Player", 45)
local automationBtn = createSidebarButton("Automation", 85)
local teleportBtn = createSidebarButton("Teleport", 125)

playerBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
playerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local function switchTab(selectedTab, selectedBtn)
    playerTab.Visible = (selectedTab == playerTab)
    automationTab.Visible = (selectedTab == automationTab)
    teleportTab.Visible = (selectedTab == teleportTab)

    for _, btn in ipairs({playerBtn, automationBtn, teleportBtn}) do
        btn.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
        btn.TextColor3 = Color3.fromRGB(140, 140, 150)
    end
    selectedBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    selectedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
end

playerBtn.MouseButton1Click:Connect(function() switchTab(playerTab, playerBtn) end)
automationBtn.MouseButton1Click:Connect(function() switchTab(automationTab, automationBtn) end)
teleportBtn.MouseButton1Click:Connect(function() switchTab(teleportTab, teleportBtn) end)

-- ================= LOGIC LOOPS & FUNCTIONALITY =================
local autoClickActive = false
local autoEvilActive = false
local autoRollActive = false
local autoBuyActive = false
local autoDonationActive = false
local autoPrestigeActive = false

local upgradesCount = 0
local clicksCount = 0
local prestigeCount = 0

-- Toggles
clickerToggleBtn.MouseButton1Click:Connect(function()
    autoClickActive = not autoClickActive
    clickerToggleBtn.Text = autoClickActive and "Auto-Clicker: ON" or "Auto-Clicker: OFF"
    clickerToggleBtn.BackgroundColor3 = autoClickActive and Color3.fromRGB(40, 160, 80) or Color3.fromRGB(50, 50, 55)
end)

buyToggleBtn.MouseButton1Click:Connect(function()
    autoBuyActive = not autoBuyActive
    buyToggleBtn.Text = autoBuyActive and "Auto-Buy Upgrades: ON" or "Auto-Buy Upgrades: OFF"
    buyToggleBtn.BackgroundColor3 = autoBuyActive and Color3.fromRGB(40, 160, 80) or Color3.fromRGB(50, 50, 55)
end)

donationToggleBtn.MouseButton1Click:Connect(function()
    autoDonationActive = not autoDonationActive
    donationToggleBtn.Text = autoDonationActive and "Auto-Buy Donation (76): ON" or "Auto-Buy Donation (76): OFF"
    donationToggleBtn.BackgroundColor3 = autoDonationActive and Color3.fromRGB(180, 60, 60) or Color3.fromRGB(50, 50, 55)
end)

prestigeToggleBtn.MouseButton1Click:Connect(function()
    autoPrestigeActive = not autoPrestigeActive
    prestigeToggleBtn.Text = autoPrestigeActive and "Auto-Prestige: ON" or "Auto-Prestige: OFF"
    prestigeToggleBtn.BackgroundColor3 = autoPrestigeActive and Color3.fromRGB(180, 120, 30) or Color3.fromRGB(50, 50, 55)
end)

evilToggleBtn.MouseButton1Click:Connect(function()
    autoEvilActive = not autoEvilActive
    evilToggleBtn.Text = autoEvilActive and "Auto-Evil: ON" or "Auto-Evil: OFF"
    evilToggleBtn.BackgroundColor3 = autoEvilActive and Color3.fromRGB(140, 40, 180) or Color3.fromRGB(50, 50, 55)
end)

rollToggleBtn.MouseButton1Click:Connect(function()
    autoRollActive = not autoRollActive
    rollToggleBtn.Text = autoRollActive and "Auto-Roll: ON" or "Auto-Roll: OFF"
    rollToggleBtn.BackgroundColor3 = autoRollActive and Color3.fromRGB(60, 120, 200) or Color3.fromRGB(50, 50, 55)
end)

-- Clicker Loop
task.spawn(function()
    while true do
        if autoClickActive then
            pcall(function()
                buyClickerRemote:FireServer()
                clicksCount = clicksCount + 1
            end)
        end
        task.wait(0.2)
    end
end)

-- Evil Clicker Loop
task.spawn(function()
    while true do
        if autoEvilActive and evilRemote then
            pcall(function()
                evilRemote:FireServer()
            end)
        end
        task.wait(0.2)
    end
end)

-- Roll Loop
local ignoreRolls = {
    "grass",
    "rich",
    "levels god",
    "roll master",
    "evil",
    "god",
    "master"
}

task.spawn(function()
    while true do
        if autoRollActive and rollRemote then
            statusLabel.Text = "Status: Rolling..."
            statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)

            local success, result = pcall(function()
                return rollRemote:InvokeServer(true)
            end)

            if success and type(result) == "table" then
                local rolledName = tostring(result.Kept or result.Equipped or ""):lower()
                local displayName = tostring(result.Kept or result.Equipped or "Unknown")

                local isIgnored = false
                for _, ignored in ipairs(ignoreRolls) do
                    if string.find(rolledName, ignored) then
                        isIgnored = true
                        break
                    end
                end

                -- If it rolled something NOT in our ignore list, stop auto-roll!
                if rolledName ~= "" and not isIgnored then
                    statusLabel.Text = "Status: STOPPED! Hit: " .. displayName
                    statusLabel.TextColor3 = Color3.fromRGB(80, 255, 120)
                    autoRollActive = false

                    -- Update button state back to OFF
                    rollToggleBtn.Text = "Auto-Roll: OFF"
                    rollToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
                else
                    statusLabel.Text = "Status: Rolled [" .. displayName .. "] (Skipping)"
                    statusLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
                end
            else
                statusLabel.Text = "Status: Roll failed / rate limited"
                statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            end
        else
            statusLabel.Text = "Status: Paused / Off"
            statusLabel.TextColor3 = Color3.fromRGB(120, 120, 130)
        end
        task.wait(0.5)
    end
end)

-- Upgrades Loop
task.spawn(function()
    while true do
        if autoBuyActive then
            local upgradesFolder = workspace:FindFirstChild("Upgrades")
            if upgradesFolder then
                for _, upgrade in ipairs(upgradesFolder:GetChildren()) do
                    if not autoBuyActive then break end
                    local id = tonumber(upgrade.Name)
                    if id and id ~= 76 and upgrade.Name ~= "Donations" then
                        pcall(function()
                            buyUpgRemote:FireServer(id)
                            upgradesCount = upgradesCount + 1
                        end)
                    end
                end
            end
        end
        task.wait(0.3)
    end
end)

-- Dedicated Donation Loop (Upgrade 76)
task.spawn(function()
    while true do
        if autoDonationActive then
            pcall(function()
                buyUpgRemote:FireServer(76)
            end)
        end
        task.wait(0.5)
    end
end)

-- Status Text Loop
task.spawn(function()
    while true do
        statsLabel.Text = string.format("Upgrades: %d | Clicks: %d", upgradesCount, clicksCount)
        if autoPrestigeActive and prestigeRemote then
            prestigeStatusLabel.Text = string.format("Prestiges: %d (Firing)", prestigeCount)
            pcall(function()
                prestigeRemote:FireServer()
                prestigeCount = prestigeCount + 1
            end)
        else
            prestigeStatusLabel.Text = string.format("Prestiges: %d (Idle)", prestigeCount)
        end
        task.wait(0.5)
    end
end)

-- ================= PLAYER MODS LOGIC =================
local function setupSlider(sliderBg, sliderFill, minVal, maxVal, onValueChanged)
    local dragging = false

    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = UserInputService:GetMouseLocation().X
            local bgPos = sliderBg.AbsolutePosition.X
            local bgSize = sliderBg.AbsoluteSize.X

            local percent = math.clamp((mousePos - bgPos) / bgSize, 0, 1)
            sliderFill.Size = UDim2.new(percent, 0, 1, 0)

            local val = math.floor(minVal + (maxVal - minVal) * percent)
            onValueChanged(val)
        end
    end)
end

setupSlider(wsSliderBg, wsSliderFill, 0, 250, function(val)
    targetWalkSpeed = val
    wsLabel.Text = "WalkSpeed: " .. val
end)

setupSlider(jpSliderBg, jpSliderFill, 0, 250, function(val)
    targetJumpPower = val
    jpLabel.Text = "JumpPower: " .. val
end)

RunService.Heartbeat:Connect(function()
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = targetWalkSpeed
        hum.UseJumpPower = true
        hum.JumpPower = targetJumpPower
    end

    if noclipActive and char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

noclipBtn.MouseButton1Click:Connect(function()
    noclipActive = not noclipActive
    noclipBtn.Text = noclipActive and "Noclip: ON" or "Noclip: OFF"
    noclipBtn.BackgroundColor3 = noclipActive and Color3.fromRGB(40, 160, 80) or Color3.fromRGB(50, 50, 55)
end)

local flyActive = false
local flySpeed = 50
flyBtn.MouseButton1Click:Connect(function()
    flyActive = not flyActive
    flyBtn.Text = flyActive and "Fly: ON" or "Fly: OFF"
    flyBtn.BackgroundColor3 = flyActive and Color3.fromRGB(40, 160, 80) or Color3.fromRGB(50, 50, 55)
end)

RunService.RenderStepped:Connect(function()
    if flyActive then
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if root and hum then
            hum.PlatformStand = true
            local cam = workspace.CurrentCamera
            local moveDir = Vector3.new()

            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end

            root.Velocity = moveDir * flySpeed
            root.CFrame = CFrame.new(root.Position, root.Position + cam.CFrame.LookVector)
        end
    else
        local char = player.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum and hum.PlatformStand then
            hum.PlatformStand = false
        end
    end
end)
