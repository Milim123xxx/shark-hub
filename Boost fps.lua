-- ═══════════════════════════════════════════════════
-- 🦈 SHARK HUB ULTIMATE FPS BOOSTER
-- ลบเอฟเฟคทุกอย่าง + แก้ PING
-- ═══════════════════════════════════════════════════

print("🦈 SHARK HUB LOADING...")

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera

-- ═══════════════════════════════════════════════════
-- 🔥 EXTREME GRAPHICS DESTROYER
-- ═══════════════════════════════════════════════════

local function destroyGraphics()
    print("🔥 DESTROYING GRAPHICS...")
    
    -- Graphics Settings (ต่ำสุด)
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
        settings().Rendering.EditQualityLevel = Enum.QualityLevel.Level01
        
        local UserGameSettings = UserSettings():GetService("UserGameSettings")
        UserGameSettings.SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel1
        UserGameSettings.GraphicsQualityLevel = 1
    end)
    
    -- Lighting
    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.FogStart = 9e9
        Lighting.Brightness = 0
        Lighting.ClockTime = 12
        Lighting.FogColor = Color3.fromRGB(255, 255, 255)
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        Lighting.Ambient = Color3.fromRGB(128, 128, 128)
        Lighting.EnvironmentDiffuseScale = 0
        Lighting.EnvironmentSpecularScale = 0
        Lighting.ShadowSoftness = 0
        Lighting.Technology = Enum.Technology.Compatibility
        
        -- ลบทุก Effect ใน Lighting
        for _, obj in pairs(Lighting:GetChildren()) do
            if obj:IsA("PostEffect") or obj:IsA("BloomEffect") or obj:IsA("BlurEffect") or
               obj:IsA("ColorCorrectionEffect") or obj:IsA("DepthOfFieldEffect") or
               obj:IsA("SunRaysEffect") or obj:IsA("Atmosphere") or obj:IsA("Sky") or
               obj:IsA("Clouds") then
                obj:Destroy()
            end
        end
    end)
    
    -- Terrain
    pcall(function()
        local terrain = Workspace:FindFirstChildOfClass("Terrain")
        if terrain then
            terrain.WaterWaveSize = 0
            terrain.WaterWaveSpeed = 0
            terrain.WaterReflectance = 0
            terrain.WaterTransparency = 1
            terrain.Decoration = false
        end
    end)
    
    print("✓ Graphics Destroyed")
end

-- ═══════════════════════════════════════════════════
-- 💣 MEGA EFFECT DESTROYER (ลบเอฟเฟคทุกอย่าง)
-- ═══════════════════════════════════════════════════

