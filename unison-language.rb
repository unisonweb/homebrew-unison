class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "1.0.M5h"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM5h/ucm-macos.tar.gz"
    sha256 "e9db6d3631f993e590fdce9128773558cddccdcbda9594c6fba0bf239a373e3a"

    head "https://github.com/unisonweb/unison/releases/download/latest/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM5h/ucm-linux.tar.gz"
    sha256 "66b59303f3a001db5eae5268a4a8ea9bdc1206244648ee65af899503d9150087"

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
