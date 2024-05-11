class UnisonLanguage < Formula
  desc "Unison [Language] Codebase Manager"
  homepage "https://unisonweb.org"
  license "MIT"

  revision 2
  version_scheme 1

  head do
    url "https://github.com/unisonweb/unison/releases/download/trunk-build/ucm-macos.tar.gz" if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/trunk-build/ucm-linux.tar.gz" if OS.linux?
  end

  option "with-compile-native", "experimental support for `compile.native` (requires --HEAD)"
  depends_on "minimal-racket" if build.with? "compile-native"
  depends_on "fzf" => :recommended

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.19/ucm-macos.tar.gz"
    sha256 "fff6e3a665b8e41a811e60488f6b8c6a161062384d27c86f1a1f8effba1840e9"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.19/ucm-linux.tar.gz"
    sha256 "dd6ca257a988ba8e460e90cafca75632f8f6dac677ba9875e6edefdd35f96190"
  end

  def install
    if build.head?
      libexec.install "unison/unison"
      libexec.install "runtime"
      pkgshare.install "ui"

      if build.with? "compile-native"
        pkgshare.install "racket"
        ENV["PLTUSERHOME"] = pkgshare/"racket"/"home"
        ohai "Installing Racket unison library"
        ohai "#{pkgshare}/racket/unison.zip"
        system "raco", "pkg", "install", "--scope", "user", "--auto", "#{pkgshare}/racket/unison.zip"
        ohai "Installing Racket compiler-lib library"
        system "raco", "pkg", "install", "--scope", "user", "--auto", "--skip-installed", "compiler-lib"

        (bin/"ucm").write <<~EOS
          #!/bin/bash

          export PLTUSERHOME="#{pkgshare}/racket/home"
          UCM_WEB_UI="#{opt_share}/ui" \\
            #{opt_libexec}/unison \\
              --runtime-path #{opt_libexec}/runtime/bin/unison-runtime \\
              "$@"
        EOS
      else
        (bin/"ucm").write <<~EOS
          #!/bin/bash

          # This installation is not set up for `compile.native`.

          UCM_WEB_UI="#{opt_share}/ui" \\
            #{opt_libexec}/unison \\
              --runtime-path #{opt_libexec}/runtime/bin/unison-runtime \\
              "$@"
        EOS
      end
    else
      odie "Option `--with-compile-native` requires --HEAD" if build.with? "compile-native"
      prefix.install Dir["*"]
      bin.install_symlink prefix/"ucm"
    end
  end

  test do
    if build.head?
      ohai "Setting up project and downloading base..."
      (testpath/"setup.md").write <<~EOS
        ```ucm
        .> project.create proj
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
    else
      (testpath/"getbase.md").write <<~EOS
        ```ucm
        .> pull https://github.com/unisonweb/base:.releases._latest .base
        ```
      EOS
      system "ucm", "transcript", testpath/"getbase.md"
    end
  end
end
