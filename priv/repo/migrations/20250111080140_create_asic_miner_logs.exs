defmodule MiningRigMonitor.Repo.Migrations.CreateAsicMinerLogs do
  use Ecto.Migration

  def change do
    create table(:asic_miner_logs) do
      add :asic_miner_id, references(:asic_miners)

      add :hashrate_5_min, :float
      add :hashrate_30_min, :float
      add :hashrate_uom, :string, size: 4
      add :pool_rejection_rate, :float
      add :uptime, :string, size: 11

      add :pool_1_address, :string
      add :pool_2_address, :string
      add :pool_3_address, :string

      add :pool_1_user, :string
      add :pool_2_user, :string
      add :pool_3_user, :string

      add :pool_1_state, :string
      add :pool_2_state, :string
      add :pool_3_state, :string

      add :pool_1_accepted_share, :integer
      add :pool_2_accepted_share, :integer
      add :pool_3_accepted_share, :integer

      add :pool_1_rejected_share, :integer
      add :pool_2_rejected_share, :integer
      add :pool_3_rejected_share, :integer

      add :hashboard_1_hashrate_5_min, :float
      add :hashboard_2_hashrate_5_min, :float
      add :hashboard_3_hashrate_5_min, :float

      add :hashboard_1_hashrate_30_min, :float
      add :hashboard_2_hashrate_30_min, :float
      add :hashboard_3_hashrate_30_min, :float

      add :hashboard_1_temp_1, :float
      add :hashboard_1_temp_2, :float

      add :hashboard_2_temp_1, :float
      add :hashboard_2_temp_2, :float

      add :hashboard_3_temp_1, :float
      add :hashboard_3_temp_2, :float

      add :fan_1_speed, :integer
      add :fan_2_speed, :integer
      add :fan_3_speed, :integer
      add :fan_4_speed, :integer

      add :lan_ip, :string
      add :wan_ip, :string

      add :coin_name, :string
      add :power, :float

      timestamps(type: :utc_datetime)
    end
  end
end
