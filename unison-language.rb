class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"

  version "1.0.M1l"

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM1l/unison-osx.tar.gz"
    sha256 "1927b573010591324f2448c6237391880dbd23114fd4a0d01c73dc71f3547d61"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM1l/unison-linux64.tar.gz"
    sha256 "1d74ccb90403f30258e739d02d336e3db4e8529c70fd679110d75b22cffe5e94"
  end

  def install
    bin.install "ucm"
  end

  test do
    system "ucm"
  end
end
