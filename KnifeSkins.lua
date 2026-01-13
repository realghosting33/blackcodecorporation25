-- ============================================
-- Knife Skins Module
-- ============================================

local KnifeSkins = {}

-- ============================================
-- Bayonet Skins
-- ============================================

KnifeSkins.BAYONET = {
    "Decor", "Aequalis", "Banner", "Candy Cane", "Consumed",
    "Cosmos", "Crimson Tiger", "Crow", "Delinquent", "Digital",
    "Easy-Bake", "Egg Shell", "Festive", "Frozen Dream", "Geo Blade",
    "Ghastly", "Goo", "Intertwine", "Marbleized", "Mariposa",
    "Naval", "Neonic", "RSL", "Racer", "Sapphire", "Silent Night",
    "Splattered", "Stock", "Topaz", "Tropical", "Twitch", "UFO",
    "Wetland", "Worn", "Wrapped", "Hallows", "Haunted"
}

-- ============================================
-- Butterfly Knife Skins
-- ============================================

KnifeSkins.BUTTERFLY = {
    "Snowfall", "Aurora", "Bloodwidow", "Consumed", "Cosmos",
    "Crimson Tiger", "Crippled Fade", "Digital", "Egg Shell",
    "Freedom", "Frozen Dream", "Goo", "Hallows", "Icicle",
    "Inversion", "Jade Dream", "Marbleized", "Naval", "Neonic",
    "Reaper", "Ruby", "Scapter", "Splattered", "Stock", "Topaz",
    "Tropical", "Twitch", "Wetland", "White Boss", "Worn",
    "Wrapped", "Argus", "Spooky"
}

-- ============================================
-- Karambit Skins
-- ============================================

KnifeSkins.KARAMBIT = {
    "Peppermint", "Bloodwidow", "Consumed", "Cosmos", "Crimson Tiger",
    "Crippled Fade", "Death Wish", "Digital", "Egg Shell", "Festive",
    "Frozen Dream", "Glossed", "Gold", "Goo", "Hallows", "Jade Dream",
    "Jester", "Lantern", "Liberty Camo", "Marbleized", "Naval",
    "Neonic", "Pizza", "Quicktime", "Racer", "Ruby", "Scapter",
    "Splattered", "Stock", "Topaz", "Tropical", "Twitch", "Wetland",
    "Worn", "Drop-Out", "Cob Web"
}

-- ============================================
-- Falchion Knife Skins
-- ============================================

KnifeSkins.FALCHION = {
    "Cocoa", "Bloodwidow", "Chosen", "Coal", "Consumed", "Cosmos",
    "Crimson Tiger", "Crippled Fade", "Digital", "Egg Shell",
    "Festive", "Freedom", "Frozen Dream", "Goo", "Hallows",
    "Inversion", "Late Night", "Toxic Nitro", "Marbleized", "Naval",
    "Neonic", "Racer", "Ruby", "Splattered", "Stock", "Topaz",
    "Tropical", "Wetland", "Worn", "Wrapped", "Zombie", "Pumpkin",
    "Twilight"
}

-- ============================================
-- Gut Knife Skins
-- ============================================

KnifeSkins.GUT = {
    "Holly", "Banner", "Bloodwidow", "Consumed", "Cosmos",
    "Crimson Tiger", "Crippled Fade", "Digital", "Egg Shell",
    "Frozen Dream", "Geo Blade", "Goo", "Hallows", "Lurker",
    "Marbleized", "Naval", "Neonic", "Present", "Ruby", "Rusty",
    "Splattered", "Topaz", "Tropical", "Wetland", "Worn", "Wrapped",
    "Cob Web"
}

-- ============================================
-- Huntsman Knife Skins
-- ============================================

KnifeSkins.HUNTSMAN = {
    "Spirit", "Aurora", "Drop-Out", "Bloodwidow", "Consumed",
    "Cosmos", "Cozy", "Crimson Tiger", "Crippled Fade", "Digital",
    "Egg Shell", "Frozen Dream", "Geo Blade", "Goo", "Hallows",
    "Honor Fade", "Marbleized", "Monster", "Naval", "Ruby",
    "Splattered", "Stock", "Tropical", "Twitch", "Wetland", "Worn",
    "Wrapped", "Spookiness"
}

