defmodule AocTest.Y2022.Day07 do
  use ExUnit.Case
  doctest Aoc.Y2022.Day07, import: true

  alias Aoc.Y2022.Day07

  @example """
  $ cd /
  $ ls
  dir a
  14848514 b.txt
  8504156 c.dat
  dir d
  $ cd a
  $ ls
  dir e
  29116 f
  2557 g
  62596 h.lst
  $ cd e
  $ ls
  584 i
  $ cd ..
  $ cd ..
  $ cd d
  $ ls
  4060174 j
  8033020 d.log
  5626152 d.ext
  7214296 k
  """

  test "part1" do
    assert Day07.part1(String.trim_trailing(@example, "\n")) == 95437
  end

end
