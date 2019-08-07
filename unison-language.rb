class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"

  version "1.0.azure46"

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2Fazure46/unison-osx.tar.gz"
    sha256 "12862e579fe68b83029d5bdec00cd15a44e92916632f3bc1614fb5f830610bd6"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2Fazure46/unison-linux64.tar.gz"
    sha256 "a9bf9347ee0d7675896c177123c70356e445f143ab8c7349af6d8a2a36731d84"
  end

  def install
    bin.install "ucm"
  end

  test do
    system "ucm"
  end
end
