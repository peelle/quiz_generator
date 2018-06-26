defmodule QuizGenerator.InputList do
  alias __MODULE__

  @enforce_keys [:q_and_a] # Later versions answer may become optional.
  defstruct [:q_and_a]

  def new(), do: %InputList{q_and_a: MapSet.new()}

  def insert(%InputList{} = list, question, answer) do
    update_in(list.q_and_a, &MapSet.put(&1, %{ question: question, answer: answer })) 
  end

  def get_column(%InputList{ q_and_a: list}, column_name) do
    MapSet.to_list(list)
    |> Enum.map( fn(item) -> item[column_name] end )
  end

@doc """

## Examples
#

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

Question.generate(:multiple_choice, list, "")
Question.generate(:fill_in_blank, list, "")
Question.generate(:matching, list, "")

 """



end

