class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"

  version "1.0.M1d"

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM1d/unison-osx.tar.gz"
    sha256 "fb9ecab64537def59f8fc168398fb116535fe59b6199febaa6cc091e2dc7f331"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM1d/unison-linux64.tar.gz"
    sha256 "9a2736046c26d3adaaf2685caec05c790dafe2bd8a68914d684ab5211a20ff66"
  end

  def install
    bin.install "ucm"
  end

  test do
    system "ucm"
  end
end
