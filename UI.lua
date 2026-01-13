-- ============================================
-- UI Module - Clean Modern Design
-- ============================================

local UI = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Cores do tema (estilo CS2 cheat)
local Theme = {
    Background = Color3.fromRGB(15, 15, 20),
    Secondary = Color3.fromRGB(25, 25, 30),
    Accent = Color3.fromRGB(88, 101, 242),
    AccentHover = Color3.fromRGB(108, 121, 255),
    Text = Color3.fromRGB(255, 255, 255),
    TextDim = Color3.fromRGB(150, 150, 150),
    Border = Color3.fromRGB(40, 40, 45),
    Success = Color3.fromRGB(67, 181, 129),
    Warning = Color3.fromRGB(250, 166, 26),
    Error = Color3.fromRGB(237, 66, 69)
}

function UI:Create(skinChanger)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SkinChangerUI"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Proteção contra detecção
    if gethui then
        screenGui.Parent = gethui()
    elseif syn and syn.protect_gui then
        syn.protect_gui(screenGui)
        screenGui.Parent = game.CoreGui
    else
        screenGui.Parent = game.CoreGui
    end
    
    -- Frame Principal
    local mainFrame = self:CreateMainFrame(screenGui)
    
    -- Barra de Título
    local titleBar = self:CreateTitleBar(mainFrame, skinChanger)
    
    -- Container de Conteúdo
    local contentContainer = self:CreateContentContainer(mainFrame)
    
    -- Sidebar
    local sidebar = self:CreateSidebar(contentContainer, skinChanger)
    
    -- Painel de Skins
    local skinPanel = self:CreateSkinPanel(contentContainer, skinChanger)
    
    -- Tornar arrastável
    self:MakeDraggable(mainFrame, titleBar)
    
    -- Toggle UI com Insert
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
            mainFrame.Visible = not mainFrame.Visible
        end
    end)
    
    return screenGui
end

function UI:CreateMainFrame(parent)
    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(0, 850, 0, 550)
    frame.Position = UDim2.new(0.5, -425, 0.5, -275)
    frame.BackgroundColor3 = Theme.Background
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    -- Sombra
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 30, 1, 30)
    shadow.Position = UDim2.new(0, -15, 0, -15)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://6014261993"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.5
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    shadow.ZIndex = 0
    shadow.Parent = frame
    
    -- Corner
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    return frame
end

function UI:CreateTitleBar(parent, skinChanger)
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = Theme.Secondary
    titleBar.BorderSizePixel = 0
    titleBar.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = titleBar
    
    -- Título
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(0, 200, 1, 0)
    title.Position = UDim2.new(0, 15, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "SKIN CHANGER"
    title.TextColor3 = Theme.Text
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = titleBar
    
    -- Versão
    local version = Instance.new("TextLabel")
    version.Name = "Version"
    version.Size = UDim2.new(0, 100, 1, 0)
    version.Position = UDim2.new(0, 150, 0, 0)
    version.BackgroundTransparency = 1
    version.Text = "v" .. skinChanger.Version
    version.TextColor3 = Theme.TextDim
    version.Font = Enum.Font.Gotham
    version.TextSize = 12
    version.TextXAlignment = Enum.TextXAlignment.Left
    version.Parent = titleBar
    
    -- Botão Fechar
    local closeBtn = self:CreateButton(titleBar, "×", UDim2.new(1, -45, 0.5, -15), UDim2.new(0, 30, 0, 30))
    closeBtn.TextSize = 24
    closeBtn.MouseButton1Click:Connect(function()
        parent.Visible = false
    end)
    
    return titleBar
end

function UI:CreateContentContainer(parent)
    local container = Instance.new("Frame")
    container.Name = "ContentContainer"
    container.Size = UDim2.new(1, -20, 1, -60)
    container.Position = UDim2.new(0, 10, 0, 50)
    container.BackgroundTransparency = 1
    container.Parent = parent
    
    return container
end

function UI:CreateSidebar(parent, skinChanger)
    local sidebar = Instance.new("ScrollingFrame")
    sidebar.Name = "Sidebar"
    sidebar.Size = UDim2.new(0, 200, 1, 0)
    sidebar.BackgroundColor3 = Theme.Secondary
    sidebar.BorderSizePixel = 0
    sidebar.ScrollBarThickness = 4
    sidebar.ScrollBarImageColor3 = Theme.Accent
    sidebar.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = sidebar
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = sidebar
    
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 10)
    padding.PaddingBottom = UDim.new(0, 10)
    padding.PaddingLeft = UDim.new(0, 10)
    padding.PaddingRight = UDim.new(0, 10)
    padding.Parent = sidebar
    
    -- Categorias
    local categories = {
        {Name = "RIFLES", Icon = "🔫"},
        {Name = "PISTOLS", Icon = "🔫"},
        {Name = "SNIPERS", Icon = "🎯"},
        {Name = "SMGS", Icon = "💨"},
        {Name = "SHOTGUNS", Icon = "💥"},
        {Name = "HEAVY", Icon = "⚡"},
        {Name = "KNIVES", Icon = "🔪"},
        {Name = "GLOVES", Icon = "🧤"}
    }
    
    for i, category in ipairs(categories) do
        local btn = self:CreateCategoryButton(sidebar, category.Icon .. " " .. category.Name)
        btn.LayoutOrder = i
    end
    
    return sidebar
