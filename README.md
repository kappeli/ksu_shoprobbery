# ksu_storerobbery

Simple storerobbery for FiveM ESX and QBcore frameworks

## Features

- Store registers and safes can be robbed
- ESX by default, switch to QBcore in `config.lua`
- Dispatch mode is configurable

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
