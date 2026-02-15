class ProtonDriveSyncPrerelease < Formula
  desc "Sync local directories to Proton Drive cloud storage (pre-release)"
  homepage "https://github.com/DamianB-BitFlipper/proton-drive-sync"
  version "0.2.3-beta.2"
  license "GPL-3.0"

  on_macos do
    on_arm do
      url "https://github.com/DamianB-BitFlipper/proton-drive-sync/releases/download/v#{version}/proton-drive-sync-darwin-arm64.tar.gz"
      sha256 "16a6d016b15e5e7cfbe7d93144854c7278812650bfa4572e1698e5493046bee9" # MAC_ARM_SHA256
    end
    on_intel do
      url "https://github.com/DamianB-BitFlipper/proton-drive-sync/releases/download/v#{version}/proton-drive-sync-darwin-x64.tar.gz"
      sha256 "6e274b0a1b85267c6e43f962137316805e67d41c17234661672cde94a6305656" # MAC_INTEL_SHA256
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/DamianB-BitFlipper/proton-drive-sync/releases/download/v#{version}/proton-drive-sync-linux-arm64.tar.gz"
      sha256 "f261616275677cd29c7e9d6fec0d4f9f3d158ff1cedaf6ae01f17a494268095a" # LINUX_ARM_SHA256
    end
    on_intel do
      url "https://github.com/DamianB-BitFlipper/proton-drive-sync/releases/download/v#{version}/proton-drive-sync-linux-x64.tar.gz"
      sha256 "0bbb7b2599a2ac36e15aab9ce37406f3c2f372b6d4aacd41d9b8753a85cf3e3f" # LINUX_INTEL_SHA256
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
