class Ltree2viz < Formula
  desc "Turn a Postgres ltree table into a Mermaid diagram"
  homepage "https://github.com/Orbasker/ltree2viz"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Orbasker/ltree2viz/releases/download/v0.1.0/ltree2viz-aarch64-apple-darwin.tar.xz"
      sha256 "7765c1a4538fbcef4b6074ab29f5d474ff57c38e87ff95279925bf67134f2fd5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Orbasker/ltree2viz/releases/download/v0.1.0/ltree2viz-x86_64-apple-darwin.tar.xz"
      sha256 "07bf20c6cb4b4d2870a1963971c3c6576c0a10465d9c6804a81c7abcc5c343e6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Orbasker/ltree2viz/releases/download/v0.1.0/ltree2viz-aarch64-unknown-linux-musl.tar.xz"
      sha256 "9f5529f7338f965d57103b5ad6efa6e3c2e66041a3544031f306c6cebf9c665e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Orbasker/ltree2viz/releases/download/v0.1.0/ltree2viz-x86_64-unknown-linux-musl.tar.xz"
      sha256 "856398f9bf4f49179ce411a7c4c11ae59867d164e943e6a491a6beeb07312083"
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
