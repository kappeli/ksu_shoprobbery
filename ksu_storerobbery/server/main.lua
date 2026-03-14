local currentLocale = Locales[Config.Locale] or Locales['en']
local ESX
local QBCore

if Config.Framework == 'qbcore' then
    QBCore = exports['qb-core']:GetCoreObject()
else
    ESX = exports['es_extended']:getSharedObject()
end

local registerCooldowns = {}
local safeCooldowns = {}
local activeSafeSessions = {}

local function locale(key, ...)
    local str = currentLocale[key] or key
    if select('#', ...) > 0 then
        return str:format(...)
    end
    return str
end

local function hasStarted(resource)
    return GetResourceState(resource) == 'started'
end

local function getPlayer(source)
    if Config.Framework == 'qbcore' then
        return QBCore.Functions.GetPlayer(source)
    end
    return ESX.GetPlayerFromId(source)
end

local function getJobName(source)
    local player = getPlayer(source)
    if not player then
        return nil
    end

    if Config.Framework == 'qbcore' then
        return player.PlayerData.job and player.PlayerData.job.name or nil
    end

    return player.job and player.job.name or nil
end

local function getPoliceCount()
    local count = 0
    for _, playerId in ipairs(GetPlayers()) do
        local job = getJobName(tonumber(playerId))
        if job and Config.PoliceJobs[job] then
            count += 1
        end
    end
    return count
end

local function hasItem(source, itemName, amount)
    amount = amount or 1

    if Config.Inventory == 'auto' or Config.Inventory == 'ox_inventory' then
        if hasStarted('ox_inventory') then
            local count = exports.ox_inventory:Search(source, 'count', itemName)
            if count and count >= amount then
                return true
            end
        end
    end

    local player = getPlayer(source)
    if not player then
        return false
    end

    if Config.Framework == 'qbcore' then
        if (Config.Inventory == 'auto' or Config.Inventory == 'qb-inventory') and hasStarted('qb-inventory') then
            local item = exports['qb-inventory']:GetItemByName(source, itemName)
            return item and item.amount and item.amount >= amount or false
        end

        if (Config.Inventory == 'auto' or Config.Inventory == 'lj-inventory') and hasStarted('lj-inventory') then
            local item = exports['lj-inventory']:GetItemByName(source, itemName)
            return item and item.amount and item.amount >= amount or false
        end

        if (Config.Inventory == 'auto' or Config.Inventory == 'qs-inventory') and hasStarted('qs-inventory') then
            local item = exports['qs-inventory']:GetItemTotalAmount(source, itemName)
            return item and item >= amount or false
        end

        if (Config.Inventory == 'auto' or Config.Inventory == 'codem-inventory') and hasStarted('codem-inventory') then
            local item = exports['codem-inventory']:GetItemsTotalAmount(source, itemName)
            return item and item >= amount or false
        end

        local item = player.Functions.GetItemByName(itemName)
        return item and item.amount and item.amount >= amount or false
    end

    local item = player.getInventoryItem(itemName)
    return item and item.count and item.count >= amount or false
end

local function removeItem(source, itemName, amount)
    amount = amount or 1

    if (Config.Inventory == 'auto' or Config.Inventory == 'ox_inventory') and hasStarted('ox_inventory') then
        return exports.ox_inventory:RemoveItem(source, itemName, amount)
    end

    local player = getPlayer(source)
    if not player then
        return false
    end

    if Config.Framework == 'qbcore' then
        player.Functions.RemoveItem(itemName, amount, false)
        return true
    end

    player.removeInventoryItem(itemName, amount)
    return true
end

local function addMoney(source, amount)
    local player = getPlayer(source)
    if not player then
        return false
    end

    if Config.Framework == 'qbcore' then
        player.Functions.AddMoney('cash', amount, 'store-robbery')
        return true
    end

    player.addMoney(amount)
    return true
end

local function addItem(source, itemName, amount)
    amount = amount or 1

    if (Config.Inventory == 'auto' or Config.Inventory == 'ox_inventory') and hasStarted('ox_inventory') then
        return exports.ox_inventory:AddItem(source, itemName, amount)
    end

    local player = getPlayer(source)
    if not player then
        return false
    end

    if Config.Framework == 'qbcore' then
        player.Functions.AddItem(itemName, amount, false)
        return true
    end

    player.addInventoryItem(itemName, amount)
    return true
end

local function registerCooldownActive(registerId)
    local expiresAt = registerCooldowns[registerId]
    return expiresAt and expiresAt > os.time()
end

local function safeCooldownActive(storeId)
    local expiresAt = safeCooldowns[storeId]
    return expiresAt and expiresAt > os.time()
end

local function startRegisterCooldown(storeId, registerId)
    local store = Config.Stores[storeId]
    registerCooldowns[registerId] = os.time() + (store.registerCooldown or Config.RegisterCooldown)
end

local function startSafeCooldown(storeId)
    local store = Config.Stores[storeId]
    safeCooldowns[storeId] = os.time() + (store.safeCooldown or Config.SafeCooldown)
end

