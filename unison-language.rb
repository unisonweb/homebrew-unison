class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"

  version "1.0.M2g"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM2g/ucm-macos.tar.gz"
    sha256 "eae914c75e7c35839ab770bdbfe96d9eda204cf5a9f2ebca88eb5f977fbb69c5"

    head "https://github.com/unisonweb/unison/releases/download/latest-macOS/unison-macOS.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM2g/ucm-linux.tar.gz"
    sha256 "d2a67dd2a4997e79aea8c95eeae412f4b28eee74944c1a7766b39e62f0e99200"

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
