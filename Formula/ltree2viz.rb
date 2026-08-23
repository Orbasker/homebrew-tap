class Ltree2viz < Formula
  desc "Turn a Postgres ltree table into a Mermaid diagram"
  homepage "https://github.com/Orbasker/ltree2viz"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Orbasker/ltree2viz/releases/download/v0.1.2/ltree2viz-aarch64-apple-darwin.tar.xz"
      sha256 "7af7107e07a8f74b6107b88ceb75746fd7e4308c89d4912cb23e84b764491bb7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Orbasker/ltree2viz/releases/download/v0.1.2/ltree2viz-x86_64-apple-darwin.tar.xz"
      sha256 "758b14ea0b5fbcdaf4fed57517bf108928e89248dd44c2610ef614461e17a2c2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Orbasker/ltree2viz/releases/download/v0.1.2/ltree2viz-aarch64-unknown-linux-musl.tar.xz"
      sha256 "9a0fa69776d3a7ac1f7044a89230f50242348b6d6973fd9ead217a22098c4bc4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Orbasker/ltree2viz/releases/download/v0.1.2/ltree2viz-x86_64-unknown-linux-musl.tar.xz"
      sha256 "3ee0763adc45401195e864fe0405f0b0b3415f24ab087848b2608d6f359d8c0f"
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
