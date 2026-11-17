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

Homebrew builds hype from source with Cargo (installing Rust for the build).

## Releasing a new version

1. In hype, bump `version` in `Cargo.toml`, merge, then tag and push:
   `git tag vX.Y.Z && git push origin vX.Y.Z`.
2. In `Formula/hype.rb`, point `url` at the new tag and update `sha256`:

   ```sh
   curl -sL https://github.com/ackertyson/hype/archive/refs/tags/vX.Y.Z.tar.gz | shasum -a 256
   ```

3. Commit and push to `main`. CI builds, tests and audits the formula on macOS and Linux.
