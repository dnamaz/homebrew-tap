class Noetic < Formula
  desc "Web search, crawl, and knowledge cache for AI coding assistants"
  homepage "https://github.com/dnamaz/noetic"
  version "0.1.0"
  license "MIT"

  on_macos do
    url "https://github.com/dnamaz/noetic/releases/download/v#{version}/noetic-#{version}-macos-arm64.tar.gz"
    sha256 "fd3555aa676c9ced93711e7402e244a2778de010db577891fc8d3536a283ae02"
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/dnamaz/noetic/releases/download/v#{version}/noetic-#{version}-linux-arm64.tar.gz"
      sha256 "3315e0d84ae34c222ce80f0fffb437a518e2fcb5b89ed860180c5f940dd9d9e9"
    else
      url "https://github.com/dnamaz/noetic/releases/download/v#{version}/noetic-#{version}-linux-x86_64.tar.gz"
      sha256 "bacd9b80bea5653367088bfaf1264ff626663a286b85da2c6f7933a46d690ece"
    end
  end

  def install
    bin.install "noetic"
    bin.install "noetic-start" if File.exist?("noetic-start")
    bin.install "noetic-stop"  if File.exist?("noetic-stop")
    bin.install "mcp-server.sh" if File.exist?("mcp-server.sh")
  end

  service do
    run [opt_bin/"noetic",
         "--server.port=8090",
         "--websearch.adapter.default-mode=rest"]
    keep_alive true
    log_path var/"log/noetic.log"
    error_log_path var/"log/noetic.log"
    working_dir var/"noetic"
  end

  def post_install
    (var/"noetic").mkpath
    (var/"log").mkpath
  end

  def caveats
    <<~EOS
      CLI (works immediately, no server needed):
        noetic --websearch.adapter.default-mode=cli search "your query"
        noetic --websearch.adapter.default-mode=cli crawl "https://example.com"

      Start the REST API server as a background service:
        brew services start noetic

      Or run the MCP server (foreground, for IDE integration):
        noetic

      Install AI assistant instructions:
        noetic install-skill --target=cursor
        noetic install-skill --list

      Server logs:  #{var}/log/noetic.log
      Model cache:  ~/.websearch/models/
      Vector cache: ~/.websearch/index/
    EOS
  end

  test do
    assert_match "noetic", shell_output("#{bin}/noetic --version")
    assert_match version.to_s, shell_output("#{bin}/noetic --version")
  end
end
