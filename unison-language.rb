class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"

  version "1.0.M1c"

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM1c/unison-osx.tar.gz"
    sha256 "ebef2141ae44a1f83bada9f424d544a2ef445113f3d669c2c7cb1f864f16000f"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM1c/unison-linux64.tar.gz"
    sha256 "644a93831f42dad7a404a453993350387821fce901309eb0bf69c4702db69ec7"
  end

  def install
    bin.install "ucm"
  end

  test do
    system "ucm"
  end
end
