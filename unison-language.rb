class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"

  version "1.0.M1j"

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM1j/unison-osx.tar.gz"
    sha256 "4f43f0a7d6773ac52bee0af2bf907dea178d9efe915a94978d42d0a755956ddf"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM1j/unison-linux64.tar.gz"
    sha256 "4e85a8f050b2673d92677bf57a0eab0fe6dda9e498c1bcc1aee3b20248a7ebf6"
  end

  def install
    bin.install "ucm"
  end

  test do
    system "ucm"
  end
end
