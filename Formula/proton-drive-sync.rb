class ProtonDriveSync < Formula
  desc "Sync local directories to Proton Drive cloud storage"
  homepage "https://github.com/DamianB-BitFlipper/proton-drive-sync"
  version "0.2.0"
  license "GPL-3.0"

  on_macos do
    on_arm do
      url "https://github.com/DamianB-BitFlipper/proton-drive-sync/releases/download/v#{version}/proton-drive-sync-darwin-arm64.tar.gz"
      sha256 "283932bf045b16229dbfe0023c8b6e09b24a3848268ed718f69c2791d8237dbe"
    end
    on_intel do
      url "https://github.com/DamianB-BitFlipper/proton-drive-sync/releases/download/v#{version}/proton-drive-sync-darwin-x64.tar.gz"
      sha256 "1a4952d112cd34fa376bc97e60e3502c57f1c67df1d51ab51577fd7e40d268fd"
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
