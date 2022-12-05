defmodule AocTest.Y2022.Day04 do
  use ExUnit.Case
  doctest Aoc.Y2022.Day04, import: true

  alias Aoc.Y2022.Day04

  @example """
  2-4,6-8
  2-3,4-5
  5-7,7-9
  2-8,3-7
  6-6,4-6
  2-6,4-8
  """

  test "part1" do
    assert Day04.part1(@example) == 2
  end

end
