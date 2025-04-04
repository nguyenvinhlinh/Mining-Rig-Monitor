# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     MiningRigMonitor.Repo.insert!(%MiningRigMonitor.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.



alias MiningRigMonitor.Repo
alias MiningRigMonitor.AsicMiners.AsicMiner
alias MiningRigMonitor.CpuGpuMiners.CpuGpuMiner
alias MiningRigMonitor.Addresses.Address
alias MiningRigMonitor.CpuGpuMinerPlaybooks.CpuGpuMinerPlaybook

Repo.delete_all(MiningRigMonitor.AsicMinerLogs.AsicMinerLog)
Repo.delete_all(MiningRigMonitor.CpuGpuMinerLogs.CpuGpuMinerLog)

Repo.delete_all(CpuGpuMinerPlaybook)
Repo.delete_all(AsicMiner)
Repo.delete_all(CpuGpuMiner)
Repo.delete_all(Address)

%AsicMiner{
  name: "ASIC_1", api_code: "api_code_1",
  model: "Ice River KS5M",
  model_variant: "10TH",
  firmware_version: "BOOT_3_1_image_1.0",
  software_version: "ICM168_3_2_10_ks5L_miner_ICM168_3_2_10_ks5L_bg",
  activated: true
}
|> Repo.insert!

%AsicMiner{
  name: "ASIC_2", api_code: "api_code_2",
  model: "Ice River KS5M",
  model_variant: "12TH",
  firmware_version: "BOOT_3_1_image_1.0",
  software_version: "ICM168_3_2_10_ks5L_miner_ICM168_3_2_10_ks5L_bg",
  activated: true
}
|> Repo.insert!

%AsicMiner{
  name: "ASIC_3", api_code: "api_code_3",
  model: "Ice River KS5M",
  model_variant: "15TH",
  firmware_version: "BOOT_3_1_image_1.0",
  software_version: "ICM168_3_2_10_ks5L_miner_ICM168_3_2_10_ks5L_bg",
  activated: false
}
|> Repo.insert!

cpu_gpu_miner_1 = %CpuGpuMiner{
  name: "CPU/GPU Miner 1",
  api_code: "api_code_1",
  motherboard_name: "B850 MSI",
  cpu_name: "Ryzen 7950x3D",
  ram_size: "8GB",
  gpu_1_name: "RTX 3080 MSI",
  gpu_2_name: "RTX 3080 MSI",
  gpu_3_name: "RTX 3080 MSI",
  gpu_4_name: "RTX 3080 MSI",
  gpu_5_name: "RTX 3080 MSI",
  gpu_6_name: "RTX 3080 MSI",
  gpu_7_name: "RTX 3080 MSI",
  gpu_8_name: "RTX 3080 MSI",
  activated: true
}
|> Repo.insert!

cpu_gpu_miner_2 = %CpuGpuMiner{
  name: "CPU/GPU Miner 2",
  api_code: "api_code_2",
  motherboard_name: "B850 MSI",
  cpu_name: "Ryzen 7950x3D",
  ram_size: "16GB",
  gpu_1_name: "RTX 3080 MSI",
  gpu_2_name: "RTX 3080 MSI",
  gpu_3_name: "RTX 3080 MSI",
  gpu_4_name: "RTX 3080 MSI",
  gpu_5_name: "RTX 3080 MSI",
  gpu_6_name: "RTX 3080 MSI",
  gpu_7_name: "RTX 3080 MSI",
  gpu_8_name: "RTX 3080 MSI",
  activated: true
}
|> Repo.insert!

%CpuGpuMiner{
  name: "CPU/GPU Miner 3",
  api_code: "api_code_3",
  motherboard_name: "B850 MSI",
  cpu_name: "Ryzen 7950x3D",
  ram_size: "256GB",
  gpu_1_name: "RTX 3080 MSI",
  gpu_2_name: "RTX 3080 MSI",
  gpu_3_name: "RTX 3080 MSI",
  gpu_4_name: "RTX 3080 MSI",
  gpu_5_name: "RTX 3080 MSI",
  gpu_6_name: "RTX 3080 MSI",
  gpu_7_name: "RTX 3080 MSI",
  gpu_8_name: "RTX 3080 MSI",
  activated: false
}
|> Repo.insert!

kaspa_address = %Address{
  name: "Kaspa",
  type: "wallet",
  address: "kaspa:qp9rv9jvx2kyf6wu4lupuruunq5zsuszyxs0dr3l89ej7wsgs48jqkewy6xtl"
}
|> Repo.insert!

monero_address = %Address{
  name: "Monero",
  type: "wallet",
  address: "4AUzXvUpuuRCh3PqMhBmUyfP3TFPhz5cL1iDbgThY6rnUv9vtbPACW2TMJZ8ArprwheeBXEc9rYh62m6vZ8nLW7a8t9iBDn"
}
|> Repo.insert!

%Address{
  name: "Ethereum",
  type: "wallet",
  address: "0x999999cf1046e68e36E1aA2E0E07105eDDD1f08E"
}
|> Repo.insert!


woolypooly_pool_address = %Address{
  name: "Woolypooly-kaspa",
  type: "pool",
  address: "pool.br.woolypooly.com:3112"
}
|> Repo.insert!

hashvault_pool_address = %Address{
  name: "Hashvault-monero",
  type: "pool",
  address: "pool.hashvault.pro:443"
}
|> Repo.insert!

%Address{
  name: "Herominer-beam",
  type: "pool",
  address: "sg.beam.gfwroute.com:1130"
}
|> Repo.insert!

%CpuGpuMinerPlaybook{
  cpu_gpu_miner_id: cpu_gpu_miner_1.id,
  software_name: "XMRig",
  software_version: "6.22.2",
  command_argument: "A very long list of argument in one line",
  coin_name_1: "Monero",
  algorithm_1: "RandomX",
  cpu_wallet_address_id: monero_address.id,
  cpu_pool_address_id: hashvault_pool_address.id
} |> Repo.insert!

%CpuGpuMinerPlaybook{
  cpu_gpu_miner_id: cpu_gpu_miner_2.id,
  software_name: "XMRig",
  software_version: "6.22.2",
  command_argument: "A very long list of argument in one line",
  coin_name_1: "Monero",
  algorithm_1: "RandomX",
  coin_name_2: "Kaspa",
  algorithm_2: "KHeavyHash",
  cpu_wallet_address_id: monero_address.id,
  cpu_pool_address_id: hashvault_pool_address.id,
  gpu_wallet_address_1_id: kaspa_address.id,
  gpu_pool_address_1_id: woolypooly_pool_address.id
} |> Repo.insert!
