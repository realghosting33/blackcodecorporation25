-- ============================================
-- Glove Skins Module
-- ============================================

local GloveSkins = {}

-- ============================================
-- Sports Glove Skins
-- ============================================

GloveSkins.SPORTS = {
    {Name = "Weeb", AssetID = "7687143935", TextureID = "6495060906"},
    {Name = "CottonTail", AssetID = "7687143935", TextureID = "9932308193"},
    {Name = "RSL", AssetID = "7687143935", TextureID = "7013092384"},
    {Name = "Royal", AssetID = "7687143935", TextureID = "6859809117"},
    {Name = "Hazard", AssetID = "7687143935", TextureID = "6698362315"},
    {Name = "Skulls", AssetID = "7687143935", TextureID = "6585681511"},
    {Name = "Pumpkin", AssetID = "7687143935", TextureID = "7692689517"},
    {Name = "Hallows", AssetID = "7687143935", TextureID = "7680766743"},
    {Name = "Majesty", AssetID = "7687143935", TextureID = "7498127695"},
    {Name = "Dead Prey", AssetID = "7687143935", TextureID = "6495060906"},
    {Name = "Calamity", AssetID = "7687143935", TextureID = "6495060906"}
}

-- ============================================
-- Strapped Glove Skins
-- ============================================

GloveSkins.STRAPPED = {
    {Name = "Molten", AssetID = "7687144943", TextureID = "6585424288"},
    {Name = "Kringle", AssetID = "7687144943", TextureID = "6585424288"},
    {Name = "Racer", AssetID = "7687144943", TextureID = "6585424288"},
    {Name = "Grim", AssetID = "7687144943", TextureID = "6585424288"},
    {Name = "Drop-Out", AssetID = "7687144943", TextureID = "6585424288"},
    {Name = "Wisk", AssetID = "7687144943", TextureID = "6585424288"},
    {Name = "Cob Web", AssetID = "7687144943", TextureID = "6585424288"}
}

-- ============================================
-- Fingerless Glove Skins
-- ============================================

GloveSkins.FINGERLESS = {
    {Name = "Crystal", AssetID = "7687143935", TextureID = "6684681077"},
    {Name = "Kimura", AssetID = "7687143935", TextureID = "6684681077"},
    {Name = "Spookiness", AssetID = "7687143935", TextureID = "6684681077"},
    {Name = "Scapter", AssetID = "7687143935", TextureID = "6684681077"},
    {Name = "Digital", AssetID = "7687143935", TextureID = "6684681077"},
    {Name = "Patch", AssetID = "7687143935", TextureID = "6684681077"}
}

-- ============================================
-- Handwraps Skins
-- ============================================

GloveSkins.HANDWRAPS = {
    {Name = "MMA", AssetID = "7687143935", TextureID = "6684681077"},
    {Name = "Mummy", AssetID = "7687143935", TextureID = "6684681077"},
    {Name = "Guts", AssetID = "7687143935", TextureID = "6684681077"},
    {Name = "Microbes", AssetID = "7687143935", TextureID = "6684681077"},
    {Name = "Toxic Nitro", AssetID = "7687143935", TextureID = "6684681077"},
    {Name = "Wetland", AssetID = "7687143935", TextureID = "6684681077"},
    {Name = "Wraps", AssetID = "7687143935", TextureID = "6684681077"},
    {Name = "Ghoul Hex", AssetID = "7687143935", TextureID = "6684681077"},
    {Name = "Phantom Hex", AssetID = "7687143935", TextureID = "6684681077"},
    {Name = "Spector Hex", AssetID = "7687143935", TextureID = "6684681077"},
    {Name = "Orange Hex", AssetID = "7687143935", TextureID = "6684681077"},
    {Name = "Purple Hex", AssetID = "7687143935", TextureID = "6684681077"},
    {Name = "Green Hex", AssetID = "7687143935", TextureID = "6684681077"}
}

-- ============================================
-- Braços especiais (Arms)
-- ============================================

GloveSkins.SPECIAL = {
    {Name = "Anarchia", AssetID = "7374186671", TextureID = "6684681077"},
    {Name = "Snake", AssetID = "7374163732", TextureID = "6684681077"},
    {Name = "Steve MC", AssetID = "7373745005", TextureID = "6684681077"}
}

-- ============================================
-- Lista de todos os braços do jogo
-- ============================================

