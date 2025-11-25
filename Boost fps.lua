-- ═══════════════════════════════════════════════════
-- 🦈 SHARK HUB - FIXED VERSION (ไม่แล็ค)
-- ═══════════════════════════════════════════════════

print("════════════════════════════════")
print("🦈 SHARK HUB LOADING...")
print("════════════════════════════════")

-- Services
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ═══════════════════════════════════════════════════
-- 🔔 NOTIFICATION SYSTEM
-- ═══════════════════════════════════════════════════

local function showNotification(title, message, duration)
    pcall(function()
        -- ลบการแจ้งเตือนเก่า
        for _, gui in pairs(playerGui:GetChildren()) do
            if gui.Name == "SharkNotif" then
                gui:Destroy()
            end
        end
        
        -- สร้างการแจ้งเตือนใหม่
        local notifGui = Instance.new("ScreenGui")
        notifGui.Name = "SharkNotif"
        notifGui.ResetOnSpawn = false
        notifGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        notifGui.Parent = playerGui
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 350, 0, 100)
        frame.Position = UDim2.new(1, 360, 0, 20)
        frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        frame.BackgroundTransparency = 0.2
        frame.BorderSizePixel = 0
        frame.Parent = notifGui
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 15)
        corner.Parent = frame
        
        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(0, 255, 255)
        stroke.Thickness = 3
        stroke.Parent = frame
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, -20, 0, 35)
        titleLabel.Position = UDim2.new(0, 10, 0, 10)
        titleLabel.BackgroundTransparency = 1
        titleLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
        titleLabel.Text = title
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextSize = 18
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Parent = frame
        
        local messageLabel = Instance.new("TextLabel")
        messageLabel.Size = UDim2.new(1, -20, 0, 45)
        messageLabel.Position = UDim2.new(0, 10, 0, 45)
        messageLabel.BackgroundTransparency = 1
        messageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        messageLabel.Text = message
        messageLabel.Font = Enum.Font.Gotham
        messageLabel.TextSize = 14
        messageLabel.TextXAlignment = Enum.TextXAlignment.Left
        messageLabel.TextWrapped = true
        messageLabel.Parent = frame
        
        -- Slide in
        frame:TweenPosition(
            UDim2.new(1, -360, 0, 20),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Back,
            0.5,
            true
        )
        
        -- Slide out
        task.wait(duration or 3)
        frame:TweenPosition(
            UDim2.new(1, 360, 0, 20),
            Enum.EasingDirection.In,
            Enum.EasingStyle.Back,
            0.5,
            true,
            function()
                task.wait(0.5)
                notifGui:Destroy()
            end
        )
    end)
end

-- ═══════════════════════════════════════════════════
-- 📊 FPS/PING DISPLAY
-- ═══════════════════════════════════════════════════

local function createDisplay()
    pcall(function()
        -- ลบ GUI เก่า
        for _, gui in pairs(playerGui:GetChildren()) do
            if gui.Name == "SharkDisplay" then
                gui:Destroy()
            end
        end
        
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "SharkDisplay"
        screenGui.ResetOnSpawn = false
        screenGui.Parent = playerGui
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 150, 0, 65)
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
        
        -- Update
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
    end)
end

-- ═══════════════════════════════════════════════════
-- 🔥 ULTRA OPTIMIZER (ไม่แล็ค)
-- ═══════════════════════════════════════════════════

