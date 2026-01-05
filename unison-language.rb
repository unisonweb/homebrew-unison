class UnisonLanguage < Formula
  desc "Unison [Language] and Codebase Manager"
  homepage "https://unisonweb.org"
  license "MIT"

  version_scheme 2
  version "1.0.2"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/unisonweb/unison/releases/download/release%2F1.0.2/ucm-macos-x64.tar.gz"
      sha256 "ac74f8b2c37476a3c5dbc3e0a047316b4a605dc14d709b9f502d6cc7358a57ee"
      head "https://github.com/unisonweb/unison/releases/download/trunk-build/ucm-macos-x64.tar.gz"
    elsif Hardware::CPU.arm?
      url "https://github.com/unisonweb/unison/releases/download/release%2F1.0.2/ucm-macos-arm64.tar.gz"
      sha256 "66869c4fdb2c0076f4a632f21c17dcfb8548e57875dd05731d618e269cfd6ac5"
      head "https://github.com/unisonweb/unison/releases/download/trunk-build/ucm-macos-arm64.tar.gz"
    else
      odie "Unsupported architecture for ucm"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/unisonweb/unison/releases/download/release%2F1.0.2/ucm-linux-x64.tar.gz"
      sha256 "ed6d7a889fb2925622c36a982a1b16f3b14501d84664964139695db78a873010"
      head "https://github.com/unisonweb/unison/releases/download/trunk-build/ucm-linux-x64.tar.gz"
    elsif Hardware::CPU.arm?
      url "https://github.com/unisonweb/unison/releases/download/release%2F1.0.2/ucm-linux-arm64.tar.gz"
      sha256 "5b80a8982cbfff75d6a9566fc7ac6f5456abbfba247cd9e04ac787783c8dac39"
      head "https://github.com/unisonweb/unison/releases/download/trunk-build/ucm-linux-arm64.tar.gz"
    else
      odie "Unsupported architecture for ucm"
    end
  end

  depends_on "fzf" => :recommended

  def install
    libexec.install "unison/unison"
    pkgshare.install "ui"

    (bin/"ucm").write <<~EOS
      #!/bin/bash

      UCM_WEB_UI="#{pkgshare}/ui" \\
        #{opt_libexec}/unison \\
          "$@"
    EOS
  end

  test do
    ohai "Setting up project and downloading base..."
    (testpath/"setup.md").write <<~EOS
      ```ucm
      scratch/main> project.create proj
      ```
      ```unison
      helloWorld = do printLine "Hello, World!"
      ```
      ```ucm
      proj/main> add
      ```
    EOS
    system "ucm", "transcript", "--save-codebase-to", testpath/"codebase", testpath/"setup.md"

    ohai "Running helloWorld..."
    (testpath/"run.md").write <<~EOS
      ```ucm
      proj/main> run helloWorld
      ```
    EOS
    system "ucm", "transcript.fork", "--codebase", testpath/"codebase", testpath/"run.md"
  end
end
