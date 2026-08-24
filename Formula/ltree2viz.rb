class Ltree2viz < Formula
  desc "Visualize a Postgres ltree hierarchy as a Mermaid diagram or interactive HTML tree"
  homepage "https://github.com/Orbasker/ltree2viz"
  version "0.1.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Orbasker/ltree2viz/releases/download/v0.1.7/ltree2viz-aarch64-apple-darwin.tar.xz"
      sha256 "6136e1cf62d969835a9a9faa6de86eb2e7fe80479b6a20c4a2107e6c23fa55a4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Orbasker/ltree2viz/releases/download/v0.1.7/ltree2viz-x86_64-apple-darwin.tar.xz"
      sha256 "2bc614e37b24852f33b05380b959e91ff1e9fd3ac8de1cf10ab1491cfbac6bcb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Orbasker/ltree2viz/releases/download/v0.1.7/ltree2viz-aarch64-unknown-linux-musl.tar.xz"
      sha256 "6121d8d99f439c80fe35804030085ebb0501679a22d4ce545133f8627e78aa3d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Orbasker/ltree2viz/releases/download/v0.1.7/ltree2viz-x86_64-unknown-linux-musl.tar.xz"
      sha256 "677771a13c6f081018217882cda7416f3f4ebee599be91c253693ed813a3ea67"
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
