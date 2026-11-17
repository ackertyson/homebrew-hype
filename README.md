# homebrew-hype

[Homebrew](https://brew.sh) tap for [hype](https://github.com/ackertyson/hype), which renders images as high-fidelity terminal text art.

## Install

```sh
brew install ackertyson/hype/hype
```

Or `brew tap ackertyson/hype` and then `brew install hype`. In a `Brewfile`:

```ruby
tap "ackertyson/hype"
brew "hype"
```

Prebuilt bottles are published for Apple Silicon macOS 15+ and x86_64 Linux; anywhere else, Homebrew builds from source.

## Releasing a new version

1. In hype, bump `version` in `Cargo.toml`, merge, then tag and push: `git tag vX.Y.Z && git push origin vX.Y.Z`.
2. Open the formula update PR (Homebrew downloads the tarball and computes the checksum):

   ```sh
   brew bump-formula-pr --no-fork \
     --url=https://github.com/ackertyson/hype/archive/refs/tags/vX.Y.Z.tar.gz \
     ackertyson/hype/hype
   ```

3. The **brew test-bot** workflow builds and tests bottles on the PR.
4. When it passes, run the **brew pr-pull** workflow (Actions tab) with the PR number. It uploads the bottles, adds them to the formula, and pushes to `main`.

The repository needs **Settings → Actions → General → Workflow permissions: Read and write** for `pr-pull` to push.
