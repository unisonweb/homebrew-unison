class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "0.5.15"
  version_scheme 1

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.15/ucm-macos.tar.gz"
    sha256 "526a6ef5642183a967e9a05be9b3d551949ac7565e87abdc607c2642e151c766"

    head "https://github.com/unisonweb/unison/releases/latest/download/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.15/ucm-linux.tar.gz"
    sha256 "705b9c050732c9ee05e957a9e8ef5bb84345cea27deaaf3fd9c56bf4d16f1c1f"
    head "https://github.com/unisonweb/unison/releases/latest/download/ucm-linux.tar.gz"
  end

  def install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"ucm"
  end

  test do
    (testpath/"getbase.md").write <<~EOS
      ```ucm
      .> pull https://github.com/unisonweb/base:.releases._latest .base
      ```
    EOS
    system "ucm", "transcript", testpath/"getbase.md"
  end
end
