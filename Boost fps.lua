-- ═══════════════════════════════════════════════════
-- 🦈 SHARK HUB - Delta Executor Optimized
-- ═══════════════════════════════════════════════════

print("════════════════════════════════")
print("🦈 SHARK HUB STARTING...")
print("📱 Delta Executor Detected")
print("════════════════════════════════")

-- Services
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui", 10)

if not playerGui then
    warn("❌ PlayerGui not found!")
    return
end

-- ═══════════════════════════════════════════════════
-- 🔔 Simple Notification (Delta Compatible)
-- ═══════════════════════════════════════════════════

local function notify(text)
    print("📢 " .. text)
    
    task.spawn(function()
        pcall(function()
            -- ลบแจ้งเตือนเก่า
            for _, gui in pairs(playerGui:GetChildren()) do
                if gui.Name == "SharkNotif" then
                    gui:Destroy()
                end
            end
            
            local sg = Instance.new("ScreenGui")
            sg.Name = "SharkNotif"
            sg.ResetOnSpawn = false
            sg.Parent = playerGui
            
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(0, 300, 0, 80)
            frame.Position = UDim2.new(1, 320, 0, 20)
            frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            frame.BackgroundTransparency = 0.3
            frame.BorderSizePixel = 0
            frame.Parent = sg
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 12)
            corner.Parent = frame
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -20, 1, -20)
            label.Position = UDim2.new(0, 10, 0, 10)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.fromRGB(0, 255, 255)
            label.Text = text
            label.Font = Enum.Font.GothamBold
            label.TextSize = 16
            label.TextWrapped = true
            label.Parent = frame
            
            frame:TweenPosition(UDim2.new(1, -310, 0, 20), "Out", "Back", 0.5, true)
            
            task.wait(3)
            
            frame:TweenPosition(UDim2.new(1, 320, 0, 20), "In", "Back", 0.5, true)
            
            task.wait(0.6)
            sg:Destroy()
        end)
    end)
end

-- ═══════════════════════════════════════════════════
-- 📊 FPS/PING Display (Simple)
-- ═══════════════════════════════════════════════════

local function createDisplay()
    task.spawn(function()
        pcall(function()
            for _, gui in pairs(playerGui:GetChildren()) do
                if gui.Name == "SharkDisplay" then
                    gui:Destroy()
                end
            end
            
            local sg = Instance.new("ScreenGui")
            sg.Name = "SharkDisplay"
            sg.ResetOnSpawn = false
            sg.Parent = playerGui
            
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(0, 140, 0, 60)
            frame.Position = UDim2.new(0.5, -70, 0, 10)
            frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            frame.BackgroundTransparency = 0.4
            frame.BorderSizePixel = 0
            frame.Parent = sg
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 10)
            corner.Parent = frame
            
            local fps = Instance.new("TextLabel")
            fps.Size = UDim2.new(1, 0, 0.5, 0)
            fps.BackgroundTransparency = 1
            fps.TextColor3 = Color3.fromRGB(0, 255, 0)
            fps.Text = "FPS: 0"
            fps.Font = Enum.Font.GothamBold
            fps.TextSize = 16
            fps.Parent = frame
            
            local ping = Instance.new("TextLabel")
            ping.Size = UDim2.new(1, 0, 0.5, 0)
            ping.Position = UDim2.new(0, 0, 0.5, 0)
            ping.BackgroundTransparency = 1
            ping.TextColor3 = Color3.fromRGB(255, 0, 255)
            ping.Text = "PING: 0"
            ping.Font = Enum.Font.GothamBold
            ping.TextSize = 16
            ping.Parent = frame
            
            local lastTime = tick()
            local frames = 0
            
            RunService.Heartbeat:Connect(function()
                frames = frames + 1
                if tick() - lastTime >= 1 then
                    pcall(function()
                        fps.Text = "FPS: " .. frames
                        local p = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
                        ping.Text = "PING: " .. p
                    end)
                    frames = 0
                    lastTime = tick()
                end
            end)
        end)
    end)
