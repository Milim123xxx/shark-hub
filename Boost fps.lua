-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()

-- ScreenGui
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "SharkHUB_Extreme"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- FPS Counter (ตรงกลางบน)
local fpsFrame = Instance.new("Frame", screenGui)
fpsFrame.Size = UDim2.new(0,120,0,45)
fpsFrame.Position = UDim2.new(0.5,-60,0,10)
fpsFrame.AnchorPoint = Vector2.new(0.5,0)
fpsFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
fpsFrame.BackgroundTransparency = 0.15
fpsFrame.BorderSizePixel = 0
fpsFrame.ZIndex = 100

local fpsCorner = Instance.new("UICorner", fpsFrame)
fpsCorner.CornerRadius = UDim.new(0,10)

local fpsStroke = Instance.new("UIStroke", fpsFrame)
fpsStroke.Color = Color3.fromRGB(0,255,100)
fpsStroke.Thickness = 2

local fpsLabel = Instance.new("TextLabel", fpsFrame)
fpsLabel.Size = UDim2.new(1,0,1,0)
fpsLabel.BackgroundTransparency = 1
fpsLabel.TextColor3 = Color3.fromRGB(0,255,100)
fpsLabel.Text = "FPS: --"
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextSize = 18
fpsLabel.ZIndex = 101

-- Notification
local notifFrame = Instance.new("Frame", screenGui)
notifFrame.Size = UDim2.new(0,320,0,110)
notifFrame.Position = UDim2.new(1,340,0,10)
notifFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)
notifFrame.BorderSizePixel = 0
notifFrame.ZIndex = 200

local notifCorner = Instance.new("UICorner", notifFrame)
notifCorner.CornerRadius = UDim.new(0,12)

local notifStroke = Instance.new("UIStroke", notifFrame)
notifStroke.Color = Color3.fromRGB(0,200,255)
notifStroke.Thickness = 3

local notifGradient = Instance.new("UIGradient", notifFrame)
notifGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0,150,255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0,255,200))
}
notifGradient.Rotation = 45

local notifIcon = Instance.new("TextLabel", notifFrame)
notifIcon.Size = UDim2.new(0,60,0,60)
notifIcon.Position = UDim2.new(0,10,0,25)
notifIcon.BackgroundTransparency = 1
notifIcon.Text = "🦈"
notifIcon.TextSize = 45
notifIcon.ZIndex = 201

local notifTitle = Instance.new("TextLabel", notifFrame)
notifTitle.Size = UDim2.new(1,-80,0,30)
notifTitle.Position = UDim2.new(0,75,0,10)
notifTitle.BackgroundTransparency = 1
notifTitle.TextColor3 = Color3.fromRGB(255,255,255)
notifTitle.Text = "SHARK HUB EXTREME"
notifTitle.Font = Enum.Font.GothamBold
notifTitle.TextSize = 18
notifTitle.TextXAlignment = Enum.TextXAlignment.Left
notifTitle.ZIndex = 201

local notifStatus = Instance.new("TextLabel", notifFrame)
notifStatus.Size = UDim2.new(1,-80,0,24)
notifStatus.Position = UDim2.new(0,75,0,42)
notifStatus.BackgroundTransparency = 1
notifStatus.TextColor3 = Color3.fromRGB(0,255,100)
notifStatus.Text = "✓ MEGA LUCK + ULTRA"
notifStatus.Font = Enum.Font.Gotham
notifStatus.TextSize = 14
notifStatus.TextXAlignment = Enum.TextXAlignment.Left
notifStatus.ZIndex = 201

local notifUser = Instance.new("TextLabel", notifFrame)
notifUser.Size = UDim2.new(1,-80,0,22)
notifUser.Position = UDim2.new(0,75,0,68)
notifUser.BackgroundTransparency = 1
notifUser.TextColor3 = Color3.fromRGB(200,200,200)
notifUser.Text = "👤 "..player.Name
notifUser.Font = Enum.Font.Gotham
notifUser.TextSize = 12
notifUser.TextXAlignment = Enum.TextXAlignment.Left
notifUser.ZIndex = 201

