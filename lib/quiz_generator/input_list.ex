defmodule QuizGenerator.InputList do
  alias __MODULE__

  @enforce_keys [:q_and_a] # Later versions answer may become optional.
  defstruct [:q_and_a]

  def new(), do: %InputList{q_and_a: MapSet.new()}

  def insert(%InputList{} = list, question, answer) do
    update_in(list.q_and_a, &MapSet.put(&1, %{ question: question, answer: answer })) 
  end

  def insert(%InputList{} = list, question, answer, extra_info) do
    update_in(list.q_and_a, &MapSet.put(&1, %{ question: question, answer: answer, extra_info: extra_info })) 
  end

  def get_column(%InputList{ q_and_a: list}, column_name), do: get_column_from_list(list, column_name)

  def get_column_from_list( list, column_name), do: Enum.map(list, fn(item) -> item[column_name] end )

@doc """
  The basic data structure for input. Currently it takes 2 fields, and stores them in a mapset.

  ## Example
    alias QuizGenerator.{InputList, Question}

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

    {:ok, q_list} = Question.generate(:multiple_choice, list, %{ max_questions: 5, max_choices: 3})
    Question.generate(:fill_in_blank, list, %{ max_questions: 7, max_choices: nil})
    Question.generate(:matching, list)

    Question.answer_key(q_list, list)


    list = InputList.new()

    list = InputList.insert(list, "我", "I; Me", "wo" ) 
    list = InputList.insert(list, "漂", "Drift; Float", "piao" ) 
    list = InputList.insert(list, "没", "Not have; Is not; be without", "mei" ) 
    list = InputList.insert(list, "向", "Direction", "xiang" ) 
    list = InputList.insert(list, "有", "Have; Possess, own; exist; contain", "you" ) 
    list = InputList.insert(list, "北方", "North; Northern place", "beifang" ) 
    list = InputList.insert(list, "忍耐", "Patience", "rennai" ) 
    list = InputList.insert(list, "别", "Don't; Other", "bie" ) 
    list = InputList.insert(list, "问", "Ask", "wen" ) 
    list = InputList.insert(list, "家乡", "Hometown; Homeland", "jia1xiang" ) 

    Question.generate(:three_way, list)


  """

end

