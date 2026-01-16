class ProtonDriveSyncPrerelease < Formula
  desc "Sync local directories to Proton Drive cloud storage (pre-release)"
  homepage "https://github.com/DamianB-BitFlipper/proton-drive-sync"
  version "0.2.3-beta.1"
  license "GPL-3.0"

  on_macos do
    on_arm do
      url "https://github.com/DamianB-BitFlipper/proton-drive-sync/releases/download/v#{version}/proton-drive-sync-darwin-arm64.tar.gz"
      sha256 "0f1782abb6236ef29f47154949ceab6cb778ec9d0fee79948bf4951f7c8604b2" # MAC_ARM_SHA256
    end
    on_intel do
      url "https://github.com/DamianB-BitFlipper/proton-drive-sync/releases/download/v#{version}/proton-drive-sync-darwin-x64.tar.gz"
      sha256 "eed306b40aa86d8d926b6579bd43cb4cf7338deb2caba6ebbdae887280c0e722" # MAC_INTEL_SHA256
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/DamianB-BitFlipper/proton-drive-sync/releases/download/v#{version}/proton-drive-sync-linux-arm64.tar.gz"
      sha256 "9afa2ee23550b1190ae742117e12f2d5ffb4c7a59c3ba0bda3cac05b3a83ba1c" # LINUX_ARM_SHA256
    end
    on_intel do
      url "https://github.com/DamianB-BitFlipper/proton-drive-sync/releases/download/v#{version}/proton-drive-sync-linux-x64.tar.gz"
      sha256 "00deed06f5309f6e1f311ceb71964049cf7dbff7eb12ebcbca04fa44683067f0" # LINUX_INTEL_SHA256
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
      This is a pre-release version (RC/alpha/beta).
      For the stable release, use: brew install proton-drive-sync

      To complete setup, run:
        proton-drive-sync setup

      This will guide you through authentication and service configuration.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/proton-drive-sync --version")
  end
end