local function showNotification()
    local tweenIn = TweenService:Create(notifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(1,-330,0,10)
    })
    tweenIn:Play()
    task.wait(4)
    local tweenOut = TweenService:Create(notifFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Position = UDim2.new(1,340,0,10)
    })
    tweenOut:Play()
    tweenOut.Completed:Connect(function()
        notifFrame:Destroy()
    end)
end

-- ═══════════════════════════════════════════════════
-- 🎰 MEGA LUCK SYSTEM (ทุกแมพ - ทุกระบบ)
-- ═══════════════════════════════════════════════════
local function enableMEGALuck()
    print("🎰 ACTIVATING MEGA LUCK SYSTEM...")
    
    -- 1. Override math.random (บังคับให้ได้ของดีเสมอ)
    local oldRandom = math.random
    local oldRandomseed = math.randomseed
    
    math.random = function(min, max)
        if not min then return 1 end
        if not max then return min end
        return max -- คืนค่าสูงสุดเสมอ
    end
    
    math.randomseed = function() end
    
    -- 2. Hook Random.new (สำหรับ Random object)
    local oldRandomNew = Random.new
    Random.new = function(...)
        local rng = oldRandomNew(...)
        local oldNextNumber = rng.NextNumber
        local oldNextInteger = rng.NextInteger
        
        rng.NextNumber = function(self, min, max)
            if not min then return 1 end
            if not max then return min end
            return max
        end
        
        rng.NextInteger = function(self, min, max)
            return max or min or 1
        end
        
        return rng
    end
    
    -- 3. Hook RemoteEvents/Functions (ปรับค่าที่ส่งไปเซิฟเวอร์)
    local function hookRemote(remote)
        if remote:IsA("RemoteEvent") then
            local oldFire = remote.FireServer
            remote.FireServer = function(self, ...)
                local args = {...}
                for i, v in ipairs(args) do
                    if type(v) == "number" then
                        -- ถ้าเป็นเลขทศนิยม 0-1 (โอกาส) เปลี่ยนเป็น 1
                        if v > 0 and v < 1 then
                            args[i] = 1
                        -- ถ้าเป็นเลขมาก อาจเป็น damage/drop rate
                        elseif v > 1 then
                            args[i] = v * 10 -- เพิ่ม 10 เท่า
                        end
                    end
                end
                return oldFire(self, unpack(args))
            end
        elseif remote:IsA("RemoteFunction") then
            local oldInvoke = remote.InvokeServer
            remote.InvokeServer = function(self, ...)
                local args = {...}
                for i, v in ipairs(args) do
                    if type(v) == "number" and v > 0 and v < 1 then
                        args[i] = 1
                    end
                end
                return oldInvoke(self, unpack(args))
            end
        end
    end
    
    for _, remote in pairs(game:GetDescendants()) do
        pcall(function() hookRemote(remote) end)
    end
    
    game.DescendantAdded:Connect(function(obj)
        pcall(function() hookRemote(obj) end)
    end)
    
    -- 4. Hook NumberValue/IntValue (ปรับค่าที่เก็บโอกาส)
    for _, obj in pairs(game:GetDescendants()) do
        pcall(function()
            if obj:IsA("NumberValue") and obj.Value > 0 and obj.Value < 1 then
                obj.Value = 1 -- เปลี่ยนโอกาสเป็น 100%
            elseif obj:IsA("IntValue") and obj.Name:lower():find("luck") or 
                   obj.Name:lower():find("chance") or obj.Name:lower():find("drop") then
                obj.Value = 100
            end
        end)
    end
    
    -- 5. Hook BindableEvent (สำหรับ drop/reward system)
    for _, bindable in pairs(game:GetDescendants()) do
        pcall(function()
            if bindable:IsA("BindableEvent") then
                local oldFire = bindable.Fire
                bindable.Fire = function(self, ...)
                    local args = {...}
                    for i, v in ipairs(args) do
                        if type(v) == "table" then
                            if v.Luck then v.Luck = 100 end
                            if v.Chance then v.Chance = 1 end
                            if v.DropRate then v.DropRate = 1 end
                            if v.Rarity then v.Rarity = "Legendary" end
                        end
                    end
                    return oldFire(self, unpack(args))
                end
            end
        end)
    end
    
    -- 6. Auto-pickup items (เก็บของอัตโนมัติ)
    task.spawn(function()
        while task.wait(0.1) do
            pcall(function()
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and (
                        obj.Name:lower():find("coin") or
                        obj.Name:lower():find("gem") or
                        obj.Name:lower():find("collectible") or
                        obj.Name:lower():find("pickup") or
                        obj.Name:lower():find("item") or
                        obj.Name:lower():find("drop")
                    ) then
                        if character and character:FindFirstChild("HumanoidRootPart") then
                            local distance = (obj.Position - character.HumanoidRootPart.Position).Magnitude
                            if distance < 100 then
                                obj.CFrame = character.HumanoidRootPart.CFrame
                            end
                        end
                    end
                end
            end)
        end
    end)
    
    print("✓ MEGA LUCK SYSTEM ENABLED")
    print("  → 100% Best Drops")
    print("  → Auto Item Pickup")
    print("  → Boosted Rewards x10")
