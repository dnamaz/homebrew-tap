class Cleave < Formula
  desc "AI-powered GitHub PR analysis - split large PRs into reviewable groups"
  homepage "https://github.com/dnamaz/cleave-releases"
  version "1.0.32"
  license "MIT"

  on_macos do
    url "https://github.com/dnamaz/cleave-releases/releases/download/v#{version}/cleave-#{version}-macos-arm64.tar.gz"
    sha256 "b519869017b271fdc87e252b751cecf8aa98716d8e8f3c1fcdfc0312e29756bc"
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/dnamaz/cleave-releases/releases/download/v#{version}/cleave-#{version}-linux-arm64.tar.gz"
      sha256 "PLACEHOLDER"
    else
      url "https://github.com/dnamaz/cleave-releases/releases/download/v#{version}/cleave-#{version}-linux-x86_64.tar.gz"
      sha256 "PLACEHOLDER"
    end
  end

  def install
    bin.install "cleave"
    libexec.install "cleave-bin"

    inreplace bin/"cleave" do |s|
      s.gsub! 'CLEAVE_BIN="$SCRIPT_DIR/cleave-bin"', "CLEAVE_BIN=\"#{libexec}/cleave-bin\""
    end
  end

  def post_install
    (var/"log").mkpath
  end

  service do
    run [opt_bin/"cleave"]
    keep_alive true
    log_path var/"log/cleave.log"
    error_log_path var/"log/cleave-error.log"
    working_dir var/"cleave"
  end

  def caveats
    <<~EOS
      First-time setup:
        cleave setup

      You'll need your org's GitHub App credentials
      (ask your team lead or check 1Password).

      Start the app:
        cleave

      Then open: http://localhost:9090

      Other commands:
        cleave status    # show configuration
        cleave reset     # remove config and data

      Run as background service:
        brew services start cleave

      Config: ~/.config/cleave/
      Logs:   #{var}/log/cleave.log
    EOS
  end

  test do
    assert_match "Usage: cleave", shell_output("#{bin}/cleave help")
  end
end
