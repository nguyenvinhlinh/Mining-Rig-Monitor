# Mining Rig Monitor

At first, I am inspired of many mining rig monitor software such as Minerstats, HiveOS, BrainOS. They do good jobs, They really help the community so much, the crypto industry really appriciate their contribution. In particular, I am a minerstats user, and I love their software! Really cool! This software is an opensource version of Minerstat which do monitor mining rigs.

For a mining farm, they can selfhost this software and play with it!

If someone could create such a great thing and opensource it (`Bitcoin`, `Monero`, `Xmrig`, `Linux kernel`, and many many thing I can't name....), yes, this piece of software can be opensource too!

I will try my best to deliver it, and I really hope so! Or it's just another time, I would fail! but it's worth a try!

----

There are two three tiers regarding monitoring mining rigs.

- **Commander**(this software)
- **Sentry**
- **Mining rig**:
  - **GPU miner**
  - **CPU miner**
  - **ASIC miner**

This source code is focusing on the **commander**. There is one **commander** for mining farm. **A sentry** is installed on each `gpu miner/ cpu miner`. On the other hand, **one sentry** can monitor **many asic miners**.

For software architecture/project management, please visit this repo. [https://github.com/nguyenvinhlinh/Mining-Rig-Monitor-Document](https://github.com/nguyenvinhlinh/Mining-Rig-Monitor-Document).

Thank you!



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

3. How to get Ice River Operational Data?
Check out this [Kaspa Asic - KS5L - API sample to get operational stage](https://hexalink.xyz/mining-rig/2024/07/15/Kaspa-Asic-KS5L-API-sample-to-get-operational-stage.html)

``` sh
$ curl 'http://192.168.1.XXX/user/userpanel' \
  -H 'Accept: application/json, text/javascript, */*; q=0.01' \
  -H 'Accept-Language: en-US,en;q=0.9,vi-VN;q=0.8,vi;q=0.7' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
  -H 'Cookie: language=en; ctime=1' \
  -H 'DNT: 1' \
  -H 'Origin: http://192.168.1.XXX' \
  -H 'Referer: http://192.168.1.XXX/' \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36' \
  -H 'X-Requested-With: XMLHttpRequest' \
  --data-raw 'post=4' \
  --insecure
```
