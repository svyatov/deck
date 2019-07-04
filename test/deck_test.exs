defmodule DeckTest do
  use ExUnit.Case
  doctest Deck

  @ordered_deck [
    "2c",
    "2d",
    "2h",
    "2s",
    "3c",
    "3d",
    "3h",
    "3s",
    "4c",
    "4d",
    "4h",
    "4s",
    "5c",
    "5d",
    "5h",
    "5s",
    "6c",
    "6d",
    "6h",
    "6s",
    "7c",
    "7d",
    "7h",
    "7s",
    "8c",
    "8d",
    "8h",
    "8s",
    "9c",
    "9d",
    "9h",
    "9s",
    "10c",
    "10d",
    "10h",
    "10s",
    "Jc",
    "Jd",
    "Jh",
    "Js",
    "Qc",
    "Qd",
    "Qh",
    "Qs",
    "Kc",
    "Kd",
    "Kh",
    "Ks",
    "Ac",
    "Ad",
    "Ah",
    "As"
  ]

  describe "new/0" do
    test "returns 52 cards ordered by rank" do
      deck = Deck.new()
      assert length(deck) == 52
      assert deck == @ordered_deck
    end
  end

  describe "new/1" do
    test "returns all possible valid numbers of cards" do
      1..13
      |> Enum.map(fn rank_no -> rank_no * 4 end)
      |> Enum.each(fn n_cards -> assert length(Deck.new(n_cards)) == n_cards end)
    end

    test "returns specified number of high cards" do
      assert Deck.new(8) == ["Kc", "Kd", "Kh", "Ks", "Ac", "Ad", "Ah", "As"]
    end

    test "raises an error if number of cards is not valid" do
      assert_raise FunctionClauseError, fn ->
        Deck.new(38)
      end
    end
  end

  describe "new_low/1" do
    test "returns all possible valid numbers of cards" do
      1..13
      |> Enum.map(fn rank_no -> rank_no * 4 end)
      |> Enum.each(fn n_cards -> assert length(Deck.new_low(n_cards)) == n_cards end)
    end

    test "returns specified number of low cards" do
      assert Deck.new_low(8) == ["2c", "2d", "2h", "2s", "3c", "3d", "3h", "3s"]
    end

    test "raises an error if number of cards is not valid" do
      assert_raise FunctionClauseError, fn ->
        Deck.new_low(23)
      end
    end
  end

  describe "shuffle/1" do
    test "randomizes card's order in the deck" do
      shuffled_deck = Deck.shuffle(@ordered_deck)
      assert shuffled_deck != @ordered_deck
      assert length(shuffled_deck) == length(@ordered_deck)
      assert same_cards?(shuffled_deck, @ordered_deck)
    end
  end

  describe "shuffled/0" do
    test "returns 52 shuffled cards" do
      shuffled_deck = Deck.shuffled()
      assert shuffled_deck != @ordered_deck
      assert length(shuffled_deck) == 52
      assert same_cards?(shuffled_deck, @ordered_deck)
    end
  end

  describe "shuffled/1" do
    test "returns all possible valid numbers of cards" do
      1..13
      |> Enum.map(fn rank_no -> rank_no * 4 end)
      |> Enum.each(fn n_cards -> assert length(Deck.shuffled(n_cards)) == n_cards end)
    end

    test "returns specified number of shuffled high cards" do
      deck = Deck.shuffled(8)
      assert same_cards?(deck, ["Kc", "Kh", "Ks", "Kd", "Ac", "Ah", "As", "Ad"])
    end

    test "raises an error if number of cards is not valid" do
      assert_raise FunctionClauseError, fn ->
        Deck.shuffled(19)
      end
    end
  end

  describe "shuffled_low/1" do
    test "returns all possible valid numbers of cards" do
      1..13
      |> Enum.map(fn rank_no -> rank_no * 4 end)
      |> Enum.each(fn n_cards -> assert length(Deck.shuffled_low(n_cards)) == n_cards end)
    end

    test "returns specified number of shuffled low cards" do
      deck = Deck.shuffled_low(8)
      assert same_cards?(deck, ["2c", "2h", "2s", "2d", "3c", "3h", "3s", "3d"])
    end

    test "raises an error if number of cards is not valid" do
      assert_raise FunctionClauseError, fn ->
        Deck.shuffled_low(29)
      end
    end
  end

  describe "deal/2" do
    test "returns specified number of cards to deal and the rest of the deck" do
      deck = Deck.new_low(12)
      {hand, deck_leftovers} = Deck.deal(deck, 3)
      assert hand == ["2c", "2d", "2h"]
      assert deck_leftovers == ["2s", "3c", "3d", "3h", "3s", "4c", "4d", "4h", "4s"]
    end

    test "returns all the cards in the deck if less than specified number of cards left" do
      deck = Deck.new(4)
      {hand, deck_leftovers} = Deck.deal(deck, 8)
      assert hand == ["Ac", "Ad", "Ah", "As"]
      assert deck_leftovers == []
    end

    test "returns empty lists if no cards left in the deck" do
      {hand, deck_leftovers} = Deck.deal([], 5)
      assert hand == []
      assert deck_leftovers == []
    end
  end

  describe "burn/2" do
    test "burns specified number of cards and returns the rest of the deck" do
      deck = Deck.new_low(12)
      assert Deck.burn(deck, 3) == ["2s", "3c", "3d", "3h", "3s", "4c", "4d", "4h", "4s"]
    end

    test "returns empty deck if less than specified number of cards left" do
      deck = Deck.new(4)
      assert Deck.burn(deck, 8) == []
    end
  end

  describe "size/1" do
    test "returns number of cards left in the deck" do
      deck = Deck.shuffled()
      assert Deck.size(deck) == 52

      deck = Deck.burn(deck, 3)
      assert Deck.size(deck) == 49

      {_hand, deck} = Deck.deal(deck, 5)
      assert Deck.size(deck) == 44
    end
  end

  ### Helpers

  defp same_cards?(deck1, deck2) do
    MapSet.equal?(MapSet.new(deck1), MapSet.new(deck2))
  end
end
