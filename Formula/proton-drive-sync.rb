class ProtonDriveSync < Formula
  desc "Sync local directories to Proton Drive cloud storage"
  homepage "https://github.com/DamianB-BitFlipper/proton-drive-sync"
  version "0.2.2"
  license "GPL-3.0"

  on_macos do
    on_arm do
      url "https://github.com/DamianB-BitFlipper/proton-drive-sync/releases/download/v#{version}/proton-drive-sync-darwin-arm64.tar.gz"
      sha256 "da9fbca7c6b0482345d88eedd810a83f5af42a277d63acfc8742ce126fc7543e" # MAC_ARM_SHA256
    end
    on_intel do
      url "https://github.com/DamianB-BitFlipper/proton-drive-sync/releases/download/v#{version}/proton-drive-sync-darwin-x64.tar.gz"
      sha256 "4b76dc8e5a80a17389f78f7f048d042250bcc30fa0e1a8b30164f884a91119f0" # MAC_INTEL_SHA256
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/DamianB-BitFlipper/proton-drive-sync/releases/download/v#{version}/proton-drive-sync-linux-arm64.tar.gz"
      sha256 "" # LINUX_ARM_SHA256
    end
    on_intel do
      url "https://github.com/DamianB-BitFlipper/proton-drive-sync/releases/download/v#{version}/proton-drive-sync-linux-x64.tar.gz"
      sha256 "" # LINUX_INTEL_SHA256
    end
  end

  def install
    bin.install "proton-drive-sync"
  end

  def uninstall
    # Stop and uninstall service
    system bin/"proton-drive-sync", "service", "uninstall", "-y"
    # Clear credentials from keychain
    system bin/"proton-drive-sync", "auth", "--logout"
    # Delete all user data
    system bin/"proton-drive-sync", "reset", "--purge", "-y"
  end

  def caveats
    <<~EOS
      To complete setup, run:
        proton-drive-sync setup

      This will guide you through authentication and service configuration.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/proton-drive-sync --version")
  end
end
