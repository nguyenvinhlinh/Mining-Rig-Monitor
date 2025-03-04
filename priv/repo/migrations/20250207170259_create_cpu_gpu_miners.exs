defmodule MiningRigMonitor.Repo.Migrations.CreateCpuGpuMiners do
  use Ecto.Migration

  def change do
    create table(:cpu_gpu_miners) do
      add :name, :string
      add :api_code, :string
      add :cpu_1_name, :string
      add :cpu_2_name, :string
      add :ram_size, :string
      add :gpu_1_name, :string
      add :gpu_2_name, :string
      add :gpu_3_name, :string
      add :gpu_4_name, :string
      add :gpu_5_name, :string
      add :gpu_6_name, :string
      add :gpu_7_name, :string
      add :gpu_8_name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
