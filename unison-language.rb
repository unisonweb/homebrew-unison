class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "1.0.M4d"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM4d/ucm-macos.tar.gz"
    sha256 "0a7094e55a968ff885e4fddb759e6a379a6f219031e5e9cd936c9fc0eea98deb"

    head "https://github.com/unisonweb/unison/releases/download/latest/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM4d/ucm-linux.tar.gz"
    sha256 "118b52a387d69d564d55883f25df046a46c97505eca315359e9096328e1796be"

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
