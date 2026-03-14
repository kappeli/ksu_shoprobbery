# ksu_storerobbery

Store robbery for ox_target with `t3_lockpick`, `pd-safe`, ox_lib and configurable dispatch.

## Features

- Every store has two register targets
- Registers use `t3_lockpick`
- Safes use `pd-safe`
- Register and safe robberies are separate
- Register cooldown is per register only
- Safe cooldown is per store only
- You can hit a safe in one store and a register in another at the same time
- ESX by default, switch to QBcore in `config.lua`
- Dispatch mode is configurable
- English locale included

## Dependencies

- `ox_lib`
- `ox_target`
- `t3_lockpick`
- `pd-safe`
- `es_extended` or `qb-core`

## Dispatch

Set `Config.Dispatch` to one of these:

- `default`
- `ps_dispatch`
- `cd_dispatch`
- `qs_dispatch`
- `custom`

For a custom setup, change `Config.CustomDispatch.event`.

## Item

Players need the item named:

```lua
lockpick
```
