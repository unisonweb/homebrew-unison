class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "0.5.18"
  version_scheme 1

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.18/ucm-macos.tar.gz"
    sha256 "b1f2f5374ca3173a56f1e217aeb3ab8849f0f1f62c3261b1914f74f48e0ab0f9"

    head "https://github.com/unisonweb/unison/releases/latest/download/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.18/ucm-linux.tar.gz"
    sha256 "01471177af86fbb3934dafe9fa88f9b3f2026015ebd7fd54c93bdf2c8f6630b0"
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
