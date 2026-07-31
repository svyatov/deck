# Security policy

## Supported versions

The newest release on [Hex](https://hex.pm/packages/deck) is the only version
that receives fixes. There are no maintained release branches.

## Reporting a vulnerability

Report security issues through GitHub private vulnerability reporting, at
https://github.com/svyatov/deck/security/advisories/new. It keeps the report
private until there is a fix to disclose.

If the advisory form is unavailable, email leonid@svyatov.com instead. Do not
open a public issue for a security report.

The maintainer acknowledges a report within one week of receiving it.

## Scope

Deck has no run-time dependencies and performs no input, output, or
deserialization. Its randomness comes from Erlang's `:rand`, which is not a
cryptographically secure source, so a deal produced by `Deck.shuffle/1` must not
be treated as unpredictable by an adversary. That is a documented property of
the library rather than a vulnerability in it; if you are dealing cards for
money, seed and shuffle with `:crypto` yourself.
