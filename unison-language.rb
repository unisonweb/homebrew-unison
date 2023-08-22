class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "1.0.M5e"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM5e/ucm-macos.tar.gz"
    sha256 "8e0f3f0e6209aeed8e299bb959f03b7dab4a71bbab3e25e7a002e27f12f6ea47"

    head "https://github.com/unisonweb/unison/releases/download/latest/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM5e/ucm-linux.tar.gz"
    sha256 "fb6748c6a7fd6fc0dfa1351a93103a42ba5bedc010282bde9edc434b5b05c633"

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
