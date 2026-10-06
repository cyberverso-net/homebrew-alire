# Homebrew tap for Alire

[Alire](https://alire.ada.dev) is the package manager and toolchain installer for the Ada and SPARK programming languages. This tap provides a Homebrew formula that installs the official `alr` binary release on macOS, for both Apple Silicon and Intel.

## Install

```bash
brew install alire-project/alire/alire
```

or, equivalently:

```bash
brew tap alire-project/alire
brew install alire
```

Then set up a GNAT toolchain:

```bash
alr toolchain --select
```

## Why a tap, and why a binary

Homebrew's main repository (homebrew-core) requires formulae to build from source. Building `alr` from source requires an existing GNAT (Ada) compiler, which Homebrew does not currently provide, since the `gcc` formula does not enable the Ada frontend (see the discussion in [Homebrew/discussions#4657](https://github.com/orgs/Homebrew/discussions/4657) and the earlier attempts in Homebrew/homebrew-core#117527 and #77641). Until Ada support lands in Homebrew's `gcc`, a tap distributing the official release binaries is the practical way to make Alire a one-command install on macOS.

A side benefit: installing through Homebrew avoids the macOS Gatekeeper quarantine prompt that affects the manually downloaded binary.

## Upgrading

The formula includes a `livecheck` block; `brew livecheck alire` reports new upstream releases. Version bumps update the `version` field and the two `sha256` values, which can be automated in CI on a schedule or via repository dispatch from the release workflow.

## Testing locally

```bash
brew install --verbose ./Formula/alire.rb
brew test alire
brew audit --strict alire
```

## Licence

The formula is provided under the same licence as Alire (GPL-3.0). The formula installs the unmodified official release artefacts published at https://github.com/alire-project/alire/releases.