end

function UI:CreateSkinPanel(parent, skinChanger)
    local panel = Instance.new("Frame")
    panel.Name = "SkinPanel"
    panel.Size = UDim2.new(1, -210, 1, 0)
    panel.Position = UDim2.new(0, 210, 0, 0)
    panel.BackgroundColor3 = Theme.Secondary
    panel.BorderSizePixel = 0
    panel.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = panel
    
    -- Header
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 50)
    header.BackgroundTransparency = 1
    header.Parent = panel
    
    local headerTitle = Instance.new("TextLabel")
    headerTitle.Size = UDim2.new(1, -20, 1, 0)
    headerTitle.Position = UDim2.new(0, 20, 0, 0)
    headerTitle.BackgroundTransparency = 1
    headerTitle.Text = "Select a category"
    headerTitle.TextColor3 = Theme.Text
    headerTitle.Font = Enum.Font.GothamBold
    headerTitle.TextSize = 18
    headerTitle.TextXAlignment = Enum.TextXAlignment.Left
    headerTitle.Parent = header
    
    -- Search Box
    local searchFrame = Instance.new("Frame")
    searchFrame.Size = UDim2.new(1, -40, 0, 35)
    searchFrame.Position = UDim2.new(0, 20, 0, 60)
    searchFrame.BackgroundColor3 = Theme.Background
    searchFrame.BorderSizePixel = 0
    searchFrame.Parent = panel
    
    local searchCorner = Instance.new("UICorner")
    searchCorner.CornerRadius = UDim.new(0, 4)
    searchCorner.Parent = searchFrame
    
    local searchBox = Instance.new("TextBox")
    searchBox.Size = UDim2.new(1, -20, 1, 0)
    searchBox.Position = UDim2.new(0, 10, 0, 0)
    searchBox.BackgroundTransparency = 1
    searchBox.Text = ""
    searchBox.PlaceholderText = "Search skins..."
    searchBox.TextColor3 = Theme.Text
    searchBox.PlaceholderColor3 = Theme.TextDim
    searchBox.Font = Enum.Font.Gotham
    searchBox.TextSize = 14
    searchBox.TextXAlignment = Enum.TextXAlignment.Left
    searchBox.Parent = searchFrame
    
    -- Scroll de Skins
    local skinScroll = Instance.new("ScrollingFrame")
    skinScroll.Name = "SkinScroll"
    skinScroll.Size = UDim2.new(1, -40, 1, -115)
    skinScroll.Position = UDim2.new(0, 20, 0, 105)
    skinScroll.BackgroundTransparency = 1
    skinScroll.BorderSizePixel = 0
    skinScroll.ScrollBarThickness = 6
    skinScroll.ScrollBarImageColor3 = Theme.Accent
    skinScroll.Parent = panel
    
    local gridLayout = Instance.new("UIGridLayout")
    gridLayout.CellSize = UDim2.new(0, 180, 0, 50)
    gridLayout.CellPadding = UDim2.new(0, 10, 0, 10)
    gridLayout.SortOrder = Enum.SortOrder.Name
    gridLayout.Parent = skinScroll
    
    return panel
end

function UI:CreateCategoryButton(parent, text)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Theme.Background
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Theme.Text
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = btn
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 15)
    padding.Parent = btn
    
    -- Hover Effect
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Accent}):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Background}):Play()
    end)
    
    return btn
end

function UI:CreateButton(parent, text, position, size)
    local btn = Instance.new("TextButton")
    btn.Size = size or UDim2.new(0, 100, 0, 30)
    btn.Position = position or UDim2.new(0, 0, 0, 0)
    btn.BackgroundColor3 = Theme.Accent
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Theme.Text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = btn
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.AccentHover}):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Accent}):Play()
    end)
    
    return btn
end

function UI:MakeDraggable(frame, dragHandle)
    local dragging = false
    local dragInput, mousePos, framePos
    
    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            frame.Position = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
        end
    end)
end

return UI
