class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "1.0.M4"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM4/ucm-macos.tar.gz"
    sha256 "03c8b58c7f7e5bcf4cf976e6631d249c9b0fe5cfc47551364fd2ff1082f45125"

    head "https://github.com/unisonweb/unison/releases/download/latest-macOS/unison-macOS.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM4/ucm-linux.tar.gz"
    sha256 "3aab4988a02c79fc367d58e1b6c6147bea8b3ea5c13c590751a321dba109049e"

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
