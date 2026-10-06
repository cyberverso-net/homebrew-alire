# Homebrew formula for Alire, the Ada/SPARK package manager.
# Installs the official binary release from the alire-project GitHub releases,
# as building alr from source requires an existing GNAT toolchain (bootstrap),
# which is not available in Homebrew. This is the standard approach for
# third-party taps.
class Alire < Formula
  desc "Package manager and toolchain installer for Ada and SPARK"
  homepage "https://alire.ada.dev"
  license "GPL-3.0-only"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/alire-project/alire/releases/download/v2.1.1/alr-2.1.1-bin-aarch64-macos.zip"
      sha256 "2c4867bfff3b95ecd9d846df460a52983d2b0072808b341f8fa5d82494fb309e"
    end
    on_intel do
      url "https://github.com/alire-project/alire/releases/download/v2.1.1/alr-2.1.1-bin-x86_64-macos.zip"
      sha256 "d3e16cdfaf0cfb2da62853b79b62910189fdca9d5fddc5c3ac5974ffc7d9544b"
    end
  end

  def install
    bin.install "bin/alr"
  end

  def caveats
    <<~EOS
      To install a GNAT toolchain and gprbuild, run:
        alr toolchain --select

      The SPARK proof tools are added per project with:
        alr with gnatprove
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/alr --version")
    system bin/"alr", "--non-interactive", "init", "--bin", "hellobrew"
    assert_path_exists testpath/"hellobrew/alire.toml"
  end
end
