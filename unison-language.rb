class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"

  version "1.0.M1f"

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM1f/unison-osx.tar.gz"
    sha256 "d3d51e2ebc1faabb164ef33b0635ef459b6d54527c6a9d865e4dc39716583621"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM1f/unison-linux64.tar.gz"
    sha256 "319b882b38ff210ce4cc753a82439e7c3ed770739fc209422a8153abae66024b"
  end

  def install
    bin.install "ucm"
  end

  test do
    system "ucm"
  end
end
