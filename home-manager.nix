{ config, pkgs, lib, ... }:
let
	home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz";
in
{
	imports = [
		(import "${home-manager}/nixos")
	];
	
	home-manager.useUserPackages = true;
	home-manager.useGlobalPkgs = true;
	home-manager.backupFileExtension = "backup";
	home-manager.users.god = import ./home.nix;

}
