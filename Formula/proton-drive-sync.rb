class ProtonDriveSync < Formula
  desc "Sync local directories to Proton Drive cloud storage"
  homepage "https://github.com/DamianB-BitFlipper/proton-drive-sync"
  version "0.2.4"
  license "GPL-3.0"

  on_macos do
    on_arm do
      url "https://github.com/DamianB-BitFlipper/proton-drive-sync/releases/download/v#{version}/proton-drive-sync-darwin-arm64.tar.gz"
      sha256 "0cd2f047eac44ad70d3588f0bb38201d9562e2971d02d81f95068d688ee2ce60" # MAC_ARM_SHA256
    end
    on_intel do
      url "https://github.com/DamianB-BitFlipper/proton-drive-sync/releases/download/v#{version}/proton-drive-sync-darwin-x64.tar.gz"
      sha256 "0fb2caa498bcc0b4740b88d77bead4dfd131d5f3fdd69345ac308a5c67cf9e15" # MAC_INTEL_SHA256
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/DamianB-BitFlipper/proton-drive-sync/releases/download/v#{version}/proton-drive-sync-linux-arm64.tar.gz"
      sha256 "40ed3dbe5ccd7513c7c02068dab27e17c765abffe34b5c21417fe2b1838a3bcf" # LINUX_ARM_SHA256
    end
    on_intel do
      url "https://github.com/DamianB-BitFlipper/proton-drive-sync/releases/download/v#{version}/proton-drive-sync-linux-x64.tar.gz"
      sha256 "c73ae43648d6ff710de83b9477e1df9628d7b7ad601245c37bec361228301994" # LINUX_INTEL_SHA256
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
