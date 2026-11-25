class Hype < Formula
  desc "Render images as high-fidelity terminal text art"
  homepage "https://github.com/ackertyson/hype"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/ackertyson/hype/releases/download/v0.1.3/hype-0.1.3-aarch64-apple-darwin.tar.gz"
      sha256 "2a9328bc35477e9dc63e736ef1283658c146c3c790817d21a9f72afea362766b"
    end
    on_intel do
      url "https://github.com/ackertyson/hype/releases/download/v0.1.3/hype-0.1.3-x86_64-apple-darwin.tar.gz"
      sha256 "f3681f6b76791bee1dd35879d04549f56ddbd54f8b7901a84c69fec05828dd3b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ackertyson/hype/releases/download/v0.1.3/hype-0.1.3-aarch64-unknown-linux-musl.tar.gz"
      sha256 "07d047609819d9b802d6d1390e8235d067621356b0422200fb739c6948885267"
    end
    on_intel do
      url "https://github.com/ackertyson/hype/releases/download/v0.1.3/hype-0.1.3-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7e3176a9ddec2fc721a16c410c382eb86b4fd43775cf907467650458bd1d7544"
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
