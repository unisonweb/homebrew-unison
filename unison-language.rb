class UnisonLanguage < Formula
  desc "Unison [Language] and Codebase Manager"
  homepage "https://unisonweb.org"
  license "MIT"

  version_scheme 2
  version "1.5.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/unisonweb/unison/releases/download/release%2F1.5.0/ucm-macos-x64.tar.gz"
      sha256 "4f9e537434d8e1615e046b4227c8c27a77a2e6dd9f14978af6385237ffc18b92"
      head "https://github.com/unisonweb/unison/releases/download/trunk-build/ucm-macos-x64.tar.gz"
    elsif Hardware::CPU.arm?
      url "https://github.com/unisonweb/unison/releases/download/release%2F1.5.0/ucm-macos-arm64.tar.gz"
      sha256 "3e1d6a978235a8f989a584e332e670eca18c15f1099fcf1881fc126b62bdbeae"
      head "https://github.com/unisonweb/unison/releases/download/trunk-build/ucm-macos-arm64.tar.gz"
    else
      odie "Unsupported architecture for ucm"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/unisonweb/unison/releases/download/release%2F1.5.0/ucm-linux-x64.tar.gz"
      sha256 "fcb2ed6284e1f69ba10c4e8a828dd65710f09cf1ee8cb876e732aa9ef566cff4"
      head "https://github.com/unisonweb/unison/releases/download/trunk-build/ucm-linux-x64.tar.gz"
    elsif Hardware::CPU.arm?
      url "https://github.com/unisonweb/unison/releases/download/release%2F1.5.0/ucm-linux-arm64.tar.gz"
      sha256 "a4be1441d040bbabdb401db8294cf7691a93f90221992bd8e7d5b8e9fadbff4e"
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
