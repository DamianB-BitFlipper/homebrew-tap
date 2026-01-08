class ProtonDriveSyncRc < Formula
  desc "Sync local directories to Proton Drive cloud storage (pre-release)"
  homepage "https://github.com/DamianB-BitFlipper/proton-drive-sync"
  version "0.2.1-rc.8"
  license "GPL-3.0"

  on_macos do
    on_arm do
      url "https://github.com/DamianB-BitFlipper/proton-drive-sync/releases/download/v#{version}/proton-drive-sync-darwin-arm64.tar.gz"
      sha256 "9f0cb38d09b963d912ab51749b4b2c9b6203ca6b3947ddc84045bf5b5b5c7fc5"
    end
    on_intel do
      url "https://github.com/DamianB-BitFlipper/proton-drive-sync/releases/download/v#{version}/proton-drive-sync-darwin-x64.tar.gz"
      sha256 "afae849ff305c243703e6f17b3b330e8f2a697a1b43b00ec0ac80ea71b81e59f"
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
