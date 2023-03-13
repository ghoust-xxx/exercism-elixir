defmodule Yacht do
  @type category ::
          :ones
          | :twos
          | :threes
          | :fours
          | :fives
          | :sixes
          | :full_house
          | :four_of_a_kind
          | :little_straight
          | :big_straight
          | :choice
          | :yacht

  @doc """
  Calculate the score of 5 dice using the given category's scoring method.
  """
  @spec score(category :: category(), dice :: [integer]) :: integer
  def score(category, dice) do
    case category do
        :ones -> Enum.count(Enum.filter(dice, fn x -> x == 1 end))
        :twos -> Enum.count(Enum.filter(dice, fn x -> x == 2 end)) * 2
        :threes -> Enum.count(Enum.filter(dice, fn x -> x == 3 end)) * 3
        :fours -> Enum.count(Enum.filter(dice, fn x -> x == 4 end)) * 4
        :fives -> Enum.count(Enum.filter(dice, fn x -> x == 5 end)) * 5
        :sixes -> Enum.count(Enum.filter(dice, fn x -> x == 6 end)) * 6
        :full_house ->
            case Enum.sort(dice) do
                [a, a, a, b, b] when a != b -> Enum.sum(dice)
                [a, a, b, b, b] when a != b -> Enum.sum(dice)
                _ -> 0
            end
        :four_of_a_kind ->
            case Enum.sort(dice) do
                [_, a, a, a, a] -> a * 4
                [a, a, a, a, _] -> a * 4
                _ -> 0
            end
        :little_straight ->
            if Enum.sort(dice) == [1, 2, 3, 4, 5] do
                30
            else
                0
            end
        :big_straight ->
            if Enum.sort(dice) == [2, 3, 4, 5, 6] do
                30
            else
                0
            end
        :choice -> Enum.sum(dice)
        :yacht ->
            case dice do
                [a, a, a, a, a] -> 50
                _ -> 0
            end
        _ -> 0
    end
  end
end
