defmodule MiningRigMonitor.Channels do
  # Used for updating mining_rig -> show page
  @mining_rig "mining_rig"

  # Used for updating: asic mining rig -> show page -> monitor record
  @asic_rig_monitor_record "asic_rig_monitor_record"

  def mining_rig_channel, do: @mining_rig
  def asic_rig_monitor_record_channel, do: @asic_rig_monitor_record
end
