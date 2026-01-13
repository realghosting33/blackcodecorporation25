-- ============================================
-- SKIN CHANGER - VERSÃO FUNCIONAL
-- Baseado no método que realmente funciona!
-- ============================================

print("╔════════════════════════════════════════╗")
print("║    COUNTER BLOX SKIN CHANGER v2.0     ║")
print("║    Sistema de troca direta de models  ║")
print("╚════════════════════════════════════════╝")

if game.PlaceId ~= 301549746 then
    warn("[Skin Changer] Este script é apenas para Counter Blox!")
    return
end

-- ============================================
-- DATABASE DE FACAS
-- ============================================

local KnifeDatabase = {
    SKELETON = {
        Name = "Skeleton Knife",
        AssetID = "7161149241",
        ModelName = "v_skeletonknife"
    },
    KARAMBIT = {
        Name = "Karambit",
        AssetID = "7161230940",
        ModelName = "v_karambit"
    },
    BUTTERFLY = {
        Name = "Butterfly Knife",
        AssetID = "7161230940",
        ModelName = "v_butterfly"
    },
    BAYONET = {
        Name = "Bayonet",
        AssetID = "7311308040",
        ModelName = "v_bayonet"
    },
    HUNTSMAN = {
        Name = "Huntsman Knife",
        AssetID = "7161142540",
        ModelName = "v_huntsman"
    },
    FALCHION = {
        Name = "Falchion Knife",
        AssetID = "7161142540",
        ModelName = "v_falchion"
    },
    GUT = {
        Name = "Gut Knife",
        AssetID = "7161142540",
        ModelName = "v_gut"
    },
    DAGGERS = {
        Name = "Shadow Daggers",
        AssetID = "7161082619",
        ModelName = "v_daggers"
    },
    BOW = {
        Name = "Bow",
        AssetID = "7161240289",
        ModelName = "v_bow"
    },
    TALON = {
        Name = "Talon Knife",
        AssetID = "6669716399",
        ModelName = "v_talon"
    },
    CLASSIC = {
        Name = "Classic Knife",
        AssetID = "7161142540",
        ModelName = "v_classic"
    }
}

-- ============================================
-- SISTEMA DE APLICAÇÃO DE SKIN
-- ============================================

local SkinChanger = {}
SkinChanger.Version = "2.0"
SkinChanger.CurrentKnife = "DEFAULT"

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Viewmodels = ReplicatedStorage:WaitForChild("Viewmodels")

-- Função para aplicar faca (igual seu código que funciona!)
function SkinChanger:ApplyKnife(knifeName)
    knifeName = knifeName:upper()
    
    local knifeData = KnifeDatabase[knifeName]
    if not knifeData then
        warn("[Skin Changer] ✗ Faca não encontrada: " .. knifeName)
        return false
    end
    
    local success, err = pcall(function()
        -- PASSO 1: Destruir facas existentes
        local ctKnife = Viewmodels:FindFirstChild("v_CT Knife")
        local tKnife = Viewmodels:FindFirstChild("v_T Knife")
        
        if ctKnife then
            ctKnife:Destroy()
            print("[Skin Changer] ✓ CT Knife removida")
        end
        
        if tKnife then
            tKnife:Destroy()
            print("[Skin Changer] ✓ T Knife removida")
        end
        
        wait(0.1)
        
        -- PASSO 2: Carregar modelo CT
        print("[Skin Changer] Carregando modelo CT...")
        local Model1 = Instance.new("Model", Viewmodels)
        game:GetObjects('rbxassetid://' .. knifeData.AssetID)[1].Parent = Model1
        
        local LoadedModel = Viewmodels:FindFirstChild("Model")
        if LoadedModel then
            for _, Child in pairs(LoadedModel:GetChildren()) do
                Child.Parent = LoadedModel.Parent
            end
            LoadedModel:Destroy()
        end
        
        wait(0.1)
        
        -- PASSO 3: Carregar modelo T
        print("[Skin Changer] Carregando modelo T...")
        local Model2 = Instance.new("Model", Viewmodels)
        game:GetObjects('rbxassetid://' .. knifeData.AssetID)[1].Parent = Model2
        
        LoadedModel = Viewmodels:FindFirstChild("Model")
        if LoadedModel then
            for _, Child in pairs(LoadedModel:GetChildren()) do
                Child.Parent = LoadedModel.Parent
            end
            LoadedModel:Destroy()
        end
        
        wait(0.1)
        
        -- PASSO 4: Renomear modelos
        print("[Skin Changer] Renomeando modelos...")
        local knife1 = Viewmodels:FindFirstChild(knifeData.ModelName)
        if knife1 then
            knife1.Name = "v_CT Knife"
            print("[Skin Changer] ✓ CT Knife criada")
        end
        
        local knife2 = Viewmodels:FindFirstChild(knifeData.ModelName)
        if knife2 then
            knife2.Name = "v_T Knife"
            print("[Skin Changer] ✓ T Knife criada")
        end
        
        self.CurrentKnife = knifeName
        print("[Skin Changer] ✓✓✓ Faca aplicada com sucesso: " .. knifeData.Name)
    end)
    
    if not success then
        warn("[Skin Changer] ✗ Erro ao aplicar faca: " .. tostring(err))
        return false
    end
    
    return true
end

-- ============================================
-- COMANDOS DO CONSOLE
-- ============================================

