-- Language Selector for PPHub V2 Lang
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- GitHub Raw URLs (Replace with your GitHub username and repo)
local EN_URL = "https://raw.githubusercontent.com/kullanıcı_adın/XHubScripts/main/XHub_EN.lua" -- Replace with your EN URL
local TR_URL = "https://raw.githubusercontent.com/kullanıcı_adın/XHubScripts/main/XHub_TR.lua" -- Replace with your TR URL

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

-- Create Language Selection GUI
local LanguageGui = Instance.new("ScreenGui")
LanguageGui.Name = "XHubLanguageSelector"
LanguageGui.Parent = game.CoreGui

local LanguageFrame = Instance.new("Frame")
LanguageFrame.Size = UDim2.new(0, 300, 0, 150)
LanguageFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
LanguageFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LanguageFrame.BorderSizePixel = 0
LanguageFrame.Parent = LanguageGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "Select Language / Dil Seç"
Title.TextColor3 = Color3.fromRGB(0, 255, 127)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.BorderSizePixel = 0
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.Parent = LanguageFrame

-- Language Selection Buttons
CreateButton(LanguageFrame, "English", function()
    local success, err = pcall(function()
        loadstring(game:HttpGet(EN_URL))()
    end)
    if not success then
        warn("Failed to load English menu: " .. err)
    end
    LanguageGui:Destroy()
end, 50)

CreateButton(LanguageFrame, "Türkçe", function()
    local success, err = pcall(function()
        loadstring(game:HttpGet(TR_URL))()
    end)
    if not success then
        warn("Türkçe menü yüklenemedi: " .. err)
    end
    LanguageGui:Destroy()
end, 100)

-- Script Start (Wait for player character to load)
LocalPlayer.CharacterAdded:Wait()
warn("XHub Language Selector Loaded! Please select a language.")
