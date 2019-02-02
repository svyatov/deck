defmodule Deck.Guards do
  @moduledoc false

  defmacro is_valid_number_of_cards(number) do
    quote do
      is_integer(unquote(number)) and rem(unquote(number), 4) == 0 and unquote(number) <= 52
    end
  end
end
