defmodule QuizGenerator.Question do
  alias QuizGenerator.InputList


  # Multiple Choice.
  def get_multiple_choices( %InputList{ QA: qa_mapset }, answer, _options) do
    MapSet.to_list(qa_mapset)
    |> Enum.take_random(5) # When enabling options, takes whatever they would specify + 1. ignoring the edge case that they would specify as much as or more more than exits.
    |> Enum.map( fn(qa) -> qa.answer end )
    |> Enum.into([answer]) # am not sure if this has any sort of order guarentee
    |> Enum.uniq
    |> Enum.take(4) # TODO: replace with optional/default mpc answer #
    |> Enum.shuffle
  end

  def get_multiple_choices(_, _options) do
    { :error, :must_use_InputList_struct }
  end

  def generate_multiple_choice_questions(input_list, _options) do
    for qa <- input_list."QA", do: %{ qa.question => get_multiple_choices(input_list, qa.answer, "") }
  end


  # Fill In The Blank
  def generate_fib_questions(input_list, _options) do
    for qa <- input_list."QA", do: %{ qa.question => "_______" }
  end

end
