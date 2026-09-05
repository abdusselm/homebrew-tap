class Panea < Formula
  desc "Local multi-pane terminal workspace with vertical tabs and split panes"
  homepage "https://github.com/abdusselm/panea"
  url "https://github.com/abdusselm/panea/archive/refs/tags/v0.4.13.tar.gz"
  version "0.4.13"
  sha256 "74801ff576901871caffc52629094a9a07765a948a221148b413a849103316d6"
  license "MIT"

  depends_on "node"
  depends_on "python@3.14"
  depends_on :macos

  def install
    system "npm", "install", *std_npm_args
    (bin/"panea").write_env_script libexec/"bin/panea",
      PANEA_PYTHON: Formula["python@3.14"].opt_bin/"python3"
  end

  def caveats
    <<~EOS
      The Electron runtime is not installed into the Cellar, because Homebrew
      relocates Mach-O files and that invalidates the signature Electron ships
      with. The first `panea --app` downloads it into ~/.panea/electron instead.

      `panea` on its own needs none of that and starts immediately.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/panea --version")
    assert_match "multi-pane", shell_output("#{bin}/panea --help")
  end
end
