class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"

  version "1.0.merge"

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2Fmerge/unison-osx.tar.gz"
    sha256 "607e79cf43e314dff9a89bb0e2eebbb35e3f47c6306e1325780f8c04bb2a4f8d"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2Fmerge/unison-linux64.tar.gz"
    sha256 "7601c87343f37147a887542194cd7f0fefb573e03333bd534b85103b0dfff15b"
  end

  def install
    bin.install "ucm"
  end

  test do
    system "ucm"
  end
end
