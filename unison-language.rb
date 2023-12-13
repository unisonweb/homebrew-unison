class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "0.5.11"
  version_scheme 1

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.11/ucm-macos.tar.gz"
    sha256 "7ba6ab2b84e937b0973995a3955c7445e23a873f2c10714c829979fd2d38684b"

    head "https://github.com/unisonweb/unison/releases/download/latest/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.11/ucm-linux.tar.gz"
    sha256 "1a51f2dbf83ae24bca1cd96d81439d1eba63b7a9c587d825f4a5e4e0916bae28"

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
