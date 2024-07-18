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


alias MiningRigMonitor.MiningRigs.MiningRig
alias MiningRigMonitor.Repo

asic_1 = %MiningRig{name: "asic_1", code: "asic_1_code", type: "asic",
                    asic_firmware_version: "BOOT_3_1_image_1.0",
                    asic_software_version: "ICM168_3_2_10_ks5L_miner_ICM168_3_2_10_ks5L_bg"} |> Repo.insert!

asic_2 = %MiningRig{name: "asic_2", code: "asic_2_code", type: "asic",
                    asic_firmware_version: "BOOT_3_1_image_1.0",
                    asic_software_version: "ICM168_3_2_10_ks5L_miner_ICM168_3_2_10_ks5L_bg"} |> Repo.insert!
asic_3 = %MiningRig{name: "asic_3", code: "asic_3_code"} |> Repo.insert!


cpu_gpu_1 = %MiningRig{name: "cpu_gpu_1", code: "cpu_gpu_1_code"} |> Repo.insert!
cpu_gpu_2 = %MiningRig{name: "cpu_gpu_2", code: "cpu_gpu_2_code"} |> Repo.insert!
cpu_gpu_3 = %MiningRig{name: "cpu_gpu_3", code: "cpu_gpu_3_code"} |> Repo.insert!
