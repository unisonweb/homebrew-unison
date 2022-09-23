class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "1.0.M4a"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM4a/ucm-macos.tar.gz"
    sha256 "5bbdd513d2c7f2e2b2f1bab8fe7e9e89666d3915bed920ed530753cb7f465e8e"

    head "https://github.com/unisonweb/unison/releases/download/latest/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM4a/ucm-linux.tar.gz"
    sha256 "35a8ea37dfd427451a46c268bb89748021f16a8b6f3b13910e7708a87d58e504"

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
