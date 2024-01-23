class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "0.5.14"
  version_scheme 1

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.14/ucm-macos.tar.gz"
    sha256 "2cbc89cb4ab3e6a9b4f178fe99bd3d941379b30deff009da498bfcdf6b1879f8"

    head "https://github.com/unisonweb/unison/releases/latest/download/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.14/ucm-linux.tar.gz"
    sha256 "b08c3799cefc7063e2f84f9f5c4a4cbedf8811f3d6d3795ec77d1bb344d57afa"
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
