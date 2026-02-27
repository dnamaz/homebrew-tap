class Cleave < Formula
  desc "AI-powered GitHub PR analysis - split large PRs into reviewable groups"
  homepage "https://github.com/dnamaz/cleave"
  version "1.0.33"
  license "MIT"

  on_macos do
    url "https://github.com/dnamaz/cleave-releases/releases/download/v#{version}/cleave-#{version}-macos-arm64.tar.gz"
    sha256 "aaccb22059f2074e649b494ec70cab7cbdb89a8b2593a3efb4f5c1aa9fdf7562"
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

      You'll need your org's GitHub credentials
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
