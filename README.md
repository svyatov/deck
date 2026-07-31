# Deck

Deck builds, shuffles, and deals a deck of playing cards, for anyone writing a card game in Elixir.

[![hex](https://img.shields.io/hexpm/v/deck)](https://hex.pm/packages/deck)
[![CI](https://github.com/svyatov/deck/actions/workflows/ci.yml/badge.svg?branch=master)](https://github.com/svyatov/deck/actions/workflows/ci.yml)

Most card libraries hand you 52 cards and stop. Deck takes any size from 4 to 52
that divides by 4, so a 36-card short deck or a 32-card pack is an argument
rather than a workaround, and `Deck.Guards` rejects every other size at the
function head instead of returning a deck nobody asked for. It has no run-time
dependencies: `mix.exs` declares three, and every one of them is `only: :dev` or
`only: [:dev, :test]`.

## Installation

Add `deck` to the dependency list in your `mix.exs`:

```elixir
defp deps do
  [
    {:deck, "~> 1.1"}
  ]
end
```

Then fetch it:

```bash
mix deps.get
```

## Example

Run this in `iex -S mix`:

```elixir
Deck.new(8)
# => ["Kc", "Kd", "Kh", "Ks", "Ac", "Ad", "Ah", "As"]

Deck.new_low(8)
# => ["2c", "2d", "2h", "2s", "3c", "3d", "3h", "3s"]

{hand, rest} = Deck.deal(Deck.new(8), 2)
# => {["Kc", "Kd"], ["Kh", "Ks", "Ac", "Ad", "Ah", "As"]}

Deck.size(rest)
# => 6
```

A card is a two-character string: a rank from `2 3 4 5 6 7 8 9 T J Q K A`
followed by a suit from `c d h s`. `Deck.new/1` counts down from the ace, so
`Deck.new(8)` is the kings and the aces, while `Deck.new_low/1` counts up from
the two. `Deck.shuffled/1` and `Deck.shuffle/1` return the same cards in an
order that changes per call, using the modern Fisher-Yates shuffle.

## What it covers

Deck is plain Elixir with no version-dependent code of its own. `mix.exs`
declares `elixir: "~> 1.6"`, and CI exercises Elixir 1.18, 1.19, and 1.20 on
OTP 28 and 29. Nothing below 1.18 is tested: the declared floor records that the
library asks for nothing newer, not that anyone still checks it there.

The package is published to [Hex](https://hex.pm/packages/deck), and the
generated API documentation is at [hexdocs.pm/deck](https://hexdocs.pm/deck).

## Status

Maintained at a low volume. The library is small and does what it set out to do,
so it gets dependency, tooling, and compatibility updates, and fixes when
something is wrong. There is no roadmap of new features. One maintainer decides
what goes in, which the [Governance](CONTRIBUTING.md#governance) section of the
contributing guide states in full.

## Questions and problems

Both go to [GitHub Issues](https://github.com/svyatov/deck/issues). A question
about how to use the library and a report that something is broken share one
inbox here, because the project is not busy enough to justify two.

Do not open an issue for a security vulnerability. Follow
[SECURITY.md](SECURITY.md) instead.

## Contributing

[CONTRIBUTING.md](CONTRIBUTING.md) has the setup command, the test command, and
what a pull request needs. Everyone taking part is expected to follow the
[code of conduct](CODE_OF_CONDUCT.md).

## Changelog and license

[CHANGELOG.md](CHANGELOG.md) describes what each release changed.

Copyright (c) 2019-2026, Leonid Svyatov. Deck is licensed under the
[Apache License 2.0](LICENSE).
