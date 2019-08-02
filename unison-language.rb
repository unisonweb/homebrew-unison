class UnisonLanguage < Formula
  desc "The Unison Language and Codebase Manager."
  homepage "https://unisonweb.org"

  version "1.0.M1a"

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM1a/unison-linux64.tar.gz"
    sha256 "C358A3DF81FE24CFDC2B6D9E035D642A9EE52464C9AD226EA7387B913F26B2B7"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2FM1a/unison-osx.tar.gz"
    sha256 "D54A5E79AFB35DD506B204CB28563B2779DE120625D0C12EC8EFB64AB35A26DD"
  end

  def install
      bin.install "ucm"
  end

  test do
    system "ucm"
  end
end
