-- ============================================
-- Configuration System
-- Sistema de salvamento e carregamento de configs
-- ============================================

local Config = {}
Config.FolderName = "SkinChangerConfigs"
Config.CurrentConfig = "default"

-- ============================================
-- Sistema de Arquivos
-- ============================================

function Config:Init()
    -- Criar pasta de configs se não existir
    if not isfolder(self.FolderName) then
        makefolder(self.FolderName)
    end
    
    -- Carregar config padrão
    self:LoadConfig("default")
end

-- ============================================
-- Estrutura de Config
-- ============================================

function Config:GetDefaultConfig()
    return {
        Version = "1.0",
        LastUpdated = os.time(),
        
        -- Configurações de Armas
        Weapons = {
            AK47 = "Default",
            AWP = "Default",
            M4A4 = "Default",
            M4A1 = "Default",
            DesertEagle = "Default",
            Glock = "Default",
            USP = "Default",
            Scout = "Default"
        },
        
        -- Configurações de Facas
        Knives = {
            CT = {Type = "Default", Skin = "Default"},
            T = {Type = "Default", Skin = "Default"}
        },
        
        -- Configurações de Luvas
        Gloves = {
            Type = "Default",
            Skin = "Default"
        },
        
        -- Preferências de UI
        UI = {
            Position = {X = 0.5, Y = 0.5},
            Theme = "Dark",
            ShowNotifications = true,
            AutoApply = true
        },
        
        -- Favoritos
        Favorites = {
            Weapons = {},
            Knives = {},
            Gloves = {}
        }
    }
end

-- ============================================
-- Salvar Config
-- ============================================

function Config:SaveConfig(configName)
    configName = configName or self.CurrentConfig
    
    local data = {
        Version = "1.0",
        LastUpdated = os.time(),
        Weapons = {},
        Knives = {},
        Gloves = {},
        UI = {},
        Favorites = {}
    }
    
    -- Coletar dados atuais do SkinChanger
    local skinChanger = getgenv().SkinChanger
    if skinChanger and skinChanger.Config then
        data.Weapons = skinChanger.Config.SelectedSkins.Rifles or {}
        data.Knives = skinChanger.Config.SelectedSkins.Knives or {}
        data.Gloves = skinChanger.Config.SelectedSkins.Gloves or {}
    end
    
    -- Converter para JSON
    local jsonData = game:GetService("HttpService"):JSONEncode(data)
    
    -- Salvar arquivo
    local filePath = self.FolderName .. "/" .. configName .. ".json"
    writefile(filePath, jsonData)
    
    print("[Config] ✓ Config salva: " .. configName)
    return true
end

-- ============================================
-- Carregar Config
-- ============================================

function Config:LoadConfig(configName)
    configName = configName or "default"
    local filePath = self.FolderName .. "/" .. configName .. ".json"
    
    -- Verificar se arquivo existe
    if not isfile(filePath) then
        print("[Config] Config não encontrada, criando padrão...")
        local defaultConfig = self:GetDefaultConfig()
        local jsonData = game:GetService("HttpService"):JSONEncode(defaultConfig)
        writefile(filePath, jsonData)
        self.CurrentConfig = configName
        return defaultConfig
    end
    
    -- Ler arquivo
    local jsonData = readfile(filePath)
    local data = game:GetService("HttpService"):JSONDecode(jsonData)
    
    self.CurrentConfig = configName
    print("[Config] ✓ Config carregada: " .. configName)
    
    return data
end

-- ============================================
-- Deletar Config
-- ============================================

function Config:DeleteConfig(configName)
    if configName == "default" then
        print("[Config] ✗ Não é possível deletar a config padrão!")
        return false
    end
    
    local filePath = self.FolderName .. "/" .. configName .. ".json"
    
    if isfile(filePath) then
        delfile(filePath)
        print("[Config] ✓ Config deletada: " .. configName)
        return true
    end
    
    print("[Config] ✗ Config não encontrada: " .. configName)
    return false
end

-- ============================================
-- Listar Configs
-- ============================================

