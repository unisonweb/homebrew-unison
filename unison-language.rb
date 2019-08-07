class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"

  version "1.0.azure42"

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2Fazure42/unison-osx.tar.gz"
    sha256 "238fb9cc96cc5bfdc018fe812aac53fe738da9a0cdf668d1c20acf62abe26927"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2Fazure42/unison-linux64.tar.gz"
    sha256 "5f6d059c41c670086fc099b1fa474600598dd0602c2eec201a7d871fb51443e2"
  end

  def install
    bin.install "ucm"
  end

  test do
    system "ucm"
  end
end
