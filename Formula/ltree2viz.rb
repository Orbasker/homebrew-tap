class Ltree2viz < Formula
  desc "Turn a Postgres ltree table into a Mermaid diagram"
  homepage "https://github.com/Orbasker/ltree2viz"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Orbasker/ltree2viz/releases/download/v0.1.3/ltree2viz-aarch64-apple-darwin.tar.xz"
      sha256 "c1bd72144a9e0a568aaaedc3d3696e5060adb432f21019e675235fb1d1007d71"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Orbasker/ltree2viz/releases/download/v0.1.3/ltree2viz-x86_64-apple-darwin.tar.xz"
      sha256 "f4f12234ae18bcada01bff479bd6ab430305be90936c5ceae5cfcfddbaa6b7fa"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Orbasker/ltree2viz/releases/download/v0.1.3/ltree2viz-aarch64-unknown-linux-musl.tar.xz"
      sha256 "fa08418766ff5be603c99c1261d1493cc3e51b45cbd91efabceee63179d3ff6c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Orbasker/ltree2viz/releases/download/v0.1.3/ltree2viz-x86_64-unknown-linux-musl.tar.xz"
      sha256 "613f58b6c103361b7d92c6d6112928681f0f6a2fd7bdd78cec99785f13a97b48"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "ltree2viz"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ltree2viz"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ltree2viz"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ltree2viz"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
