class Ltree2viz < Formula
  desc "Visualize a Postgres ltree hierarchy as a Mermaid diagram or interactive HTML tree"
  homepage "https://github.com/Orbasker/ltree2viz"
  version "0.1.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Orbasker/ltree2viz/releases/download/v0.1.8/ltree2viz-aarch64-apple-darwin.tar.xz"
      sha256 "a509598f3dff9b86f528f6bb19db3ed5a07a07043286a31672fa4ad4af28c1d2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Orbasker/ltree2viz/releases/download/v0.1.8/ltree2viz-x86_64-apple-darwin.tar.xz"
      sha256 "572f4c9555f0afc1811fde1761d3a8a0e801fe2d4ffed67978b7cf6c71a51704"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Orbasker/ltree2viz/releases/download/v0.1.8/ltree2viz-aarch64-unknown-linux-musl.tar.xz"
      sha256 "64a980d6c2c9e9207faf51ad7c277ac46fdd322205d4a92f329899c34d1c5672"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Orbasker/ltree2viz/releases/download/v0.1.8/ltree2viz-x86_64-unknown-linux-musl.tar.xz"
      sha256 "4da72eb982772872b8265ee4ecb1a1c5a146cfd366be06c570b47bdd8ff6530f"
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
