class Panea < Formula
  desc "Local multi-pane terminal workspace with vertical tabs and split panes"
  homepage "https://github.com/abdusselm/panea"
  url "https://github.com/abdusselm/panea/archive/refs/tags/v0.1.2.tar.gz"
  version "0.1.2"
  sha256 "4f492246d634e34b85efad90995f4759223c8bd00e70ad7a59f0581bf88045d4"
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