end

-- ═══════════════════════════════════════════════════
-- 🔥 FPS BOOSTER (Delta Optimized)
-- ═══════════════════════════════════════════════════

local function boostFPS()
    notify("🔥 กำลังลบเอฟเฟค...")
    
    task.spawn(function()
        local removed = 0
        
        -- Graphics
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            local ugs = UserSettings():GetService("UserGameSettings")
            ugs.SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel1
        end)
        
        -- Lighting
        pcall(function()
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 9e9
            
            for _, v in pairs(Lighting:GetChildren()) do
                if v:IsA("PostEffect") then
                    v:Destroy()
                    removed = removed + 1
                end
            end
        end)
        
        -- Workspace (แบ่ง Batch สำหรับ Delta)
        local count = 0
        for _, obj in pairs(Workspace:GetDescendants()) do
            count = count + 1
            
            -- พักทุก 200 objects (Delta ชอบแบบนี้)
            if count % 200 == 0 then
                task.wait(0.05)
            end
            
            pcall(function()
                local name = obj.Name:lower()
                
                -- เก็บตัวละคร + ชื่อ
                if name:find("humanoid") or name:find("head") or name:find("torso") or
                   name:find("arm") or name:find("leg") or name:find("rootpart") or
                   name:find("nametag") or name:find("overhead") then
                    return
                end
                
                -- ลบ Effects
                if obj:IsA("ParticleEmitter") then
                    obj:Destroy()
                    removed = removed + 1
                elseif obj:IsA("Trail") then
                    obj:Destroy()
                    removed = removed + 1
                elseif obj:IsA("Beam") then
                    obj:Destroy()
                    removed = removed + 1
                elseif obj:IsA("Fire") then
                    obj:Destroy()
                    removed = removed + 1
                elseif obj:IsA("Smoke") then
                    obj:Destroy()
                    removed = removed + 1
                elseif obj:IsA("Sparkles") then
                    obj:Destroy()
                    removed = removed + 1
                elseif obj:IsA("Explosion") then
                    obj:Destroy()
                    removed = removed + 1
                    
                -- ลบ Lights
                elseif obj:IsA("PointLight") then
                    obj:Destroy()
                    removed = removed + 1
                elseif obj:IsA("SpotLight") then
                    obj:Destroy()
                    removed = removed + 1
                elseif obj:IsA("SurfaceLight") then
                    obj:Destroy()
                    removed = removed + 1
                    
                -- ลบ Textures
                elseif obj:IsA("Decal") then
                    if name ~= "face" then
                        obj:Destroy()
                        removed = removed + 1
                    end
                elseif obj:IsA("Texture") then
                    obj:Destroy()
                    removed = removed + 1
                elseif obj:IsA("SurfaceAppearance") then
                    obj:Destroy()
                    removed = removed + 1
                    
                -- Optimize Parts
                elseif obj:IsA("MeshPart") then
                    obj.TextureID = ""
                    obj.Material = Enum.Material.Plastic
                    obj.CastShadow = false
                    obj.RenderFidelity = Enum.RenderFidelity.Performance
                    removed = removed + 1
                    
                elseif obj:IsA("BasePart") then
                    obj.Material = Enum.Material.Plastic
                    obj.CastShadow = false
                    
                -- Sounds
                elseif obj:IsA("Sound") then
                    obj.Volume = 0
                end
            end)
        end
        
        print("✓ ลบเอฟเฟค: " .. removed .. " objects")
    end)
end

-- ═══════════════════════════════════════════════════
-- ⚡ PING FIX
-- ═══════════════════════════════════════════════════

local function fixPing()
    pcall(function()
        settings().Network.IncomingReplicationLag = 0
    end)
    
    notify("⚡ แก้ PING เสร็จ")
    print("✓ Ping Fixed")
end