local function destroyAllEffects()
    print("💣 DESTROYING ALL EFFECTS...")
    
    local effectsDestroyed = 0
    local objectsOptimized = 0
    
    -- Workspace
    for _, obj in pairs(Workspace:GetDescendants()) do
        pcall(function()
            local name = obj.Name:lower()
            local parent = obj.Parent and obj.Parent.Name:lower() or ""
            
            -- เก็บตัวละคร
            if name == "humanoid" or name == "head" or name:find("torso") or 
               name:find("arm") or name:find("leg") or name == "humanoidrootpart" then
                return
            end
            
            -- เก็บชื่อผู้เล่น
            if name:find("nametag") or name:find("overhead") or name:find("healthbar") or
               parent:find("nametag") or parent:find("overhead") then
                return
            end
            
            -- ลบ Particle Effects
            if obj:IsA("ParticleEmitter") then
                obj:Destroy()
                effectsDestroyed = effectsDestroyed + 1
                
            -- ลบ Trail Effects
            elseif obj:IsA("Trail") then
                obj:Destroy()
                effectsDestroyed = effectsDestroyed + 1
                
            -- ลบ Beam Effects
            elseif obj:IsA("Beam") then
                obj:Destroy()
                effectsDestroyed = effectsDestroyed + 1
                
            -- ลบ Fire Effects
            elseif obj:IsA("Fire") then
                obj:Destroy()
                effectsDestroyed = effectsDestroyed + 1
                
            -- ลบ Smoke Effects
            elseif obj:IsA("Smoke") then
                obj:Destroy()
                effectsDestroyed = effectsDestroyed + 1
                
            -- ลบ Sparkles Effects
            elseif obj:IsA("Sparkles") then
                obj:Destroy()
                effectsDestroyed = effectsDestroyed + 1
                
            -- ลบ Explosion Effects
            elseif obj:IsA("Explosion") then
                obj:Destroy()
                effectsDestroyed = effectsDestroyed + 1
                
            -- ลบ Light Effects
            elseif obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
                obj:Destroy()
                effectsDestroyed = effectsDestroyed + 1
                
            -- ลบ Decals/Textures
            elseif obj:IsA("Decal") then
                if name ~= "face" then
                    obj:Destroy()
                    effectsDestroyed = effectsDestroyed + 1
                end
                
            elseif obj:IsA("Texture") or obj:IsA("SurfaceAppearance") then
                obj:Destroy()
                effectsDestroyed = effectsDestroyed + 1
                
            -- Optimize Parts
            elseif obj:IsA("MeshPart") then
                obj.Material = Enum.Material.Plastic
                obj.Reflectance = 0
                obj.CastShadow = false
                obj.TextureID = ""
                obj.RenderFidelity = Enum.RenderFidelity.Performance
                obj.CollisionFidelity = Enum.CollisionFidelity.Box
                obj.DoubleSided = false
                objectsOptimized = objectsOptimized + 1
                
            elseif obj:IsA("Part") or obj:IsA("WedgePart") or obj:IsA("UnionOperation") then
                obj.Material = Enum.Material.Plastic
                obj.Reflectance = 0
                obj.CastShadow = false
                objectsOptimized = objectsOptimized + 1
                
            -- Remove Mesh Textures
            elseif obj:IsA("SpecialMesh") or obj:IsA("FileMesh") then
                obj.TextureId = ""
                objectsOptimized = objectsOptimized + 1
                
            -- Disable Sounds
            elseif obj:IsA("Sound") then
                obj.Volume = 0
                if obj.IsPlaying then
                    obj:Stop()
                end
                
            -- Remove GUI (keep player names)
            elseif obj:IsA("SurfaceGui") then
                if not name:find("name") and not name:find("health") then
                    obj:Destroy()
                    effectsDestroyed = effectsDestroyed + 1
                end
                
            elseif obj:IsA("BillboardGui") then
                if not name:find("name") and not name:find("health") and 
                   not name:find("overhead") and not parent:find("name") then
                    obj:Destroy()
                    effectsDestroyed = effectsDestroyed + 1
                end
            end
        end)
    end
    
    -- Camera Effects
    pcall(function()
        for _, effect in pairs(camera:GetChildren()) do
            if effect:IsA("PostEffect") or effect:IsA("BloomEffect") or 
               effect:IsA("BlurEffect") or effect:IsA("ColorCorrectionEffect") or
               effect:IsA("DepthOfFieldEffect") or effect:IsA("SunRaysEffect") then
                effect:Destroy()
                effectsDestroyed = effectsDestroyed + 1
            end
        end
    end)
    
    -- ReplicatedStorage Effects
    pcall(function()
        for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
                obj:Destroy()
                effectsDestroyed = effectsDestroyed + 1
            end
        end
    end)
    
    print("✓ Effects Destroyed: " .. effectsDestroyed)
    print("✓ Objects Optimized: " .. objectsOptimized)
end

-- ═══════════════════════════════════════════════════
-- ⚡ NETWORK OPTIMIZER (แก้ PING)
-- ═══════════════════════════════════════════════════

