# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog 2.0.0](https://keepachangelog.com/en/2.0.0/), and this project follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html) over the public API described in the [README](README.md#public-api).

## [Unreleased]

## [1.1.1] - 2026-07-31

### Added

- Continuous integration on GitHub Actions, covering Elixir 1.16 through 1.20, each on an OTP release that version supports. The project had no working CI after travis-ci.org shut down.
- The community files a contributor needs: a contributing guide carrying the setup and check commands, a code of conduct, a security policy with a private reporting channel, issue forms, and a pull request template.

### Changed

- The README states what the library covers, which Elixir versions are tested, whether it is maintained, and where to ask a question. The dead Travis badge and the downloads badge are gone.
- The README declares the public API that Semantic Versioning covers: the `Deck` module, the card format, and the accepted deck size. `Deck.Guards` is named as internal, which its `@moduledoc false` already made it.
- `mix.exs` declares the license as the SPDX identifier `Apache-2.0` rather than the free text `Apache 2.0`, and links the changelog alongside the repository.

### Removed

- `config/config.exs`, which held nothing but comments and a `use Mix.Config` call deprecated since Elixir 1.9. A library's `config/config.exs` never reaches the project depending on it.

### Security

- The development dependency set no longer resolves to `earmark` 1.4.3, which is retired and carries [CVE-2026-48591](https://osv.dev/vulnerability/EEF-CVE-2026-48591), a stored cross-site scripting issue. `ex_doc` was constrained `~> 0.21`, which pins a 0.x version below 0.22; widening it to `~> 0.40` moves documentation generation onto `earmark_parser`. No release of this package ever shipped `earmark` to anyone depending on it, because the dependency is `only: :dev`.

## [1.1.0] - 2020-03-30

### Changed

- **Breaking:** the minimum required Elixir version is 1.6.

## [1.0.0] - 2019-02-02

### Added

- First release. Build a full or partial deck, shuffle it, deal from it, burn cards, and count what is left.

[Unreleased]: https://github.com/svyatov/deck/compare/v1.1.1...HEAD
[1.1.1]: https://github.com/svyatov/deck/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/svyatov/deck/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/svyatov/deck/releases/tag/v1.0.0
