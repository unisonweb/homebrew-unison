class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"

  version "1.0.M1m"

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM1m/unison-osx.tar.gz"
    sha256 "3b181d7a166e40029a1f884fbac3bc45ab5ab966870a602fc817c951ceddfd1a"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM1m/unison-linux64.tar.gz"
    sha256 "ecb03e7b8f7c3f2a97a588cd330c3cff4fc4b14eee8601fe24a31580b0db57e3"
  end

  def install
    bin.install "ucm"
  end

  test do
    system "ucm"
  end
end
