--[[
    OX_VOID  •  Neon Liquid Glass Edition
    Made By Albina_bazarbaeva0
    Powered by Grok
]]

local Players           = game:GetService("Players")
local UIS               = game:GetService("UserInputService")
local TweenService      = game:GetService("TweenService")
local RunService        = game:GetService("RunService")
local StarterGui        = game:GetService("StarterGui")
local Lighting          = game:GetService("Lighting")
local CoreGui           = game:GetService("CoreGui")
local VirtualUser       = game:GetService("VirtualUser")

local LP                = Players.LocalPlayer
local Mouse             = LP:GetMouse()
local Camera            = workspace.CurrentCamera

local Char, Hum, Root
local function RefreshChar()
    Char = LP.Character or LP.CharacterAdded:Wait()
    Hum  = Char:WaitForChild("Humanoid")
    Root = Char:WaitForChild("HumanoidRootPart")
end
RefreshChar()
LP.CharacterAdded:Connect(RefreshChar)

--==============================================================
-- SETTINGS
--==============================================================
local S = {
    Speed           = 50,
    JumpPower       = 80,
    FlySpeed        = 60,
    InfiniteJump    = false,
    Noclip          = false,
    SpeedEnabled    = false,
    JumpEnabled     = false,
    FlyEnabled      = false,
    Bhop            = false,
    ESP             = false,
    Fullbright      = false,
    FOV             = 70,
    GodMode         = false,
    AntiAFK         = true,
    ClickTP         = false,
    SpinBot         = false,
    SpinSpeed       = 20,
}

local Connections = {}
local function AddConn(c) table.insert(Connections, c) return c end

local function Notify(title, text, dur)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title or "OX_VOID",
            Text = text or "",
            Duration = dur or 3
        })
    end)
end