function SkinChanger:CreateCommands()
    -- Comando principal
    getgenv().changeKnife = function(knifeName)
        return SkinChanger:ApplyKnife(knifeName)
    end
    
    -- Listar facas disponíveis
    getgenv().listKnives = function()
        print("╔════════════════════════════════════════╗")
        print("║       FACAS DISPONÍVEIS                ║")
        print("╚════════════════════════════════════════╝")
        local i = 1
        for key, data in pairs(KnifeDatabase) do
            print(string.format("%2d. %-15s -> changeKnife('%s')", i, data.Name, key))
            i = i + 1
        end
        print("\nExemplo: changeKnife('SKELETON')")
    end
    
    -- Status
    getgenv().knifeStatus = function()
        print("╔════════════════════════════════════════╗")
        print("║         SKIN CHANGER STATUS            ║")
        print("╚════════════════════════════════════════╝")
        print("Versão: " .. SkinChanger.Version)
        print("Faca atual: " .. SkinChanger.CurrentKnife)
        print("\nComandos disponíveis:")
        print("  • listKnives() - Ver facas")
        print("  • changeKnife('NOME') - Trocar faca")
        print("  • knifeStatus() - Ver este menu")
    end
    
    -- Resetar para padrão
    getgenv().resetKnife = function()
        local success = pcall(function()
            local ctKnife = Viewmodels:FindFirstChild("v_CT Knife")
            local tKnife = Viewmodels:FindFirstChild("v_T Knife")
            
            if ctKnife then ctKnife:Destroy() end
            if tKnife then tKnife:Destroy() end
            
            -- Recarregar página forçará o jogo a carregar as facas padrão
            print("[Skin Changer] ✓ Facas resetadas! Reequipe sua faca.")
            SkinChanger.CurrentKnife = "DEFAULT"
        end)
        
        return success
    end
    
    print("[Skin Changer] ✓ Comandos criados com sucesso!")
end

-- ============================================
-- INTERFACE VISUAL SIMPLES
-- ============================================

function SkinChanger:CreateUI()
    local success = pcall(function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        -- Criar ScreenGui
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "SkinChangerUI"
        screenGui.ResetOnSpawn = false
        screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        
        if gethui then
            screenGui.Parent = gethui()
        else
            screenGui.Parent = game.CoreGui
        end
        
        -- Frame principal
        local mainFrame = Instance.new("Frame")
        mainFrame.Name = "MainFrame"
        mainFrame.Size = UDim2.new(0, 300, 0, 400)
        mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
        mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
        mainFrame.BorderSizePixel = 0
        mainFrame.Visible = false
        mainFrame.Parent = screenGui
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = mainFrame
        
        -- Título
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 40)
        title.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        title.BorderSizePixel = 0
        title.Text = "SKIN CHANGER v" .. self.Version
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.Font = Enum.Font.GothamBold
        title.TextSize = 16
        title.Parent = mainFrame
        
        local titleCorner = Instance.new("UICorner")
        titleCorner.CornerRadius = UDim.new(0, 8)
        titleCorner.Parent = title
        
        -- ScrollFrame
        local scrollFrame = Instance.new("ScrollingFrame")
        scrollFrame.Size = UDim2.new(1, -20, 1, -60)
        scrollFrame.Position = UDim2.new(0, 10, 0, 50)
        scrollFrame.BackgroundTransparency = 1
        scrollFrame.BorderSizePixel = 0
        scrollFrame.ScrollBarThickness = 4
        scrollFrame.Parent = mainFrame
        
        local listLayout = Instance.new("UIListLayout")
        listLayout.Padding = UDim.new(0, 5)
        listLayout.SortOrder = Enum.SortOrder.Name
        listLayout.Parent = scrollFrame
        
        -- Criar botões para cada faca
        for key, data in pairs(KnifeDatabase) do
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(1, -10, 0, 35)
            button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
            button.BorderSizePixel = 0
            button.Text = data.Name
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.Font = Enum.Font.Gotham
            button.TextSize = 14
            button.Parent = scrollFrame
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 4)
            btnCorner.Parent = button
            
            button.MouseButton1Click:Connect(function()
                self:ApplyKnife(key)
                button.BackgroundColor3 = Color3.fromRGB(67, 181, 129)
                wait(0.3)
                button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
            end)
        end
        
        -- Ajustar tamanho do scroll
        listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
        end)
        
        -- Toggle com INSERT
        game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
                mainFrame.Visible = not mainFrame.Visible
            end
        end)
        
        print("[Skin Changer] ✓ UI criada! Pressione INSERT para abrir")
    end)
    
    if not success then
        warn("[Skin Changer] ⚠ Não foi possível criar UI, use comandos do console")
    end
end

-- ============================================
-- NOTIFICAÇÃO
-- ============================================

function SkinChanger:Notify(text)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Skin Changer",
            Text = text,
            Duration = 3
        })
    end)
end

-- ============================================
-- INICIALIZAÇÃO
-- ============================================

function SkinChanger:Init()
    print("[Skin Changer] Inicializando sistema...")
    
    -- Verificar se Viewmodels existe
    if not Viewmodels then
        warn("[Skin Changer] ✗ Viewmodels não encontrado!")
        return
    end
    
    -- Criar comandos
    self:CreateCommands()
    
    -- Criar UI
    task.wait(0.5)
    self:CreateUI()
    
    -- Notificar
    self:Notify("Carregado! Pressione INSERT ou use listKnives()")
    
    print("╔════════════════════════════════════════╗")
    print("║  ✓✓✓ SISTEMA CARREGADO COM SUCESSO    ║")
    print("║                                        ║")
    print("║  Pressione INSERT para abrir UI       ║")
    print("║  ou use: listKnives()                 ║")
    print("╚════════════════════════════════════════╝")
end

-- Executar
SkinChanger:Init()

-- Exportar
getgenv().SkinChanger = SkinChanger

return SkinChanger
