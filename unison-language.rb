class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "0.5.13"
  version_scheme 1

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.13/ucm-macos.tar.gz"
    sha256 "fe268bde34f051e1a17cf819d3c9e3a2990e0b9b78458df38209f49f6ccb4e7c"

    head "https://github.com/unisonweb/unison/releases/latest/download/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.13/ucm-linux.tar.gz"
    sha256 "671b87a5ccadd33c5732296db9ef7d4f3ae5becaeb6f570bdcb35c188a3936c2"

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
