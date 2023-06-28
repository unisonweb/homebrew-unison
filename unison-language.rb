class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "1.0.M5"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM5/ucm-macos.tar.gz"
    sha256 "779af02dc993088ce887c950e478b4fbae2f18c8e14382a2ec3eb619e05255f7"

    head "https://github.com/unisonweb/unison/releases/download/latest/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM5/ucm-linux.tar.gz"
    sha256 "e54323b2456ef21c0f0457229bb772a135fe34bdc70e1f6c1c05c0c77eff2ea6"

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