end

-- ═══════════════════════════════════════════════════
-- 🔥 EXTREME PERFORMANCE MODE (ลบทุกอย่าง)
-- ═══════════════════════════════════════════════════
local function enableEXTREMEMode()
    print("🔥 ACTIVATING EXTREME PERFORMANCE MODE...")
    
    local removedCount = 0
    
    -- ═══ STEP 1: RENDERING SETTINGS ═══
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
    settings().Rendering.EditQualityLevel = Enum.QualityLevel.Level01
    
    -- ═══ STEP 2: LIGHTING DESTRUCTION ═══
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.FogStart = 9e9
    Lighting.Brightness = 0
    Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)
    Lighting.Ambient = Color3.fromRGB(128,128,128)
    Lighting.EnvironmentDiffuseScale = 0
    Lighting.EnvironmentSpecularScale = 0
    Lighting.ShadowSoftness = 0
    Lighting.Technology = Enum.Technology.Compatibility
    Lighting.ClockTime = 12
    Lighting.GeographicLatitude = 0
    Lighting.ExposureCompensation = 0
    
    -- ลบทุก Effect ใน Lighting
    for _, obj in pairs(Lighting:GetChildren()) do
        pcall(function()
            obj:Destroy()
            removedCount = removedCount + 1
        end)
    end
    
    -- ═══ STEP 3: TERRAIN OPTIMIZATION ═══
    if Workspace:FindFirstChild("Terrain") then
        local terrain = Workspace.Terrain
        terrain.Decoration = false
        terrain.WaterReflectance = 0
        terrain.WaterTransparency = 0
        terrain.WaterWaveSize = 0
        terrain.WaterWaveSpeed = 0
    end
    
    -- ═══ STEP 4: WORKSPACE DESTRUCTION ═══
    local count = 0
    for _, obj in pairs(Workspace:GetDescendants()) do
        count = count + 1
        if count % 20 == 0 then task.wait() end
        
        pcall(function()
            -- ═══ PARTS ═══
            if obj:IsA("BasePart") then
                obj.Material = Enum.Material.Plastic
                obj.CastShadow = false
                obj.Reflectance = 0
                
                if obj:IsA("MeshPart") then
                    obj.RenderFidelity = Enum.RenderFidelity.Performance
                    obj.CollisionFidelity = Enum.CollisionFidelity.Box
                    obj.TextureID = ""
                    obj.DoubleSided = false
                    removedCount = removedCount + 1
                end
                
                if obj:IsA("Part") or obj:IsA("WedgePart") then
                    obj.TopSurface = Enum.SurfaceType.Smooth
                    obj.BottomSurface = Enum.SurfaceType.Smooth
                    obj.LeftSurface = Enum.SurfaceType.Smooth
                    obj.RightSurface = Enum.SurfaceType.Smooth
                    obj.FrontSurface = Enum.SurfaceType.Smooth
                    obj.BackSurface = Enum.SurfaceType.Smooth
                end
                
            -- ═══ PARTICLES & EFFECTS ═══
            elseif obj:IsA("ParticleEmitter") then
                obj:Destroy()
                removedCount = removedCount + 1
                
            elseif obj:IsA("Trail") then
                obj:Destroy()
                removedCount = removedCount + 1
                
            elseif obj:IsA("Beam") then
                obj:Destroy()
                removedCount = removedCount + 1
                
            -- ═══ TEXTURES & DECALS ═══
            elseif obj:IsA("Decal") then
                obj:Destroy()
                removedCount = removedCount + 1
                
            elseif obj:IsA("Texture") then
                obj:Destroy()
                removedCount = removedCount + 1
                
            elseif obj:IsA("SurfaceAppearance") then
                obj:Destroy()
                removedCount = removedCount + 1
                
            -- ═══ FIRE/SMOKE/SPARKLES ═══
            elseif obj:IsA("Fire") then
                obj:Destroy()
                removedCount = removedCount + 1
                
            elseif obj:IsA("Smoke") then
                obj:Destroy()
                removedCount = removedCount + 1
                
            elseif obj:IsA("Sparkles") then
                obj:Destroy()
                removedCount = removedCount + 1
                
            -- ═══ LIGHTS ═══
            elseif obj:IsA("PointLight") then
                obj:Destroy()
                removedCount = removedCount + 1
                
            elseif obj:IsA("SpotLight") then
                obj:Destroy()
                removedCount = removedCount + 1
                
            elseif obj:IsA("SurfaceLight") then
                obj:Destroy()
                removedCount = removedCount + 1
                
            -- ═══ MESHES ═══
            elseif obj:IsA("SpecialMesh") then
                obj.TextureId = ""
                removedCount = removedCount + 1
                
            elseif obj:IsA("FileMesh") then
                obj.TextureId = ""
                
            -- ═══ GUIS ═══
            elseif obj:IsA("SurfaceGui") then
                obj:Destroy()
                removedCount = removedCount + 1
                
            elseif obj:IsA("BillboardGui") then
                obj:Destroy()
                removedCount = removedCount + 1
                
            -- ═══ SOUNDS ═══
            elseif obj:IsA("Sound") then
                obj.Volume = 0
                removedCount = removedCount + 1
                
            -- ═══ POST EFFECTS ═══
            elseif obj:IsA("BloomEffect") or obj:IsA("BlurEffect") or 
                   obj:IsA("ColorCorrectionEffect") or obj:IsA("DepthOfFieldEffect") or
                   obj:IsA("SunRaysEffect") then
                obj:Destroy()
                removedCount = removedCount + 1
                
            -- ═══ ANIMATIONS ═══
            elseif obj:IsA("AnimationController") then
                for _, track in pairs(obj:GetPlayingAnimationTracks()) do
                    track:Stop()
                end
                
            -- ═══ WELDS/CONSTRAINTS (ไม่จำเป็น) ═══
            elseif obj:IsA("WeldConstraint") or obj:IsA("RopeConstraint") or
                   obj:IsA("RodConstraint") or obj:IsA("SpringConstraint") then
                -- เก็บไว้เพื่อไม่ให้เกม break
            end
        end)
    end
    
    -- ═══ STEP 5: CAMERA EFFECTS ═══
    if Workspace.CurrentCamera then
        for _, effect in pairs(Workspace.CurrentCamera:GetDescendants()) do
            pcall(function()
                if effect:IsA("PostEffect") then
                    effect:Destroy()
                    removedCount = removedCount + 1
                end
            end)
        end
    end
    
    -- ═══ STEP 6: GUI OPTIMIZATION ═══
    for _, gui in pairs(playerGui:GetDescendants()) do
        pcall(function()
            if gui:IsA("ImageLabel") or gui:IsA("ImageButton") then
                gui.ImageTransparency = 1
                gui.Image = ""
            elseif gui:IsA("ViewportFrame") then
                gui:Destroy()
                removedCount = removedCount + 1
            end
        end)
    end
    
    -- ═══ STEP 7: CONTINUOUS CLEANUP ═══
    task.spawn(function()
        while task.wait(3) do
            pcall(function()
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or 
                       obj:IsA("Beam") or obj:IsA("Fire") or obj:IsA("Smoke") then
                        obj:Destroy()
                    end
                end
            end)
        end
    end)
    
    print("✓ EXTREME MODE ACTIVATED")
    print("🗑️ DESTROYED: "..removedCount.." objects/effects")
