class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"

  version "1.0.M2h"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM2h/ucm-macos.tar.gz"
    sha256 "12e0530262786648c7fffad01bdb12a682c0a36717cab06768d0457a388d07e8"

    head "https://github.com/unisonweb/unison/releases/download/latest-macOS/unison-macOS.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM2h/ucm-linux.tar.gz"
    sha256 "b03f00be06f6b70219017f7a8f990bf8290975a66e57f8dc7209e23c5f2e2363"

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
