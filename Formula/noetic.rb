class Noetic < Formula
  desc "Web search, crawl, and knowledge cache for AI coding assistants"
  homepage "https://github.com/dnamaz/noetic"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/dnamaz/noetic/releases/download/v#{version}/noetic-#{version}-macos-arm64.tar.gz"
      # sha256 "PLACEHOLDER" # fill after first release
    else
      url "https://github.com/dnamaz/noetic/releases/download/v#{version}/noetic-#{version}-macos-x86_64.tar.gz"
      # sha256 "PLACEHOLDER" # fill after first release
    end
  end

  on_linux do
    url "https://github.com/dnamaz/noetic/releases/download/v#{version}/noetic-#{version}-linux-x86_64.tar.gz"
    # sha256 "PLACEHOLDER" # fill after first release
  end

  def install
    bin.install "noetic-bin"
    bin.install "noetic"
  end

  test do
    assert_match "noetic", shell_output("#{bin}/noetic --version")
  end
end
