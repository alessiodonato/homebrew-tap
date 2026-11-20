class Forchetta < Formula
  desc "Local control center for the Claude Code sessions running on your Mac"
  homepage "https://forchetta.dev/"
  url "https://github.com/alessiodonato/forchetta/releases/download/v0.10.0/forchetta-0.10.0.tar.gz"
  sha256 "054243bf6171d43e43b3f4fe948fb5fb7adb078dceb1668a9fa79db7e35dc8cd"
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