local function Tween(obj, props, time, style)
    local t = TweenService:Create(obj, TweenInfo.new(time or 0.35, style or Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props)
    t:Play()
    return t
end

--==============================================================
-- LOADING SCREEN + CONFETTI
--==============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "OX_VOID_NEON"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = CoreGui

-- Loading Overlay
local Loading = Instance.new("Frame", ScreenGui)
Loading.Size = UDim2.new(1, 0, 1, 0)
Loading.BackgroundColor3 = Color3.fromRGB(8, 2, 18)
Loading.BorderSizePixel = 0
Loading.ZIndex = 100

local LoadTitle = Instance.new("TextLabel", Loading)
LoadTitle.Size = UDim2.new(1, 0, 0, 80)
LoadTitle.Position = UDim2.new(0, 0, 0.35, 0)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Text = "OX_VOID"
LoadTitle.TextColor3 = Color3.fromRGB(200, 100, 255)
LoadTitle.Font = Enum.Font.GothamBlack
LoadTitle.TextSize = 52
LoadTitle.TextTransparency = 1

local LoadSub = Instance.new("TextLabel", Loading)
LoadSub.Size = UDim2.new(1, 0, 0, 30)
LoadSub.Position = UDim2.new(0, 0, 0.35, 70)
LoadSub.BackgroundTransparency = 1
LoadSub.Text = "Grok"
LoadSub.TextColor3 = Color3.fromRGB(180, 140, 255)
LoadSub.Font = Enum.Font.Gotham
LoadSub.TextSize = 22
LoadSub.TextTransparency = 1

local LoadBarBG = Instance.new("Frame", Loading)
LoadBarBG.Size = UDim2.new(0, 320, 0, 6)
LoadBarBG.Position = UDim2.new(0.5, -160, 0.55, 0)
LoadBarBG.BackgroundColor3 = Color3.fromRGB(30, 10, 50)
LoadBarBG.BorderSizePixel = 0
Instance.new("UICorner", LoadBarBG).CornerRadius = UDim.new(1, 0)

local LoadBar = Instance.new("Frame", LoadBarBG)
LoadBar.Size = UDim2.new(0, 0, 1, 0)
LoadBar.BackgroundColor3 = Color3.fromRGB(190, 90, 255)
LoadBar.BorderSizePixel = 0
Instance.new("UICorner", LoadBar).CornerRadius = UDim.new(1, 0)

local Credit = Instance.new("TextLabel", Loading)
Credit.Size = UDim2.new(1, 0, 0, 25)
Credit.Position = UDim2.new(0, 0, 1, -50)
Credit.BackgroundTransparency = 1
Credit.Text = "Made By Albina_bazarbaeva0"
Credit.TextColor3 = Color3.fromRGB(160, 120, 220)
Credit.Font = Enum.Font.Gotham
Credit.TextSize = 14
Credit.TextTransparency = 1

-- Animate loading in
Tween(LoadTitle, {TextTransparency = 0}, 0.8)
Tween(LoadSub, {TextTransparency = 0}, 0.9)
Tween(Credit, {TextTransparency = 0}, 1.1)

-- Fake loading progress
task.spawn(function()
    for i = 0, 100, 2 do
        LoadBar.Size = UDim2.new(i/100, 0, 1, 0)
        task.wait(0.025)
    end
    task.wait(0.4)

    -- Confetti
    local function MakeConfetti()
        for i = 1, 60 do
            local p = Instance.new("Frame", Loading)
            p.Size = UDim2.new(0, math.random(6, 12), 0, math.random(6, 12))
            p.Position = UDim2.new(0.5, 0, 0.5, 0)
            p.BackgroundColor3 = Color3.fromHSV(math.random(), 0.8, 1)
            p.BorderSizePixel = 0
            p.Rotation = math.random(0, 360)
            Instance.new("UICorner", p).CornerRadius = UDim.new(0, 3)
            p.ZIndex = 110

            local endPos = UDim2.new(
                math.random(10, 90)/100,
                0,
                math.random(10, 90)/100,
                0
            )
            Tween(p, {
                Position = endPos,
                Rotation = math.random(-360, 360),
                BackgroundTransparency = 1
            }, 1.4, Enum.EasingStyle.Quad)
            game.Debris:AddItem(p, 1.5)
        end
    end
    MakeConfetti()
    task.wait(1.1)

    -- Fade out loading
    Tween(Loading, {BackgroundTransparency = 1}, 0.6)
    Tween(LoadTitle, {TextTransparency = 1}, 0.5)
    Tween(LoadSub, {TextTransparency = 1}, 0.5)
    Tween(Credit, {TextTransparency = 1}, 0.5)
    Tween(LoadBarBG, {BackgroundTransparency = 1}, 0.5)
    Tween(LoadBar, {BackgroundTransparency = 1}, 0.5)
    task.wait(0.7)
    Loading:Destroy()
end)

--==============================================================
-- FLOATING TOGGLE BUTTON (cool)
--==============================================================
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Name = "OX_Toggle"
ToggleBtn.Size = UDim2.new(0, 58, 0, 58)
ToggleBtn.Position = UDim2.new(0, 20, 0.5, -29)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 10, 70)
ToggleBtn.Text = "OX"
ToggleBtn.TextColor3 = Color3.fromRGB(220, 160, 255)
ToggleBtn.Font = Enum.Font.GothamBlack
ToggleBtn.TextSize = 18
ToggleBtn.AutoButtonColor = false
ToggleBtn.ZIndex = 50

Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
ToggleStroke.Color = Color3.fromRGB(180, 80, 255)
ToggleStroke.Thickness = 2
ToggleStroke.Transparency = 0.3

-- Glow pulse
task.spawn(function()
    while ToggleBtn.Parent do
        Tween(ToggleStroke, {Transparency = 0.1}, 0.8)
        task.wait(0.8)
        Tween(ToggleStroke, {Transparency = 0.45}, 0.8)
        task.wait(0.8)
    end
end)

--==============================================================
-- MAIN GUI (Neon Liquid Glass Purple)
--==============================================================
local Main = Instance.new("Frame", ScreenGui)
Main.Name = "Main"
Main.Size = UDim2.new(0, 540, 0, 440)
Main.Position = UDim2.new(0.5, -270, 0.5, -220)
Main.BackgroundColor3 = Color3.fromRGB(18, 6, 32)
Main.BackgroundTransparency = 0.15
Main.BorderSizePixel = 0
Main.Visible = false
Main.Active = true
Main.Draggable = true
Main.ZIndex = 10

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 16)

-- Glass border
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(170, 70, 255)
MainStroke.Thickness = 2
MainStroke.Transparency = 0.35

-- Top accent gradient line
local TopLine = Instance.new("Frame", Main)
TopLine.Size = UDim2.new(1, 0, 0, 3)
TopLine.BackgroundColor3 = Color3.fromRGB(190, 90, 255)
TopLine.BorderSizePixel = 0
local grad = Instance.new("UIGradient", TopLine)
grad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 40, 200)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(220, 120, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 40, 200))
}