local function optimize()
    print("🔥 Starting Optimization...")
    
    local destroyed = 0
    
    -- Graphics
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        UserSettings():GetService("UserGameSettings").SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel1
    end)
    
    -- Lighting
    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.Brightness = 1
        
        for _, obj in pairs(Lighting:GetChildren()) do
            if obj:IsA("PostEffect") then
                obj:Destroy()
                destroyed = destroyed + 1
            end
        end
    end)
    
    -- Destroy Effects (แบ่งเป็น batch ไม่แล็ค)
    task.spawn(function()
        local count = 0
        local batch = 0
        
        for _, obj in pairs(Workspace:GetDescendants()) do
            count = count + 1
            
            -- พักทุก 300 objects
            if count % 300 == 0 then
                batch = batch + 1
                print("📦 Processing batch " .. batch .. "...")
                task.wait(0.1)
            end
            
            pcall(function()
                local name = obj.Name:lower()
                
                -- เก็บตัวละครและชื่อ
                if name:find("humanoid") or name:find("head") or name:find("torso") or
                   name:find("arm") or name:find("leg") or name:find("rootpart") or
                   name:find("nametag") or name:find("overhead") or name:find("health") then
                    return
                end
                
                -- ลบ Effects
                if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or
                   obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") or
                   obj:IsA("Explosion") then
                    obj:Destroy()
                    destroyed = destroyed + 1
                    
                -- ลบ Lights
                elseif obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
                    obj:Destroy()
                    destroyed = destroyed + 1
                    
                -- ลบ Textures
                elseif obj:IsA("Decal") and name ~= "face" then
                    obj:Destroy()
                    destroyed = destroyed + 1
                    
                elseif obj:IsA("Texture") or obj:IsA("SurfaceAppearance") then
                    obj:Destroy()
                    destroyed = destroyed + 1
                    
                -- Optimize Parts
                elseif obj:IsA("MeshPart") then
                    obj.TextureID = ""
                    obj.Material = Enum.Material.Plastic
                    obj.CastShadow = false
                    obj.RenderFidelity = Enum.RenderFidelity.Performance
                    destroyed = destroyed + 1
                    
                elseif obj:IsA("BasePart") then
                    obj.Material = Enum.Material.Plastic
                    obj.CastShadow = false
                    
                -- Sounds
                elseif obj:IsA("Sound") then
                    obj.Volume = 0
                end
            end)
        end
        
        print("✓ Destroyed " .. destroyed .. " objects")
    end)
end

-- ═══════════════════════════════════════════════════
-- ⚡ NETWORK FIX
-- ═══════════════════════════════════════════════════

local function fixNetwork()
    pcall(function()
        settings().Network.IncomingReplicationLag = 0
    end)
    print("✓ Network Fixed")
end

-- ═══════════════════════════════════════════════════
-- 👁️ SIMPLE ESP
-- ═══════════════════════════════════════════════════

local function addESP()
    task.spawn(function()
        for _, otherPlayer in pairs(Players:GetPlayers()) do
            if otherPlayer ~= player then
                pcall(function()
                    local function createESP(char)
                        local hrp = char:WaitForChild("HumanoidRootPart", 5)
                        if not hrp then return end
                        
                        -- ลบ ESP เก่า
                        for _, old in pairs(hrp:GetChildren()) do
                            if old.Name == "ESP" then
                                old:Destroy()
                            end
                        end
                        
                        local billboard = Instance.new("BillboardGui")
                        billboard.Name = "ESP"
                        billboard.Adornee = hrp
                        billboard.Size = UDim2.new(0, 200, 0, 50)
                        billboard.StudsOffset = Vector3.new(0, 3, 0)
                        billboard.AlwaysOnTop = true
                        billboard.Parent = hrp
                        
                        local nameLabel = Instance.new("TextLabel")
                        nameLabel.Size = UDim2.new(1, 0, 1, 0)
                        nameLabel.BackgroundTransparency = 1
                        nameLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                        nameLabel.TextStrokeTransparency = 0
                        nameLabel.Text = otherPlayer.Name
                        nameLabel.Font = Enum.Font.GothamBold
                        nameLabel.TextSize = 16
                        nameLabel.Parent = billboard
                        
                        -- Update distance
                        task.spawn(function()
                            while billboard and billboard.Parent do
                                pcall(function()
                                    local char = player.Character
                                    if char and char:FindFirstChild("HumanoidRootPart") then
                                        local dist = (char.HumanoidRootPart.Position - hrp.Position).Magnitude
                                        nameLabel.Text = otherPlayer.Name .. "\n" .. math.floor(dist) .. "m"
                                    end
                                end)
                                task.wait(0.5)
                            end
                        end)
                    end
                    
                    if otherPlayer.Character then
                        createESP(otherPlayer.Character)
                    end
                    
                    otherPlayer.CharacterAdded:Connect(function(char)
                        task.wait(1)
                        createESP(char)
                    end)
                end)
            end
        end
        
        Players.PlayerAdded:Connect(function(newPlayer)
            task.wait(2)
            if newPlayer.Character then
                pcall(function()
                    local hrp = newPlayer.Character:WaitForChild("HumanoidRootPart", 5)
                    if hrp then
                        local billboard = Instance.new("BillboardGui")
                        billboard.Name = "ESP"
                        billboard.Adornee = hrp
                        billboard.Size = UDim2.new(0, 200, 0, 50)
                        billboard.StudsOffset = Vector3.new(0, 3, 0)
                        billboard.AlwaysOnTop = true
                        billboard.Parent = hrp
                        
                        local nameLabel = Instance.new("TextLabel")
                        nameLabel.Size = UDim2.new(1, 0, 1, 0)
                        nameLabel.BackgroundTransparency = 1
                        nameLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                        nameLabel.TextStrokeTransparency = 0
                        nameLabel.Text = newPlayer.Name
                        nameLabel.Font = Enum.Font.GothamBold
                        nameLabel.TextSize = 16
                        nameLabel.Parent = billboard
                    end
                end)
            end
        end)
    end)
    
    print("✓ ESP Active")