local function createSafeCombo()
    local combo = {}
    for i = 1, Config.SafeMinigame.wheels do
        combo[#combo + 1] = math.random(Config.SafeMinigame.min, Config.SafeMinigame.max)
    end
    return combo
end

local function clearSafeSession(storeId)
    activeSafeSessions[storeId] = nil
end

lib.callback.register('ksu_storerobbery:server:startRegister', function(source, storeId, registerId)
    local store = Config.Stores[storeId]
    if not store then
        return { ok = false, message = 'Invalid store' }
    end

    if registerCooldownActive(registerId) then
        return { ok = false, message = locale('register_cooldown') }
    end

    if getPoliceCount() < Config.RequiredPolice.register then
        return { ok = false, message = locale('not_enough_police') }
    end

    if not hasItem(source, Config.LockpickItem, 1) then
        return { ok = false, message = locale('need_lockpick') }
    end

    return { ok = true }
end)

RegisterNetEvent('ksu_storerobbery:server:registerFailed', function()
    local source = source

    if Config.RemoveLockpickOnFail and math.random(1, 100) <= Config.LockpickBreakChance then
        removeItem(source, Config.LockpickItem, 1)
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'ksu_storerobbery',
            description = locale('lockpick_broke'),
            type = 'error'
        })
    end
end)

lib.callback.register('ksu_storerobbery:server:finishRegister', function(source, storeId, registerId)
    local store = Config.Stores[storeId]
    if not store then
        return { ok = false, message = 'Invalid store' }
    end

    if registerCooldownActive(registerId) then
        return { ok = false, message = locale('register_cooldown') }
    end

    local reward = math.random(Config.RegisterReward.min, Config.RegisterReward.max)
    addMoney(source, reward)
    startRegisterCooldown(storeId, registerId)

    return { ok = true, reward = reward }
end)

lib.callback.register('ksu_storerobbery:server:startSafe', function(source, storeId)
    local store = Config.Stores[storeId]
    if not store then
        return { ok = false, message = 'Invalid store' }
    end

    if safeCooldownActive(storeId) then
        return { ok = false, message = locale('safe_cooldown') }
    end

    if getPoliceCount() < Config.RequiredPolice.safe then
        return { ok = false, message = locale('not_enough_police') }
    end

    if not hasItem(source, Config.LockpickItem, 1) then
        return { ok = false, message = locale('need_lockpick') }
    end

    local session = activeSafeSessions[storeId]
    if session then
        return { ok = false, message = locale('safe_busy') }
    end

    session = {
        owner = source,
        combo = createSafeCombo()
    }

    activeSafeSessions[storeId] = session

    return {
        ok = true,
        combo = session.combo
    }
end)

RegisterNetEvent('ksu_storerobbery:server:cancelSafe', function(storeId)
    local source = source
    local session = activeSafeSessions[storeId]
    if not session or session.owner ~= source then
        return
    end

    clearSafeSession(storeId)
end)

RegisterNetEvent('ksu_storerobbery:server:failSafe', function(storeId)
    local source = source
    local session = activeSafeSessions[storeId]
    if not session or session.owner ~= source then
        return
    end

    if Config.RemoveLockpickOnFail and math.random(1, 100) <= Config.SafeBreakChance then
        removeItem(source, Config.LockpickItem, 1)
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'ksu_storerobbery',
            description = locale('lockpick_broke'),
            type = 'error'
        })
    end

    clearSafeSession(storeId)
end)

lib.callback.register('ksu_storerobbery:server:finishSafe', function(source, storeId)
    local session = activeSafeSessions[storeId]
    if not session then
        return { ok = false, message = locale('safe_not_active') }
    end

    if session.owner ~= source then
        return { ok = false, message = locale('safe_busy') }
    end

    local cash = math.random(Config.SafeReward.cash.min, Config.SafeReward.cash.max)
    addMoney(source, cash)

    for _, reward in ipairs(Config.SafeReward.items) do
        if math.random(1, 100) <= reward.chance then
            local amount = math.random(reward.amount.min, reward.amount.max)
            addItem(source, reward.name, amount)
        end
    end

    startSafeCooldown(storeId)
    clearSafeSession(storeId)

    return { ok = true, reward = cash }
end)

RegisterNetEvent('ksu_storerobbery:server:dispatch', function(payload)
    local source = source
    local storeName = payload and payload.store or 'Store'
    local coords = payload and payload.coords or vec3(0.0, 0.0, 0.0)

    local dispatchPayload = {
        title = locale('dispatch_title'),
        message = locale('dispatch_message', storeName),
        coords = { x = coords.x, y = coords.y, z = coords.z },
        jobs = {}
    }

    for jobName in pairs(Config.PoliceJobs) do
        dispatchPayload.jobs[#dispatchPayload.jobs + 1] = jobName
    end

    if Config.Dispatch == 'default' then
        for _, playerId in ipairs(GetPlayers()) do
            playerId = tonumber(playerId)
            local job = getJobName(playerId)
            if job and Config.PoliceJobs[job] then
                TriggerClientEvent('ksu_storerobbery:client:policeAlert', playerId, coords, dispatchPayload.message)
            end
        end
        return
    end

    TriggerClientEvent('ksu_storerobbery:client:externalDispatch', source, dispatchPayload)
end)

AddEventHandler('playerDropped', function()
    local source = source
    for storeId, session in pairs(activeSafeSessions) do
        if session.owner == source then
            clearSafeSession(storeId)
        end
    end
end)
