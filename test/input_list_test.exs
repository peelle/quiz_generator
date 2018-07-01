defmodule InputListTest do
  use ExUnit.Case
  doctest QuizGenerator.InputList

  alias QuizGenerator.InputList

  test "Generate a fresh list." do
    assert InputList.new() == %InputList{q_and_a: MapSet.new()}
  end


  test "Generate a value, and make sure it's in there." do
    list = InputList.new()
    list = InputList.insert(list, "我", "I; Me" )
    assert InputList.get_column(list, :question) == ["我"]
    assert InputList.get_column(list, :answer) == ["I; Me"]

  end

end
