class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"

  version "1.0.M1e"

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM1e/unison-osx.tar.gz"
    sha256 "d0b02776217de5fd90ab1d2599e5c1ed97f8ef65a97a72c231795b991b6292c9"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM1e/unison-linux64.tar.gz"
    sha256 "a17770f9abf537124bea36f162351ec643716e0eef2b843b1c1bd37450ef06cb"
  end

  def install
    bin.install "ucm"
  end

  test do
    system "ucm"
  end
end
