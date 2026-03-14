Config = {}

Config.Framework = 'esx' -- esx / qbcore
Config.Inventory = 'auto' -- auto / ox_inventory / qb-inventory / qs-inventory / lj-inventory / codem-inventory / core
Config.Locale = 'en'
Config.Dispatch = 'default' -- default / ps_dispatch / cd_dispatch / qs_dispatch / custom

Config.PoliceJobs = {
    police = true,
    sheriff = true
}

Config.RequiredPolice = {
    register = 1,
    safe = 2
}

Config.LockpickItem = 'lockpick'
Config.RemoveLockpickOnFail = true
Config.LockpickBreakChance = 35
Config.SafeBreakChance = 25

Config.RegisterCooldown = 900
Config.SafeCooldown = 1800

Config.RegisterReward = {
    min = 180,
    max = 420
}

Config.SafeReward = {
    cash = { min = 900, max = 1800 },
    items = {
        { name = 'lockpick', chance = 20, amount = { min = 1, max = 1 } }
    }
}

Config.RegisterMinigame = {
    item = 'lockpick',
    difficulty = 2,
    pins = 4
}

Config.SafeMinigame = {
    wheels = 4,
    min = 0,
    max = 99
}

Config.StoreBlipDuration = 90
Config.StoreBlipSprite = 161
Config.StoreBlipScale = 1.2
Config.StoreBlipColour = 1

Config.TargetDistance = 1.4
Config.RegisterInteractOffset = 0.42
Config.RegisterTargetSize = vec3(0.95, 0.9, 0.9)
Config.SafeTargetSize = vec3(0.75, 0.75, 1.0)

Config.CustomDispatch = {
    event = 'ksu_dispatch:storeRobbery'
}

