class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "1.0.M4h"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM4h/ucm-macos.tar.gz"
    sha256 "ef2a616a9eea64191b4ca8b08720932e06c13bf680d1e516b6f6be5e3a5a6432"

    head "https://github.com/unisonweb/unison/releases/download/latest/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM4h/ucm-linux.tar.gz"
    sha256 "beb669605a10c35871819ee50287a322a9e320e14531a84023d4a314dfc29e6b"

    head "https://github.com/unisonweb/unison/releases/download/latest/ucm-linux.tar.gz"
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
