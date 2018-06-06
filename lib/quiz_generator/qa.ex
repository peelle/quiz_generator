defmodule QuizGenerator.QA do
  alias __MODULE__

  @enforce_keys [:question, :answer] # Later versions answer may become optional.
  defstruct [:question, :answer]
  
end