end

-- ═══════════════════════════════════════════════════
-- 🔄 CONTINUOUS CLEANER (เบา)
-- ═══════════════════════════════════════════════════

local function startCleaner()
    task.spawn(function()
        while task.wait(3) do
            pcall(function()
                local count = 0
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or 
                       obj:IsA("Beam") or obj:IsA("Sparkles") then
                        obj:Destroy()
                        count = count + 1
                        if count >= 50 then break end
                    end
                end
            end)
        end
    end)
end

-- ═══════════════════════════════════════════════════
-- 🎰 AUTO PICKUP
-- ═══════════════════════════════════════════════════

local function autoPickup()
    task.spawn(function()
        while task.wait(0.5) do
            pcall(function()
                local char = player.Character
                if not char then return end
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("BasePart") then
                        local n = obj.Name:lower()
                        if n:find("coin") or n:find("gem") or n:find("cash") or 
                           n:find("money") or n:find("orb") then
                            local dist = (obj.Position - hrp.Position).Magnitude
                            if dist < 250 then
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
-- 🚀 MAIN EXECUTION
-- ═══════════════════════════════════════════════════

-- แสดงการแจ้งเตือนเริ่มต้น
showNotification("🦈 SHARK HUB", "กำลังโหลดระบบ...", 2)

task.wait(1)

-- สร้าง Display
createDisplay()
print("✓ Display Created")

task.wait(0.5)

-- Optimize
optimize()
showNotification("🔥 OPTIMIZER", "กำลังลบเอฟเฟค...", 2)

task.wait(1)

-- Fix Network
fixNetwork()
showNotification("⚡ NETWORK", "แก้ไข PING แล้ว", 2)

task.wait(1)

-- Add ESP
addESP()
showNotification("👁️ ESP", "เปิดใช้งาน ESP แล้ว", 2)

task.wait(1)

-- Start Cleaner
startCleaner()
print("✓ Continuous Cleaner Started")

task.wait(0.5)

-- Auto Pickup
autoPickup()

task.wait(0.5)

-- แสดงการแจ้งเตือนเสร็จสิ้น
showNotification("✅ SHARK HUB", "พร้อมใช้งาน! FPS Boost Active", 3)

print("════════════════════════════════")
print("✅ SHARK HUB READY!")
print("✅ FPS Boost: ACTIVE")
print("✅ Ping Fix: ACTIVE")
print("✅ ESP: ACTIVE")
print("✅ Auto Pickup: ACTIVE")
print("════════════════════════════════")

-- Respawn Handler
player.CharacterAdded:Connect(function()
    task.wait(2)
    autoPickup()
end)
