class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"

  version "1.0.M1b"

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM1b/unison-osx.tar.gz"
    sha256 "287da570aab68b94be10df2b857aa08136a264cfbf0c00fbd7f9f72ed783dc89"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM1b/unison-linux64.tar.gz"
    sha256 "921c0bf9bb592a843b00bd84b66e24b8a3b440fbc9bde960ee9e2004470eab20"
  end

  def install
    bin.install "ucm"
  end

  test do
    system "ucm"
  end
end
