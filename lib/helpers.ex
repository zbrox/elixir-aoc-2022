defmodule Aoc.Helpers do
  def get_input(year, day) do
    day = day |> Integer.to_string() |> String.pad_leading(2, "0")

    "inputs/#{year}/day_#{day}.txt"
    |> Path.expand()
    |> Path.absname()
    |> File.read!()
    |> String.trim()
  end
end
