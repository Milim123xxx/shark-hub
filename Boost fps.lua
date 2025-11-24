-- ═══════════════════════════════════════════════════
-- 🦈 SHARK HUB ULTIMATE - EXTREME PERFORMANCE MODE
-- ═══════════════════════════════════════════════════
-- ⚠️ WARNING: จัดหนักจัดเต็ม ลบทุกอย่างที่ไม่จำเป็น
-- ═══════════════════════════════════════════════════

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Stats = game:GetService("Stats")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- ลบ GUI เก่า (ป้องกันรันซ้ำ)
for _, gui in pairs(playerGui:GetChildren()) do
    if gui.Name == "SharkHUB_Extreme" then
        gui:Destroy()
    end
end
task.wait(0.2)

-- สร้าง ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SharkHUB_Extreme"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- ═══════════════════════════════════════════════════
-- 📊 FPS/PING DISPLAY (สี Neon สดจัด)
-- ═══════════════════════════════════════════════════
local statsFrame = Instance.new("Frame")
statsFrame.Size = UDim2.new(0, 180, 0, 70)
statsFrame.Position = UDim2.new(0.5, -90, 0, 15)
statsFrame.AnchorPoint = Vector2.new(0.5, 0)
statsFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
statsFrame.BackgroundTransparency = 0.1
statsFrame.BorderSizePixel = 0
statsFrame.ZIndex = 100
statsFrame.Parent = screenGui

local statsCorner = Instance.new("UICorner")
statsCorner.CornerRadius = UDim.new(0, 15)
statsCorner.Parent = statsFrame

local statsStroke = Instance.new("UIStroke")
statsStroke.Color = Color3.fromRGB(0, 255, 255)
statsStroke.Thickness = 4
statsStroke.Transparency = 0
statsStroke.Parent = statsFrame

local statsGlow = Instance.new("ImageLabel")
statsGlow.Size = UDim2.new(1, 20, 1, 20)
statsGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
statsGlow.AnchorPoint = Vector2.new(0.5, 0.5)
statsGlow.BackgroundTransparency = 1
statsGlow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
statsGlow.ImageColor3 = Color3.fromRGB(0, 255, 255)
statsGlow.ImageTransparency = 0.8
statsGlow.ZIndex = 99
statsGlow.Parent = statsFrame

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(1, 0, 0.5, 0)
fpsLabel.Position = UDim2.new(0, 0, 0, 0)
fpsLabel.BackgroundTransparency = 1
fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 50)
fpsLabel.Text = "⚡ FPS: --"
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextSize = 20
fpsLabel.TextStrokeTransparency = 0.2
fpsLabel.ZIndex = 101
fpsLabel.Parent = statsFrame

local pingLabel = Instance.new("TextLabel")
pingLabel.Size = UDim2.new(1, 0, 0.5, 0)
pingLabel.Position = UDim2.new(0, 0, 0.5, 0)
pingLabel.BackgroundTransparency = 1
pingLabel.TextColor3 = Color3.fromRGB(255, 0, 255)
pingLabel.Text = "📡 PING: --"
pingLabel.Font = Enum.Font.GothamBold
pingLabel.TextSize = 20
pingLabel.TextStrokeTransparency = 0.2
pingLabel.ZIndex = 101
pingLabel.Parent = statsFrame

-- ═══════════════════════════════════════════════════
-- 🔔 NOTIFICATION SYSTEM (สี Neon เข้มข้น)
-- ═══════════════════════════════════════════════════
local notifFrame = Instance.new("Frame")
notifFrame.Size = UDim2.new(0, 380, 0, 140)
notifFrame.Position = UDim2.new(1, 400, 0, 15)
notifFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
notifFrame.BackgroundTransparency = 0.05
notifFrame.BorderSizePixel = 0
notifFrame.ZIndex = 200
notifFrame.Parent = screenGui

local notifCorner = Instance.new("UICorner")
notifCorner.CornerRadius = UDim.new(0, 18)
notifCorner.Parent = notifFrame

local notifStroke = Instance.new("UIStroke")
notifStroke.Color = Color3.fromRGB(255, 0, 255)
notifStroke.Thickness = 5
notifStroke.Transparency = 0
notifStroke.Parent = notifFrame

local notifGradient = Instance.new("UIGradient")
notifGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 150)),
    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0, 255, 100)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 200))
}
notifGradient.Rotation = 0
notifGradient.Parent = notifFrame

-- Animated Gradient
local gradientActive = true
task.spawn(function()
    while gradientActive and notifFrame.Parent do
        for angle = 0, 360, 10 do
            if not (notifGradient and notifGradient.Parent) then break end
            notifGradient.Rotation = angle
            task.wait(0.04)
        end
    end
end)

