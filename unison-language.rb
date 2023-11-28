class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "1.0.M5i"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM5i/ucm-macos.tar.gz"
    sha256 "f7210f11759eda506d8588539fab71fe6867ca8d30a3dada02c1ceabaff1ab49"

    head "https://github.com/unisonweb/unison/releases/download/latest/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM5i/ucm-linux.tar.gz"
    sha256 "5b6c9a5932f6d480812a4d29f9ac3f29f5526fbe8b0c75854ee1c6ac08bbb49b"

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
