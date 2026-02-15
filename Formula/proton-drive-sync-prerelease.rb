class ProtonDriveSyncPrerelease < Formula
  desc "Sync local directories to Proton Drive cloud storage (pre-release)"
  homepage "https://github.com/DamianB-BitFlipper/proton-drive-sync"
  version "0.2.3-beta.3"
  license "GPL-3.0"

  on_macos do
    on_arm do
      url "https://github.com/DamianB-BitFlipper/proton-drive-sync/releases/download/v#{version}/proton-drive-sync-darwin-arm64.tar.gz"
      sha256 "ab49191e2da4a61526b0c06f66aaacf628b9a18e3f1863862b9ecbdf5b79b552" # MAC_ARM_SHA256
    end
    on_intel do
      url "https://github.com/DamianB-BitFlipper/proton-drive-sync/releases/download/v#{version}/proton-drive-sync-darwin-x64.tar.gz"
      sha256 "971c34573b3f4e1213024ba5b433e2e118a9501f3ebe6a8773585a74c60f9d8e" # MAC_INTEL_SHA256
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/DamianB-BitFlipper/proton-drive-sync/releases/download/v#{version}/proton-drive-sync-linux-arm64.tar.gz"
      sha256 "accb3852f0ba29ba5e73d6fb341ae7cf77a0988ac63e08e0979a1bc40267075e" # LINUX_ARM_SHA256
    end
    on_intel do
      url "https://github.com/DamianB-BitFlipper/proton-drive-sync/releases/download/v#{version}/proton-drive-sync-linux-x64.tar.gz"
      sha256 "522f3946fa9e9d617496afe5d6f989b74050cdab7f5b6279f47f7f51313895be" # LINUX_INTEL_SHA256
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
