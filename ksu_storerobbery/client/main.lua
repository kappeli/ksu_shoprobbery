local resourceName = GetCurrentResourceName()
local currentLocale = Locales[Config.Locale] or Locales['en']

local function locale(key, ...)
    local str = currentLocale[key] or key
    if select('#', ...) > 0 then
        return str:format(...)
    end
    return str
end

local function notify(description, ntype)
    if lib and lib.notify then
        lib.notify({
            title = 'ksu_storerobbery',
            description = description,
            type = ntype or 'inform'
        })
        return
    end

    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(description)
    EndTextCommandThefeedPostTicker(false, false)
end

local function isPoliceJob(job)
    return job and Config.PoliceJobs[job] == true
end

local function getPlayerJob()
    if Config.Framework == 'qbcore' then
        local qb = exports['qb-core']:GetCoreObject()
        local data = qb.Functions.GetPlayerData()
        return data and data.job and data.job.name or nil
    end

    local state = LocalPlayer.state
    if state and state.job and state.job.name then
        return state.job.name
    end

    if ESX and ESX.PlayerData and ESX.PlayerData.job then
        return ESX.PlayerData.job.name
    end

    return nil
end

local function addDispatchBlip(coords)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, Config.StoreBlipSprite)
    SetBlipScale(blip, Config.StoreBlipScale)
    SetBlipColour(blip, Config.StoreBlipColour)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(locale('dispatch_title'))
    EndTextCommandSetBlipName(blip)

    CreateThread(function()
        local expire = GetGameTimer() + (Config.StoreBlipDuration * 1000)
        while GetGameTimer() < expire do
            SetBlipAlpha(blip, 255)
            Wait(500)
            if not DoesBlipExist(blip) then
                return
            end
        end

        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
    end)
end

RegisterNetEvent('ksu_storerobbery:client:policeAlert', function(coords, message)
    local job = getPlayerJob()
    if not isPoliceJob(job) then
        return
    end

    addDispatchBlip(coords)
    notify(message or locale('internal_alert'), 'error')
end)

RegisterNetEvent('ksu_storerobbery:client:externalDispatch', function(payload)
    local mode = Config.Dispatch

    if mode == 'ps_dispatch' and GetResourceState('ps-dispatch') == 'started' then
        exports['ps-dispatch']:CustomAlert({
            coords = vector3(payload.coords.x, payload.coords.y, payload.coords.z),
            message = payload.message,
            dispatchCode = '10-90',
            description = payload.message,
            radius = 0,
            sprite = Config.StoreBlipSprite,
            color = Config.StoreBlipColour,
            scale = Config.StoreBlipScale,
            length = 2,
            jobs = payload.jobs
        })
        return
    end

    if mode == 'cd_dispatch' and GetResourceState('cd_dispatch') == 'started' then
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = payload.jobs,
            coords = vector3(payload.coords.x, payload.coords.y, payload.coords.z),
            title = payload.title,
            message = payload.message,
            flash = 1,
            unique_id = tostring(math.random(100000, 999999)),
            sound = 1,
            blip = {
                sprite = Config.StoreBlipSprite,
                scale = Config.StoreBlipScale,
                colour = Config.StoreBlipColour,
                flashes = false,
                text = payload.title,
                time = Config.StoreBlipDuration,
                radius = 0
            }
        })
        return
    end

    if mode == 'qs_dispatch' and GetResourceState('qs-dispatch') == 'started' then
        TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', {
            job = payload.jobs,
            callLocation = vector3(payload.coords.x, payload.coords.y, payload.coords.z),
            callCode = { code = '10-90', snippet = payload.title },
            message = payload.message,
            flashes = false,
            image = nil,
            blip = {
                sprite = Config.StoreBlipSprite,
                scale = Config.StoreBlipScale,
                colour = Config.StoreBlipColour,
                flashes = false,
                text = payload.title,
                time = Config.StoreBlipDuration,
                radius = 0
            }
        })
        return
    end

    if mode == 'custom' and Config.CustomDispatch.event and Config.CustomDispatch.event ~= '' then
        TriggerEvent(Config.CustomDispatch.event, payload)
        return
    end

    notify(locale('fallback_dispatch'))
