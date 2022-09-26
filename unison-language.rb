class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "1.0.M4a"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM4a/ucm-macos.tar.gz"
    sha256 "5d7d830bcc3225f14525ff79ac42bd5deb8b2c81d224812a5381dca5fbe6c09e"

    head "https://github.com/unisonweb/unison/releases/download/latest/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM4a/ucm-linux.tar.gz"
    sha256 "5e0127483c38f522663733718888161ce7f355e4b77223075d3b599d1fad1cb7"

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