-- ============================================
-- Facas Especiais
-- ============================================

KnifeSkins.BEARDEDAXE = {
    "Beast", "Splattered"
}

KnifeSkins.CLEAVER = {
    "Spider", "Splattered"
}

KnifeSkins.SICKLE = {
    "Stock", "Mummy", "Splattered"
}

KnifeSkins.CLASSIC = {
    "Default"
}

KnifeSkins.BOW = {
    "Default"
}

KnifeSkins.DAGGERS = {
    "Default"
}

KnifeSkins.SKELETON = {
    "Default"
}

KnifeSkins.VALOR = {
    "Default"
}

KnifeSkins.TALON = {
    "Default"
}

KnifeSkins.STAFF = {
    "Default"
}

KnifeSkins.IMPOSTOR = {
    "Default"
}

KnifeSkins.KRUK = {
    "Default"
}

KnifeSkins.PICKAXE = {
    "Default"
}

KnifeSkins.CARD = {
    "Default"
}

-- ============================================
-- Asset IDs para cada faca
-- ============================================

KnifeSkins.AssetIDs = {
    BAYONET = "7311308040",
    BUTTERFLY = "7161230940",
    KARAMBIT = "7161230940",
    FALCHION = "7161142540",
    GUT = "7161142540",
    HUNTSMAN = "7161142540",
    BEARDEDAXE = "7161142540",
    CLEAVER = "8135776468",
    SICKLE = "7161142540",
    CLASSIC = "7161142540",
    BOW = "7161240289",
    DAGGERS = "7161082619",
    SKELETON = "7161149241",
    VALOR = "7161230940",
    TALON = "6669716399",
    STAFF = "8136273912",
    IMPOSTOR = "6500791405",
    KRUK = "7374148548",
    PICKAXE = "8202952676",
    CARD = "6571605917"
}

-- ============================================
-- Funções
-- ============================================

function KnifeSkins:IsKnife(knifeName)
    return self[knifeName] ~= nil and knifeName ~= "AssetIDs"
end

function KnifeSkins:GetAllKnives()
    local allKnives = {}
    
    for knife, skins in pairs(self) do
        if type(skins) == "table" and knife ~= "AssetIDs" and knife ~= "IsKnife" and knife ~= "GetAllKnives" and knife ~= "ApplySkin" then
            table.insert(allKnives, knife)
        end
    end
    
    return allKnives
end

function KnifeSkins:ApplySkin(knifeName, skinName)
    local viewmodels = game.ReplicatedStorage:FindFirstChild("Viewmodels")
    if not viewmodels then return end
    
    -- Remover facas existentes
    local ctKnife = viewmodels:FindFirstChild("v_CT Knife")
    local tKnife = viewmodels:FindFirstChild("v_T Knife")
    
    if ctKnife then ctKnife:Destroy() end
    if tKnife then tKnife:Destroy() end
    
    wait()
    
    -- Carregar nova faca
    local assetId = self.AssetIDs[knifeName]
    if not assetId then return end
    
    -- CT Knife
    local Model1 = Instance.new("Model", viewmodels)
    game:GetObjects('rbxassetid://' .. assetId)[1].Parent = Model1
    local Model = viewmodels.Model
    for _, Child in pairs(Model:GetChildren()) do
        Child.Parent = Model.Parent
    end
    Model:Destroy()
    
    wait()
    
    -- T Knife
    local Model2 = Instance.new("Model", viewmodels)
    game:GetObjects('rbxassetid://' .. assetId)[1].Parent = Model2
    Model = viewmodels.Model
    for _, Child in pairs(Model:GetChildren()) do
        Child.Parent = Model.Parent
    end
    Model:Destroy()
    
    wait()
    
    -- Renomear
    local knifeModel = viewmodels:FindFirstChild("v_" .. knifeName:lower())
    if knifeModel then
        knifeModel.Name = "v_CT Knife"
    end
    
    knifeModel = viewmodels:FindFirstChild("v_" .. knifeName:lower())
    if knifeModel then
        knifeModel.Name = "v_T Knife"
    end
end

return KnifeSkins
