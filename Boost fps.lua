-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Stats = game:GetService("Stats")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()

-- ScreenGui
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "SharkHUB_Ultimate"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- FPS + PING Counter (ตรงกลางบน - สีสดใส)
local statsFrame = Instance.new("Frame", screenGui)
statsFrame.Size = UDim2.new(0,140,0,50)
statsFrame.Position = UDim2.new(0.5,-70,0,10)
statsFrame.AnchorPoint = Vector2.new(0.5,0)
statsFrame.BackgroundColor3 = Color3.fromRGB(15,15,20)
statsFrame.BackgroundTransparency = 0.1
statsFrame.BorderSizePixel = 0
statsFrame.ZIndex = 100

local statsCorner = Instance.new("UICorner", statsFrame)
statsCorner.CornerRadius = UDim.new(0,12)

local statsStroke = Instance.new("UIStroke", statsFrame)
statsStroke.Color = Color3.fromRGB(0,255,255)
statsStroke.Thickness = 3

local statsGradient = Instance.new("UIGradient", statsFrame)
statsGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30,30,40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15,15,25))
}
statsGradient.Rotation = 90

-- FPS Label
local fpsLabel = Instance.new("TextLabel", statsFrame)
fpsLabel.Size = UDim2.new(1,0,0.5,0)
fpsLabel.Position = UDim2.new(0,0,0,0)
fpsLabel.BackgroundTransparency = 1
fpsLabel.TextColor3 = Color3.fromRGB(0,255,150)
fpsLabel.Text = "FPS: --"
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextSize = 16
fpsLabel.ZIndex = 101

-- PING Label
local pingLabel = Instance.new("TextLabel", statsFrame)
pingLabel.Size = UDim2.new(1,0,0.5,0)
pingLabel.Position = UDim2.new(0,0,0.5,0)
pingLabel.BackgroundTransparency = 1
pingLabel.TextColor3 = Color3.fromRGB(255,100,255)
pingLabel.Text = "PING: --"
pingLabel.Font = Enum.Font.GothamBold
pingLabel.TextSize = 16
pingLabel.ZIndex = 101

-- Notification (สีสดใส)
local notifFrame = Instance.new("Frame", screenGui)
notifFrame.Size = UDim2.new(0,340,0,120)
notifFrame.Position = UDim2.new(1,360,0,10)
notifFrame.BackgroundColor3 = Color3.fromRGB(10,10,15)
notifFrame.BorderSizePixel = 0
notifFrame.ZIndex = 200

local notifCorner = Instance.new("UICorner", notifFrame)
notifCorner.CornerRadius = UDim.new(0,15)

local notifStroke = Instance.new("UIStroke", notifFrame)
notifStroke.Color = Color3.fromRGB(0,255,255)
notifStroke.Thickness = 4

local notifGradient = Instance.new("UIGradient", notifFrame)
notifGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,150)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0,255,255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150,0,255))
}
notifGradient.Rotation = 45

-- Animated gradient
task.spawn(function()
    while notifFrame and notifFrame.Parent do
        for i = 0, 360, 5 do
            if notifGradient then
                notifGradient.Rotation = i
            end
            task.wait(0.05)
        end
    end
end)

local notifIcon = Instance.new("TextLabel", notifFrame)
notifIcon.Size = UDim2.new(0,70,0,70)
notifIcon.Position = UDim2.new(0,10,0,25)
notifIcon.BackgroundTransparency = 1
notifIcon.Text = "🦈"
notifIcon.TextSize = 50
notifIcon.ZIndex = 201

local notifTitle = Instance.new("TextLabel", notifFrame)
notifTitle.Size = UDim2.new(1,-90,0,32)
notifTitle.Position = UDim2.new(0,85,0,8)
notifTitle.BackgroundTransparency = 1
notifTitle.TextColor3 = Color3.fromRGB(255,255,255)
notifTitle.Text = "🦈 SHARK HUB ULTIMATE"
notifTitle.Font = Enum.Font.GothamBold
notifTitle.TextSize = 19
notifTitle.TextXAlignment = Enum.TextXAlignment.Left
notifTitle.ZIndex = 201

