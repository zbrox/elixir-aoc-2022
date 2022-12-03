defmodule Aoc.Y2022.Day03 do
  alias Aoc.Helpers

  @moduledoc """
  ## --- Day 3: Rucksack Reorganization ---

  One Elf has the important job of loading all of the rucksacks with supplies for
  the jungle journey. Unfortunately, that Elf didn't quite follow the packing
  instructions, and so a few items now need to be rearranged.

  Each rucksack has two large *compartments*. All items of a given type are meant
  to go into exactly one of the two compartments. The Elf that did the packing
  failed to follow this rule for exactly one item type per rucksack.

  The Elves have made a list of all of the items currently in each rucksack (your
  puzzle input), but they need your help finding the errors. Every item type is
  identified by a single lowercase or uppercase letter (that is, `a` and `A` refer
  to different types of items).

  The list of items for each rucksack is given as characters all on a single line.
  A given rucksack always has the same number of items in each of its two
  compartments, so the first half of the characters represent items in the first
  compartment, while the second half of the characters represent items in the
  second compartment.

  For example, suppose you have the following list of contents from six rucksacks:

  `vJrwpWtwJgWrhcsFMMfFFhFp
  jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
  PmmdzqPrVvPwwTWBwg
  wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
  ttgJtRGJQctTZtZT
  CrZsJsPPZsGzwwsLwLmpwMDw
  `- The first rucksack contains the items `vJrwpWtwJgWrhcsFMMfFFhFp`, which means
  its first compartment contains the items `vJrwpWtwJgWr`, while the second
  compartment contains the items `hcsFMMfFFhFp`. The only item type that appears
  in both compartments is lowercase `*p*`.
  - The second rucksack's compartments contain `jqHRNqRjqzjGDLGL` and
  `rsFMfFZSrLrFZsSL`. The only item type that appears in both compartments is
  uppercase `*L*`.
  - The third rucksack's compartments contain `PmmdzqPrV` and `vPwwTWBwg`; the
  only common item type is uppercase `*P*`.
  - The fourth rucksack's compartments only share item type `*v*`.
  - The fifth rucksack's compartments only share item type `*t*`.
  - The sixth rucksack's compartments only share item type `*s*`.
  To help prioritize item rearrangement, every item type can be converted to a
  *priority*:

  - Lowercase item types `a` through `z` have priorities 1 through 26.
  - Uppercase item types `A` through `Z` have priorities 27 through 52.
  In the above example, the priority of the item type that appears in both
  compartments of each rucksack is 16 (`p`), 38 (`L`), 42 (`P`), 22 (`v`), 20
  (`t`), and 19 (`s`); the sum of these is `*157*`.

  Find the item type that appears in both compartments of each rucksack. *What is
  the sum of the priorities of those item types?*

  """
  def prepare_backpack_data(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn v -> prepare_backpack_contents_data(v) end)
  end

  def prepare_backpack_contents_data(backpack_data) do
    snacks_by_compartment =
      backpack_data
      |> String.codepoints()
      |> Enum.split(round(String.length(backpack_data) / 2))

    {
      MapSet.new(elem(snacks_by_compartment, 0)),
      MapSet.new(elem(snacks_by_compartment, 1))
    }
  end

  def common_snacks(contents) do
    MapSet.intersection(elem(contents, 0), elem(contents, 1))
    |> MapSet.to_list()
  end

  def ord(char) do
    String.to_charlist(char) |> hd
  end

  def is_lowercase(char) do
    codepoint = ord(char)
    ?a <= codepoint and codepoint <= ?z
  end

  def get_value(char) do
    case is_lowercase(char) do
      true -> ord(char) - 96
      false -> ord(char) - 38
    end
  end

  def part1(input) do
    prepare_backpack_data(input)
    |> Enum.map(fn v ->
      common_snacks(v)
      |> Enum.map(fn v -> get_value(v) end)
      |> Enum.sum()
    end)
    |> Enum.sum()
  end

  def solve_part1() do
    Helpers.get_input(2022, 3)
    |> part1
  end
end
