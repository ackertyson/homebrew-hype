class Hype < Formula
  desc "Render images as high-fidelity terminal text art"
  homepage "https://github.com/ackertyson/hype"
  url "https://github.com/ackertyson/hype/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "37c06e7e7be4515c5aa7193d986eeaccff369018e0c43f5402c0de374a9330e2"
  license "MIT"
  head "https://github.com/ackertyson/hype.git", branch: "master"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
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
