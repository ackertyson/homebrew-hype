class Hype < Formula
  desc "Render images as high-fidelity terminal text art"
  homepage "https://github.com/ackertyson/hype"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/ackertyson/hype/releases/download/v0.1.2/hype-0.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "f0efda6222c3c22e7d0615ee32c5a91804bed4b2d5baffefe8405daab48bcd40"
    end
    on_intel do
      url "https://github.com/ackertyson/hype/releases/download/v0.1.2/hype-0.1.2-x86_64-apple-darwin.tar.gz"
      sha256 "649b8e8e272b8fed8b7246a99d6edf29627458b48bf551e33be285b6b7630325"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ackertyson/hype/releases/download/v0.1.2/hype-0.1.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "036d7bdea18b7296d47f6c13d3bca1bb55c1c148805be365391de8452c689630"
    end
    on_intel do
      url "https://github.com/ackertyson/hype/releases/download/v0.1.2/hype-0.1.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "809ce4897d06a4ee8b36086054c046708cc0d17f6f56423af2ca3ee3c6d254f9"
    end
  end

  def install
    bin.install "hype"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hype --version")

    %w[test.png test.jpg].each do |image|
      output = shell_output("#{bin}/hype #{test_fixtures(image)} -w 8 -H 4 -c true")
      assert_equal 4, output.lines.count
      assert_match "\e[48;2;", output
    end
  end
end
