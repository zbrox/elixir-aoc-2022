defmodule AocTest.Y2022.Day02 do
  use ExUnit.Case
  doctest Aoc.Y2022.Day02, import: true

  alias Aoc.Y2022.Day02

  @example """
  A Y
  B X
  C Z
  """

  test "part1" do
    assert Day02.part1(@example) == 15
  end

  test "part2" do
    assert Day02.part2(@example) == 12
  end
end
