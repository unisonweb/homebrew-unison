class UnisonLanguage < Formula
  desc "Unison [Language] and Codebase Manager"
  homepage "https://unisonweb.org"
  license "MIT"

  version_scheme 2
  version "0.5.46"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.46/ucm-macos-x64.tar.gz"
      sha256 "e1411247d43d9866b31311892695619e4cb5b5edf6f8523c5632b0c16ddde5bd"
      head "https://github.com/unisonweb/unison/releases/download/trunk-build/ucm-macos-x64.tar.gz"
    elsif Hardware::CPU.arm?
      url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.46/ucm-macos-arm64.tar.gz"
      sha256 "34cbd2366335b80508bfd9ee7f80569cd56649ce37affd36095ebf36fae26faa"
      head "https://github.com/unisonweb/unison/releases/download/trunk-build/ucm-macos-arm64.tar.gz"
    else
      odie "Unsupported architecture for ucm"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.46/ucm-linux-x64.tar.gz"
      sha256 "0c408f16e5c0e98f4f046faaccc9d3fed209db6fa8167dd79f0d0c6786f1b763"
      head "https://github.com/unisonweb/unison/releases/download/trunk-build/ucm-linux-x64.tar.gz"
    elsif Hardware::CPU.arm?
      url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.46/ucm-linux-arm64.tar.gz"
      sha256 "a44e6e5d2da762fb184787dc669ec055f789f3c5ed1eeb6170e4c67b9e383e3d"
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