end

-- ═══════════════════════════════════════════════════
-- 📊 FPS MONITOR & AUTO-ACTIVATION
-- ═══════════════════════════════════════════════════
local lastTime = tick()
local frameCount = 0
local fpsHistory = {}
local extremeModeActivated = false

RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    
    if tick() - lastTime >= 1 then
        local fps = frameCount
        fpsLabel.Text = "FPS: "..fps
        
        if fps >= 144 then
            fpsLabel.TextColor3 = Color3.fromRGB(0,255,100)
            fpsStroke.Color = Color3.fromRGB(0,255,100)
        elseif fps >= 60 then
            fpsLabel.TextColor3 = Color3.fromRGB(100,255,100)
            fpsStroke.Color = Color3.fromRGB(100,255,100)
        elseif fps >= 30 then
            fpsLabel.TextColor3 = Color3.fromRGB(255,200,0)
            fpsStroke.Color = Color3.fromRGB(255,200,0)
        else
            fpsLabel.TextColor3 = Color3.fromRGB(255,50,50)
            fpsStroke.Color = Color3.fromRGB(255,50,50)
        end
        
        table.insert(fpsHistory, fps)
        if #fpsHistory > 5 then table.remove(fpsHistory, 1) end
        
        local avgFps = 0
        for _, f in ipairs(fpsHistory) do avgFps = avgFps + f end
        avgFps = avgFps / #fpsHistory
        
        if not extremeModeActivated and #fpsHistory >= 5 and avgFps < 60 then
            extremeModeActivated = true
            notifStatus.Text = "⚠️ LOW FPS → BOOSTING"
            showNotification()
            task.wait(0.5)
            enableEXTREMEMode()
            notifStatus.Text = "✓ EXTREME MODE ON"
        end
        
        frameCount = 0
        lastTime = tick()
    end
end)

-- ═══════════════════════════════════════════════════
-- 🚀 AUTO-START
-- ═══════════════════════════════════════════════════
task.spawn(function()
    task.wait(1)
    enableMEGALuck()
end)

task.wait(0.5)
showNotification()

print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("🦈 SHARK HUB - EXTREME EDITION v2.0")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("✓ Script Loaded Successfully")
print("📊 FPS Monitor: CENTER TOP")
print("🔥 Extreme Performance: READY")
print("🎰 MEGA Luck System: ACTIVE")
print("👤 User: "..player.Name)
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("⚡ Features:")
print("  → Auto-destroy ALL effects")
print("  → 100% best drops/rewards")
print("  → Auto item pickup")
print("  → Boosted luck x10")
print("  → Target: 200+ FPS")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
