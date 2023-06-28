class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"
  depends_on "fzf" => :recommended

  version "1.0.M5"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM5/ucm-macos.tar.gz"
    sha256 "7e07777d2b61a9fe232c7faa98b6b6007e5f14c69a90114278977e28a3b9a2dc"

    head "https://github.com/unisonweb/unison/releases/download/latest/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM5/ucm-linux.tar.gz"
    sha256 "f7afdc8f4db7379f4cd97c82a900e0bcda97e8cba97cc496db06aa0db9700b18"

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
