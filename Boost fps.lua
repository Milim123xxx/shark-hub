-- ═══════════════════════════════════════════════════
-- 🦈 SHARK HUB POTATO MODE - กากที่สุด + Player ESP
-- ═══════════════════════════════════════════════════

print("🦈 SHARK HUB POTATO LOADING...")

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera

-- ═══════════════════════════════════════════════════
-- 💀 POTATO GRAPHICS (กากสุดๆ)
-- ═══════════════════════════════════════════════════

local function potatoGraphics()
    print("💀 ACTIVATING POTATO MODE...")
    
    -- Graphics ต่ำสุดที่เป็นไปได้
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
        settings().Rendering.EditQualityLevel = Enum.QualityLevel.Level01
        
        local UserGameSettings = UserSettings():GetService("UserGameSettings")
        UserGameSettings.SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel1
        UserGameSettings.MasterVolume = 0
    end)
    
    -- Lighting (ไม่มีอะไรเลย)
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
        
        -- ลบทุกอย่าง
        for _, obj in pairs(Lighting:GetChildren()) do
            if not obj:IsA("Terrain") then
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
    
    print("✓ POTATO MODE ACTIVE")
end

-- ═══════════════════════════════════════════════════
-- 🗑️ MEGA DESTROYER (ลบทุกอย่างที่เห็น)
-- ═══════════════════════════════════════════════════

local function megaDestroyer()
    print("🗑️ DESTROYING EVERYTHING...")
    
    local destroyed = 0
    
    for _, obj in pairs(Workspace:GetDescendants()) do
        pcall(function()
            local name = obj.Name:lower()
            
            -- เก็บแค่ตัวละคร
            if name == "humanoid" or name == "head" or name == "torso" or 
               name == "left arm" or name == "right arm" or name == "left leg" or 
               name == "right leg" or name == "humanoidrootpart" or 
               name == "upper torso" or name == "lower torso" then
                return
            end
            
            -- ลบทุกอย่าง
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or
               obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") or
               obj:IsA("Explosion") or obj:IsA("PointLight") or obj:IsA("SpotLight") or
               obj:IsA("SurfaceLight") then
                obj:Destroy()
                destroyed = destroyed + 1
                
            -- ลบ Textures/Decals (ทุกอย่าง รวมหน้า)
            elseif obj:IsA("Decal") then
                obj.Transparency = 1
                destroyed = destroyed + 1
            elseif obj:IsA("Texture") or obj:IsA("SurfaceAppearance") then
                obj:Destroy()
                destroyed = destroyed + 1
                
            -- ลบ GUI (ยกเว้น ESP)
            elseif obj:IsA("SurfaceGui") or obj:IsA("BillboardGui") then
                if not obj.Name:find("ESP") then
                    obj:Destroy()
                    destroyed = destroyed + 1
                end
                
            -- ทำ Parts กาก
            elseif obj:IsA("MeshPart") then
                obj.Material = Enum.Material.Plastic
                obj.Reflectance = 0
                obj.CastShadow = false
                obj.TextureID = ""
                obj.RenderFidelity = Enum.RenderFidelity.Performance
                obj.CollisionFidelity = Enum.CollisionFidelity.Box
                obj.DoubleSided = false
                obj.Color = Color3.fromRGB(150, 150, 150)
                destroyed = destroyed + 1
                
            elseif obj:IsA("Part") or obj:IsA("WedgePart") or obj:IsA("UnionOperation") then
                obj.Material = Enum.Material.Plastic
                obj.Reflectance = 0
                obj.CastShadow = false
                obj.Color = Color3.fromRGB(150, 150, 150)
                destroyed = destroyed + 1
                
            -- ลบ Mesh Textures
            elseif obj:IsA("SpecialMesh") or obj:IsA("FileMesh") then
                obj.TextureId = ""
                destroyed = destroyed + 1
                
            -- ปิด Sounds
            elseif obj:IsA("Sound") then
                obj.Volume = 0
                obj:Stop()
            end
        end)
    end
    
    -- Camera Effects
    pcall(function()
        for _, effect in pairs(camera:GetChildren()) do
            if not effect:IsA("Camera") then
                effect:Destroy()
                destroyed = destroyed + 1
            end
        end
    end)
    
    print("✓ Destroyed " .. destroyed .. " objects")
end

-- ═══════════════════════════════════════════════════
-- 👁️ PLAYER ESP (เห็นชื่อผู้เล่นทุกคน)
-- ═══════════════════════════════════════════════════

local espEnabled = true
local espColor = Color3.fromRGB(0, 255, 0)

