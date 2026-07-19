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

  # Загрузчик
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Сеть
  networking.hostName = "ice";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  networking.networkmanager.dns = "none";
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  # Дисплейный менеджер и автологин
  services.displayManager = {
    sddm.enable = true;
    autoLogin = {
      enable = true;
      user = "bankaiseru";
    };
    defaultSession = "hyprland";
  };

  # Таймзона
  time.timeZone = "Europe/Moscow";

  # Пользователи
  users.users.bankaiseru = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish; 
    packages = with pkgs; [
      tree
    ];
  };

  # Программы и окружение
  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs.dconf.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };

  services.xserver.enable = true;
  nixpkgs.config.allowUnfree = true;

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

  # Экспериментальные функции Nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Системные службы и питание
  services.udisks2.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  hardware.bluetooth.enable = true;

  # Включение аппаратного ускорения (GPU) для устранения лагов интерфейса
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Фикс прорисовки текста: делаем шрифты резкими без двухэтапного размытия
  fonts.fontconfig = {
    enable = true;
    subpixel = {
      rgba = "rgb";
      lcdfilter = "default";
    };
    hinting = {
      enable = true;
      style = "full";
    };
  };

  # Ограничение зарядки батареи Lenovo до 80% (Conservation Mode) через tmpfiles.d
  systemd.tmpfiles.settings = {
    "ideapad-conservation-mode" = {
      "/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode" = {
        "f+" = {
          group = "root";
          user = "root";
          mode = "0644";
          argument = "1"; # 1 — лимит включен, 0 — выключен
        };
      };
    };
  };

  # Сервис Zapret DPI bypass
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
