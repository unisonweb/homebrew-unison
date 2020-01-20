class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"

  version "1.0.M1h"

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM1h/unison-osx.tar.gz"
    sha256 "17b29f63e2499473cc07c7e5414989270a16ae996cd3913fc00ecc555fa93b46"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM1h/unison-linux64.tar.gz"
    sha256 "917973ccdee78201cdb858bb30d79e74913da44906cf03a96bf122eb03236839"
  end

  def install
    bin.install "ucm"
  end

  test do
    system "ucm"
  end
end
