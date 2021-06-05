class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"

  version "1.0.M2"
  
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/M2-macOS/unison-macOS.tar.gz"
    sha256 "bfbace7cca55cb6a9464b089bf9bea8eabda14907d184fc7b47b92d3a10d8e71"

    head "https://github.com/unisonweb/unison/releases/download/latest-macOS/unison-macOS.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/M2-Linux/unison-Linux.tar.gz"
    sha256 "862b160ee4a4b2ba165fbf871710eb9de9b45824705073909b2a297f5f499b02"
    
    head "https://github.com/unisonweb/unison/releases/download/latest-Linux/unison-Linux.tar.gz"
  end

  def install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"ucm"
  end
end
