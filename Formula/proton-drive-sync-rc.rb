class ProtonDriveSyncRc < Formula
  desc "Sync local directories to Proton Drive cloud storage (pre-release)"
  homepage "https://github.com/DamianB-BitFlipper/proton-drive-sync"
  version "0.2.2-beta.1"
  license "GPL-3.0"

  on_macos do
    on_arm do
      url "https://github.com/DamianB-BitFlipper/proton-drive-sync/releases/download/v#{version}/proton-drive-sync-darwin-arm64.tar.gz"
      sha256 "d31ab1c5729d9eb4369fce65e21e557318253839a475fe54306118dc3b10ef49"
    end
    on_intel do
      url "https://github.com/DamianB-BitFlipper/proton-drive-sync/releases/download/v#{version}/proton-drive-sync-darwin-x64.tar.gz"
      sha256 "517c9114601f3b6b561a8b2e8dc4c2fdecb37d3d45f9d5d64d2c9b85d0ceb639"
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
