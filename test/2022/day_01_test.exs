defmodule AocTest.Y2022.Day01 do
  use ExUnit.Case
  doctest Aoc.Y2022.Day01, import: true

  alias Aoc.Y2022.Day01

  @example """
  1000
  2000
  3000

  4000

  5000
  6000

  7000
  8000
  9000

  10000
  """

  test "part1" do
    assert Day01.part1(@example) == 24000
  end
end
