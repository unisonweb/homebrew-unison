class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"

  version "1.0.M1i"

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM1i/unison-osx.tar.gz"
    sha256 "da508a2bde84f5763c067b4216514cd08f5c78ffb1059f1c8281ec92b43cc74f"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM1i/unison-linux64.tar.gz"
    sha256 "d0ab582069466c304b29e72b54df62a9d3165d72d080bcec6625b0cde829ed0b"
  end

  def install
    bin.install "ucm"
  end

  test do
    system "ucm"
  end
end
