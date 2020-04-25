class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"

  version "1.0.M1k"

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM1k/unison-osx.tar.gz"
    sha256 "b340e92000ab81ef3d07eeb6a8c64673d17ad72366c8b3f5c2f6b60c0c874951"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM1k/unison-linux64.tar.gz"
    sha256 "0c6e7ab893779ca43054c1de310f22e62cc9b7bd2fcdea9e6cc4bd224100c3bb"
  end

  def install
    bin.install "ucm"
  end

  test do
    system "ucm"
  end
end