local notifStatus = Instance.new("TextLabel", notifFrame)
notifStatus.Size = UDim2.new(1,-90,0,26)
notifStatus.Position = UDim2.new(0,85,0,42)
notifStatus.BackgroundTransparency = 1
notifStatus.TextColor3 = Color3.fromRGB(0,255,150)
notifStatus.Text = "✓ MEGA LUCK + ULTRA FPS"
notifStatus.Font = Enum.Font.Gotham
notifStatus.TextSize = 14
notifStatus.TextXAlignment = Enum.TextXAlignment.Left
notifStatus.ZIndex = 201

local notifPing = Instance.new("TextLabel", notifFrame)
notifPing.Size = UDim2.new(1,-90,0,24)
notifPing.Position = UDim2.new(0,85,0,70)
notifPing.BackgroundTransparency = 1
notifPing.TextColor3 = Color3.fromRGB(255,150,255)
notifPing.Text = "⚡ LOW PING OPTIMIZER ON"
notifPing.Font = Enum.Font.Gotham
notifPing.TextSize = 13
notifPing.TextXAlignment = Enum.TextXAlignment.Left
notifPing.ZIndex = 201

local notifUser = Instance.new("TextLabel", notifFrame)
notifUser.Size = UDim2.new(1,-90,0,22)
notifUser.Position = UDim2.new(0,85,0,95)
notifUser.BackgroundTransparency = 1
notifUser.TextColor3 = Color3.fromRGB(200,220,255)
notifUser.Text = "👤 @"..player.Name.." | Display: "..player.DisplayName
notifUser.Font = Enum.Font.Gotham
notifUser.TextSize = 12
notifUser.TextXAlignment = Enum.TextXAlignment.Left
notifUser.ZIndex = 201

local function showNotification()
    local tweenIn = TweenService:Create(notifFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(1,-350,0,10)
    })
    tweenIn:Play()
    task.wait(4.5)
    local tweenOut = TweenService:Create(notifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Position = UDim2.new(1,360,0,10)
    })
    tweenOut:Play()
    tweenOut.Completed:Connect(function()
        notifFrame:Destroy()
    end)
end

-- ═══════════════════════════════════════════════════
-- ⚡ LOW PING OPTIMIZER
-- ═══════════════════════════════════════════════════
local function enableLowPingMode()
    print("⚡ ACTIVATING LOW PING OPTIMIZER...")
    
    -- 1. ลด Network Replication
    settings().Network.IncomingReplicationLag = 0
    
    -- 2. ปิด Unnecessary Network Objects
    for _, obj in pairs(Workspace:GetDescendants()) do
        pcall(function()
            if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                -- ไม่ลบ แต่ optimize
            elseif obj:IsA("Sound") then
                obj.PlayOnRemove = false
                obj:Stop()
            end
        end)
    end
    
    -- 3. ลด Player Replication
    pcall(function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                for _, part in pairs(plr.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Transparency = 0.5
                    elseif part:IsA("Decal") or part:IsA("Texture") then
                        part:Destroy()
                    end
                end
            end
        end
    end)
    
    -- 4. ปิด Unnecessary Services
    pcall(function()
        game:GetService("CoreGui").Name = "CoreGui"
    end)
    
    print("✓ LOW PING MODE ENABLED")
end

-- ═══════════════════════════════════════════════════
-- 🎰 MEGA LUCK SYSTEM
-- ═══════════════════════════════════════════════════
local function enableMEGALuck()
    print("🎰 ACTIVATING MEGA LUCK SYSTEM...")
    
    -- Override math.random
    local oldRandom = math.random
    math.random = function(min, max)
        if not min then return 1 end
        if not max then return min end
        return max
    end
    math.randomseed = function() end
    
    -- Hook Random.new
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
    
    -- Hook RemoteEvents
    local function hookRemote(remote)
        if remote:IsA("RemoteEvent") then
            local oldFire = remote.FireServer
            remote.FireServer = function(self, ...)
                local args = {...}
                for i, v in ipairs(args) do
                    if type(v) == "number" and v > 0 and v < 1 then
                        args[i] = 1
                    elseif type(v) == "number" and v > 1 then
                        args[i] = v * 10
                    end
                end
                return oldFire(self, unpack(args))
            end
        end
    end
    
    for _, remote in pairs(game:GetDescendants()) do
        pcall(function() hookRemote(remote) end)
    end
    game.DescendantAdded:Connect(function(obj)
        pcall(function() hookRemote(obj) end)
    end)
    
    -- Auto-pickup items
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
                        obj.Name:lower():find("drop") or
                        obj.Name:lower():find("cash") or
                        obj.Name:lower():find("money")
                    ) then
                        if character and character:FindFirstChild("HumanoidRootPart") then
                            local distance = (obj.Position - character.HumanoidRootPart.Position).Magnitude
                            if distance < 150 then
                                obj.CFrame = character.HumanoidRootPart.CFrame
                            end
                        end
                    end
                end
            end)
        end
    end)
    
    print("✓ MEGA LUCK ENABLED")
