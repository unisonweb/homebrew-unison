class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "0.5.19"
  version_scheme 1

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.19/ucm-macos.tar.gz"
    sha256 "fff6e3a665b8e41a811e60488f6b8c6a161062384d27c86f1a1f8effba1840e9"

    head "https://github.com/unisonweb/unison/releases/latest/download/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.19/ucm-linux.tar.gz"
    sha256 "dd6ca257a988ba8e460e90cafca75632f8f6dac677ba9875e6edefdd35f96190"
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