-- ═══════════════════════════════════════════════════
-- 👁️ PLAYER ESP (Simple)
-- ═══════════════════════════════════════════════════

local function addESP()
    task.spawn(function()
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= player then
                pcall(function()
                    local function create(char)
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        if not hrp then return end
                        
                        for _, old in pairs(hrp:GetChildren()) do
                            if old.Name == "ESP" then
                                old:Destroy()
                            end
                        end
                        
                        local bb = Instance.new("BillboardGui")
                        bb.Name = "ESP"
                        bb.Adornee = hrp
                        bb.Size = UDim2.new(0, 200, 0, 50)
                        bb.StudsOffset = Vector3.new(0, 3, 0)
                        bb.AlwaysOnTop = true
                        bb.Parent = hrp
                        
                        local txt = Instance.new("TextLabel")
                        txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.BackgroundTransparency = 1
                        txt.TextColor3 = Color3.fromRGB(0, 255, 0)
                        txt.TextStrokeTransparency = 0
                        txt.Text = p.Name
                        txt.Font = Enum.Font.GothamBold
                        txt.TextSize = 14
                        txt.Parent = bb
                        
                        task.spawn(function()
                            while bb and bb.Parent do
                                pcall(function()
                                    local c = player.Character
                                    if c and c:FindFirstChild("HumanoidRootPart") then
                                        local d = (c.HumanoidRootPart.Position - hrp.Position).Magnitude
                                        txt.Text = p.Name .. "\n" .. math.floor(d) .. "m"
                                    end
                                end)
                                task.wait(0.5)
                            end
                        end)
                    end
                    
                    if p.Character then
                        create(p.Character)
                    end
                    
                    p.CharacterAdded:Connect(function(c)
                        task.wait(1)
                        create(c)
                    end)
                end)
            end
        end
    end)
    
    notify("👁️ ESP เปิดแล้ว")
    print("✓ ESP Active")
end

-- ═══════════════════════════════════════════════════
-- 🔄 CLEANER (เบา)
-- ═══════════════════════════════════════════════════

local function startCleaner()
    task.spawn(function()
        while task.wait(4) do
            pcall(function()
                local c = 0
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
                        obj:Destroy()
                        c = c + 1
                        if c >= 30 then break end
                    end
                end
            end)
        end
    end)
    print("✓ Cleaner Started")
end

-- ═══════════════════════════════════════════════════
-- 🎰 AUTO PICKUP
-- ═══════════════════════════════════════════════════

local function pickup()
    task.spawn(function()
        while task.wait(0.6) do
            pcall(function()
                local char = player.Character
                if not char then return end
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("BasePart") then
                        local n = obj.Name:lower()
                        if n:find("coin") or n:find("gem") or n:find("cash") or n:find("money") or n:find("orb") then
                            local d = (obj.Position - hrp.Position).Magnitude
                            if d < 200 then
                                obj.CFrame = hrp.CFrame
                            end
                        end
                    end
                end
            end)
        end
    end)
    notify("🎰 Auto Pickup เปิดแล้ว")
    print("✓ Auto Pickup Active")
end

-- ═══════════════════════════════════════════════════
-- 🚀 MAIN
-- ═══════════════════════════════════════════════════

notify("🦈 SHARK HUB\nกำลังโหลด...")

task.wait(0.5)
createDisplay()
print("✓ Display Created")

task.wait(0.5)
boostFPS()

task.wait(1.5)
fixPing()

task.wait(0.5)
addESP()

task.wait(0.5)
startCleaner()

task.wait(0.5)
pickup()

task.wait(0.5)
notify("✅ SHARK HUB\nพร้อมใช้งาน!")

print("════════════════════════════════")
print("✅ SHARK HUB READY!")
print("✅ FPS Boost: ON")
print("✅ Ping Fix: ON")
print("✅ ESP: ON")
print("✅ Auto Pickup: ON")
print("════════════════════════════════")

player.CharacterAdded:Connect(function()
    task.wait(2)
    pickup()
end)
