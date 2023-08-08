class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "1.0.M5c"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM5c/ucm-macos.tar.gz"
    sha256 "2d3a6c2b0895d19c5178b72ece8258b8c3f58cdeaff0cff3ea652a1fdb3903e8"

    head "https://github.com/unisonweb/unison/releases/download/latest/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM5c/ucm-linux.tar.gz"
    sha256 "ea0497f073affcae33153cf53b856fae9591f7e890c8b38eeaf211bfaa15c3f7"

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
