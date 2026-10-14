class CloudflareOneWarp < Formula
  desc "Cloudflare One WARP — unofficial Cloudflare One client via warp-cli"
  homepage "https://github.com/bodencrouch/cloudflare-one-warp"
  url "https://github.com/bodencrouch/cloudflare-one-warp/releases/download/v0.3.6/cloudflare-one-warp-0.3.6-src.tar.gz"
  sha256 "d00786ed4c735445a9487e2ff3274954f837eb54ccb6d9aee1a94fd6288fb5d5"
  license "MIT"

  depends_on "node@24"

  def install
    libexec.install "server.js", "package.json", "lib", "config", "public", "assets", "scripts", "bin", "LICENSE", "README.md"
    (bin/"cloudflare-one-warp").write <<~EOS
      #!/bin/bash
      export PATH="#{Formula["node@24"].bin}:$PATH"
      exec "#{libexec}/bin/cloudflare-one-warp" "$@"
    EOS
    chmod 0755, bin/"cloudflare-one-warp"
  end

  def caveats
    <<~EOS
      Requires Cloudflare WARP (warp-cli) installed separately on macOS.
      Launch with: cloudflare-one-warp --no-open
    EOS
  end

  test do
    assert_match "Cloudflare One WARP", shell_output("#{bin}/cloudflare-one-warp --help")
  end
end
