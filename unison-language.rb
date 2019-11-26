class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"

  version "1.0.M1g"

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM1g/unison-osx.tar.gz"
    sha256 "3ed393b99e5518d1c7234c5b46cf727149455055682d160037273de78e3fdea0"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM1g/unison-linux64.tar.gz"
    sha256 "4b05432d735fa12a17aac8a6233002617f6bb2c565c942edd5ea5216b26229ce"
  end

  def install
    bin.install "ucm"
  end

  test do
    system "ucm"
  end
end