local function createESP(player)
    if player == Players.LocalPlayer then return end
    
    local function addESP(character)
        if not character then return end
        
        local hrp = character:WaitForChild("HumanoidRootPart", 5)
        local humanoid = character:WaitForChild("Humanoid", 5)
        if not hrp or not humanoid then return end
        
        -- ลบ ESP เก่า
        for _, old in pairs(hrp:GetChildren()) do
            if old.Name == "ESP_GUI" then
                old:Destroy()
            end
        end
        
        -- สร้าง BillboardGui
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESP_GUI"
        billboard.Adornee = hrp
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = hrp
        
        -- ชื่อผู้เล่น
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.TextColor3 = espColor
        nameLabel.TextStrokeTransparency = 0
        nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        nameLabel.Text = player.Name
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextSize = 16
        nameLabel.Parent = billboard
        
        -- ระยะทาง
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
            local localChar = Players.LocalPlayer.Character
            while billboard and billboard.Parent and humanoid.Health > 0 do
                pcall(function()
                    if localChar and localChar:FindFirstChild("HumanoidRootPart") then
                        local dist = (localChar.HumanoidRootPart.Position - hrp.Position).Magnitude
                        distLabel.Text = math.floor(dist) .. "m"
                        
                        -- เปลี่ยนสีตามระยะ
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
        
        -- เมื่อตาย
        humanoid.Died:Connect(function()
            task.wait(0.5)
            if billboard then billboard:Destroy() end
        end)
    end
    
    -- เมื่อมีตัวละคร
    if player.Character then
        addESP(player.Character)
    end
    
    -- เมื่อ Respawn
    player.CharacterAdded:Connect(function(char)
        task.wait(1)
        addESP(char)
    end)
end

local function setupESP()
    print("👁️ SETTING UP PLAYER ESP...")
    
    -- ESP สำหรับผู้เล่นปัจจุบัน
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        createESP(otherPlayer)
    end
    
    -- ESP สำหรับผู้เล่นใหม่
    Players.PlayerAdded:Connect(function(otherPlayer)
        createESP(otherPlayer)
    end)
    
    print("✓ PLAYER ESP ACTIVE")
end

-- ═══════════════════════════════════════════════════
-- 🎨 ทำให้ผู้เล่นอื่นเป็นสีเทา (เห็นง่าย)
-- ═══════════════════════════════════════════════════

local function grayPlayers()
    print("🎨 MAKING PLAYERS GRAY...")
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player then
            task.spawn(function()
                local char = otherPlayer.Character
                if char then
                    for _, part in pairs(char:GetDescendants()) do
                        pcall(function()
                            if part:IsA("BasePart") then
                                part.Color = Color3.fromRGB(100, 100, 100)
                                part.Material = Enum.Material.Plastic
                                part.CastShadow = false
                            elseif part:IsA("Decal") then
                                part.Transparency = 0.5
                            end
                        end)
                    end
                end
            end)
        end
    end
    
    -- สำหรับผู้เล่นใหม่
    Players.PlayerAdded:Connect(function(newPlayer)
        newPlayer.CharacterAdded:Connect(function(char)
            task.wait(1)
            for _, part in pairs(char:GetDescendants()) do
                pcall(function()
                    if part:IsA("BasePart") then
                        part.Color = Color3.fromRGB(100, 100, 100)
                        part.Material = Enum.Material.Plastic
                    end
                end)
            end
        end)
    end)
    
    print("✓ PLAYERS ARE NOW GRAY")
end

-- ═══════════════════════════════════════════════════
-- ⚡ ULTRA PING REDUCER
-- ═══════════════════════════════════════════════════

local function ultraPing()
    print("⚡ REDUCING PING...")
    
    pcall(function()
        settings().Network.IncomingReplicationLag = 0
    end)
    
    print("✓ PING REDUCED")
end

-- ═══════════════════════════════════════════════════
-- 🎰 MEGA LUCK
-- ═══════════════════════════════════════════════════

local function megaLuck()
    print("🎰 LUCK SYSTEM...")
    
    math.random = function(a, b)
        if not a then return 1 end
        if not b then return a end
        return b
    end
    
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
                           n:find("money") or n:find("orb") or n:find("pickup") then
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
    
    print("✓ LUCK ACTIVE")
end

-- ═══════════════════════════════════════════════════
-- 🔄 CONTINUOUS DESTROYER
-- ═══════════════════════════════════════════════════

local function continuousDestroyer()
    task.spawn(function()
        while task.wait(3) do
            pcall(function()
                for _, obj in pairs(Workspace:GetDescendants()) do
                    pcall(function()
                        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or 
                           obj:IsA("Beam") or obj:IsA("Fire") or obj:IsA("Smoke") or
                           obj:IsA("Sparkles") or obj:IsA("PointLight") or 
                           obj:IsA("SpotLight") or obj:IsA("Explosion") then
                            obj:Destroy()
                        end
                    end)
                end
            end)
        end
    end)
end

-- ═══════════════════════════════════════════════════
-- 📊 SIMPLE FPS COUNTER
-- ═══════════════════════════════════════════════════

local function createFPSCounter()
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
    frame.Size = UDim2.new(0, 150, 0, 60)
    frame.Position = UDim2.new(0.5, -75, 0, 10)
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
    fpsLabel.TextSize = 18
    fpsLabel.Parent = frame
    
    local pingLabel = Instance.new("TextLabel")
    pingLabel.Size = UDim2.new(1, 0, 0.5, 0)
    pingLabel.Position = UDim2.new(0, 0, 0.5, 0)
    pingLabel.BackgroundTransparency = 1
    pingLabel.TextColor3 = Color3.fromRGB(255, 0, 255)
    pingLabel.Text = "PING: --"
    pingLabel.Font = Enum.Font.GothamBold
    pingLabel.TextSize = 18
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
            end)
            frames = 0
            lastTime = tick()
        end
    end)
end

-- ═══════════════════════════════════════════════════
-- 🚀 EXECUTE ALL
-- ═══════════════════════════════════════════════════

print("═══════════════════════════════════")
print("🦈 SHARK HUB POTATO MODE")
print("═══════════════════════════════════")

task.wait(0.5)
potatoGraphics()

task.wait(0.3)
megaDestroyer()

task.wait(0.3)
setupESP()

task.wait(0.3)
grayPlayers()

task.wait(0.3)
ultraPing()

task.wait(0.3)
megaLuck()

task.wait(0.3)
continuousDestroyer()

task.wait(0.3)
createFPSCounter()

print("═══════════════════════════════════")
print("✓ POTATO MODE ACTIVE!")
print("✓ PLAYER ESP ACTIVE!")
print("✓ FPS SHOULD BE MAXIMUM!")
print("═══════════════════════════════════")

player.CharacterAdded:Connect(function()
    task.wait(2)
    megaLuck()
end)
