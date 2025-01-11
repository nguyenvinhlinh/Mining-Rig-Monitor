defmodule MiningRigMonitor.AsicMinerLogs.AsicMinerLog do
  use Ecto.Schema
  import Ecto.Changeset

  alias MiningRigMonitor.AsicMiners.AsicMiner
  schema "asic_miner_logs" do
    belongs_to :asic_miner, AsicMiner, foreign_key: :asic_miner_id

    field :hashrate_5_min, :float
    field :hashrate_30_min, :float
    field :hashrate_uom, :string
    field :pool_rejection_rate, :float
    field :uptime, :string

    field :pool_1_address, :string
    field :pool_2_address, :string
    field :pool_3_address, :string

    field :pool_1_user, :string
    field :pool_2_user, :string
    field :pool_3_user, :string

    field :pool_1_state, :string
    field :pool_2_state, :string
    field :pool_3_state, :string

    field :pool_1_accepted_share, :integer
    field :pool_2_accepted_share, :integer
    field :pool_3_accepted_share, :integer

    field :pool_1_rejected_share, :integer
    field :pool_2_rejected_share, :integer
    field :pool_3_rejected_share, :integer

    field :hashboard_1_hashrate_5_min, :float
    field :hashboard_2_hashrate_5_min, :float
    field :hashboard_3_hashrate_5_min, :float

    field :hashboard_1_hashrate_30_min, :float
    field :hashboard_2_hashrate_30_min, :float
    field :hashboard_3_hashrate_30_min, :float

    field :hashboard_1_temp_1, :float
    field :hashboard_1_temp_2, :float

    field :hashboard_2_temp_1, :float
    field :hashboard_2_temp_2, :float

    field :hashboard_3_temp_1, :float
    field :hashboard_3_temp_2, :float

    field :fan_1_speed, :integer
    field :fan_2_speed, :integer
    field :fan_3_speed, :integer
    field :fan_4_speed, :integer

    field :lan_ip, :string
    field :wan_ip, :string

    field :coin_name, :string
    field :power, :float

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(asic_miner_log, attrs) do
    asic_miner_log
    |> cast(attrs, cast_column_list())
    |> validate_required([:asic_miner_id])
  end

  defp cast_column_list()  do
    [:asic_miner_id, :hashrate_5_min, :hashrate_30_min, :hashrate_uom, :pool_rejection_rate, :uptime,
     :pool_1_address, :pool_2_address, :pool_3_address, :pool_1_user,
     :pool_2_user, :pool_3_user, :pool_1_state, :pool_2_state,
     :pool_3_state, :pool_1_accepted_share,  :pool_2_accepted_share,  :pool_3_accepted_share,
     :pool_1_rejected_share,  :pool_2_rejected_share,  :pool_3_rejected_share,  :hashboard_1_hashrate_5_min,
     :hashboard_2_hashrate_5_min, :hashboard_3_hashrate_5_min, :hashboard_1_hashrate_30_min, :hashboard_2_hashrate_30_min,
     :hashboard_3_hashrate_30_min, :hashboard_1_temp_1, :hashboard_1_temp_2, :hashboard_2_temp_1,
     :hashboard_2_temp_2, :hashboard_3_temp_1, :hashboard_3_temp_2, :fan_1_speed,
     :fan_2_speed, :fan_3_speed, :fan_4_speed, :lan_ip,
     :wan_ip, :coin_name, :power]
  end
end
