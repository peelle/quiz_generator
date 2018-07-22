defmodule QuizGenerator.Question do
  alias QuizGenerator.InputList

  @default_options %{ max_questions: nil, max_choices: 3, answer_key: false }

  def generate(a, b, options \\ @default_options ) # This is a function template.

  def generate(:multiple_choice, list, options ) do
    {:ok, (for qa <- list."q_and_a" do 
            %{ qa.question => generate_multiple_choices(list, qa.answer, options.max_choices) }
          end ) 
    |> Enum.take_random(options.max_questions || Enum.count(list.q_and_a)) 
    }
  end

  # Fill In The Blank
  def generate(:fill_in_blank, list, options) do
    { :ok, 
      (for qa <- list."q_and_a", do: %{ qa.question => "_______" }) |> Enum.take_random(options.max_questions || Enum.count(list.q_and_a))
    }
  end

  def generate(:matching, list,  options) do
    {:ok, 
      InputList.get_column(list, :question)
      |> Enum.take(options.max_questions)
      |> Enum.zip(generate_matching(list, options))
    }
  end

  def generate(:three_way, list, options) do
      sub_list = list.q_and_a |> Enum.take(options.max_questions || Enum.count(list.q_and_a))
    tuple = Enum.zip([ Enum.shuffle(InputList.get_column_from_list(sub_list, :question)), Enum.shuffle(InputList.get_column_from_list(sub_list, :answer)), Enum.shuffle(InputList.get_column_from_list(sub_list, :extra_info))])
    {:ok, tuple}
  end

  # Default catchall
  def generate(_, _, _), do: { :error, "Unknown section type." }

  def answer_key(questions, list) do
    # I had a tough time figuring this out. 
    # Might be beacuse I picked the wrong DS. 
    for q <- questions,
        question <- MapSet.to_list(list.q_and_a), 
        List.first(Map.keys(q)) == Map.get(question, :question) do 
      { List.first(Map.keys(q)), question.answer }
    end
  end

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
    |> Enum.take(options.max_questions || Enum.count(list.q_and_a))
    |> Enum.shuffle
  end

end
