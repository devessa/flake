{
  pkgs,
  lib,
  config,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./sops.nix
  ];
  networking.hostName = "laptop";
  services.printing.enable = true;
  # hardware config
  boot.initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "vmd" "nvme" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/7d60759c-dcf8-4e73-a4c0-05e4dbcd2396";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-c35ecaf4-4de4-4514-8717-20c270b79d0a".device = "/dev/disk/by-uuid/c35ecaf4-4de4-4514-8717-20c270b79d0a";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/E3C1-FA2B";
    fsType = "vfat";
  };

  swapDevices = [];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp58s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  specialisation = {
    plugged-in.configuration = {
      # -- NVIDIA --
      services.xserver.videoDrivers = ["nvidia"]; # or "nvidiaLegacy470 etc.
      hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };

      hardware.nvidia = {
        modesetting.enable = true;
        prime = {
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
          # got buses from lshw
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
        };
        powerManagement.enable = false;
        powerManagement.finegrained = false;

        open = false;
        nvidiaSettings = true;
      };

      hardware.bluetooth.enable = true;
      hardware.bluetooth.powerOnBoot = true;
    };
  };
  nix.settings.experimental-features = ["nix-command" "flakes"];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = lib.mkForce pkgs.pinentry-gnome3;
  };
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
    };
  };

  # Hosts
  # TODO: Change to use correct IPs!
  networking.extraHosts = ''
    192.168.0.161 nmcs
    192.168.0.134 mcs
    192.168.0.120 idrac
    192.168.1.171 proxmox
    192.168.1.203 dockerzero
    192.168.1.40 pihole
  '';
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Audio
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.tailscale.enable = true;

  environment.sessionVariables = {
    # if ur cursor becomes invisble
    WLR_NO_HARDWARE_CURSORS = "1";
    # tell electron to use wayland
    NIXOS_OZONE_WL = "1";
  };
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-wlr
  ];
  system.stateVersion = "24.05";
}
