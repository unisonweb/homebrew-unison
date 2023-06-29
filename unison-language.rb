class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "1.0.M5a"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM5a/ucm-macos.tar.gz"
    sha256 "02fb2f702224cf60033f33cf26b2c71a80ab16664ba23a46e48bd0c26e41d489"

    head "https://github.com/unisonweb/unison/releases/download/latest/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM5a/ucm-linux.tar.gz"
    sha256 "bcaa939b402d8ed39762b541eb2b4e9fa19af65ed69022d9b8199b81ebab13a9"

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