function Config:ListConfigs()
    local configs = {}
    
    if isfolder(self.FolderName) then
        local files = listfiles(self.FolderName)
        
        for _, file in ipairs(files) do
            if file:match("%.json$") then
                local configName = file:match("([^/]+)%.json$")
                table.insert(configs, configName)
            end
        end
    end
    
    return configs
end

-- ============================================
-- Exportar Config (para compartilhar)
-- ============================================

function Config:ExportConfig(configName)
    configName = configName or self.CurrentConfig
    local filePath = self.FolderName .. "/" .. configName .. ".json"
    
    if isfile(filePath) then
        local data = readfile(filePath)
        setclipboard(data)
        print("[Config] ✓ Config copiada para clipboard!")
        return true
    end
    
    print("[Config] ✗ Config não encontrada!")
    return false
end

-- ============================================
-- Importar Config (de clipboard)
-- ============================================

function Config:ImportConfig(configName)
    configName = configName or "imported_" .. os.time()
    
    local success, data = pcall(function()
        return game:GetService("HttpService"):JSONDecode(getclipboard())
    end)
    
    if not success then
        print("[Config] ✗ Dados inválidos no clipboard!")
        return false
    end
    
    -- Validar estrutura
    if not data.Version then
        print("[Config] ✗ Config inválida!")
        return false
    end
    
    -- Salvar
    local filePath = self.FolderName .. "/" .. configName .. ".json"
    writefile(filePath, game:GetService("HttpService"):JSONEncode(data))
    
    print("[Config] ✓ Config importada: " .. configName)
    return true
end

-- ============================================
-- Aplicar Config
-- ============================================

function Config:ApplyConfig(configData)
    local skinChanger = getgenv().SkinChanger
    if not skinChanger then
        print("[Config] ✗ SkinChanger não encontrado!")
        return false
    end
    
    -- Aplicar skins de armas
    if configData.Weapons then
        for weapon, skin in pairs(configData.Weapons) do
            if skin ~= "Default" then
                skinChanger:ApplyWeaponSkin(weapon, skin)
            end
        end
    end
    
    -- Aplicar facas
    if configData.Knives then
        if configData.Knives.CT and configData.Knives.CT.Type ~= "Default" then
            skinChanger:ApplyKnifeSkin(configData.Knives.CT.Type, configData.Knives.CT.Skin)
        end
    end
    
    -- Aplicar luvas
    if configData.Gloves then
        if configData.Gloves.Type ~= "Default" then
            skinChanger:ApplyGloveSkin(configData.Gloves.Type, {
                Name = configData.Gloves.Skin,
                AssetID = "7687143935",
                TextureID = "6495060906"
            })
        end
    end
    
    print("[Config] ✓ Config aplicada!")
    return true
end

-- ============================================
-- Auto-save
-- ============================================

function Config:EnableAutoSave(interval)
    interval = interval or 300 -- 5 minutos
    
    task.spawn(function()
        while true do
            task.wait(interval)
            self:SaveConfig(self.CurrentConfig)
            print("[Config] ✓ Auto-save executado")
        end
    end)
end

-- ============================================
-- Comandos de Console
-- ============================================

function Config:CreateCommands()
    getgenv().saveConfig = function(name)
        return Config:SaveConfig(name)
    end
    
    getgenv().loadConfig = function(name)
        local data = Config:LoadConfig(name)
        return Config:ApplyConfig(data)
    end
    
    getgenv().listConfigs = function()
        local configs = Config:ListConfigs()
        print("[Config] Configs disponíveis:")
        for i, config in ipairs(configs) do
            print("  " .. i .. ". " .. config)
        end
        return configs
    end
    
    getgenv().deleteConfig = function(name)
        return Config:DeleteConfig(name)
    end
    
    getgenv().exportConfig = function(name)
        return Config:ExportConfig(name)
    end
    
    getgenv().importConfig = function(name)
        return Config:ImportConfig(name)
    end
    
    print("[Config] ✓ Comandos criados:")
    print("  - saveConfig(name)")
    print("  - loadConfig(name)")
    print("  - listConfigs()")
    print("  - deleteConfig(name)")
    print("  - exportConfig(name)")
    print("  - importConfig(name)")
end

-- ============================================
-- Inicializar
-- ============================================

Config:Init()
Config:CreateCommands()

return Config
