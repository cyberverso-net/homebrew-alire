# Draft issue for github.com/alire-project/alire

**Title:** Offering a ready-made Homebrew tap for one-command installation on macOS

**Body:**

Hi, and thanks for Alire, which has become the de facto entry point to the Ada/SPARK ecosystem.

Installation on macOS is currently the least smooth of the supported platforms: users download an archive, extract it, adjust PATH, and then work around the Gatekeeper quarantine prompt described in the Alire documentation. A `brew install` would remove all of that friction, and there is documented demand for it (Homebrew discussion #4657, plus the earlier homebrew-core attempts in #117527 and #77641).

Getting Alire into homebrew-core proper is blocked upstream: core requires building from source, and Homebrew's `gcc` formula does not enable the Ada frontend, so there is no bootstrap compiler available. That effort is worthwhile but long-horizon. In the meantime, a project-hosted tap distributing the official release binaries gives users essentially the same experience today:

```bash
brew install alire-project/alire/alire
```

I have prepared a complete, working tap and I would like to offer it to the project, ideally to be hosted as `alire-project/homebrew-alire` so that it is official and discoverable. It contains:

- `Formula/alire.rb`: installs the official `alr` binary from GitHub releases, with per-architecture `url`/`sha256` blocks (Apple Silicon and Intel), a `livecheck` block for release tracking, caveats pointing users to `alr toolchain --select`, and a functional `test do` block (`alr --version` and a non-interactive `alr init`).
- A `brew test-bot` GitHub Actions workflow running on both `macos-14` (ARM) and `macos-13` (Intel) runners.
- A README documenting the rationale and the local test procedure (`brew install --verbose`, `brew test`, `brew audit --strict`).

Maintenance burden is low: a release bump touches three lines (version and two hashes) and can be automated from the release workflow via `repository_dispatch`, or semi-automated with `brew livecheck`/`brew bump-formula-pr`. I am happy to set that automation up as part of the contribution, and to co-maintain the tap.

If hosting under the org is not desirable, I will publish it as a personal tap and would still appreciate a link from the installation docs. Either way, please let me know your preference and I will open the corresponding PRs.

One point for maintainers to confirm: the formula currently declares `license "GPL-3.0-only"` based on the LICENSE file in the release archive; if the intended licence is GPL-3.0-or-later, I will adjust the SPDX identifier.
