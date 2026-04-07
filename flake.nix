{
	description = "NixOS configuration";
	inputs = {
		
		# Unofficial NixOS Packages sources
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		# Home-Manager
		nixos-hardware.url = "github:NixOS/nixos-hardware/master";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# Matlab functionality patch
		nix-matlab = {
			url = "gitlab:doronbehar/nix-matlab"; 
			inputs.nixpkgs.follows = "nixpkgs";
		};
		# ...
	};
	
	outputs = inputs@{ self, nixpkgs, home-manager, nix-matlab, ... }:
	let
		flake-overlays = [ nix-matlab.overlay ];
	in {
		nixosConfigurations = {
			god = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					(import ./configuration.nix flake-overlays)
					home-manager.nixosModules.default
					{
						home-manager = {
							useGlobalPkgs = true;
							useUserPackages = true;
							backupFileExtension = "backup";
							users.god = import ./home.nix;
						};
						
					}
				];
			};
		};
	};
}