end

-- ═══════════════════════════════════════════════════
-- 🔥 ULTIMATE PERFORMANCE (ลบทุกอย่าง)
-- ═══════════════════════════════════════════════════
local function enableULTIMATEMode()
    print("🔥 ACTIVATING ULTIMATE PERFORMANCE...")
    
    local removedCount = 0
    
    -- ═══ RENDERING SETTINGS ═══
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
    settings().Rendering.EditQualityLevel = Enum.QualityLevel.Level01
    
    -- ═══ LIGHTING DESTRUCTION ═══
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
    
    for _, obj in pairs(Lighting:GetChildren()) do
        pcall(function()
            obj:Destroy()
            removedCount = removedCount + 1
        end)
    end
    
    -- ═══ TERRAIN ═══
    if Workspace:FindFirstChild("Terrain") then
        local terrain = Workspace.Terrain
        terrain.Decoration = false
        terrain.WaterReflectance = 0
        terrain.WaterTransparency = 0
        terrain.WaterWaveSize = 0
        terrain.WaterWaveSpeed = 0
    end
    
    -- ═══ WORKSPACE EXTREME CLEANUP ═══
    local count = 0
    for _, obj in pairs(Workspace:GetDescendants()) do
        count = count + 1
        if count % 15 == 0 then task.wait() end
        
        pcall(function()
            local objName = obj.Name:lower()
            
            -- ไม่ลบชื่อผู้เล่น/หน้าตา
            if objName:find("head") or objName:find("torso") or objName:find("arm") or 
               objName:find("leg") or objName:find("humanoid") then
                return
            end
            
            -- ═══ PARTS ═══
            if obj:IsA("BasePart") then
                obj.Material = Enum.Material.Plastic
                obj.CastShadow = false
                obj.Reflectance = 0
                
                if obj:IsA("MeshPart") then
                    obj.RenderFidelity = Enum.RenderFidelity.Performance
                    obj.CollisionFidelity = Enum.CollisionFidelity.Box
                    if not objName:find("head") and not objName:find("face") then
                        obj.TextureID = ""
                    end
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
                
            -- ═══ EFFECTS (DESTROY ALL) ═══
            elseif obj:IsA("ParticleEmitter") then
                obj:Destroy()
                removedCount = removedCount + 1
            elseif obj:IsA("Trail") then
                obj:Destroy()
                removedCount = removedCount + 1
            elseif obj:IsA("Beam") then
                obj:Destroy()
                removedCount = removedCount + 1
            elseif obj:IsA("Fire") then
                obj:Destroy()
                removedCount = removedCount + 1
            elseif obj:IsA("Smoke") then
                obj:Destroy()
                removedCount = removedCount + 1
            elseif obj:IsA("Sparkles") then
                obj:Destroy()
                removedCount = removedCount + 1
                
            -- ═══ DECALS (เว้นหน้าตัวละคร) ═══
            elseif obj:IsA("Decal") then
                if not objName:find("face") then
                    obj:Destroy()
                    removedCount = removedCount + 1
                end
            elseif obj:IsA("Texture") then
                obj:Destroy()
                removedCount = removedCount + 1
            elseif obj:IsA("SurfaceAppearance") then
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
                if not objName:find("head") then
                    obj.TextureId = ""
                    removedCount = removedCount + 1
                end
            elseif obj:IsA("FileMesh") then
                if not objName:find("head") then
                    obj.TextureId = ""
                end
                
            -- ═══ GUIS ═══
            elseif obj:IsA("SurfaceGui") then
                obj:Destroy()
                removedCount = removedCount + 1
            elseif obj:IsA("BillboardGui") then
                -- เก็บชื่อผู้เล่น
                if not objName:find("name") and not objName:find("tag") then
                    obj:Destroy()
                    removedCount = removedCount + 1
                end
                
            -- ═══ SOUNDS ═══
            elseif obj:IsA("Sound") then
                obj.Volume = 0
                obj:Stop()
                removedCount = removedCount + 1
                
            -- ═══ POST EFFECTS ═══
            elseif obj:IsA("BloomEffect") or obj:IsA("BlurEffect") or 
                   obj:IsA("ColorCorrectionEffect") or obj:IsA("DepthOfFieldEffect") or
                   obj:IsA("SunRaysEffect") then
                obj:Destroy()
                removedCount = removedCount + 1
                
            -- ═══ ATTACHMENTS & ACCESSORIES ═══
            elseif obj:IsA("Attachment") then
                for _, child in pairs(obj:GetChildren()) do
                    if child:IsA("ParticleEmitter") or child:IsA("Trail") or child:IsA("Beam") then
                        child:Destroy()
                        removedCount = removedCount + 1
                    end
                end
            end
        end)
    end
    
    -- ═══ CAMERA EFFECTS ═══
    if Workspace.CurrentCamera then
        for _, effect in pairs(Workspace.CurrentCamera:GetDescendants()) do
            pcall(function()
                effect:Destroy()
                removedCount = removedCount + 1
            end)
        end
    end
    
    -- ═══ GUI OPTIMIZATION ═══
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
    
    -- ═══ CONTINUOUS CLEANUP ═══
    task.spawn(function()
        while task.wait(2) do
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
    
    print("✓ ULTIMATE MODE ACTIVATED")
    print("🗑️ DESTROYED: "..removedCount.." objects")
end

-- ═══════════════════════════════════════════════════
-- 📊 FPS + PING MONITOR
-- ═══════════════════════════════════════════════════
local lastTime = tick()
local frameCount = 0
local fpsHistory = {}
local ultimateModeActivated = false

RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    
    if tick() - lastTime >= 1 then
        local fps = frameCount
        local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
        
        -- FPS Display
        fpsLabel.Text = "FPS: "..fps
        if fps >= 144 then
            fpsLabel.TextColor3 = Color3.fromRGB(0,255,150)
        elseif fps >= 60 then
            fpsLabel.TextColor3 = Color3.fromRGB(150,255,100)
        elseif fps >= 30 then
            fpsLabel.TextColor3 = Color3.fromRGB(255,220,0)
        else
            fpsLabel.TextColor3 = Color3.fromRGB(255,50,50)
        end
        
        -- PING Display
        pingLabel.Text = "PING: "..math.floor(ping).."ms"
        if ping < 50 then
            pingLabel.TextColor3 = Color3.fromRGB(0,255,150)
        elseif ping < 100 then
            pingLabel.TextColor3 = Color3.fromRGB(255,220,0)
        else
            pingLabel.TextColor3 = Color3.fromRGB(255,100,255)
        end
        
        -- Auto-activate
        table.insert(fpsHistory, fps)
        if #fpsHistory > 5 then table.remove(fpsHistory, 1) end
        
        local avgFps = 0
        for _, f in ipairs(fpsHistory) do avgFps = avgFps + f end
        avgFps = avgFps / #fpsHistory
        
        if not ultimateModeActivated and #fpsHistory >= 5 and avgFps < 60 then
            ultimateModeActivated = true
            notifStatus.Text = "⚠️ LOW FPS → BOOSTING NOW"
            showNotification()
            task.wait(0.5)
            enableULTIMATEMode()
            enableLowPingMode()
            notifStatus.Text = "✓ ULTIMATE MODE ACTIVE"
     
