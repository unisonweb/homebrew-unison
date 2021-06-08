class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"
  license "MIT"

  version "1.0.M2f"
  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM2f/ucm-macos.tar.gz"
    sha256 "98a0a1b5a15363296b685939cf61e108d761f82156b09947e2a138982f3f3239"

    head "https://github.com/unisonweb/unison/releases/download/latest-macOS/unison-macOS.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM2f/ucm-linux.tar.gz"
    sha256 "ddaef9572e540e1dee8c765fc1a710bad6d7d4c8edc8f577c8ba20141c6a16ef"

    head "https://github.com/unisonweb/unison/releases/download/latest-Linux/unison-Linux.tar.gz"
  end

  def install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"ucm"
  end
end
