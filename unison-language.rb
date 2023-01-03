class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "1.0.M4f"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM4f/ucm-macos.tar.gz"
    sha256 "55f2a4b155352d6c899d5046fd1f2bb3d499b288d29d8177e30a42d05aa2a188"

    head "https://github.com/unisonweb/unison/releases/download/latest/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM4f/ucm-linux.tar.gz"
    sha256 "e2c68d9b10e7808dd142da69754010981e6cebbbe3de85a980f9a3e9c7739a94"

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
