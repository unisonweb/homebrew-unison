class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "1.0.M4i"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM4i/ucm-macos.tar.gz"
    sha256 "d50a75481e6b0ac562999cd1a3534e5fc1c1a0c106948c9c24f9b7cc64d4b8ec"

    head "https://github.com/unisonweb/unison/releases/download/latest/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM4i/ucm-linux.tar.gz"
    sha256 "431f2f3bf55acf455d0865f023045022e325a78e21c42ae843b9bb63e9bb6979"

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
