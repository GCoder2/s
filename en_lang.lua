-- PPHub English Menu by Grok
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Game IDs
local MM2_PLACE_ID = 142823291 -- Murder Mystery 2
local ARSENAL_PLACE_ID = 286090429 -- Arsenal
local gameId = game.PlaceId

-- Common Functions
local function CreateButton(frame, name, callback, yPos)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 260, 0, 40)
    button.Position = UDim2.new(0, 20, 0, yPos)
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.BorderSizePixel = 0
    button.Font = Enum.Font.Gotham
    button.TextSize = 18
    button.Parent = frame
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 255, 127)}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
    end)
    button.MouseButton1Click:Connect(callback)
    
    return button
end

local function CreateTextBox(frame, placeholder, yPos, sizeY)
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0, 260, 0, sizeY or 30)
    textBox.Position = UDim2.new(0, 20, 0, yPos)
    textBox.Text = placeholder
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    textBox.BorderSizePixel = 0
    textBox.Font = Enum.Font.Gotham
    textBox.TextSize = 16
    textBox.MultiLine = true
    textBox.TextWrapped = true
    textBox.Parent = frame
    
    return textBox
end

-- Script Editor Function
local ScriptEditorGui
local function CreateScriptEditor()
    if ScriptEditorGui then ScriptEditorGui:Destroy() end
    
    ScriptEditorGui = Instance.new("ScreenGui")
    ScriptEditorGui.Name = "PPHubScriptEditor"
    ScriptEditorGui.Parent = game.CoreGui

    local EditorFrame = Instance.new("Frame")
    EditorFrame.Size = UDim2.new(0, 400, 0, 300)
    EditorFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    EditorFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    EditorFrame.BorderSizePixel = 0
    EditorFrame.Active = true
    EditorFrame.Draggable = true
    EditorFrame.Parent = ScriptEditorGui

    local EditorTitle = Instance.new("TextLabel")
    EditorTitle.Size = UDim2.new(1, 0, 0, 30)
    EditorTitle.Text = "Script Editor"
    EditorTitle.TextColor3 = Color3.fromRGB(0, 255, 127)
    EditorTitle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    EditorTitle.BorderSizePixel = 0
    EditorTitle.Font = Enum.Font.GothamBold
    EditorTitle.TextSize = 18
    EditorTitle.Parent = EditorFrame

    local EditorBox = Instance.new("TextBox")
    EditorBox.Size = UDim2.new(0, 360, 0, 200)
    EditorBox.Position = UDim2.new(0, 20, 0, 40)
    EditorBox.Text = "-- Write your script here\n-- Type 'editor:close' to close"
    EditorBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    EditorBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    EditorBox.BorderSizePixel = 0
    EditorBox.Font = Enum.Font.SourceSans
    EditorBox.TextSize = 16
    EditorBox.MultiLine = true
    EditorBox.TextWrapped = true
    EditorBox.ClearTextOnFocus = false
    EditorBox.Parent = EditorFrame

    local ExecuteButton = Instance.new("TextButton")
    ExecuteButton.Size = UDim2.new(0, 360, 0, 40)
    ExecuteButton.Position = UDim2.new(0, 20, 0, 250)
    ExecuteButton.Text = "Execute"
    ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExecuteButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    ExecuteButton.BorderSizePixel = 0
    ExecuteButton.Font = Enum.Font.Gotham
    ExecuteButton.TextSize = 18
    ExecuteButton.Parent = EditorFrame

    ExecuteButton.MouseEnter:Connect(function()
        TweenService:Create(ExecuteButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 255, 127)}):Play()
    end)
    ExecuteButton.MouseLeave:Connect(function()
        TweenService:Create(ExecuteButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
    end)

    ExecuteButton.MouseButton1Click:Connect(function()
        local scriptText = EditorBox.Text
        if scriptText == "editor:close" then
            ScriptEditorGui:Destroy()
            warn("Editor closed!")
        else
            local success, err = pcall(function()
                loadstring(scriptText)()
            end)
            if not success then
                warn("Error executing script: " .. err)
            else
                warn("Script executed successfully!")
            end
        end
    end)
end

-- Main GUI Loading Function
local function LoadMainGui()
    if gameId == MM2_PLACE_ID then
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "PPHubMM2"
        ScreenGui.Parent = game.CoreGui

        local MainFrame = Instance.new("Frame")
        MainFrame.Size = UDim2.new(0, 300, 0, 400)
        MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
        MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        MainFrame.BorderSizePixel = 0
        MainFrame.ClipsDescendants = true
        MainFrame.Active = true
        MainFrame.Draggable = true
        MainFrame.Parent = ScreenGui

        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1, 0, 0, 40)
        Title.Text = "PPHub - MM2 Script"
        Title.TextColor3 = Color3.fromRGB(0, 255, 127)
        Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Title.BorderSizePixel = 0
        Title.Font = Enum.Font.GothamBold
        Title.TextSize = 22
        Title.Parent = MainFrame

        local MinimizeButton = Instance.new("TextButton")
        MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
        MinimizeButton.Position = UDim2.new(1, -35, 0, 5)
        MinimizeButton.Text = "-"
        MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        MinimizeButton.Font = Enum.Font.Gotham
        MinimizeButton.TextSize = 20
        MinimizeButton.Parent = MainFrame

        local ScrollFrame = Instance.new("ScrollingFrame")
        ScrollFrame.Size = UDim2.new(1, 0, 1, -50)
        ScrollFrame.Position = UDim2.new(0, 0, 0, 50)
        ScrollFrame.BackgroundTransparency = 1
        ScrollFrame.ScrollBarThickness = 5
        ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        ScrollFrame.Parent = MainFrame

        -- MM2 Features
        local ESPEnabled = false
        local ESPTable = {}
        local function UpdateESP(player)
            if player == LocalPlayer or not player.Character then return end
            local character = player.Character
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 5)
            if not humanoidRootPart then return end
            if ESPTable[player] then
                ESPTable[player].Highlight:Destroy()
                ESPTable[player].Billboard:Destroy()
                ESPTable[player] = nil
            end
            local role, roleColor
            if player.Backpack:FindFirstChild("Knife") or character:FindFirstChild("Knife") then
                role = "Murderer"
                roleColor = Color3.fromRGB(255, 0, 0)
            elseif player.Backpack:FindFirstChild("Gun") or character:FindFirstChild("Gun") then
                role = "Sheriff"
                roleColor = Color3.fromRGB(0, 0, 255)
            else
                role = "Innocent"
                roleColor = Color3.fromRGB(255, 255, 255)
            end
            local highlight = Instance.new("Highlight")
            highlight.Name = "PPHubESP"
            highlight.Adornee = character
            highlight.FillColor = roleColor
            highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0
            highlight.Parent = character
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "PPHubESPText"
            billboard.Adornee = humanoidRootPart
            billboard.Size = UDim2.new(0, 100, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.AlwaysOnTop = true
            billboard.Parent = humanoidRootPart
            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.Text = player.Name .. "\n[" .. role .. "]"
            textLabel.TextSize = 16
            textLabel.TextColor3 = roleColor
            textLabel.TextStrokeTransparency = 0
            textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            textLabel.Font = Enum.Font.GothamBold
            textLabel.Parent = billboard
            ESPTable[player] = {Highlight = highlight, Billboard = billboard}
        end

        local function ToggleESP()
            ESPEnabled = not ESPEnabled
            if ESPEnabled then
                for _, player in pairs(Players:GetPlayers()) do
                    if player.Character then UpdateESP(player) end
                    player.CharacterAdded:Connect(function() UpdateESP(player) end)
                end
                spawn(function()
                    while ESPEnabled do
                        for _, player in pairs(Players:GetPlayers()) do
                            if player.Character then UpdateESP(player) end
                        end
                        wait(5)
                    end
                end)
                warn("ESP Enabled!")
            else
                for _, esp in pairs(ESPTable) do
                    esp.Highlight:Destroy()
                    esp.Billboard:Destroy()
                end
                ESPTable = {}
                warn("ESP Disabled!")
            end
        end

        local Flying = false
        local FlySpeed = 50
        local function ToggleFly()
            Flying = not Flying
            local character = LocalPlayer.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then return end
            local humanoid = character:FindFirstChild("Humanoid")
            local rootPart = character.HumanoidRootPart
            if Flying then
                humanoid.PlatformStand = true
                local bv = Instance.new("BodyVelocity")
                bv.Velocity = Vector3.new(0, 0, 0)
                bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                bv.Parent = rootPart
                spawn(function()
                    while Flying do
                        local cam = workspace.CurrentCamera
                        local speed = FlySpeed
                        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then speed = speed * 2 end
                        if UserInputService:IsKeyDown(Enum.KeyCode.W) then bv.Velocity = cam.CFrame.LookVector * speed end
                        if UserInputService:IsKeyDown(Enum.KeyCode.S) then bv.Velocity = -cam.CFrame.LookVector * speed end
                        if UserInputService:IsKeyDown(Enum.KeyCode.A) then bv.Velocity = -cam.CFrame.RightVector * speed end
                        if UserInputService:IsKeyDown(Enum.KeyCode.D) then bv.Velocity = cam.CFrame.RightVector * speed end
                        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then bv.Velocity = Vector3.new(0, speed, 0) end
                        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then bv.Velocity = Vector3.new(0, -speed, 0) end
                        wait()
                    end
                    bv:Destroy()
                    humanoid.PlatformStand = false
                end)
                warn("Fly Enabled!")
            else
                warn("Fly Disabled!")
            end
        end

        local function KillAll()
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.Health = 0
                end
            end
            warn("Everyone Killed!")
        end

        local SpeedBox
        local function SetSpeed()
            local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid and SpeedBox.Text ~= "" then
                local speed = tonumber(SpeedBox.Text)
                if speed then
                    humanoid.WalkSpeed = speed
                    warn("Speed set to: " .. speed)
                else
                    warn("Enter a valid number!")
                end
            end
        end

        local JumpBox
        local function SetJumpPower()
            local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid and JumpBox.Text ~= "" then
                local power = tonumber(JumpBox.Text)
                if power then
                    humanoid.JumpPower = power
                    warn("Jump power set to: " .. power)
                else
                    warn("Enter a valid number!")
                end
            end
        end

        local function ToggleInvisible()
            local character = LocalPlayer.Character
            if not character then return end
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.Transparency = part.Transparency == 1 and 0 or 1
                end
            end
            warn("Invisibility " .. (character.Head.Transparency == 1 and "Enabled!" or "Disabled!"))
        end

        local function AutoCollectCoins()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "Coin_Server" and obj:IsA("BasePart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                    wait(0.1)
                end
            end
            warn("Coins Collected!")
        end

        local function GrabSheriffGun()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "GunDrop" and obj:IsA("BasePart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                    wait(0.1)
                    break
                end
            end
            warn("Sheriff's Gun Grabbed!")
        end

        local AimbotEnabled = false
        local function ToggleAimbot()
            AimbotEnabled = not AimbotEnabled
            if AimbotEnabled then
                spawn(function()
                    while AimbotEnabled do
                        local murderer
                        for _, player in pairs(Players:GetPlayers()) do
                            if player ~= LocalPlayer and (player.Backpack:FindFirstChild("Knife") or player.Character:FindFirstChild("Knife")) then
                                murderer = player
                                break
                            end
                        end
                        if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") then
                            local cam = workspace.CurrentCamera
                            cam.CFrame = CFrame.new(cam.CFrame.Position, murderer.Character.HumanoidRootPart.Position)
                        end
                        wait()
                    end
                end)
                warn("Aimbot Enabled!")
            else
                warn("Aimbot Disabled!")
            end
        end

        local NoclipEnabled = false
        local function ToggleNoclip()
            NoclipEnabled = not NoclipEnabled
            if NoclipEnabled then
                spawn(function()
                    while NoclipEnabled do
                        local character = LocalPlayer.Character
                        if character then
                            for _, part in pairs(character:GetDescendants()) do
                                if part:IsA("BasePart") then
                                    part.CanCollide = false
                                end
                            end
                        end
                        wait()
                    end
                    local character = LocalPlayer.Character
                    if character then
                        for _, part in pairs(character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = true
                            end
                        end
                    end
                end)
                warn("Noclip Enabled!")
            else
                warn("Noclip Disabled!")
            end
        end

        local Minimized = false
        MinimizeButton.MouseButton1Click:Connect(function()
            Minimized = not Minimized
            TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = Minimized and UDim2.new(0, 300, 0, 40) or UDim2.new(0, 300, 0, 400)}):Play()
            MinimizeButton.Text = Minimized and "+" or "-"
        end)

        local yPos = 10
        CreateButton(ScrollFrame, "Toggle ESP", ToggleESP, yPos); yPos = yPos + 50
        CreateButton(ScrollFrame, "Toggle Fly", ToggleFly, yPos); yPos = yPos + 50
        CreateButton(ScrollFrame, "Kill All", KillAll, yPos); yPos = yPos + 50
        SpeedBox = CreateTextBox(ScrollFrame, "Speed (e.g., 50)", yPos); yPos = yPos + 40
        CreateButton(ScrollFrame, "Set Speed", SetSpeed, yPos); yPos = yPos + 50
        JumpBox = CreateTextBox(ScrollFrame, "Jump Power (e.g., 50)", yPos); yPos = yPos + 40
        CreateButton(ScrollFrame, "Set Jump Power", SetJumpPower, yPos); yPos = yPos + 50
        CreateButton(ScrollFrame, "Toggle Invisibility", ToggleInvisible, yPos); yPos = yPos + 50
        CreateButton(ScrollFrame, "Collect Coins", AutoCollectCoins, yPos); yPos = yPos + 50
        CreateButton(ScrollFrame, "Grab Sheriff Gun", GrabSheriffGun, yPos); yPos = yPos + 50
        CreateButton(ScrollFrame, "Toggle Aimbot", ToggleAimbot, yPos); yPos = yPos + 50
        CreateButton(ScrollFrame, "Toggle Noclip", ToggleNoclip, yPos); yPos = yPos + 50
        CreateButton(ScrollFrame, "Open Editor", CreateScriptEditor, yPos); yPos = yPos + 50
        ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPos)

        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function()
                if ESPEnabled then UpdateESP(player) end
            end)
        end)

        warn("PPHub - Murder Mystery 2 Menu Loaded!")

    elseif gameId == ARSENAL_PLACE_ID then
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "PPHubArsenal"
        ScreenGui.Parent = game.CoreGui

        local MainFrame = Instance.new("Frame")
        MainFrame.Size = UDim2.new(0, 300, 0, 400)
        MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
        MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        MainFrame.BorderSizePixel = 0
        MainFrame.ClipsDescendants = true
        MainFrame.Active = true
        MainFrame.Draggable = true
        MainFrame.Parent = ScreenGui

        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1, 0, 0, 40)
        Title.Text = "PPHub - Arsenal Script"
        Title.TextColor3 = Color3.fromRGB(0, 255, 127)
        Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Title.BorderSizePixel = 0
        Title.Font = Enum.Font.GothamBold
        Title.TextSize = 22
        Title.Parent = MainFrame

        local MinimizeButton = Instance.new("TextButton")
        MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
        MinimizeButton.Position = UDim2.new(1, -35, 0, 5)
        MinimizeButton.Text = "-"
        MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        MinimizeButton.Font = Enum.Font.Gotham
        MinimizeButton.TextSize = 20
        MinimizeButton.Parent = MainFrame

        local ScrollFrame = Instance.new("ScrollingFrame")
        ScrollFrame.Size = UDim2.new(1, 0, 1, -50)
        ScrollFrame.Position = UDim2.new(0, 0, 0, 50)
        ScrollFrame.BackgroundTransparency = 1
        ScrollFrame.ScrollBarThickness = 5
        ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        ScrollFrame.Parent = MainFrame

        -- Arsenal Features
        local ESPEnabled = false
        local ESPTable = {}
        local function UpdateESP(player)
            if player == LocalPlayer or not player.Character then return end
            local character = player.Character
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 5)
            if not humanoidRootPart then return end
            if ESPTable[player] then
                ESPTable[player].Box:Destroy()
                ESPTable[player] = nil
            end
            local box = Instance.new("BoxHandleAdornment")
            box.Name = "PPHubESP"
            box.Adornee = humanoidRootPart
            box.Size = character:GetExtentsSize() * 1.1
            box.Color3 = Color3.fromRGB(255, 0, 0)
            box.Transparency = 0.7
            box.AlwaysOnTop = true
            box.ZIndex = 5
            box.Parent = game.CoreGui
            ESPTable[player] = {Box = box}
        end

        local function ToggleESP()
            ESPEnabled = not ESPEnabled
            if ESPEnabled then
                for _, player in pairs(Players:GetPlayers()) do
                    if player.Character then UpdateESP(player) end
                    player.CharacterAdded:Connect(function() 
                        if ESPEnabled then UpdateESP(player) end 
                    end)
                end
                spawn(function()
                    while ESPEnabled do
                        for _, player in pairs(Players:GetPlayers()) do
                            if player.Character then UpdateESP(player) end
                        end
                        wait(1)
                    end
                end)
                warn("ESP Enabled!")
            else
                for _, esp in pairs(ESPTable) do
                    esp.Box:Destroy()
                end
                ESPTable = {}
                warn("ESP Disabled!")
            end
        end

        local Flying = false
        local FlySpeed = 50
        local function ToggleFly()
            Flying = not Flying
            local character = LocalPlayer.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then return end
            local humanoid = character:FindFirstChild("Humanoid")
            local rootPart = character.HumanoidRootPart
            if Flying then
                humanoid.PlatformStand = true
                local bv = Instance.new("BodyVelocity")
                bv.Velocity = Vector3.new(0, 0, 0)
                bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                bv.Parent = rootPart
                spawn(function()
                    while Flying do
                        local cam = workspace.CurrentCamera
                        local speed = FlySpeed
                        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then speed = speed * 2 end
                        if UserInputService:IsKeyDown(Enum.KeyCode.W) then bv.Velocity = cam.CFrame.LookVector * speed end
                        if UserInputService:IsKeyDown(Enum.KeyCode.S) then bv.Velocity = -cam.CFrame.LookVector * speed end
                        if UserInputService:IsKeyDown(Enum.KeyCode.A) then bv.Velocity = -cam.CFrame.RightVector * speed end
                        if UserInputService:IsKeyDown(Enum.KeyCode.D) then bv.Velocity = cam.CFrame.RightVector * speed end
                        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then bv.Velocity = Vector3.new(0, speed, 0) end
                        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then bv.Velocity = Vector3.new(0, -speed, 0) end
                        wait()
                    end
                    bv:Destroy()
                    humanoid.PlatformStand = false
                end)
                warn("Fly Enabled!")
            else
                warn("Fly Disabled!")
            end
        end

        local AimbotEnabled = false
        local AimbotActive = false
        local function ToggleAimbot()
            AimbotEnabled = not AimbotEnabled
            if AimbotEnabled then
                warn("Aimbot Enabled! Right-click to aim.")
                UserInputService.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton2 and AimbotEnabled then
                        AimbotActive = true
                    end
                end)
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton2 then
                        AimbotActive = false
                    end
                end)
                spawn(function()
                    while AimbotEnabled do
                        if AimbotActive then
                            local closestEnemy
                            local closestDistance = math.huge
                            local cam = workspace.CurrentCamera
                            for _, player in pairs(Players:GetPlayers()) do
                                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                                    local head = player.Character.Head
                                    local screenPos, onScreen = cam:WorldToViewportPoint(head.Position)
                                    if onScreen then
                                        local distance = (cam.CFrame.Position - head.Position).Magnitude
                                        if distance < closestDistance then
                                            closestDistance = distance
                                            closestEnemy = player
                                        end
                                    end
                                end
                            end
                            if closestEnemy and closestEnemy.Character and closestEnemy.Character:FindFirstChild("Head") then
                                cam.CFrame = CFrame.new(cam.CFrame.Position, closestEnemy.Character.Head.Position)
                            end
                        end
                        wait()
                    end
                end)
            else
                AimbotActive = false
                warn("Aimbot Disabled!")
            end
        end

        local NoclipEnabled = false
        local function ToggleNoclip()
            NoclipEnabled = not NoclipEnabled
            if NoclipEnabled then
                spawn(function()
                    while NoclipEnabled do
                        local character = LocalPlayer.Character
                        if character then
                            for _, part in pairs(character:GetDescendants()) do
                                if part:IsA("BasePart") then
                                    part.CanCollide = false
                                end
                            end
                        end
                        wait()
                    end
                    local character = LocalPlayer.Character
                    if character then
                        for _, part in pairs(character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = true
                            end
                        end
                    end
                end)
                warn("Noclip Enabled!")
            else
                warn("Noclip Disabled!")
            end
        end

        local SpeedBox
        local function SetSpeed()
            local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid and SpeedBox.Text ~= "" then
                local speed = tonumber(SpeedBox.Text)
                if speed then
                    humanoid.WalkSpeed = speed
                    warn("Speed set to: " .. speed)
                else
                    warn("Enter a valid number!")
                end
            end
        end

        local function ToggleNoRecoil()
            local weapon = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if weapon then
                for _, v in pairs(weapon:GetDescendants()) do
                    if v:IsA("NumberValue") and v.Name == "Recoil" then
                        v.Value = 0
                    end
                end
                warn("No Recoil Enabled!")
            else
                warn("No weapon found!")
            end
        end

        local Minimized = false
        MinimizeButton.MouseButton1Click:Connect(function()
            Minimized = not Minimized
            TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = Minimized and UDim2.new(0, 300, 0, 40) or UDim2.new(0, 300, 0, 400)}):Play()
            MinimizeButton.Text = Minimized and "+" or "-"
        end)

        local yPos = 10
        CreateButton(ScrollFrame, "Toggle ESP", ToggleESP, yPos); yPos = yPos + 50
        CreateButton(ScrollFrame, "Toggle Fly", ToggleFly, yPos); yPos = yPos + 50
        CreateButton(ScrollFrame, "Toggle Aimbot", ToggleAimbot, yPos); yPos = yPos + 50
        SpeedBox = CreateTextBox(ScrollFrame, "Speed (e.g., 50)", yPos); yPos = yPos + 40
        CreateButton(ScrollFrame, "Set Speed", SetSpeed, yPos); yPos = yPos + 50
        CreateButton(ScrollFrame, "Toggle Noclip", ToggleNoclip, yPos); yPos = yPos + 50
        CreateButton(ScrollFrame, "Toggle No Recoil", ToggleNoRecoil, yPos); yPos = yPos + 50
        CreateButton(ScrollFrame, "Open Editor", CreateScriptEditor, yPos); yPos = yPos + 50
        ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPos)

        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function()
                if ESPEnabled then UpdateESP(player) end
            end)
        end)

        warn("PPHub - Arsenal Menu Loaded!")
    else
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "PPHubScriptRunner"
        ScreenGui.Parent = game.CoreGui

        local MainFrame = Instance.new("Frame")
        MainFrame.Size = UDim2.new(0, 300, 0, 100)
        MainFrame.Position = UDim2.new(0.5, -150, 0.5, -50)
        MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        MainFrame.BorderSizePixel = 0
        MainFrame.ClipsDescendants = true
        MainFrame.Active = true
        MainFrame.Draggable = true
        MainFrame.Parent = ScreenGui

        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1, 0, 0, 40)
        Title.Text = "PPHub - Script Runner"
        Title.TextColor3 = Color3.fromRGB(0, 255, 127)
        Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Title.BorderSizePixel = 0
        Title.Font = Enum.Font.GothamBold
        Title.TextSize = 22
        Title.Parent = MainFrame

        local yPos = 50
        CreateButton(MainFrame, "Open Editor", CreateScriptEditor, yPos)

        warn("PPHub - Script Runner Loaded!")
    end
end

-- Script Start (Wait for player character to load)
LocalPlayer.CharacterAdded:Wait()
LoadMainGui()
