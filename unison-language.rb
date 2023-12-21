class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "0.5.12"
  version_scheme 1

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.12/ucm-macos.tar.gz"
    sha256 "9da5fcd14752030140192d3865de55c954b62905a7a2d138fa62715984575cd5"

    head "https://github.com/unisonweb/unison/releases/download/latest/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.12/ucm-linux.tar.gz"
    sha256 "443ea91c3408f2cb14fc4f0bccb5e6aad79d2c22f9c1957f6cedca1c85a260df"

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
