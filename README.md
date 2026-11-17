# homebrew-hype

[Homebrew](https://brew.sh) tap for [hype](https://github.com/ackertyson/hype), which renders images as high-fidelity terminal text art.

## Install

```sh
brew install ackertyson/hype/hype
```

Installing by this fully-qualified name also marks the formula as trusted, which
Homebrew requires for third-party taps. If you tap first and install by the
short name instead, run `brew trust ackertyson/hype` once.

In a `Brewfile`:

```ruby
tap "ackertyson/hype"
brew "ackertyson/hype/hype"
```

The formula installs the prebuilt binary from hype's GitHub release (macOS and
static-musl Linux, arm64 and x86_64), so it has no dependencies, build-time or runtime.

## Releasing a new version

1. In hype, run `build/tag.sh X.Y.Z` on an up-to-date `master`. It bumps
   `Cargo.toml`, commits, tags and pushes; the tag's Release workflow publishes
   the binaries and `checksums.txt`.
2. Once that workflow finishes, run `./release.sh X.Y.Z` here. It regenerates
   `Formula/hype.rb` from `hype.rb.template` with the release's checksums, commits
   and pushes to `main`. CI then audits, installs and tests the formula on macOS and Linux.

Edit `hype.rb.template`, not `Formula/hype.rb`, which is overwritten on each release.
