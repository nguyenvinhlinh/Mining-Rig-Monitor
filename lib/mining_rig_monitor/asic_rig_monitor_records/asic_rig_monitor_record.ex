defmodule MiningRigMonitor.AsicRigMonitorRecords.AsicRigMonitorRecord do
  use Ecto.Schema
  import Ecto.Changeset

  alias MiningRigMonitor.MiningRigs.MiningRig
  schema "asic_rig_monitor_records" do
    belongs_to :mining_rig, MiningRig, foreign_key: :mining_rig_id

    field :hashrate_5_min, :float
    field :hashrate_30_min, :float
    field :hashrate_uom, :string
    field :pool_rejection_rate, :float
    field :uptime, :string

    field :pool_1_fieldress, :string
    field :pool_2_fieldress, :string
    field :pool_3_fieldress, :string

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


    timestamps([updated_at: false])
  end

  @doc false
  def changeset(mining_rig, attrs) do
    mining_rig
    |> cast(attrs, [])
    |> validate_required([])
  end
end
