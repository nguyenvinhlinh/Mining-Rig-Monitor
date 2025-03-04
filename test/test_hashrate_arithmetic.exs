defmodule HashrateArithmeticTest do
  use ExUnit.Case

  test "unify_hashrate_to_hash_second - 01" do
    result = HashrateArithmetic.unify_hashrate_to_hash_second(123, "H/s")
    expect = {123, "H/s"}
    assert result == expect
  end

  test "unify_hashrate_to_hash_second - 02" do
    result = HashrateArithmetic.unify_hashrate_to_hash_second(123.4, "H/s")
    expect = {123.4 , "H/s"}
    assert result == expect
  end

  test "unify_hashrate_to_hash_second - 03" do
    result = HashrateArithmetic.unify_hashrate_to_hash_second(1234, "KH/s")
    expect = {1234000 , "H/s"}
    assert result == expect
  end

  test "unify_hashrate_to_hash_second - 04" do
    result = HashrateArithmetic.unify_hashrate_to_hash_second(123.4, "KH/s")
    expect = {123_400 , "H/s"}
    assert result == expect
  end

  test "unify_hashrate_to_hash_second - 05" do
    result = HashrateArithmetic.unify_hashrate_to_hash_second(123.4, "MH/s")
    expect = {123_400_000 , "H/s"}
    assert result == expect
  end

  test "unify_hashrate_to_hash_second - 06" do
    result = HashrateArithmetic.unify_hashrate_to_hash_second(123.4, "GH/s")
    expect = {123_400_000_000 , "H/s"}
    assert result == expect
  end

  test "unify_hashrate_to_hash_second - 07" do
    result = HashrateArithmetic.unify_hashrate_to_hash_second(123.4, "TH/s")
    expect = {123_400_000_000_000 , "H/s"}
    assert result == expect
  end

  test "unify_hashrate_to_hash_second - 08" do
    result = HashrateArithmetic.unify_hashrate_to_hash_second(123.4, "PH/s")
    expect = {123_400_000_000_000_000 , "H/s"}
    assert result == expect
  end

  test "unify_hashrate_to_hash_second - 09 - bad hashrate" do
    assert_raise HashrateArithmeticError, fn() ->
      HashrateArithmetic.unify_hashrate_to_hash_second("abc", "PH/s")
    end
  end

  test "unify_hashrate_to_hash_second - 10 - bad unit of measurement" do
    assert_raise HashrateArithmeticError, fn() ->
      HashrateArithmetic.unify_hashrate_to_hash_second(123, "SOL/s")
    end
  end

  test "add - 1" do
    hashrate_tuple_1 = {1, "H/s"}
    hashrate_tuple_2 = {2, "KH/s"}
    result = HashrateArithmetic.add(hashrate_tuple_1, hashrate_tuple_2)
    expect = {2_001, "H/s"}
    assert(result == expect)
  end

  test "add - 2" do
    hashrate_tuple_1 = {2, "H/s"}
    hashrate_tuple_2 = {3, "MH/s"}
    result = HashrateArithmetic.add(hashrate_tuple_1, hashrate_tuple_2)
    expect = {3_000_002, "H/s"}
    assert(result == expect)
  end

  test "add - 3" do
    hashrate_tuple_1 = {3, "H/s"}
    hashrate_tuple_2 = {4, "GH/s"}
    result = HashrateArithmetic.add(hashrate_tuple_1, hashrate_tuple_2)
    expect = {4_000_000_003, "H/s"}
    assert(result == expect)
  end

  test "add - 4" do
    hashrate_tuple_1 = {4, "H/s"}
    hashrate_tuple_2 = {5, "TH/s"}
    result = HashrateArithmetic.add(hashrate_tuple_1, hashrate_tuple_2)
    expect = {5_000_000_000_004, "H/s"}
    assert(result == expect)
  end

  test "add - 5" do
    hashrate_tuple_1 = {5, "H/s"}
    hashrate_tuple_2 = {6, "PH/s"}
    result = HashrateArithmetic.add(hashrate_tuple_1, hashrate_tuple_2)
    expect = {6_000_000_000_000_005, "H/s"}
    assert(result == expect)
  end
end
