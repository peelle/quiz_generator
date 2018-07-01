defmodule QuestionTest do
  use ExUnit.Case
  doctest QuizGenerator.Question

  alias QuizGenerator.{InputList, Question}

  test "Generate a DS, and check for ok output" do
    list = InputList.new()
    list = InputList.insert(list, "我", "I; Me" )
    list = InputList.insert(list, "漂", "Drift; Float" )
    list = InputList.insert(list, "没", "Not have; Is not; be without" )
    list = InputList.insert(list, "向", "Direction" )
    list = InputList.insert(list, "有", "Have; Possess, own; exist; contain" )
    list = InputList.insert(list, "北方", "North; Northern place" )
    list = InputList.insert(list, "忍耐", "Patience" )
    list = InputList.insert(list, "别", "Don't; Other" )
    list = InputList.insert(list, "问", "Ask" )
    list = InputList.insert(list, "家乡", "Hometown; Homeland" )

    {value, _question_list } = Question.generate(:multiple_choice, list, "")
    assert value == :ok
    {value, _question_list } = Question.generate(:matching, list, "")
    assert value == :ok
    {value, _question_list } = Question.generate(:fill_in_blank, list, "")
    assert value == :ok
  end

end
