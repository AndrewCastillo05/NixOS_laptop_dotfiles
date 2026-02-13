# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
	home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz";
	tex = (pkgs.texliveMedium.withPackages (
		ps: with ps; [
			background
			everypage

		])
	);
in
{

  # nixos nvidia driver hardware configuration added via nixos-hardware channel following guide at
  # https://gitub.com/NixOS/nixos-hardware/tree/master
  imports =
    [ # Include the results of the hardware scan.
      <nixos-hardware/lenovo/thinkpad/p1/3th-gen>
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];

  # setup home-manager variables. will import home.nix for further specs
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.god = import ./home.nix;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "god"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  hardware.bluetooth = {
  	enable = true;
	powerOnBoot = true;
	settings = {
		General = {
			Experimental = true;
		};
	};
  };
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.god = {
    isNormalUser = true;
    description = "overlord";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # List Fonts installed in system profile.
  fonts.packages = with pkgs; [
  	noto-fonts
	noto-fonts-color-emoji
	liberation_ttf
	fira-code
	fira-code-symbols
	mplus-outline-fonts.githubRelease
	dina-font
	proggyfonts
	font-awesome
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	bluez			# required for bluetooth file transfer
	bluez-tools		# required for bluetooth file transfer
	calibre			# E-Book Viewer
	clipman			# clipboard manager for wayland. Supports copy/pase text only
	fastfetch		# like neofetch, but supported
	feh			# CLI focused Image Viewer
	firefox			# Spyware
	gimp			# GNU Image Manipulation Program; photoshop without painting or a price
	git			# Send your files to the little angels in the sky
	gnvim			# a gui version of neovim. good for use with octave
	greetd			# login manager alternative to ly
	htop			# CLI process viewer
	hunspell		# package used for spell-checking in libreoffice
	hunspellDicts.en_US	# us english spell-check package
	hyphenDicts.en_US	# us english spell-check for hyphenation package
	hyprland		# tiling window manager
	hyprpaper		# wallpaper manager for hyprland
	hyprcursor		# cursor customization software
	hyprpolkitagent		# If a program needs root permissions, this daemon handles them
	inkscape		# FOSS Vector Graphics development and editing software
	jre_minimal		# a minimal version of the Java Runtime Environment
	jre8			# an open-source Java Development Kit
	kitty			# terminal
	krita			# FOSS painting software
	krusader		# File browser made for use in the gnome DE, though works here too
	libreoffice		# A FOSS office suite
	librewolf		# Firefox without the spyware
	logseq			# note taking application for the mentally unsound
	mako 			# starts the mako daemon, which is used to push notifications
	mpv 			# plays video files. super configurable
	nemo-with-extensions	# file browser; fork of nautilus
	neovim			# text editor for the mentally unsound programmer
	obexfs			# tool for mounting obex-based devices (like bluetooth phones)
	obexftp			# library and tool for accessing files on obex-based devices (c.f., up)
	octaveFull		# yippee, octave!!
	p7zip			# software for compressing and uncompressing 7zip archives
	pipewire		# API for dealing with multimedia pipelines
	ranger			# File browser inspired by vim
	rose-pine-cursor	# a backup cursor, for when hyprcursor is being a baby (always)
	rose-pine-hyprcursor	# A basic cursor for use with the hyprcursor package
	tex
	texstudio		# LaTeX writer. Makes using LaTeX less painful.
	udiskie			# An automatic USB mass storage device mounting daemon
	unzip			# file decompression software
	waybar			# Status bar for wayland window managers
	wget			# CLI utility for downloading files
	wireplumber		# session/policy manager for pipewire
	wofi 			# Software starter library
	xapp-symbolic-icons	# XSI icons - an alternative to adwaita icons for non-gnome applications
	xdg-desktop-portal-hyprland	# xdg-desktop-portal backend for Hyprland
	zip			# file compression software
	

	font-awesome		# font package filled with symbols for applications
  	noto-fonts		# font package filled with a ton of super versatile fonts
	noto-fonts-color-emoji	# font package containing nearly all emojis
	liberation_ttf		# font package containing alternatives to common formal fonts
	fira-code		# A free and open-source monospaced font made for programming
	fira-code-symbols	# A free and open-source monospaced symbol font
	mplus-outline-fonts.githubRelease	# A large collection of fonts for typesetting
	dina-font		# an old-school font for old-school applications
  ];

  programs.neovim = {
  	enable = true;
	defaultEditor = true;
	viAlias = true;
	vimAlias = true;
	configure = {
		customRC = ''
			set runtimepath^=${pkgs.vimPlugins.jellybeans-vim}
			colorscheme jellybeans
			set number
			set cc=80
			set list
			set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
      			if &diff
        			colorscheme blue
      			endif
    			'';
		packages.myVimPackage = with pkgs.vimPlugins; {
			start = [ctrlp];
		};
	};
  };

  # enable Hyprland
  programs.hyprland.enable = true;

  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
 services.greetd = {
  	enable = true;
	settings.default_session.command = "${pkgs.tuigreet}/bin/tuigreet --xsessions ${config.services.displayManager.sessionData.desktops}/share/xsessions --sessions  ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --remember --remember-user-session --user-menu-min-uid 1000 --asterisks --power-shutdown 'shutdown -P now' --power-reboot 'shutdown -r now'";
	};
  services.udisks2.enable = true;
  services.blueman.enable = true; 
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # GPU PCI Bus Devices and Bus IDs
  # 00:02.0 Intel Corporation CometLake-H GT2 [UHD Graphics] (rev 05)
  # 01:00.0 Nvidia Corporation TU117GLM [Quadro T2000 Mobile / Max-Q] (rev a1)

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment
 
}
