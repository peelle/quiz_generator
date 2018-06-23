defmodule QuizGenerator.Question do
  alias QuizGenerator.InputList

  def generate(:multiple_choice, list, _options) do
    {:ok, (for qa <- list."q_and_a", do: %{ qa.question => generate_multiple_choices(list, qa.answer, "") }) }
  end

  # Fill In The Blank
  def generate(:fill_in_blank, list, _options) do
    { :ok, (for qa <- list."q_and_a", do: %{ qa.question => "_______" }) }
  end

  def generate(:matching, list, _options) do
    {:ok, 
      InputList.get_column(list,:question)
      |> Enum.zip(generate_matching(list, ""))
    }
  end
    
  def generate(_, _, _), do: { :error, "Unknown section type." }

  # Multiple Choice.
  defp generate_multiple_choices( %InputList{} = list, answer, _options) do
    InputList.get_column(list, :answer)
    |> Enum.take_random(5) # When enabling options, takes whatever they would specify + 1. ignoring the edge case that they would specify as much as or more more than exits.
    |> Enum.into([answer]) # am not sure if this has any sort of order guarentee
    |> Enum.uniq
    |> Enum.take(4) # TODO: replace with optional/default mpc answer #
    |> Enum.shuffle
  end

  defp generate_matching( %InputList{} = list, _options) do
    InputList.get_column(list, :answer)
    |> Enum.shuffle
  end

end
