class UnisonLanguage < Formula
  desc "Unison [Language] and Codebase Manager"
  homepage "https://unisonweb.org"
  license "MIT"

  version_scheme 2
  version "0.5.36"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.36/ucm-macos-x64.tar.gz"
      sha256 "b1e2fc132db429856c38bba01af7d55d720855dbfbab4e0f61787773a3286439"
      head "https://github.com/unisonweb/unison/releases/download/trunk-build/ucm-macos-x64.tar.gz"
    elsif Hardware::CPU.arm?
      url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.36/ucm-macos-arm64.tar.gz"
      sha256 "187d2a66d6f6f6a0f12f7f6702b612cc2439d3fb2c3ce88df425e702f6fdb954"
      head "https://github.com/unisonweb/unison/releases/download/trunk-build/ucm-macos-arm64.tar.gz"
    else
      odie "Unsupported architecture for ucm"
    end
  end

  on_linux do
    url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.36/ucm-linux-x64.tar.gz"
    sha256 "65bf758b15dddee7908faf988c2f5682adcf9df70a04a65974225f4b49d0395e"
    head "https://github.com/unisonweb/unison/releases/download/trunk-build/ucm-linux-x64.tar.gz"
  end

  option "with-compile-native", "experimental support for `compile.native`"
  if build.with? "compile-native"
    depends_on "libb2"
  end
  depends_on "fzf" => :recommended

  def install
    libexec.install "unison/unison"
    libexec.install "runtime"
    pkgshare.install "ui"

    if build.with? "compile-native"
      resource "minimal-racket" do
        if OS.linux?
          url "https://download.racket-lang.org/releases/8.14/installers/racket-minimal-8.14-x86_64-linux-cs.tgz"
          sha256 "a1b5cab3adee21cd00219c7e85315c945db4eab11a6c80653db7687b11c993f0"
        elsif OS.mac?
          if Hardware::CPU.intel?
            url "https://download.racket-lang.org/releases/8.14/installers/racket-minimal-8.14-x86_64-macosx-cs.tgz"
            sha256 "168644f90c09b5474a84293e0f81a4b9b2c165cdabb3a5e595953f6b956ec1ed"
          elsif Hardware::CPU.arm?
            url "https://download.racket-lang.org/releases/8.14/installers/racket-minimal-8.14-aarch64-macosx-cs.tgz"
            sha256 "5d3e0c94668889ffb744fa99f7e787b1352de6b30587665cf0a80d34f02e421a"
          else
            odie "Unsupported architecture for racket"
          end
        else
          odie "Unsupported OS"
        end
      end

      resource("minimal-racket").stage do
        (libexec/"racket").install Dir["*"]
        (libexec/"racket/lib").install_symlink Formula["libb2"].lib/"libb2.1.dylib"
      end

      raco = "#{libexec}/racket/bin/raco"

      ohai "Installing Racket unison library"
      pkgshare.install "racket"
      jitlib = "#{pkgshare}/racket/unison.zip"
      system raco, "pkg", "install", "--scope", "installation", "--auto", jitlib

      ohai "Installing Racket compiler-lib library"
      system raco, "pkg", "install", "--scope", "installation", "--auto", "--skip-installed", "compiler-lib"

      (bin/"ucm").write <<~EOS
        #!/bin/bash

        PATH="#{opt_libexec}/racket/bin:$PATH" \\
        UCM_WEB_UI="#{pkgshare}/ui" \\
          #{opt_libexec}/unison \\
            --runtime-path #{opt_libexec}/runtime/bin/unison-runtime \\
            "$@"
      EOS
    else
      (bin/"ucm").write <<~EOS
        #!/bin/bash

        # This installation is not set up for `compile.native`.

        UCM_WEB_UI="#{pkgshare}/ui" \\
          #{opt_libexec}/unison \\
            --runtime-path #{opt_libexec}/runtime/bin/unison-runtime \\
            "$@"
      EOS
    end
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
      ```ucm
      proj/main> run.native helloWorld
      ```
    EOS
    system "ucm", "transcript.fork", "--codebase", testpath/"codebase", testpath/"run.md"

    if build.with? "compile-native"
      ohai "Compiling helloWorld..."
      (testpath/"compile.md").write <<~EOS
        ```ucm
        proj/main> compile.native helloWorld #{testpath/"helloWorld"}
        ```
      EOS
      system "ucm", "transcript.fork", "--codebase", testpath/"codebase", testpath/"compile.md"
      assert_match "Hello, World!\n", shell_output("#{testpath}/helloWorld")
    else
      ohai "Skipping `compile.native` test, as it requires `--with-compile-native`."
    end
  end
end
