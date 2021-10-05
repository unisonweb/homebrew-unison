class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"

  version "1.0.M2i"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM2i/ucm-macos.tar.gz"
    sha256 "85f244bdda22cecc3d9df83bed1c7f693d34463e96d3fc59694dd57909b99218"

    head "https://github.com/unisonweb/unison/releases/download/latest-macOS/unison-macOS.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM2i/ucm-linux.tar.gz"
    sha256 "b51f3f60a7ccdf8b4e1e55efe61d240024e8b4c47ee22f65e36fd88e363ff8f4"

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