-- Title
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, -20, 0, 40)
Title.Position = UDim2.new(0, 16, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "OX_VOID"
Title.TextColor3 = Color3.fromRGB(220, 150, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 26
Title.TextXAlignment = Enum.TextXAlignment.Left

local SubTitle = Instance.new("TextLabel", Main)
SubTitle.Size = UDim2.new(1, -20, 0, 18)
SubTitle.Position = UDim2.new(0, 16, 0, 42)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Neon Liquid Glass  •  Made By Albina_bazarbaeva0"
SubTitle.TextColor3 = Color3.fromRGB(160, 110, 210)
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 12
SubTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Close button inside main
local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Size = UDim2.new(0, 34, 0, 34)
CloseBtn.Position = UDim2.new(1, -44, 0, 12)
CloseBtn.BackgroundColor3 = Color3.fromRGB(50, 15, 70)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 120, 180)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

--==============================================================
-- TOGGLE LOGIC
--==============================================================
local guiOpen = false

local function SetGuiVisible(state)
    guiOpen = state
    if state then
        Main.Visible = true
        Main.Size = UDim2.new(0, 520, 0, 0)
        Tween(Main, {Size = UDim2.new(0, 540, 0, 440)}, 0.45, Enum.EasingStyle.Back)
    else
        Tween(Main, {Size = UDim2.new(0, 540, 0, 0)}, 0.3)
        task.delay(0.3, function()
            if not guiOpen then Main.Visible = false end
        end)
    end
end

ToggleBtn.MouseButton1Click:Connect(function()
    SetGuiVisible(not guiOpen)
end)

CloseBtn.MouseButton1Click:Connect(function()
    SetGuiVisible(false)
end)

--==============================================================
-- TABS + CONTENT (simplified clean version)
--==============================================================
local TabBar = Instance.new("Frame", Main)
TabBar.Size = UDim2.new(1, -24, 0, 34)
TabBar.Position = UDim2.new(0, 12, 0, 68)
TabBar.BackgroundTransparency = 1

local UIList = Instance.new("UIListLayout", TabBar)
UIList.FillDirection = Enum.FillDirection.Horizontal
UIList.Padding = UDim.new(0, 8)

local Pages = {}
local CurrentPage

local function CreateTab(name)
    local btn = Instance.new("TextButton", TabBar)
    btn.Size = UDim2.new(0, 100, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(35, 12, 55)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(180, 140, 220)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    local page = Instance.new("ScrollingFrame", Main)
    page.Size = UDim2.new(1, -24, 1, -120)
    page.Position = UDim2.new(0, 12, 0, 110)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = Color3.fromRGB(180, 80, 255)
    page.Visible = false
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    local lay = Instance.new("UIListLayout", page)
    lay.Padding = UDim.new(0, 8)

    Pages[name] = page

    btn.MouseButton1Click:Connect(function()
        if CurrentPage then CurrentPage.Visible = false end
        page.Visible = true
        CurrentPage = page
        for _, b in pairs(TabBar:GetChildren()) do
            if b:IsA("TextButton") then
                b.BackgroundColor3 = Color3.fromRGB(35, 12, 55)
                b.TextColor3 = Color3.fromRGB(180, 140, 220)
            end
        end
        btn.BackgroundColor3 = Color3.fromRGB(90, 30, 140)
        btn.TextColor3 = Color3.fromRGB(240, 200, 255)
    end)
    return page
end

local MovementPage = CreateTab("Movement")
local VisualsPage  = CreateTab("Visuals")
local CombatPage   = CreateTab("Combat")
local MiscPage     = CreateTab("Misc")

-- Auto select first tab after load
task.delay(2.5, function()
    if Pages["Movement"] then
        Pages["Movement"].Visible = true
        CurrentPage = Pages["Movement"]
    end
end)

local function CreateToggle(parent, text, default, callback)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, 0, 0, 42)
    frame.BackgroundColor3 = Color3.fromRGB(28, 10, 48)
    frame.BackgroundTransparency = 0.3
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, -70, 1, 0)
    label.Position = UDim2.new(0, 14, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 190, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left

    local toggle = Instance.new("TextButton", frame)
    toggle.Size = UDim2.new(0, 46, 0, 24)
    toggle.Position = UDim2.new(1, -58, 0.5, -12)
    toggle.BackgroundColor3 = default and Color3.fromRGB(160, 70, 255) or Color3.fromRGB(50, 20, 70)
    toggle.Text = ""
    Instance.new("UICorner", toggle).CornerRadius = UDim.new(1, 0)

    local circle = Instance.new("Frame", toggle)
    circle.Size = UDim2.new(0, 18, 0, 18)
    circle.Position = default and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

    local state = default
    toggle.MouseButton1Click:Connect(function()
        state = not state
        Tween(toggle, {BackgroundColor3 = state and Color3.fromRGB(160, 70, 255) or Color3.fromRGB(50, 20, 70)}, 0.25)
        Tween(circle, {Position = state and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)}, 0.25)
        callback(state)
    end)
