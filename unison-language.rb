class UnisonLanguage < Formula
  desc "Unison [Language] and Codebase Manager"
  homepage "https://unisonweb.org"
  license "MIT"

  version_scheme 2
  version "1.1.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/unisonweb/unison/releases/download/release%2F1.1.1/ucm-macos-x64.tar.gz"
      sha256 "7fabccb6f83607b522fdf2661001519784b1a616d65c8ba9ddd3a23a77056266"
      head "https://github.com/unisonweb/unison/releases/download/trunk-build/ucm-macos-x64.tar.gz"
    elsif Hardware::CPU.arm?
      url "https://github.com/unisonweb/unison/releases/download/release%2F1.1.1/ucm-macos-arm64.tar.gz"
      sha256 "f221c6b8168669291b41568310770350c8b1efd3b6bcb40d68734fccdf64b7ff"
      head "https://github.com/unisonweb/unison/releases/download/trunk-build/ucm-macos-arm64.tar.gz"
    else
      odie "Unsupported architecture for ucm"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/unisonweb/unison/releases/download/release%2F1.1.1/ucm-linux-x64.tar.gz"
      sha256 "f2c8b5a1e98f0cf1dd59419251712c9628792bacff71d2e28f0ca6377d4dd8d8"
      head "https://github.com/unisonweb/unison/releases/download/trunk-build/ucm-linux-x64.tar.gz"
    elsif Hardware::CPU.arm?
      url "https://github.com/unisonweb/unison/releases/download/release%2F1.1.1/ucm-linux-arm64.tar.gz"
      sha256 "92aa921582a83fc73ca096a85702de161308b856366b5ba550fa5978657914c6"
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
