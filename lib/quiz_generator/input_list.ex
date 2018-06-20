defmodule QuizGenerator.InputList do

  defstruct [:QA]


@doc """

## Examples
#
iex(15)> list = %QuizGenerator.InputList{ QA: MapSet.new() }                                            %QuizGenerator.InputList{QA: #MapSet<[]>}
iex(16)> list = update_in(list."QA", &MapSet.put(&1, %QuizGenerator.QA{ question: "龘东", answer: "JJ" }))
%QuizGenerator.InputList{
  QA: #MapSet<[%QuizGenerator.QA{answer: "JJ", question: "龘东"}]>
}
iex(17)> list = update_in(list."QA", &MapSet.put(&1, %QuizGenerator.QA{ question: "车龘东", answer: "JJC" })) 
%QuizGenerator.InputList{
  QA: #MapSet<[
    %QuizGenerator.QA{answer: "JJ", question: "龘东"},
    %QuizGenerator.QA{answer: "JJC", question: "车龘东"}
  ]>
}

list = %QuizGenerator.InputList{ QA: MapSet.new() }
list = update_in(list."QA", &MapSet.put(&1, %QuizGenerator.QA{ question: "车龘东", answer: "JJC" })) 
list = update_in(list."QA", &MapSet.put(&1, %QuizGenerator.QA{ question: "漂", answer: "Drift; Float" })) 
list = update_in(list."QA", &MapSet.put(&1, %QuizGenerator.QA{ question: "向", answer: "Direction" })) 
list = update_in(list."QA", &MapSet.put(&1, %QuizGenerator.QA{ question: "北方", answer: "North; Northern place" })) 
list = update_in(list."QA", &MapSet.put(&1, %QuizGenerator.QA{ question: "别", answer: "Don't; Other" })) 
list = update_in(list."QA", &MapSet.put(&1, %QuizGenerator.QA{ question: "问", answer: "Ask" })) 
list = update_in(list."QA", &MapSet.put(&1, %QuizGenerator.QA{ question: "我", answer: "I" })) 
list = update_in(list."QA", &MapSet.put(&1, %QuizGenerator.QA{ question: "家乡", answer: "Hometown; Homeland" })) 
QuizGenerator.Question.generate(:multiple_choice, list, "")
QuizGenerator.Question.generate(:fill_in_blank, list, "")

 """



end

