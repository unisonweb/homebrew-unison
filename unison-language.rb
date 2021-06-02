class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"

  version "1.0.M1m"

  url "https://github.com/unisonweb/unison/releases/download/release%2FM1m/unison-osx.tar.gz"
  sha256 "3b181d7a166e40029a1f884fbac3bc45ab5ab966870a602fc817c951ceddfd1a"

  head "https://github.com/unisonweb/unison/releases/download/latest-macOS/unison-macOS.tar.gz"

  def install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"ucm"
  end
end