end

-- Populate toggles
CreateToggle(MovementPage, "Speed Boost", false, function(v)
    S.SpeedEnabled = v
    if Hum then Hum.WalkSpeed = v and S.Speed or 16 end
end)
CreateToggle(MovementPage, "Super Jump", false, function(v)
    S.JumpEnabled = v
    if Hum then Hum.JumpPower = v and S.JumpPower or 50 end
end)
CreateToggle(MovementPage, "Fly", false, function(v) S.FlyEnabled = v end)
CreateToggle(MovementPage, "Noclip", false, function(v) S.Noclip = v end)
CreateToggle(MovementPage, "Infinite Jump", false, function(v) S.InfiniteJump = v end)

CreateToggle(VisualsPage, "Fullbright", false, function(v)
    S.Fullbright = v
    if v then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 9e9
        Lighting.GlobalShadows = false
    else
        Lighting.Brightness = 1
        Lighting.FogEnd = 1000
        Lighting.GlobalShadows = true
    end
end)

CreateToggle(CombatPage, "Godmode (Client)", false, function(v) S.GodMode = v end)
CreateToggle(CombatPage, "Spinbot", false, function(v) S.SpinBot = v end)
CreateToggle(CombatPage, "Click TP", false, function(v) S.ClickTP = v end)

CreateToggle(MiscPage, "Anti-AFK", true, function(v) S.AntiAFK = v end)

--==============================================================
-- CORE LOOPS
--==============================================================
local BV, BG

AddConn(RunService.RenderStepped:Connect(function()
    if not Root or not Hum then return end

    if S.SpeedEnabled then Hum.WalkSpeed = S.Speed end
    if S.JumpEnabled then Hum.JumpPower = S.JumpPower end

    if S.FlyEnabled then
        if not BV then
            BV = Instance.new("BodyVelocity")
            BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            BV.Parent = Root
            BG = Instance.new("BodyGyro")
            BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            BG.P = 9e4
            BG.Parent = Root
        end
        local dir = Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then dir += Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= Camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then dir += Camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.yAxis end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.yAxis end
        BV.Velocity = dir.Magnitude > 0 and dir.Unit * S.FlySpeed or Vector3.zero
        BG.CFrame = Camera.CFrame
    else
        if BV then BV:Destroy() BV = nil end
        if BG then BG:Destroy() BG = nil end
    end

    if S.Noclip and Char then
        for _, part in pairs(Char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end

    if S.SpinBot and Root then
        Root.CFrame = Root.CFrame * CFrame.Angles(0, math.rad(S.SpinSpeed), 0)
    end

    if S.GodMode and Hum then
        Hum.Health = Hum.MaxHealth
    end
end))

AddConn(UIS.JumpRequest:Connect(function()
    if S.InfiniteJump and Hum then
        Hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end))

AddConn(Mouse.Button1Down:Connect(function()
    if S.ClickTP and Mouse.Target and Root then
        Root.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0))
    end
end))

AddConn(LP.Idled:Connect(function()
    if S.AntiAFK then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end))

-- After loading finishes, show the toggle button nicely
task.delay(2.8, function()
    ToggleBtn.Position = UDim2.new(0, -70, 0.5, -29)
    Tween(ToggleBtn, {Position = UDim2.new(0, 20, 0.5, -29)}, 0.6, Enum.EasingStyle.Back)
    Notify("OX_VOID", "Neon Liquid Glass ready", 4)
end)

print("OX_VOID Neon Liquid Glass Edition loaded | Made By Albina_bazarbaeva0 | Grok")