Config.Stores = {
    ['straberry_ltd'] = {
        label = 'Strawberry LTD',
        registerCooldown = Config.RegisterCooldown,
        safeCooldown = Config.SafeCooldown,
        registers = {
            { id = 'straberry_ltd_reg_1', coords = vec3(-47.24, -1757.65, 29.53), size = vec3(0.5, 0.35, 0.45), heading = 50.0 },
            { id = 'straberry_ltd_reg_2', coords = vec3(-48.58, -1759.21, 29.59), size = vec3(0.5, 0.35, 0.45), heading = 50.0 }
        },
        safe = {
            id = 'straberry_ltd_safe',
            coords = vec3(-43.43, -1748.30, 29.42),
            size = vec3(0.55, 0.55, 0.85),
            heading = 50.0
        }
    },

    ['vespucci_247'] = {
        label = 'Vespucci 24/7',
        registerCooldown = Config.RegisterCooldown,
        safeCooldown = Config.SafeCooldown,
        registers = {
            { id = 'vespucci_247_reg_1', coords = vec3(-1222.03, -908.32, 12.43), size = vec3(0.5, 0.35, 0.45), heading = 32.0 },
            { id = 'vespucci_247_reg_2', coords = vec3(-1220.77, -909.70, 12.43), size = vec3(0.5, 0.35, 0.45), heading = 32.0 }
        },
        safe = {
            id = 'vespucci_247_safe',
            coords = vec3(-1220.88, -916.15, 11.33),
            size = vec3(0.6, 0.55, 0.9),
            heading = 123.0
        }
    },

    ['little_seoul_ltd'] = {
        label = 'Little Seoul LTD',
        registerCooldown = Config.RegisterCooldown,
        safeCooldown = Config.SafeCooldown,
        registers = {
            { id = 'little_seoul_ltd_reg_1', coords = vec3(-706.67, -914.42, 19.32), size = vec3(0.5, 0.35, 0.45), heading = 90.0 },
            { id = 'little_seoul_ltd_reg_2', coords = vec3(-706.67, -912.54, 19.32), size = vec3(0.5, 0.35, 0.45), heading = 90.0 }
        },
        safe = {
            id = 'little_seoul_ltd_safe',
            coords = vec3(-709.74, -904.15, 19.22),
            size = vec3(0.55, 0.55, 0.9),
            heading = 0.0
        }
    },

    ['mirror_park_ltd'] = {
        label = 'Mirror Park LTD',
        registerCooldown = Config.RegisterCooldown,
        safeCooldown = Config.SafeCooldown,
        registers = {
            { id = 'mirror_park_ltd_reg_1', coords = vec3(1165.89, -324.37, 69.21), size = vec3(0.5, 0.35, 0.45), heading = 100.0 },
            { id = 'mirror_park_ltd_reg_2', coords = vec3(1164.54, -322.77, 69.21), size = vec3(0.5, 0.35, 0.45), heading = 100.0 }
        },
        safe = {
            id = 'mirror_park_ltd_safe',
            coords = vec3(1169.31, -324.68, 69.21),
            size = vec3(0.55, 0.55, 0.85),
            heading = 190.0
        }
    },

    ['chumash_247'] = {
        label = 'Chumash 24/7',
        registerCooldown = Config.RegisterCooldown,
        safeCooldown = Config.SafeCooldown,
        registers = {
            { id = 'chumash_247_reg_1', coords = vec3(-1820.17, 794.28, 138.09), size = vec3(0.5, 0.35, 0.45), heading = 132.0 },
            { id = 'chumash_247_reg_2', coords = vec3(-1818.89, 792.94, 138.09), size = vec3(0.5, 0.35, 0.45), heading = 132.0 }
        },
        safe = {
            id = 'chumash_247_safe',
            coords = vec3(-1829.27, 798.76, 138.19),
            size = vec3(0.6, 0.55, 0.9),
            heading = 42.0
        }
    },

    ['banham_robs'] = {
        label = 'Banham Canyon Robs Liquor',
        registerCooldown = Config.RegisterCooldown,
        safeCooldown = Config.SafeCooldown,
        registers = {
            { id = 'banham_robs_reg_1', coords = vec3(-1486.26, -378.00, 40.16), size = vec3(0.5, 0.35, 0.45), heading = 134.0 },
            { id = 'banham_robs_reg_2', coords = vec3(-1488.59, -380.64, 40.16), size = vec3(0.5, 0.35, 0.45), heading = 134.0 }
        },
        safe = {
            id = 'banham_robs_safe',
            coords = vec3(-1479.08, -375.43, 39.16),
            size = vec3(0.6, 0.55, 0.9),
            heading = 226.0
        }
    },

    ['great_ocean_247'] = {
        label = 'Great Ocean 24/7',
        registerCooldown = Config.RegisterCooldown,
        safeCooldown = Config.SafeCooldown,
        registers = {
            { id = 'great_ocean_247_reg_1', coords = vec3(-3244.56, 1000.14, 12.93), size = vec3(0.5, 0.35, 0.45), heading = 355.0 },
            { id = 'great_ocean_247_reg_2', coords = vec3(-3242.26, 1000.03, 12.93), size = vec3(0.5, 0.35, 0.45), heading = 355.0 }
        },
        safe = {
            id = 'great_ocean_247_safe',
            coords = vec3(-3250.06, 1004.43, 12.83),
            size = vec3(0.6, 0.55, 0.9),
            heading = 90.0
        }
    },

    ['ineseno_robs'] = {
        label = 'Ineseno Robs Liquor',
        registerCooldown = Config.RegisterCooldown,
        safeCooldown = Config.SafeCooldown,
        registers = {
            { id = 'ineseno_robs_reg_1', coords = vec3(-2966.39, 390.89, 15.14), size = vec3(0.5, 0.35, 0.45), heading = 84.0 },
            { id = 'ineseno_robs_reg_2', coords = vec3(-2968.27, 390.91, 15.14), size = vec3(0.5, 0.35, 0.45), heading = 84.0 }
        },
        safe = {
            id = 'ineseno_robs_safe',
            coords = vec3(-2959.64, 387.08, 14.04),
            size = vec3(0.6, 0.55, 0.9),
            heading = 176.0
        }
    },

    ['route68_247'] = {
        label = 'Route 68 24/7',
        registerCooldown = Config.RegisterCooldown,
        safeCooldown = Config.SafeCooldown,
        registers = {
            { id = 'route68_247_reg_1', coords = vec3(549.04, 2671.36, 42.26), size = vec3(0.5, 0.35, 0.45), heading = 10.0 },
            { id = 'route68_247_reg_2', coords = vec3(549.33, 2669.04, 42.26), size = vec3(0.5, 0.35, 0.45), heading = 10.0 }
        },
        safe = {
            id = 'route68_247_safe',
            coords = vec3(546.41, 2662.80, 42.16),
            size = vec3(0.6, 0.55, 0.9),
            heading = 100.0
        }
    },

    ['senora_247'] = {
        label = 'Senora 24/7',
        registerCooldown = Config.RegisterCooldown,
        safeCooldown = Config.SafeCooldown,
        registers = {
            { id = 'senora_247_reg_1', coords = vec3(2678.36, 3279.57, 55.35), size = vec3(0.5, 0.35, 0.45), heading = 330.0 },
            { id = 'senora_247_reg_2', coords = vec3(2676.16, 3280.64, 55.35), size = vec3(0.5, 0.35, 0.45), heading = 330.0 }
        },
        safe = {
            id = 'senora_247_safe',
            coords = vec3(2672.78, 3286.61, 55.25),
            size = vec3(0.6, 0.55, 0.9),
            heading = 62.0
        }
    },

    ['sandy_robs'] = {
        label = 'Sandy Robs Liquor',
        registerCooldown = Config.RegisterCooldown,
        safeCooldown = Config.SafeCooldown,
        registers = {
            { id = 'sandy_robs_reg_1', coords = vec3(1134.25, -982.47, 46.52), size = vec3(0.5, 0.35, 0.45), heading = 280.0 },
            { id = 'sandy_robs_reg_2', coords = vec3(1135.78, -982.17, 46.52), size = vec3(0.5, 0.35, 0.45), heading = 280.0 }
        },
        safe = {
            id = 'sandy_robs_safe',
            coords = vec3(1126.77, -980.10, 45.42),
            size = vec3(0.6, 0.55, 0.9),
            heading = 190.0
        }
    },

    ['grapeseed_247'] = {
        label = 'Grapeseed 24/7',
        registerCooldown = Config.RegisterCooldown,
        safeCooldown = Config.SafeCooldown,
        registers = {
            { id = 'grapeseed_247_reg_1', coords = vec3(1728.78, 6417.34, 35.14), size = vec3(0.5, 0.35, 0.45), heading = 245.0 },
            { id = 'grapeseed_247_reg_2', coords = vec3(1730.11, 6415.63, 35.14), size = vec3(0.5, 0.35, 0.45), heading = 245.0 }
        },
        safe = {
            id = 'grapeseed_247_safe',
            coords = vec3(1734.84, 6420.84, 35.04),
            size = vec3(0.6, 0.55, 0.9),
            heading = 333.0
        }
    },

    ['harmony_247'] = {
        label = 'Harmony 24/7',
        registerCooldown = Config.RegisterCooldown,
        safeCooldown = Config.SafeCooldown,
        registers = {
            { id = 'harmony_247_reg_1', coords = vec3(544.83, 2668.92, 42.26), size = vec3(0.5, 0.35, 0.45), heading = 10.0 },
            { id = 'harmony_247_reg_2', coords = vec3(544.50, 2671.19, 42.26), size = vec3(0.5, 0.35, 0.45), heading = 10.0 }
        },
        safe = {
            id = 'harmony_247_safe',
            coords = vec3(548.12, 2662.90, 42.16),
            size = vec3(0.6, 0.55, 0.9),
            heading = 100.0
        }
    },

    ['sandy_247'] = {
        label = 'Sandy 24/7',
        registerCooldown = Config.RegisterCooldown,
        safeCooldown = Config.SafeCooldown,
        registers = {
            { id = 'sandy_247_reg_1', coords = vec3(1960.13, 3740.00, 32.45), size = vec3(0.5, 0.35, 0.45), heading = 300.0 },
            { id = 'sandy_247_reg_2', coords = vec3(1961.74, 3741.63, 32.45), size = vec3(0.5, 0.35, 0.45), heading = 300.0 }
        },
        safe = {
            id = 'sandy_247_safe',
            coords = vec3(1959.33, 3748.99, 32.35),
            size = vec3(0.6, 0.55, 0.9),
            heading = 30.0
        }
    },

    ['senora_gas'] = {
        label = 'Senora Gas Station',
        registerCooldown = Config.RegisterCooldown,
        safeCooldown = Config.SafeCooldown,
        registers = {
            { id = 'senora_gas_reg_1', coords = vec3(1392.88, 3606.70, 34.98), size = vec3(0.5, 0.35, 0.45), heading = 200.0 },
            { id = 'senora_gas_reg_2', coords = vec3(1395.09, 3605.16, 34.98), size = vec3(0.5, 0.35, 0.45), heading = 200.0 }
        },
        safe = {
            id = 'senora_gas_safe',
            coords = vec3(1394.97, 3613.00, 34.88),
            size = vec3(0.6, 0.55, 0.9),
            heading = 20.0
        }
    },

    ['palomino_247'] = {
        label = 'Palomino 24/7',
        registerCooldown = Config.RegisterCooldown,
        safeCooldown = Config.SafeCooldown,
        registers = {
            { id = 'palomino_247_reg_1', coords = vec3(2557.44, 382.00, 108.73), size = vec3(0.5, 0.35, 0.45), heading = 0.0 },
            { id = 'palomino_247_reg_2', coords = vec3(2555.65, 380.91, 108.73), size = vec3(0.5, 0.35, 0.45), heading = 0.0 }
        },
        safe = {
            id = 'palomino_247_safe',
            coords = vec3(2549.24, 384.92, 108.62),
            size = vec3(0.6, 0.55, 0.9),
            heading = 90.0
        }
    },

    ['perro_247'] = {
        label = 'Del Perro 24/7',
        registerCooldown = Config.RegisterCooldown,
        safeCooldown = Config.SafeCooldown,
        registers = {
            { id = 'perro_247_reg_1', coords = vec3(-3038.98, 584.50, 7.02), size = vec3(0.5, 0.35, 0.45), heading = 17.0 },
            { id = 'perro_247_reg_2', coords = vec3(-3041.18, 583.84, 7.02), size = vec3(0.5, 0.35, 0.45), heading = 17.0 }
        },
        safe = {
            id = 'perro_247_safe',
            coords = vec3(-3047.88, 585.58, 7.02),
            size = vec3(0.6, 0.55, 0.9),
            heading = 108.0
        }
    },

    ['downtown_247'] = {
        label = 'Downtown 24/7',
        registerCooldown = Config.RegisterCooldown,
        safeCooldown = Config.SafeCooldown,
        registers = {
            { id = 'downtown_247_reg_1', coords = vec3(24.49, -1344.99, 29.60), size = vec3(0.5, 0.35, 0.45), heading = 267.0 },
            { id = 'downtown_247_reg_2', coords = vec3(25.69, -1347.30, 29.60), size = vec3(0.5, 0.35, 0.45), heading = 267.0 }
        },
        safe = {
            id = 'downtown_247_safe',
            coords = vec3(28.24, -1339.23, 29.50),
            size = vec3(0.6, 0.55, 0.9),
            heading = 0.0
        }
    },

    ['vinewood_247'] = {
        label = 'Vinewood 24/7',
        registerCooldown = Config.RegisterCooldown,
        safeCooldown = Config.SafeCooldown,
        registers = {
            { id = 'vinewood_247_reg_1', coords = vec3(373.05, 328.65, 103.67), size = vec3(0.5, 0.35, 0.45), heading = 255.0 },
            { id = 'vinewood_247_reg_2', coords = vec3(373.80, 326.43, 103.67), size = vec3(0.5, 0.35, 0.45), heading = 255.0 }
        },
        safe = {
            id = 'vinewood_247_safe',
            coords = vec3(378.17, 333.44, 103.57),
            size = vec3(0.6, 0.55, 0.9),
            heading = 164.0
        }
    },

    ['grapeseed_ltd'] = {
        label = 'Grapeseed LTD',
        registerCooldown = Config.RegisterCooldown,
        safeCooldown = Config.SafeCooldown,
        registers = {
            { id = 'grapeseed_ltd_reg_1', coords = vec3(1696.69, 4923.61, 42.16), size = vec3(0.5, 0.35, 0.45), heading = 323.0 },
            { id = 'grapeseed_ltd_reg_2', coords = vec3(1698.33, 4922.89, 42.16), size = vec3(0.5, 0.35, 0.45), heading = 323.0 }
        },
        safe = {
            id = 'grapeseed_ltd_safe',
            coords = vec3(1707.82, 4919.63, 42.06),
            size = vec3(0.6, 0.55, 0.9),
            heading = 55.0
        }
    }
}
