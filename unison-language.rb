class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "1.0.M2l"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM2l/ucm-macos.tar.gz"
    sha256 "d63c032029b5b6dffff764bec9b1e145c3508de09ce4368cebe44c2272d6cc51"

    head "https://github.com/unisonweb/unison/releases/download/latest-macOS/unison-macOS.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM2l/ucm-linux.tar.gz"
    sha256 "102a60ea237149592dfd5baca45613755c943bff97c46c01d4d9a07cc3a16f90"

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
