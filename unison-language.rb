class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "1.0.M3"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM3/ucm-macos.tar.gz"
    sha256 "c6c86aa84441afad2fcf5a849dec2580d22f776e1a13afd5b4ae620656a74078"

    head "https://github.com/unisonweb/unison/releases/download/latest-macOS/unison-macOS.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM3/ucm-linux.tar.gz"
    sha256 "aedf18d591105471fa824e09577947dfc1f5d130f074b0e76e7aa31b6bf2cb2e"

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
