class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "1.0.M5f"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM5f/ucm-macos.tar.gz"
    sha256 "ac7213d3303ebd2d5db9d5b57c9dceb4c5a951e79edfdb298ed29ecf2099accc"

    head "https://github.com/unisonweb/unison/releases/download/latest/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM5f/ucm-linux.tar.gz"
    sha256 "ea7e190f565f8b99f4400f54664fd0b8b96dd8ff7634fe394b8f48d68a78ddbf"

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
