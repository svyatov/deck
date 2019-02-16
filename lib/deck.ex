defmodule Deck do
  @moduledoc """
  Get, shuffle and deal a deck of playing cards of any size (from 4 to 52 cards).
  """

  import Deck.Guards, only: [is_valid_number_of_cards: 1]

  # T = 10, J = Jack, Q = Queen, K = King, A = Ace
  @ranks ~w[2 3 4 5 6 7 8 9 T J Q K A]

  # Clubs, diamonds, hearts, spades
  @suits ~w[c d h s]

  # A full deck of cards ordered by rank
  @deck for rank <- @ranks, suit <- @suits, do: "#{rank}#{suit}"

  @doc """
  Returns a full deck of cards (52 cards) ordered by rank.

  ## Examples

      iex> Deck.new()
      ["2c", "2d", "2h", "2s", "3c", "3d", "3h", "3s", "4c", "4d", "4h", "4s",
       "5c", "5d", "5h", "5s", "6c", "6d", "6h", "6s", "7c", "7d", "7h", "7s",
       "8c", "8d", "8h", "8s", "9c", "9d", "9h", "9s", "Tc", "Td", "Th", "Ts",
       "Jc", "Jd", "Jh", "Js", "Qc", "Qd", "Qh", "Qs", "Kc", "Kd", "Kh", "Ks",
       "Ac", "Ad", "Ah", "As"]
  """
  def new do
    @deck
  end

  @doc """
  Returns a deck containing high `n_cards` ordered by rank.

  `n_cards` must be less than or equal 52 and must be divisible by 4.

  ## Examples

      iex> Deck.new(12)
      ["Qc", "Qd", "Qh", "Qs", "Kc", "Kd", "Kh", "Ks", "Ac", "Ad", "Ah", "As"]
  """
  def new(n_cards) when is_valid_number_of_cards(n_cards) do
    new() |> Enum.take(-n_cards)
  end

  @doc """
  Returns a deck containing low `n_cards` ordered by rank.

  `n_cards` must be less than or equal 52 and must be divisible by 4.

  ## Examples

      iex> Deck.new_low(12)
      ["2c", "2d", "2h", "2s", "3c", "3d", "3h", "3s", "4c", "4d", "4h", "4s"]
  """
  def new_low(n_cards) when is_valid_number_of_cards(n_cards) do
    new() |> Enum.take(n_cards)
  end

  @doc """
  Returns a full shuffled deck of cards (52 cards).

  ## Examples

      iex> Deck.shuffled() != Deck.new()
      true
  """
  def shuffled do
    new() |> shuffle
  end

  @doc """
  Returns a shuffled deck containing high `n_cards`.

  `n_cards` must be less than or equal 52 and must be divisible by 4.

  ## Examples

      iex> Deck.shuffled(36) != Deck.new(36)
      true
  """
  def shuffled(n_cards) when is_valid_number_of_cards(n_cards) do
    n_cards |> new |> shuffle
  end

  @doc """
  Returns a shuffled deck containing low `n_cards`.

  `n_cards` must be less than or equal 52 and must be divisible by 4.

  ## Examples

      iex> Deck.shuffled_low(36) != Deck.new_low(36)
      true
  """
  def shuffled_low(n_cards) when is_valid_number_of_cards(n_cards) do
    n_cards |> new_low |> shuffle
  end

  @doc """
  Shuffles the `deck` using the modern version of the Fisher–Yates shuffle algorithm.

  ## Examples

      iex> deck = Deck.new()
      ...> shuffled_deck = Deck.shuffle(deck)
      ...> shuffled_deck != deck
      true
      iex> Deck.shuffle(shuffled_deck) != Deck.shuffle(shuffled_deck)
      true

  """
  def shuffle(deck) when is_list(deck) do
    do_shuffle(deck, length(deck), [])
  end

  defp do_shuffle([last_card | _empty_deck], 1, shuffled_deck), do: [last_card | shuffled_deck]

  defp do_shuffle(deck, cards_left, shuffled_deck) do
    random_card_index = :rand.uniform(cards_left) - 1
    random_card = Enum.at(deck, random_card_index)
    {current_last_card, deck_leftovers} = List.pop_at(deck, -1)

    deck_leftovers
    |> List.replace_at(random_card_index, current_last_card)
    |> do_shuffle(cards_left - 1, [random_card | shuffled_deck])
  end

  @doc """
  Returns `n_cards` from the `deck` and the rest of the `deck`.

  ## Example

      iex> Deck.deal(Deck.new(8), 2)
      {["Kc", "Kd"], ["Kh", "Ks", "Ac", "Ad", "Ah", "As"]}
  """
  def deal(deck, n_cards) when is_list(deck) and is_integer(n_cards) and n_cards > 0 do
    deck |> Enum.split(n_cards)
  end

  @doc """
  "Burns" `n_cards` in the `deck` and returns the rest of the `deck`.

  ## Example

      iex> Deck.burn(Deck.new(8), 6)
      ["Ah", "As"]
  """
  def burn(deck, n_cards) when is_list(deck) and is_integer(n_cards) and n_cards > 0 do
    deck |> Enum.drop(n_cards)
  end

  @doc """
  Returns number of cards left in the `deck`.

  ## Example

      iex> Deck.size(Deck.new(12))
      12
  """
  def size(deck) when is_list(deck) do
    deck |> Enum.count()
  end
end
