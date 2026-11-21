class Forchetta < Formula
  desc "Draw teams of Claude Code agents that work in one folder without collisions"
  homepage "https://forchetta.dev/"
  url "https://github.com/alessiodonato/forchetta/releases/download/v0.11.1/forchetta-0.11.1.tar.gz"
  sha256 "6cf59a75e7be3135580d4abf2ef837f0357825365912869b3d2eb600b01cf246"
  license "Apache-2.0"

  depends_on :macos
  depends_on "node"
  depends_on "tmux"

  def install
    # node-pty brings its binary for both kinds of Mac: keep the one of this Mac.
    other = Hardware::CPU.arm? ? "x64" : "arm64"
    rm_r "node_modules/node-pty/prebuilds/darwin-#{other}"
    libexec.install Dir["*"]
    (bin/"forchetta").write_env_script libexec/"bin/forchetta", PATH: "#{Formula["node"].opt_bin}:$PATH"
  end

  def caveats
    <<~EOS
      To build the app on this Mac, put it in ~/Applications and add the hooks to Claude Code:
        forchetta setup
      Run it again after every `brew upgrade forchetta`.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/forchetta --version")
  end
end