local notifIcon = Instance.new("TextLabel")
notifIcon.Size = UDim2.new(0, 80, 0, 80)
notifIcon.Position = UDim2.new(0, 15, 0, 30)
notifIcon.BackgroundTransparency = 1
notifIcon.Text = "🦈"
notifIcon.TextSize = 60
notifIcon.ZIndex = 201
notifIcon.Parent = notifFrame

local notifTitle = Instance.new("TextLabel")
notifTitle.Size = UDim2.new(1, -110, 0, 35)
notifTitle.Position = UDim2.new(0, 100, 0, 10)
notifTitle.BackgroundTransparency = 1
notifTitle.TextColor3 = Color3.fromRGB(0, 255, 255)
notifTitle.Text = "🦈 SHARK HUB EXTREME"
notifTitle.Font = Enum.Font.GothamBold
notifTitle.TextSize = 22
notifTitle.TextXAlignment = Enum.TextXAlignment.Left
notifTitle.TextStrokeTransparency = 0.3
notifTitle.ZIndex = 201
notifTitle.Parent = notifFrame

local notifStatus = Instance.new("TextLabel")
notifStatus.Size = UDim2.new(1, -110, 0, 30)
notifStatus.Position = UDim2.new(0, 100, 0, 48)
notifStatus.BackgroundTransparency = 1
notifStatus.TextColor3 = Color3.fromRGB(0, 255, 50)
notifStatus.Text = "✓ EXTREME MODE ACTIVATED"
notifStatus.Font = Enum.Font.Gotham
notifStatus.TextSize = 16
notifStatus.TextXAlignment = Enum.TextXAlignment.Left
notifStatus.TextStrokeTransparency = 0.3
notifStatus.ZIndex = 201
notifStatus.Parent = notifFrame

local notifInfo = Instance.new("TextLabel")
notifInfo.Size = UDim2.new(1, -110, 0, 28)
notifInfo.Position = UDim2.new(0, 100, 0, 80)
notifInfo.BackgroundTransparency = 1
notifInfo.TextColor3 = Color3.fromRGB(255, 255, 0)
notifInfo.Text = "⚡ DESTROYING ALL EFFECTS..."
notifInfo.Font = Enum.Font.Gotham
notifInfo.TextSize = 15
notifInfo.TextXAlignment = Enum.TextXAlignment.Left
notifInfo.TextStrokeTransparency = 0.3
notifInfo.ZIndex = 201
notifInfo.Parent = notifFrame

local notifUser = Instance.new("TextLabel")
notifUser.Size = UDim2.new(1, -110, 0, 26)
notifUser.Position = UDim2.new(0, 100, 0, 110)
notifUser.BackgroundTransparency = 1
notifUser.TextColor3 = Color3.fromRGB(200, 200, 255)
notifUser.Text = "👤 " .. player.Name .. " | " .. player.DisplayName
notifUser.Font = Enum.Font.Gotham
notifUser.TextSize = 14
notifUser.TextXAlignment = Enum.TextXAlignment.Left
notifUser.TextStrokeTransparency = 0.3
notifUser.ZIndex = 201
notifUser.Parent = notifFrame

local function showNotification()
    local tweenIn = TweenService:Create(notifFrame, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -395, 0, 15)
    })
    tweenIn:Play()
    
    task.wait(6)
    
    local tweenOut = TweenService:Create(notifFrame, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Position = UDim2.new(1, 400, 0, 15)
    })
    tweenOut:Play()
    tweenOut.Completed:Connect(function()
        gradientActive = false
        if notifFrame then notifFrame:Destroy() end
    end)
end

-- ═══════════════════════════════════════════════════
-- 🔥 EXTREME PERFORMANCE MODE (ลบทุกอย่าง)
-- ═══════════════════════════════════════════════════
local destroyedCount = 0

