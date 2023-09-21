class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "1.0.M5g"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM5g/ucm-macos.tar.gz"
    sha256 "e04ffc09f5a60fe21579706a71313be24d8766d93d76dff81bd1aa063561b56a"

    head "https://github.com/unisonweb/unison/releases/download/latest/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM5g/ucm-linux.tar.gz"
    sha256 "1a5e38ec24ae2e010f3c7ce0c4f4c80bc4171a093fd66a0da8553e3e1bfa7bf5"

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
