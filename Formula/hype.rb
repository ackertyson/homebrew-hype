class Hype < Formula
  desc "Render images as high-fidelity terminal text art"
  homepage "https://github.com/ackertyson/hype"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/ackertyson/hype/releases/download/v0.1.1/hype-0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "0ce93adef0e31dff98d2108d01dee18f4b66b28051ec2bd279bfc8a8d5f0e085"
    end
    on_intel do
      url "https://github.com/ackertyson/hype/releases/download/v0.1.1/hype-0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "ff7ef8ecab8ec05fbb9d8afd68859ab6dd8d66137eb4cd4a4e31ddf5b71d9ffb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ackertyson/hype/releases/download/v0.1.1/hype-0.1.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "056b4e28d20be3d9ac8cc24b0fbb9cca10cfb019499378ad9727bb5229c004bb"
    end
    on_intel do
      url "https://github.com/ackertyson/hype/releases/download/v0.1.1/hype-0.1.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "26bcb9692d5ee442efa9540024f3ab7f03d202d1606405babec744f9ccc89dde"
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
