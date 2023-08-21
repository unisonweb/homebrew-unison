class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "1.0.M5d"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM5d/ucm-macos.tar.gz"
    sha256 "3f82321809621ec35fdf737abfe49d4ab120bf81ebd9efe937f953f817001179"

    head "https://github.com/unisonweb/unison/releases/download/latest/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM5d/ucm-linux.tar.gz"
    sha256 "b239d3ccf0d3923f1cb7a2623ab43fc1e7bdc8695bf57a950ec5d75c03ed66a0"

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