local function extremePerformanceMode()
    print("🔥 === SHARK HUB EXTREME MODE === 🔥")
    print("⚠️ DESTROYING EVERYTHING...")
    
    -- ══════════════════════════════════════
    -- RENDERING SETTINGS (ต่ำสุด)
    -- ══════════════════════════════════════
    pcall(function()
        local renderSettings = settings().Rendering
        renderSettings.QualityLevel = Enum.QualityLevel.Level01
        renderSettings.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
        renderSettings.EditQualityLevel = Enum.QualityLevel.Level01
        
        local userGameSettings = UserSettings():GetService("UserGameSettings")
        userGameSettings.SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel1
        userGameSettings.MasterVolume = 0
    end)
    
    -- ══════════════════════════════════════
    -- LIGHTING (ปิดทุกอย่าง)
    -- ══════════════════════════════════════
    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.FogStart = 9e9
        Lighting.Brightness = 0
        Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.EnvironmentDiffuseScale = 0
        Lighting.EnvironmentSpecularScale = 0
        Lighting.ShadowSoftness = 0
        Lighting.Technology = Enum.Technology.Compatibility
        Lighting.ClockTime = 12
        Lighting.GeographicLatitude = 0
        Lighting.ExposureCompensation = 0
        
        for _, obj in pairs(Lighting:GetChildren()) do
            if not obj:IsA("Atmosphere") then
                pcall(function() obj:Destroy() end)
                destroyedCount = destroyedCount + 1
            end
        end
        
        if Lighting:FindFirstChildOfClass("Atmosphere") then
            Lighting:FindFirstChildOfClass("Atmosphere"):Destroy()
        end
    end)
    
    -- ══════════════════════════════════════
    -- TERRAIN (ลดทุกอย่าง)
    -- ══════════════════════════════════════
    pcall(function()
        local terrain = Workspace:FindFirstChildOfClass("Terrain")
        if terrain then
            terrain.Decoration = false
            terrain.WaterReflectance = 0
            terrain.WaterTransparency = 0
            terrain.WaterWaveSize = 0
            terrain.WaterWaveSpeed = 0
        end
    end)
    
    -- ══════════════════════════════════════
    -- WORKSPACE DESTRUCTION (จัดหนักสุด)
    -- ══════════════════════════════════════
    local processedCount = 0
    local preservedNames = {"head", "torso", "arm", "leg", "humanoid", "rootpart", "nametag", "healthbar", "overhead", "billboard"}
    
    for _, obj in pairs(Workspace:GetDescendants()) do
        processedCount = processedCount + 1
        if processedCount % 50 == 0 then task.wait() end
        
        pcall(function()
            local objName = obj.Name:lower()
            local isPreserved = false
            
            for _, preserved in ipairs(preservedNames) do
                if objName:find(preserved) then
                    isPreserved = true
                    break
                end
            end
            
            if isPreserved then return end
            
            -- ═══ ลบ EFFECTS ทั้งหมด ═══
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or
               obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") or
               obj:IsA("Explosion") then
                obj:Destroy()
                destroyedCount = destroyedCount + 1
                
            -- ═══ ลบ LIGHTS ทั้งหมด ═══
            elseif obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
                obj:Destroy()
                destroyedCount = destroyedCount + 1
                
            -- ═══ ลบ POST EFFECTS ═══
            elseif obj:IsA("BloomEffect") or obj:IsA("BlurEffect") or
                   obj:IsA("ColorCorrectionEffect") or obj:IsA("DepthOfFieldEffect") or
                   obj:IsA("SunRaysEffect") then
                obj:Destroy()
                destroyedCount = destroyedCount + 1
                
            -- ═══ ลบ DECALS/TEXTURES (เว้นหน้า) ═══
            elseif obj:IsA("Decal") then
                if objName ~= "face" then
                    obj:Destroy()
                    destroyedCount = destroyedCount + 1
                end
            elseif obj:IsA("Texture") or obj:IsA("SurfaceAppearance") then
                obj:Destroy()
                destroyedCount = destroyedCount + 1
                
            -- ═══ OPTIMIZE PARTS ═══
            elseif obj:IsA("BasePart") then
                obj.Material = Enum.Material.Plastic
                obj.CastShadow = false
                obj.Reflectance = 0
                
                if obj:IsA("MeshPart") then
                    obj.RenderFidelity = Enum.RenderFidelity.Performance
                    obj.CollisionFidelity = Enum.CollisionFidelity.Box
                    if objName ~= "head" then
                        obj.TextureID = ""
                    end
                    obj.DoubleSided = false
                end
                
                if obj:IsA("Part") or obj:IsA("WedgePart") or obj:IsA("CornerWedgePart") then
                    obj.TopSurface = Enum.SurfaceType.Smooth
                    obj.BottomSurface = Enum.SurfaceType.Smooth
                end
                
            -- ═══ ลบ/ปิด SOUNDS ═══
            elseif obj:IsA("Sound") then
                obj.Volume = 0
                obj:Stop()
                destroyedCount = destroyedCount + 1
                
            -- ═══ OPTIMIZE MESHES ═══
            elseif obj:IsA("SpecialMesh") then
                if objName ~= "head" then
                    obj.TextureId = ""
                end
                
            -- ═══ ลบ SURFACE GUIs (เว้นชื่อ) ═══
            elseif obj:IsA("SurfaceGui") then
                if not (objName:find("name") or objName:find("health")) then
                    obj:Destroy()
                    destroyedCount = destroyedCount + 1
                end
                
            -- ═══ BILLBOARDS (เว้นชื่อผู้เล่น) ═══
            elseif obj:IsA("BillboardGui") then
                if not (objName:find("name") or objName:find("tag") or 
                        objName:find("health") or objName:find("overhead")) then
                    obj:Destroy()
                    destroyedCount = destroyedCount + 1
                end
            end
        end)
    end
    
    -- ══════════════════════════════════════
    -- CAMERA EFFECTS (ลบทุกอัน)
    -- ══════════════════════════════════════
    pcall(function()
        local camera = Workspace.CurrentCamera
        if camera then
            for _, effect in pairs(camera:GetDescendants()) do
                if effect:IsA("BloomEffect") or effect:IsA("BlurEffect") or
                   effect:IsA("ColorCorrectionEffect") or effect:IsA("DepthOfFieldEffect") or
                   effect:IsA("SunRaysEffect") then
                    effect:Destroy()
                    destroyedCount = destroyedCount + 1
                end
            end
        end
    end)
    
    -- ══════════════════════════════════════
    -- NETWORK OPTIMIZATION (ลด PING)
    -- ══════════════════════════════════════
    pcall(function()
        settings().Network.IncomingReplicationLag = 0
        settings().Network.PhysicsSend = 1
        settings().Network.PhysicsReceive = 1
        settings().Network.ExperimentalPhysicsEnabled = false
    end)
    
    -- ══════════════════════════════════════
    -- OTHER PLAYERS (ทำให้โปร่งแสง)
    -- ══════════════════════════════════════
    pcall(function()
        for _, otherPlayer in pairs(Players:GetPlayers()) do
            if otherPlayer ~= player and otherPlayer.Character then
                for _, part in pairs(otherPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "Head" and part.Name ~= "HumanoidRootPart" then
                        part.Transparency = 0.8
                        part.CanCollide = false
                    elseif part:IsA("Decal") and part.Name ~= "face" then
                        part:Destroy()
                    end
                end
            end
        end
    end)
    
    print("✅ EXTREME MODE COMPLETE!")
    print("🗑️ DESTROYED: " .. destroyedCount .. " objects")
    print("⚡ FPS BOOST ACTIVATED!")
    notifInfo.Text = "✓ DESTROYED " .. destroyedCount .. " OBJECTS"
end

-- ══════════════════════════════════════
-- CONTINUOUS DESTROYER (ลบแอฟเฟคตลอดเวลา)
-- ══════════════════════════════════════
task.spawn(function()
    task.wait(3)
    while true do
        task.wait(1)
        pcall(function()
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or
                   obj:IsA("Beam") or obj:IsA("Fire") or obj:IsA("Smoke") or
                   obj:IsA("Sparkles") or obj:IsA("PointLight") or
                   obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
                    obj:Destroy()
                end
            end
        end)
    end
end)

-- ══════════════════════════════════════
-- MEGA LUCK SYSTEM (RNG Override)
-- ══════════════════════════════════════
local function enableMegaLuck()
    print("🎰 MEGA LUCK ACTIVATED")
    
    local oldRandom = math.random
    math.random = function(min, max)
        if not min then return 1 end
        if not max then return min end
        return max
    end
    
    local oldRandomNew = Random.new
    Random.new = function(...)
        local rng = oldRandomNew(...)
        rng.NextNumber = function(self, min, max)
            return max or min or 1
        end
        rng.NextInteger = function(self, min, max)
            return max or min or 1
        end
        return rng
    end
    
    task.spawn(function()
        while character and character.Parent do
            task.wait(0.2)
            pcall(function()
                if not (humanoidRootPart and humanoidRootPart.Parent) then return end
                
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("BasePart") then
                        local name = obj.Name:lower()
                        if name:find("coin") or name:find("gem") or name:find("cash") or
                           name:find("money") or name:find("orb") or name:find("collectible") or
                           name:find("pickup") or name:find("item") or name:find("drop") then
                            local distance = (obj.Position - humanoidRootPart.Position).Magnitude
                            if distance < 250 then
                                obj.CFrame = humanoidRootPart.CFrame
                            end
                        end
                    end
                end
            end)
        end
    end)
end

-- ══════════════════════════════════════
-- FPS/PING MONITOR
-- ══════════════════════════════════════
local lastUpdateTime = tick()
local frameCounter = 0
local optimizerStarted = false

RunService.RenderStepped:Connect(function()
    frameCounter = frameCounter + 1
    
    local currentTime = tick()
    if currentTime - lastUpdateTime >= 1 then
        local fps = frameCounter
        local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        
        fpsLabel.Text = "⚡ FPS: " .. fps
        if fps >= 120 then
            fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 50)
        elseif fps >= 60 then
            fpsLabel.TextColor3 = Color3.fromRGB(100, 255, 50)
        elseif fps >= 30 then
            fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
        else
            fpsLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
        
        pingLabel.Text = "📡 PING: " .. ping .. "ms"
        if ping < 50 then
            pingLabel.TextColor3 = Color3.fromRGB(0, 255, 50)
        elseif ping < 100 then
            pingLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
        elseif ping < 200 then
            pingLabel.TextColor3 = Color3.fromRGB(255, 100, 0)
        else
            pingLabel.TextColo
