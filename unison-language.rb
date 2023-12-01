class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "1.0.M5j"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM5j/ucm-macos.tar.gz"
    sha256 "0839b96b84d1f067ccf102b99989846fadcf4b3e3af57dd1e4b6a290072f20b2"

    head "https://github.com/unisonweb/unison/releases/download/latest/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM5j/ucm-linux.tar.gz"
    sha256 "e47e2a38f876b4580ea7eb87367770c21d4af966f8d9499f974a24f48c6b95cf"

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
