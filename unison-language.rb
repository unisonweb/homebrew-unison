class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"

  version "1.0.M2j"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM2j/ucm-macos.tar.gz"
    sha256 "0854e0eb64fd261d77dad83ca4839ca174090859b2fa538e4d8f7fecea193253"

    head "https://github.com/unisonweb/unison/releases/download/latest-macOS/unison-macOS.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM2j/ucm-linux.tar.gz"
    sha256 "a950c6106c71c483fd3c890b081957d24662edda03cba8219391cb4973b07163"

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