end)

local function offsetCoordsFromHeading(coords, heading, distance)
    local radians = math.rad(heading)
    return vec3(
        coords.x - math.sin(radians) * distance,
        coords.y + math.cos(radians) * distance,
        coords.z
    )
end

local function createBoxOption(name, coords, size, heading, label, onSelect, canInteract)
    exports.ox_target:addBoxZone({
        name = ('%s_%s'):format(resourceName, name),
        coords = coords,
        size = size,
        rotation = heading,
        debug = false,
        options = {
            {
                name = name,
                icon = 'fa-solid fa-mask',
                label = label,
                distance = Config.TargetDistance,
                canInteract = canInteract,
                onSelect = onSelect
            }
        }
    })
end

local function beginDispatch(store)
    TriggerServerEvent('ksu_storerobbery:server:dispatch', {
        store = store.label,
        coords = store.safe.coords
    })
end

local function tryRegister(storeId, registerId)
    local response = lib.callback.await('ksu_storerobbery:server:startRegister', false, storeId, registerId)
    if not response or not response.ok then
        notify(response and response.message or 'Error', 'error')
        return
    end

    beginDispatch(Config.Stores[storeId])

    local success = exports['t3_lockpick']:startLockpick(
        Config.RegisterMinigame.item,
        Config.RegisterMinigame.difficulty,
        Config.RegisterMinigame.pins
    )

    if not success then
        TriggerServerEvent('ksu_storerobbery:server:registerFailed')
        notify(locale('lockpick_failed'), 'error')
        return
    end

    local progress = lib.progressBar({
        duration = 5000,
        label = locale('using_register'),
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = false,
            car = true,
            combat = true
        }
    })

    if not progress then
        return
    end

    local finished = lib.callback.await('ksu_storerobbery:server:finishRegister', false, storeId, registerId)
    if not finished or not finished.ok then
        notify(finished and finished.message or 'Error', 'error')
        return
    end

    notify(locale('register_success'), 'success')
end

local function trySafe(storeId)
    local response = lib.callback.await('ksu_storerobbery:server:startSafe', false, storeId)
    if not response or not response.ok then
        notify(response and response.message or 'Error', 'error')
        return
    end

    beginDispatch(Config.Stores[storeId])

    local progress = lib.progressBar({
        duration = 3500,
        label = locale('setting_safe'),
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = false,
            car = true,
            combat = true
        }
    })

    if not progress then
        TriggerServerEvent('ksu_storerobbery:server:cancelSafe', storeId)
        return
    end

    local success = exports['pd-safe']:createSafe(response.combo)

    if not success then
        TriggerServerEvent('ksu_storerobbery:server:failSafe', storeId)
        notify(locale('safe_failed'), 'error')
        return
    end

    local finished = lib.callback.await('ksu_storerobbery:server:finishSafe', false, storeId)
    if not finished or not finished.ok then
        notify(finished and finished.message or 'Error', 'error')
        return
    end

    notify(locale('safe_success'), 'success')
end

CreateThread(function()
    for storeId, store in pairs(Config.Stores) do
        for _, register in ipairs(store.registers) do
            local targetCoords = offsetCoordsFromHeading(register.coords, register.heading, Config.RegisterInteractOffset or 0.42)
            createBoxOption(
                register.id,
                targetCoords,
                Config.RegisterTargetSize or register.size,
                register.heading,
                locale('target_register'),
                function()
                    tryRegister(storeId, register.id)
                end
            )
        end

        createBoxOption(
            store.safe.id,
            store.safe.coords,
            Config.SafeTargetSize or store.safe.size,
            store.safe.heading,
            locale('target_safe'),
            function()
                trySafe(storeId)
            end
        )
    end
end)
