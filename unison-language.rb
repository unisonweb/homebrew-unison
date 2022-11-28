class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "1.0.M4e"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM4e/ucm-macos.tar.gz"
    sha256 "b9370eabc447e680ee5ddb1e085225147ce9fdfb34cacea15d5679cd072bfd67"

    head "https://github.com/unisonweb/unison/releases/download/latest/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM4e/ucm-linux.tar.gz"
    sha256 "759b4d42296c1b894846af717b16e9b7e63829db56851860bbe7f567eece8cf1"

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
