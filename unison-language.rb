class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "1.0.M4c"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM4c/ucm-macos.tar.gz"
    sha256 "9a4cc80bf70f9291f4a1b101aa4bef29587be0b695ea391fc8430b1e6267fe71"

    head "https://github.com/unisonweb/unison/releases/download/latest/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM4c/ucm-linux.tar.gz"
    sha256 "2df4ffa4c3af7c10307b0e8d5b454dbee079735002edbfaa2ab68fdb9fa4cad8"

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
