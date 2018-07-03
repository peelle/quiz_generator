defmodule QuizGenerator.Question do
  alias QuizGenerator.InputList

  @default_options %{ max_questions: nil, max_choices: 4 }

  def generate(a, b, options \\ @default_options ) # This is a function template.
  def generate(:multiple_choice, list, %{ max_questions: max_questions, max_choices: max_choices } ) do
    {:ok, (for qa <- list."q_and_a", do: %{ qa.question => generate_multiple_choices(list, qa.answer, max_choices) }) |> Enum.take_random(max_questions) }
  end

  # Fill In The Blank
  def generate(:fill_in_blank, list, %{ max_questions: max_questions, max_choices: _ }) do
    { :ok, 
      (for qa <- list."q_and_a", do: %{ qa.question => "_______" }) |> Enum.take_random(max_questions)
    }
  end

  def generate(:matching, list,  %{ max_questions: max_questions, max_choices: _ }) do
    {:ok, 
      InputList.get_column(list,:question)
      |> Enum.take(max_questions)
      |> Enum.zip(generate_matching(list, ""))
    }
  end
    
  #def generate(_, _), do: { :error, "Unknown section type." }
  def generate(_, _, _), do: { :error, "Unknown section type." }

  # Multiple Choice.
  defp generate_multiple_choices( %InputList{} = list, answer, max_choices) do
    InputList.get_column(list, :answer)
    |> Enum.take_random(max_choices) # When enabling options, takes whatever they would specify + 1. ignoring the edge case that they would specify as much as or more more than exits.
    |> Enum.into([answer]) # am not sure if this has any sort of order guarentee
    |> Enum.uniq
    |> Enum.take(max_choices) # TODO: replace with optional/default mpc answer #
    |> Enum.shuffle
  end

  defp generate_matching( %InputList{} = list, options) do
    InputList.get_column(list, :answer)
    |> Enum.take(options.max_questions)
    |> Enum.shuffle
  end

end
