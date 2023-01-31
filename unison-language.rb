class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "1.0.M4g"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM4g/ucm-macos.tar.gz"
    sha256 "5476d77828a10398af12de264e126f7b88c8dd038f491a8ffc9fd35a6d0d698c"

    head "https://github.com/unisonweb/unison/releases/download/latest/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM4g/ucm-linux.tar.gz"
    sha256 "efcf4517c6649cf90a08a64a0d4cc776421158da4ac9c6058c652061da9c02fd"

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
