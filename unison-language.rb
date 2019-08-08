class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"

  version "1.0.merge"

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2Fmerge/unison-osx.tar.gz"
    sha256 "0f711a35ab0baf295919daaf1b0a291ba52165273cfba2d0a72322773c473d05"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2Fmerge/unison-linux64.tar.gz"
    sha256 "06c313981e13f94e2352e9015fa4f6773b0eecbf24bb312248b35e027550522e"
  end

  def install
    bin.install "ucm"
  end

  test do
    system "ucm"
  end
end
