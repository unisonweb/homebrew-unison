class UnisonLanguage < Formula
  desc "Unison [Language] and Codebase Manager"
  homepage "https://unisonweb.org"
  license "MIT"

  version_scheme 2
  version "0.5.47"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.47/ucm-macos-x64.tar.gz"
      sha256 "164a2eabf8efd0376fd448d112d8868cc004a9d368c70bf89eaaa9fe7c1ffb38"
      head "https://github.com/unisonweb/unison/releases/download/trunk-build/ucm-macos-x64.tar.gz"
    elsif Hardware::CPU.arm?
      url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.47/ucm-macos-arm64.tar.gz"
      sha256 "39cab087e907e2d2cc4ccb616decc3074a34d134c5fddea7f02cd0c51f75f610"
      head "https://github.com/unisonweb/unison/releases/download/trunk-build/ucm-macos-arm64.tar.gz"
    else
      odie "Unsupported architecture for ucm"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.47/ucm-linux-x64.tar.gz"
      sha256 "462cd865a35d6970a47e21576e5077e1bb6a9aeeb1a37a302a44ae3ab828a48a"
      head "https://github.com/unisonweb/unison/releases/download/trunk-build/ucm-linux-x64.tar.gz"
    elsif Hardware::CPU.arm?
      url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.47/ucm-linux-arm64.tar.gz"
      sha256 "11338c5fe784e01083b2baa4ef398db215ab7ade9902ef39e5fac4f83b97efaa"
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
