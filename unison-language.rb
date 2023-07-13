class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "1.0.M5b"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM5b/ucm-macos.tar.gz"
    sha256 "5249edd4daf2c261acf18a2f96737c4d4f22698813d637983f84900ae2b5bbe2"

    head "https://github.com/unisonweb/unison/releases/download/latest/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM5b/ucm-linux.tar.gz"
    sha256 "0992c60387c5172b311e4c1e742f1104b9875b0af704cf31aa9b3b84ddd30bf8"

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
