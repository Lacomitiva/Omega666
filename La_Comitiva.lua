-- Inicialización del script
local speedBoost = false
local speedValue = 1.0
local playerTracker = {}
local bestBrainrot = nil
local teleportServer = nil
local brainrotTypes = {"og", "seceto", "Brainrot God", "mitico", "legendario", "epico", "raro", "comun"}
local selectedType = nil
local duneroPerSecond = 0

-- Función para activar/desactivar el speed boost
function toggleSpeedBoost()
    speedBoost = not speedBoost
    if speedBoost then
        print("Speed Boost activado")
    else
        print("Speed Boost desactivado")
    end
    updateSpeedBoostInterface()
end

-- Función para actualizar la interfaz del speed boost
function updateSpeedBoostInterface()
    if speedBoostInterface then
        speedBoostInterface:Destroy()
    end
    speedBoostInterface = Chili.Frame:new(screen, {Title = "Speed Boost", Width = 200, Height = 100, X = 10, Y = 10})
    local toggleButton = Chili.Button:new(speedBoostInterface, {Text = speedBoost and "ON" or "OFF", Width = 50, Height = 30, Y = 10})
    local speedSlider = Chili.Slider:new(speedBoostInterface, {Width = 150, Height = 30, Y = 50, Min = 1.0, Max = 5.0, Value = speedValue})
    toggleButton:EventAttach(Chili.Event.MouseButton1, toggleSpeedBoost, nil)
    speedSlider:EventAttach(Chili.Event.ValueChanged, function() speedValue = speedSlider:GetValue() end, nil)
end

-- Función para rastrear jugadores
function trackPlayers()
    -- Lógica para rastrear jugadores y actualizar la lista playerTracker
    print("Rastreando jugadores...")
end

-- Función para encontrar el mejor Brainrot
function findBestBrainrot()
    -- Lógica para determinar el mejor Brainrot y actualizar bestBrainrot
    print("Buscando el mejor Brainrot...")
end

-- Función para teletransportarse a otro servidor
function teleportToServer(server)
    teleportServer = server
    print("Teletransportándose al servidor: " .. server)
end

-- Interfaz principal
local Chili = require("Chili")
local screen = Chili.Screen:new()
local frame = Chili.Frame:new(screen, {Title = "Brainrot Script", Width = 300, Height = 400})

-- Botones y elementos de la interfaz principal
local speedBoostButton = Chili.Button:new(frame, {Text = "Toggle Speed Boost", Width = 200, Height = 30, Y = 20})
local trackPlayersButton = Chili.Button:new(frame, {Text = "Track Players", Width = 200, Height = 30, Y = 60})
local findBestBrainrotButton = Chili.Button:new(frame, {Text = "Find Best Brainrot", Width = 200, Height = 30, Y = 100})
local teleportButton = Chili.Button:new(frame, {Text = "Teleport to Server", Width = 200, Height = 30, Y = 140})

-- Eventos de los botones de la interfaz principal
speedBoostButton:EventAttach(Chili.Event.MouseButton1, toggleSpeedBoost, nil)
trackPlayersButton:EventAttach(Chili.Event.MouseButton1, trackPlayers, nil)
findBestBrainrotButton:EventAttach(Chili.Event.MouseButton1, function() openBrainrotFinder() end, nil)
teleportButton:EventAttach(Chili.Event.MouseButton1, function() teleportToServer("NuevoServidor") end, nil)

-- Función para abrir la interfaz de búsqueda de Brainrot
function openBrainrotFinder()
    local brainrotFinderFrame = Chili.Frame:new(screen, {Title = "Brainrot Finder", Width = 300, Height = 300, X = 320, Y = 10})
    local typeDropdown = Chili.ComboBox:new(brainrotFinderFrame, {Width = 200, Height = 30, Y = 20, Items = brainrotTypes})
    local duneroSlider = Chili.Slider:new(brainrotFinderFrame, {Width = 200, Height = 30, Y = 60, Min = 0, Max = 1000, Value = 0})
    local autoSearchButton = Chili.Button:new(brainrotFinderFrame, {Text = "Auto Search", Width = 200, Height = 30, Y = 100})
    local manualSearchButton = Chili.Button:new(brainrotFinderFrame, {Text = "Manual Search", Width = 200, Height = 30, Y = 140})

    autoSearchButton:EventAttach(Chili.Event.MouseButton1, function()
        selectedType = typeDropdown:GetSelected()
        duneroPerSecond = duneroSlider:GetValue()
        print("Buscando Brainrot automáticamente...")
        -- Lógica para buscar Brainrot automáticamente
    end, nil)

    manualSearchButton:EventAttach(Chili.Event.MouseButton1, function()
        selectedType = typeDropdown:GetSelected()
        duneroPerSecond = duneroSlider:GetValue()
        openManualSearchInterface()
    end, nil)
end

-- Función para abrir la interfaz de búsqueda manual
function openManualSearchInterface()
    local manualSearchFrame = Chili.Frame:new(screen, {Title = "Manual Search", Width = 400, Height = 300, X = 640, Y = 10})
    local refreshButton = Chili.Button:new(manualSearchFrame, {Text = "Refresh Servers", Width = 150, Height = 30, Y = 20})
    local servers = getAvailableServers() -- Función para obtener los servidores disponibles
    for i, server in ipairs(servers) do
        local serverButton = Chili.Button:new(manualSearchFrame, {Text = server.Name, Width = 150, Height = 30, Y = 60 + (i - 1) * 40})
        serverButton:EventAttach(Chili.Event.MouseButton1, function() teleportToServer(server.Name) end, nil)
    end
    refreshButton:EventAttach(Chili.Event.MouseButton1, function() refreshServers(manualSearchFrame) end, nil)
end

-- Función para obtener los servidores disponibles
function getAvailableServers()
    -- Lógica para obtener los servidores disponibles
    return {
        {Name = "Server 1", Type = selectedType, DuneroPerSecond = duneroPerSecond},
        {Name = "Server 2", Type = selectedType, DuneroPerSecond = duneroPerSecond},
        -- Añade más servidores según sea necesario
    }
end

-- Función para refrescar los servidores disponibles
function refreshServers(frame)
    for _, child in ipairs(frame:GetChildren()) do
        if child:IsA("Chili.Button") and child:GetText() ~= "Refresh Servers" then
            child:Destroy()
        end
    end
    local servers = getAvailableServers()
    for i, server in ipairs(servers) do
        local serverButton = Chili.Button:new(frame, {Text = server.Name, Width = 150, Height = 30, Y = 60 + (i - 1) * 40})
        serverButton:EventAttach(Chili.Event.MouseButton1, function() teleportToServer(server.Name) end, nil)
    end
end