defmodule AocTest.Y2022.Day05 do
  use ExUnit.Case
  doctest Aoc.Y2022.Day05, import: true

  alias Aoc.Y2022.Day05

  @diagram_example """
      [D]
  [N] [C]
  [Z] [M] [P]
   1   2   3
  """

  @example """
      [D]
  [N] [C]
  [Z] [M] [P]
   1   2   3

  move 1 from 2 to 1
  move 3 from 1 to 3
  move 2 from 2 to 1
  move 1 from 1 to 2
  """

  test "parse_command_str" do
    assert Day05.parse_command("move 10 from 5 to 3") === %Day05.Command{
             qty: 10,
             origin: 4,
             target: 2
           }
  end

  test "parse_diagram" do
    expected = [
      ["Z", "N"],
      ["M", "C", "D"],
      ["P"]
    ]

    result = Day05.parse_diagram(String.trim_trailing(@diagram_example))

    Enum.with_index(result)
    |> Enum.each(fn {col, idx} ->
      assert col == Enum.at(expected, idx)
    end)
  end

  test "part1" do
    assert Day05.part1(String.trim_trailing(@example, "\n")) == "CMZ"
  end
end
