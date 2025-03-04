defmodule HashrateArithmetic  do

  @uom_list ["H/s", "KH/s", "MH/s", "GH/s", "TH/s", "PH/s"]

  @doc """
  add/2, this function add two {hashrate, uom}
  hashrate_tuple_1 = {hashrate, unit_of_measure}
  hashrate_tuple_2 = {hashrate, unit_of_measure}
  Output:
  {hashrate, unit_of_measure}
  """
  def add({hashrate_1, uom_1}, {hashrate_2, uom_2}) do
    {hashrate_1_mod, "H/s"} = unify_hashrate_to_hash_second(hashrate_1, uom_1)
    {hashrate_2_mod, "H/s"} = unify_hashrate_to_hash_second(hashrate_2, uom_2)

    sum_hashrate = hashrate_1_mod + hashrate_2_mod
    {sum_hashrate, "H/s"}
  end

  def unify_hashrate_to_hash_second(hashrate, "H/s") when Kernel.is_number(hashrate) do
    {hashrate, "H/s"}
  end

  def unify_hashrate_to_hash_second(hashrate, "KH/s") when Kernel.is_number(hashrate) do
    {hashrate * 1_000, "H/s"}
  end

  def unify_hashrate_to_hash_second(hashrate, "MH/s") when Kernel.is_number(hashrate) do
    {hashrate * 1_000_000, "H/s"}
  end

  def unify_hashrate_to_hash_second(hashrate, "GH/s") when Kernel.is_number(hashrate) do
    {hashrate * 1_000_000_000, "H/s"}
  end

  def unify_hashrate_to_hash_second(hashrate, "TH/s") when Kernel.is_number(hashrate) do
    {hashrate * 1_000_000_000_000, "H/s"}
  end

  def unify_hashrate_to_hash_second(hashrate, "PH/s") when Kernel.is_number(hashrate) do
    {hashrate * 1_000_000_000_000_000, "H/s"}
  end

  def unify_hashrate_to_hash_second(bad_hashrate, bad_uom)  do
    if Kernel.is_number(bad_hashrate) == false  do
      raise HashrateArithmeticError, "Bad hashrate, got: #{bad_hashrate}"
    end

    if Enum.member?(@uom_list, bad_uom) == false do
      raise HashrateArithmeticError, "Bad unit of measurement, got: #{bad_uom}"
    end
  end

  def uom_list, do: @uom_list
end
