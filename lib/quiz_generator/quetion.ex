defmodule QuizGenerator.Question do
  alias QuizGenerator.InputList

  def generate(:multiple_choice, input_list, _options) do
    {:ok, (for qa <- input_list."QA", do: %{ qa.question => generate_multiple_choices(input_list, qa.answer, "") }) }
  end

  # Fill In The Blank
  def generate(:fill_in_blank, input_list, _options) do
    { :ok, (for qa <- input_list."QA", do: %{ qa.question => "_______" }) }
  end

  def generate(:matching, input_list, _options) do
    {:ok, 
      MapSet.to_list(input_list."QA")
      |> Enum.map( fn(qa) -> qa.question end)
      |> Enum.zip(generate_matching(input_list, ""))
    }
  end
    
  def generate(_, _, _) do
    { :error, "Unknown section type." }
  end

  # Multiple Choice.
  defp generate_multiple_choices( %InputList{ QA: qa_mapset }, answer, _options) do
    MapSet.to_list(qa_mapset)
    |> Enum.take_random(5) # When enabling options, takes whatever they would specify + 1. ignoring the edge case that they would specify as much as or more more than exits.
    |> Enum.map( fn(qa) -> qa.answer end )
    |> Enum.into([answer]) # am not sure if this has any sort of order guarentee
    |> Enum.uniq
    |> Enum.take(4) # TODO: replace with optional/default mpc answer #
    |> Enum.shuffle
  end

  defp generate_matching( %InputList{ QA: qa_mapset }, _options) do
    MapSet.to_list(qa_mapset)
    |> Enum.map( fn(qa) -> qa.answer end )
    |> Enum.shuffle
  end

end
