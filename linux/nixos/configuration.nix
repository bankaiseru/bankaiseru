{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "ice";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  networking.networkmanager.dns = "none";
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  #services.displayManager.ly.enable = true;

  services.displayManager = {
    sddm = {
      enable = true;
    };
   
    autoLogin = {
      enable = true;
      user = "bankaiseru";
    };
   
    defaultSession = "hyprland";
  };

  time.timeZone = "Europe/Moscow";

  users.users.bankaiseru = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish; 
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };

  services.xserver.enable = true;

  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    git
    alacritty
    vim
    vscode
    bibata-cursors
    quickshell
    thunar
    thunar-volman
    nwg-look
    adwaita-icon-theme
    gnome-themes-extra
    hyprshot
    zip
    unzip
    blueman
    orchis-theme
    papirus-icon-theme
    curl
    obsidian
    ipset
  ];

  programs.thunar.plugins = with pkgs; [
    thunar-volman
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.udisks2.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  hardware.bluetooth.enable = true;

  programs.dconf.enable = true;

  systemd.services.zapret = {
    description = "Zapret DPI bypass service";
    after = [ "network.target" "networkmanager.service" "firewall.service" ];
    wantedBy = [ "multi-user.target" ];
    path = with pkgs; [ iptables ipset gawk coreutils ];
    serviceConfig = {
      Type = "forking";
      ExecStart = "/opt/zapret/init.d/sysv/zapret start";
      ExecStop = "/opt/zapret/init.d/sysv/zapret stop";
      RemainAfterExit = true;
      Restart = "on-failure";
    };
  };

  system.stateVersion = "26.05";
}
