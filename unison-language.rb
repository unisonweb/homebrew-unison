class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"

  version "1.0.M2k"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM2k/ucm-macos.tar.gz"
    sha256 "557e74b7891ee7c1428b0383a7075e85617efa2aa6fccf7a8f50b2c1212f9533"

    head "https://github.com/unisonweb/unison/releases/download/latest-macOS/unison-macOS.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM2k/ucm-linux.tar.gz"
    sha256 "553b10351f1cef05acaa260571c4f0f0204095bc468e77d0569ce0ad58898079"

    head "https://github.com/unisonweb/unison/releases/download/latest-Linux/unison-Linux.tar.gz"
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
