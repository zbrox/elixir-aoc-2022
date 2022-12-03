defmodule AocTest.Y2022.Day03 do
  use ExUnit.Case
  doctest Aoc.Y2022.Day03, import: true

  alias Aoc.Y2022.Day03

  @example """
  vJrwpWtwJgWrhcsFMMfFFhFp
  jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
  PmmdzqPrVvPwwTWBwg
  wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
  ttgJtRGJQctTZtZT
  CrZsJsPPZsGzwwsLwLmpwMDw
  """

  test "part1" do
    assert Day03.part1(@example) == 157
  end

  test "part2" do
    assert Day03.part2(@example) == 70
  end

end