local function optimizeNetwork()
    print("⚡ OPTIMIZING NETWORK...")
    
    -- Network Settings
    pcall(function()
        settings().Network.IncomingReplicationLag = 0
        settings().Network.PhysicsSend = 1
        settings().Network.PhysicsReceive = 1
        settings().Network.ExperimentalPhysicsEnabled = false
    end)
    
    -- Simplify Other Players
    pcall(function()
        for _, otherPlayer in pairs(Players:GetPlayers()) do
            if otherPlayer ~= player and otherPlayer.Character then
                for _, part in pairs(otherPlayer.Character:GetDescendants()) do
                    pcall(function()
                        if part:IsA("BasePart") then
                            if part.Name ~= "Head" and part.Name ~= "HumanoidRootPart" then
                                part.Transparency = 0.8
                                part.CanCollide = false
                                part.CastShadow = false
                            end
                        elseif part:IsA("ParticleEmitter") or part:IsA("Trail") or part:IsA("Beam") then
                            part:Destroy()
                        end
                    end)
                end
            end
        end
    end)
    
    print("✓ Network Optimized")
end

-- ═══════════════════════════════════════════════════
-- 👁️ PLAYER ESP (เห็นชื่อผู้เล่น)
-- ═══════════════════════════════════════════════════

local function createESP(targetPlayer)
    if targetPlayer == player then return end
    
    local function addESP(character)
        if not character then return end
        
        pcall(function()
            local hrp = character:WaitForChild("HumanoidRootPart", 5)
            local humanoid = character:WaitForChild("Humanoid", 5)
            if not hrp or not humanoid then return end
            
            -- Remove old ESP
            for _, old in pairs(hrp:GetChildren()) do
                if old.Name == "ESP_GUI" then
                    old:Destroy()
                end
            end
            
            -- Create BillboardGui
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "ESP_GUI"
            billboard.Adornee = hrp
            billboard.Size = UDim2.new(0, 200, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.AlwaysOnTop = true
            billboard.Parent = hrp
            
            -- Player Name
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            nameLabel.TextStrokeTransparency = 0
            nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            nameLabel.Text = targetPlayer.Name
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.TextSize = 16
            nameLabel.Parent = billboard
            
            -- Distance
            local distLabel = Instance.new("TextLabel")
            distLabel.Size = UDim2.new(1, 0, 0.5, 0)
            distLabel.Position = UDim2.new(0, 0, 0.5, 0)
            distLabel.BackgroundTransparency = 1
            distLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
            distLabel.TextStrokeTransparency = 0
            distLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            distLabel.Text = "0m"
            distLabel.Font = Enum.Font.Gotham
            distLabel.TextSize = 14
            distLabel.Parent = billboard
            
            -- Update Distance
            task.spawn(function()
                while billboard and billboard.Parent and humanoid.Health > 0 do
                    pcall(function()
                        local char = player.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            local dist = (char.HumanoidRootPart.Position - hrp.Position).Magnitude
                            distLabel.Text = math.floor(dist) .. "m"
                            
                            if dist < 50 then
                                nameLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                            elseif dist < 100 then
                                nameLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                            else
                                nameLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                            end
                        end
                    end)
                    task.wait(0.5)
                end
                if billboard then billboard:Destroy() end
            end)
            
            humanoid.Died:Connect(function()
                task.wait(0.5)
                if billboard then billboard:Destroy() end
            end)
        end)
    end
    
    if targetPlayer.Character then
        addESP(targetPlayer.Character)
    end
    
    targetPlayer.CharacterAdded:Connect(function(char)
        task.wait(1)
        addESP(char)
    end)
end

local function setupESP()
    print("👁️ SETTING UP ESP...")
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        createESP(otherPlayer)
    end
    
    Players.PlayerAdded:Connect(function(otherPlayer)
        createESP(otherPlayer)
    end)
    
    print("✓ ESP Active")
end

-- ═══════════════════════════════════════════════════
-- 🔄 CONTINUOUS EFFECT DESTROYER
-- ═══════════════════════════════════════════════════

local function continuousDestroyer()
    task.spawn(function()
        while task.wait(2) do
            pcall(function()
                for _, obj in pairs(Workspace:GetDescendants()) do
                    pcall(function()
                        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or 
                           obj:IsA("Beam") or obj:IsA("Fire") or obj:IsA("Smoke") or
                           obj:IsA("Sparkles") or obj:IsA("PointLight") or 
                           obj:IsA("SpotLight") or obj:IsA("SurfaceLight") or
                           obj:IsA("Explosion") then
                            obj:Destroy()
                        end
                    end)
                end
            end)
        end
    end)
    print("✓ Continuous Destroyer Active")
end

-- ═══════════════════════════════════════════════════
-- 🎰 AUTO PICKUP
-- ═══════════════════════════════════════════════════

local function autoPickup()
    task.spawn(function()
        local char = player.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        while task.wait(0.5) do
            pcall(function()
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("BasePart") then
                        local n = obj.Name:lower()
                        if n:find("coin") or n:find("gem") or n:find("cash") or 
                           n:find("money") or n:find("orb") or n:find("pickup") or
                           n:find("collectible") or n:find("drop") then
                            local dist = (obj.Position - hrp.Position).Magnitude
                            if dist < 300 then
                                obj.CFrame = hrp.CFrame
                            end
                        end
                    end
                end
            end)
        end
    end)
    print("✓ Auto Pickup Active")
end

-- ═══════════════════════════════════════════════════
-- 📊 FPS/PING COUNTER
-- ═══════════════════════════════════════════════════

local function createCounter()
    local playerGui = player:WaitForChild("PlayerGui")
    
    for _, gui in pairs(playerGui:GetChildren()) do
        if gui.Name == "SharkFPS" then
            gui:Destroy()
        end
    end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SharkFPS"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 160, 0, 70)
    frame.Position = UDim2.new(0.5, -80, 0, 10)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame
    
    local fpsLabel = Instance.new("TextLabel")
    fpsLabel.Size = UDim2.new(1, 0, 0.5, 0)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    fpsLabel.Text = "FPS: --"
    fpsLabel.Font = Enum.Font.GothamBold
    fpsLabel.TextSize = 20
    fpsLabel.Parent = frame
    
    local pingLabel = Instance.new("TextLabel")
    pingLabel.Size = UDim2.new(1, 0, 0.5, 0)
    pingLabel.Position = UDim2.new(0, 0, 0.5, 0)
    pingLabel.BackgroundTransparency = 1
    pingLabel.TextColor3 = Color3.fromRGB(255, 0, 255)
    pingLabel.Text = "PING: --"
    pingLabel.Font = Enum.Font.GothamBold
    pingLabel.TextSize = 20
    pingLabel.Parent = frame
    
    local lastTime = tick()
    local frames = 0
    
    RunService.Heartbeat:Connect(function()
        frames = frames + 1
        if tick() - lastTime >= 1 then
            pcall(function()
                fpsLabel.Text = "FPS: " .. frames
                local ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
                pingLabel.Text = "PING: " .. ping .. "ms"
                
                if frames >= 60 then
                    fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                elseif frames >= 30 then
                    fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                else
                    fpsLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                end
                
                if ping < 100 then
                    pingLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                elseif ping < 200 then
                    pingLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                else
                    pingLabel.TextColor3 = Color3.fromRGB(255, 0, 255)
                end
            end)
            frames = 0
            lastTime = tick()
        end
    end)
end

-- ═══════════════════════════════════════════════════
-- 🚀 EXECUTE
-- ═══════════════════════════════════════════════════

print("═══════════════════════════════════")
print("🦈 SHARK HUB ULTIMATE")
print("═══════════════════════════════════")

task.wait(0.5)
destroyGraphics()

task.wait(0.3)
destroyAllEffects()

task.wait(0.3)
optimizeNetwork()

task.wait(0.3)
setupESP()

task.wait(0.3)
continuousDestroyer()

task.wait(0.3)
autoPickup()

task.wait(0.3)
createCounter()

print("═══════════════════════════════════")
print("✓ SHARK HUB READY!")
print("✓ FPS BOOST ACTIVE!")
print("✓ PING OPTIMIZED!")
print("✓ ESP ACTIVE!")
print("═══════════════════════════════════")

player.CharacterAdded:Connect(function()
    task.wait(2)
    autoPickup()
end)
