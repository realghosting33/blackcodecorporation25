-- ============================================
-- Skin Changer System
-- Versão: 1.0
-- ============================================

local SkinChanger = {}
SkinChanger.Version = "1.0"
SkinChanger.Enabled = false

-- Serviços
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- Player Local
local LocalPlayer = Players.LocalPlayer

-- Módulos de Skins
local WeaponSkins = require(script.WeaponSkins)
local KnifeSkins = require(script.KnifeSkins)
local GloveSkins = require(script.GloveSkins)

-- Configurações
SkinChanger.Config = {
    SelectedSkins = {
        Rifles = {},
        SMGs = {},
        Snipers = {},
        Pistols = {},
        Heavy = {},
        Knives = {},
        Gloves = {}
    }
}

-- ============================================
-- Funções Core
-- ============================================

function SkinChanger:Init()
    print("[Skin Changer] Inicializando...")
    
    -- Hook no MetaTable
    self:SetupHooks()
    
    -- Criar UI
    self:CreateUI()
    
    print("[Skin Changer] Inicializado com sucesso!")
end

function SkinChanger:SetupHooks()
    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)
    
    local isUnlocked = false
    
    mt.__namecall = newcclosure(function(self, ...)
        local args = {...}
        local method = getnamecallmethod()
        
        -- Bloquear Hugh
        if method == "InvokeServer" and tostring(self) == "Hugh" then
            return
        end
        
        -- Unlock de Skins
        if method == "FireServer" then
            if args[1] == LocalPlayer.UserId then
                return
            end
            
            if string.len(tostring(self)) == 38 then
                if not isUnlocked then
                    isUnlocked = true
                    
                    -- Adicionar todas as skins
                    for _, skinData in pairs(WeaponSkins:GetAllSkins()) do
                        local doSkip = false
                        for _, v2 in pairs(args[1]) do
                            if skinData[1] == v2[1] then
                                doSkip = true
                            end
                        end
                        if not doSkip then
                            table.insert(args[1], skinData)
                        end
                    end
                end
                return
            end
            
            -- Aplicar Skin
            if tostring(self) == "DataEvent" and args[1][4] then
                local currentSkin = string.split(args[1][4][1], "_")[2]
                if args[1][2] == "Both" then
                    LocalPlayer.SkinFolder.CTFolder[args[1][3]].Value = currentSkin
                    LocalPlayer.SkinFolder.TFolder[args[1][3]].Value = currentSkin
                else
                    LocalPlayer.SkinFolder[args[1][2] .. "Folder"][args[1][3]].Value = currentSkin
                end
            end
        end
        
        return oldNamecall(self, ...)
    end)
    
    setreadonly(mt, true)
end

function SkinChanger:ApplySkin(weaponType, skinName)
    if not self.Enabled then return end
    
    local weaponClass = string.upper(weaponType)
    
    -- Aplicar skin baseado no tipo
    if WeaponSkins:HasWeapon(weaponClass) then
        WeaponSkins:ApplySkin(weaponClass, skinName)
    elseif KnifeSkins:IsKnife(weaponClass) then
        KnifeSkins:ApplySkin(skinName)
    elseif GloveSkins:IsGlove(weaponClass) then
        GloveSkins:ApplySkin(skinName)
    end
end

function SkinChanger:CreateUI()
    -- UI será criada no próximo arquivo
    require(script.UI):Create(self)
end

-- ============================================
-- Inicializar
-- ============================================

SkinChanger:Init()

return SkinChanger
