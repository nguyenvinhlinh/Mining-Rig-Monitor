defmodule MiningRigMonitor.UtilityTest do
  use ExUnit.Case
  alias  MiningRigMonitor.Utility

  test "remove_diacritical_marks 1" do
    string = """
    a á à ã ạ ả
    â ấ ầ ẫ ậ ẩ
    ă ắ ằ ẳ ặ ẳ
    e é è ẽ ẹ ẻ
    ê ế ề ễ ệ ể
    u ú ù ũ ụ ủ
    ư ứ ừ ữ ự ử
    o ó ò õ ọ ỏ
    ơ ớ ờ ỡ ợ ở
    """
    test_result = Utility.remove_diacritical_marks(string)
    expected_result = """
    a a a a a a
    a a a a a a
    a a a a a a
    e e e e e e
    e e e e e e
    u u u u u u
    u u u u u u
    o o o o o o
    o o o o o o
    """
    assert(test_result == expected_result)
  end

  test "remove_diacritical_marks 2" do
    string = """
    A Á À Ã Ạ Ả
    Â Ấ Ầ Ẫ Ậ Ẩ
    Ă Ắ Ằ Ẳ Ặ Ẳ
    E É È Ẽ Ẹ Ẻ
    Ê Ế Ề Ễ Ệ Ể
    U Ú Ù Ũ Ụ Ủ
    Ư Ứ Ừ Ữ Ự Ử
    O Ó Ò Õ Ọ Ỏ
    Ơ Ớ Ờ Ỡ Ợ Ở
    """
    test_result = Utility.remove_diacritical_marks(string)
    expected_result = """
    A A A A A A
    A A A A A A
    A A A A A A
    E E E E E E
    E E E E E E
    U U U U U U
    U U U U U U
    O O O O O O
    O O O O O O
    """
    assert(test_result == expected_result)
  end
end
