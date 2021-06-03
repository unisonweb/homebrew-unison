class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"

  version "1.0.M2"

  url "https://github.com/unisonweb/unison/releases/download/M2-macOS/unison-macOS.tar.gz"
  sha256 "bfbace7cca55cb6a9464b089bf9bea8eabda14907d184fc7b47b92d3a10d8e71"

  head "https://github.com/unisonweb/unison/releases/download/latest-macOS/unison-macOS.tar.gz"

  def install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"ucm"
  end
end
