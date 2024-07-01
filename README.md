# MiningRigMonitor

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
# Q&A
1. How to get info from nvidia-smi
```bash
$ nvidia-smi --query-gpu=name,driver_version,vbios_version,pci.bus_id,memory.total --format=csv
name, driver_version, vbios_version, pci.bus_id, memory.total [MiB]
NVIDIA GeForce RTX 3080, 550.90.07, 94.02.71.40.66, 00000000:05:00.0, 10240 MiB
```
2. How to get ram info
```bash
$ dmidecode --type 17
Handle 0x0032, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x0030
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 32 GB
	Form Factor: DIMM
	Set: None
	Locator: P2-DIMMF1
	Bank Locator: P1_Node1_Channel1_Dimm0
	Type: DDR4
	Type Detail: Synchronous
	Speed: 2400 MT/s
	Manufacturer: Samsung
	Serial Number: 02E20563
	Asset Tag: P2-DIMMF1_AssetTag (date:16/34)
	Part Number: M393A2K40BB1-CRC
	Rank: 2
	Configured Memory Speed: 2400 MT/s
	Minimum Voltage: Unknown
	Maximum Voltage: Unknown
	Configured Voltage: Unknown
```


