class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "1.0.M4b"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM4b/ucm-macos.tar.gz"
    sha256 "5233752c39273f002cd5c8b81e37e5ca695705b9bc0fd77794f027a173e759d6"

    head "https://github.com/unisonweb/unison/releases/download/latest/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM4b/ucm-linux.tar.gz"
    sha256 "f570d53a962176e841b45aa730db513c496ca7cf2d28adc99881973918931455"

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
