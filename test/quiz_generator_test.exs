defmodule QuizGeneratorTest do
  use ExUnit.Case
  doctest QuizGenerator

  test "greets the world" do
    assert QuizGenerator.hello() == :world
  end
end
