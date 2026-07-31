# Contributing to Deck

Thanks for taking the time. Deck is small, so most changes are small too.

## Setting up

Deck needs Elixir and Erlang/OTP. CI runs Elixir 1.18, 1.19, and 1.20 on OTP 28
and 29, so anything in that range is a safe local choice.

```bash
git clone https://github.com/svyatov/deck.git
cd deck
mix deps.get
```

## Running the checks

CI runs these four, and nothing else. Run them before you open a pull request.

```bash
mix test
mix compile --warnings-as-errors
mix format --check-formatted
mix credo
```

`mix format` rewrites files in place; the `--check-formatted` form only reports.
If `mix deps.get` changes `mix.lock`, commit that change: CI installs with
`mix deps.get --check-locked`, which fails rather than re-resolving.

## Submitting a change

Fork the repository, create a branch, and open a pull request against `master`.

Before you open it:

- A change that adds or alters behavior arrives with a test.
- The four checks above pass.
- `CHANGELOG.md` has an entry under Unreleased, unless the change is not
  notable to anyone using the package.

What an acceptable contribution has to satisfy is the standard in
[STANDARD.md](https://github.com/svyatov/oss-kit/blob/main/skills/oss-audit/STANDARD.md),
the rule set this repository is scored against.

Commit messages use [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/):
`type(scope): description`. Branches use the same types, as in
`fix/short-deck-guard`.

## Governance

One maintainer, Leonid Svyatov, decides what goes into Deck and publishes every
release. Decisions happen in the open, in issues and pull requests, and anyone
may argue for or against a change there. Only the maintainer has write access,
so every contribution arrives as a pull request from a fork and merges only with
their approval.

No succession is arranged. If the maintainer stops, nothing here continues on
its own: nobody else holds write access, and no organization owns the
repository. The license lets anyone fork and carry on, and the library is two
source files with no service behind it, which makes that fork cheap.
