defmodule Aoc.Y2022.Day05 do
  alias Aoc.Helpers

  @moduledoc """
  ## --- Day 5: Supply Stacks ---

  The expedition can depart as soon as the final supplies have been unloaded from
  the ships. Supplies are stored in stacks of marked *crates*, but because the
  needed supplies are buried under many other crates, the crates need to be
  rearranged.

  The ship has a *giant cargo crane* capable of moving crates between stacks. To
  ensure none of the crates get crushed or fall over, the crane operator will
  rearrange them in a series of carefully-planned steps. After the crates are
  rearranged, the desired crates will be at the top of each stack.

  The Elves don't want to interrupt the crane operator during this delicate
  procedure, but they forgot to ask her *which* crate will end up where, and they
  want to be ready to unload them as soon as possible so they can embark.

  They do, however, have a drawing of the starting stacks of crates *and* the
  rearrangement procedure (your puzzle input). For example:

  `   [D]
  [N] [C]
  [Z] [M] [P]
   1   2   3

  move 1 from 2 to 1
  move 3 from 1 to 3
  move 2 from 2 to 1
  move 1 from 1 to 2
  `In this example, there are three stacks of crates. Stack 1 contains two crates:
  crate `Z` is on the bottom, and crate `N` is on top. Stack 2 contains three
  crates; from bottom to top, they are crates `M`, `C`, and `D`. Finally, stack 3
  contains a single crate, `P`.

  Then, the rearrangement procedure is given. In each step of the procedure, a
  quantity of crates is moved from one stack to a different stack. In the first
  step of the above rearrangement procedure, one crate is moved from stack 2 to
  stack 1, resulting in this configuration:

  `[D]
   [N] [C]
   [Z] [M] [P]
    1   2   3
  `In the second step, three crates are moved from stack 1 to stack 3. Crates are
  moved *one at a time*, so the first crate to be moved (`D`) ends up below the
  second and third crates:

  `       [Z]
          [N]
      [C] [D]
      [M] [P]
   1   2   3
  `Then, both crates are moved from stack 2 to stack 1. Again, because crates are
  moved *one at a time*, crate `C` ends up below crate `M`:

  `       [Z]
          [N]
  [M]     [D]
  [C]     [P]
   1   2   3
  `Finally, one crate is moved from stack 1 to stack 2:

  `          [*Z*]
              [N]
              [D]
  [*C*] [*M*] [P]
   1   2   3
  `The Elves just need to know *which crate will end up on top of each stack*; in
  this example, the top crates are `C` in stack 1, `M` in stack 2, and `Z` in
  stack 3, so you should combine these together and give the Elves the message
  `*CMZ*`.

  *After the rearrangement procedure completes, what crate ends up on top of each
  stack?*
  """

  defmodule Command do
    defstruct qty: 0, origin: 0, target: 0
  end

  def parse_input(input) do
    [diagram_str, commands_str] =
      input
      |> String.split("\n\n")

    diagram = parse_diagram(diagram_str)

    commands =
      String.split(commands_str, "\n")
      |> Enum.map(fn v -> parse_command(v) end)

    {diagram, commands}
  end

  def parse_diagram(diagram_str) do
    {stack_count, diagram_str} =
      String.split(diagram_str, "\n")
      |> List.pop_at(-1)

    stack_count =
      stack_count
      |> String.split()
      |> Enum.count()

    diagram_rows =
      diagram_str
      |> Enum.map(fn line ->
        line
        |> String.codepoints()
        |> Enum.chunk_every(4)
        |> Enum.map(fn v ->
          Enum.join(v, "")
          |> String.trim()
          |> String.trim("[")
          |> String.trim("]")
        end)
      end)

    diagram =
      0..(stack_count - 1)
      |> Enum.map(fn col_idx ->
        List.foldl(diagram_rows, [], fn row, acc ->
          box = Enum.at(row, col_idx, "")

          if box != "" do
            acc = List.insert_at(acc, 0, box)
            acc
          else
            acc
          end
        end)
      end)

    diagram
  end

  def parse_command(command_str) do
    [_, count, origin, target] = Regex.run(~r/move (\d+) from (\d+) to (\d+)/, command_str)

    %Command{
      qty: String.to_integer(count),
      origin: String.to_integer(origin) - 1,
      target: String.to_integer(target) - 1
    }
  end

  def execute_command(diagram, command) do
    origin_column = Enum.at(diagram, command.origin)
    {origin_column, boxes} = Enum.split(origin_column, -command.qty)
    diagram = List.replace_at(diagram, command.origin, origin_column)

    target_column = Enum.at(diagram, command.target)
    target_column = target_column ++ Enum.reverse(boxes)
    diagram = List.replace_at(diagram, command.target, target_column)
    diagram
  end

  def part1(input) do
    {diagram, commands} = parse_input(input)

    final_diagram =
      List.foldl(commands, diagram, fn cmd, dia ->
        execute_command(dia, cmd)
      end)

    Enum.map(final_diagram, fn col ->
      List.last(col)
    end)
    |> List.flatten()
    |> Enum.join("")
  end

  def solve_part1() do
    Helpers.get_input(2022, 5)
    |> part1()
  end
end
