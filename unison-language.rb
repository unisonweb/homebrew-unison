class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"

  version "1.0.azure43"

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2Fazure43/unison-osx.tar.gz"
    sha256 "5b275222db1d0b58153f99a4a65f314d2dd35b6600fbbe9ee5442326b31284c8"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2Fazure43/unison-linux64.tar.gz"
    sha256 "f0c936d297219c1c427eac4cc20ec0d5910d74212f970fca1dc4da4e223df93a"
  end

  def install
    bin.install "ucm"
  end

  test do
    system "ucm"
  end
end
