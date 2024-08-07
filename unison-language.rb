class UnisonLanguage < Formula
  desc "Unison [Language] and Codebase Manager"
  homepage "https://unisonweb.org"
  license "MIT"

  version_scheme 1

  if OS.mac?
    url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.25/ucm-macos.tar.gz"
    sha256 "4dcf5761609aa7737d297e64e8cf372f579fc33d9c1b76e6bf9b72638cee14f4"
    head "https://github.com/unisonweb/unison/releases/download/trunk-build/ucm-macos.tar.gz"
  elsif OS.linux?
    url "https://github.com/unisonweb/unison/releases/download/release%2F0.5.25/ucm-linux.tar.gz"
    sha256 "235508930c70fde3eff1d5854f8a3f152698b8119bbe8554464e6c1d7ee0b4be"
    head "https://github.com/unisonweb/unison/releases/download/trunk-build/ucm-linux.tar.gz"
  end

  option "with-compile-native", "experimental support for `compile.native`"
  depends_on "minimal-racket" if build.with? "compile-native"
  depends_on "fzf" => :recommended

  def install
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
  end
end