GloveSkins.ArmsList = {
    "GIGNArms", "ECArms", "SASArms", "IDFArms", "UTArms",
    "GCTArms", "PCArms", "BDSArms", "GSGArms", "SPArms",
    "WDArms", "GTArms", "CSSArms", "PTArms", "AAArms"
}

-- ============================================
-- Funções
-- ============================================

function GloveSkins:IsGlove(gloveName)
    return self[gloveName] ~= nil and gloveName ~= "ArmsList"
end

function GloveSkins:GetAllGloveTypes()
    return {"SPORTS", "STRAPPED", "FINGERLESS", "HANDWRAPS", "SPECIAL"}
end

function GloveSkins:ApplySkin(gloveType, skinData)
    local viewmodels = game.ReplicatedStorage:FindFirstChild("Viewmodels")
    if not viewmodels then return end
    
    -- Remover todos os braços existentes
    for _, armName in ipairs(self.ArmsList) do
        local arm = viewmodels:FindFirstChild(armName)
        if arm then
            arm:Destroy()
        end
    end
    
    wait()
    
    -- Carregar novo modelo
    local Model1 = Instance.new("Model", viewmodels)
    game:GetObjects('rbxassetid://' .. skinData.AssetID)[1].Parent = Model1
    Model1 = viewmodels.Model
    
    for _, Child in pairs(Model1:GetChildren()) do
        Child.Parent = Model1.Parent
    end
    Model1:Destroy()
    
    wait()
    
    -- Se for Sports gloves, processar o modelo importado
    if gloveType == "SPORTS" or gloveType == "STRAPPED" then
        local importedModel
        if gloveType == "SPORTS" then
            importedModel = viewmodels:FindFirstChild("Sports_Models")
        else
            importedModel = viewmodels:FindFirstChild("Strapped_Models")
        end
        
        if importedModel then
            for _, Child in pairs(importedModel:GetChildren()) do
                Child.Parent = importedModel.Parent
            end
            importedModel:Destroy()
        end
    elseif gloveType == "SPECIAL" then
        -- Processar modelos especiais
        local specialModels = {
            ["Anarchia"] = "anarchia",
            ["Snake"] = "snake",
            ["Steve MC"] = "stevemc"
        }
        
        local modelName = specialModels[skinData.Name]
        if modelName then
            local model = viewmodels:FindFirstChild(modelName)
            if model then
                for _, Child in pairs(model:GetChildren()) do
                    Child.Parent = model.Parent
                end
                model:Destroy()
            end
        end
    end
    
    wait()
    
    -- Aplicar texturas
    self:ApplyTextures(skinData.TextureID, gloveType)
end

function GloveSkins:ApplyTextures(textureID, gloveType)
    local viewmodels = game.ReplicatedStorage:FindFirstChild("Viewmodels")
    if not viewmodels then return end
    
    for _, armName in ipairs(self.ArmsList) do
        local arm = viewmodels:FindFirstChild(armName)
        if arm then
            -- Aplicar textura ao braço esquerdo
            local leftArm = arm:FindFirstChild("Left Arm")
            if leftArm then
                if gloveType == "SPORTS" or gloveType == "STRAPPED" then
                    -- Com luvas
                    local lGlove = leftArm:FindFirstChild("LGlove")
                    if lGlove and lGlove:FindFirstChild("Mesh") then
                        lGlove.Mesh.TextureId = "rbxassetid://" .. textureID
                    end
                else
                    -- Sem luvas (apenas textura do braço)
                    if leftArm:FindFirstChild("Mesh") then
                        leftArm.Mesh.TextureId = "rbxassetid://" .. textureID
                    end
                end
            end
            
            -- Aplicar textura ao braço direito
            local rightArm = arm:FindFirstChild("Right Arm")
            if rightArm then
                if gloveType == "SPORTS" or gloveType == "STRAPPED" then
                    -- Com luvas
                    local rGlove = rightArm:FindFirstChild("RGlove")
                    if rGlove and rGlove:FindFirstChild("Mesh") then
                        rGlove.Mesh.TextureId = "rbxassetid://" .. textureID
                    end
                else
                    -- Sem luvas (apenas textura do braço)
                    if rightArm:FindFirstChild("Mesh") then
                        rightArm.Mesh.TextureId = "rbxassetid://" .. textureID
                    end
                end
            end
        end
    end
end

function GloveSkins:GetGlovesByType(gloveType)
    return self[gloveType] or {}
end

return GloveSkins
