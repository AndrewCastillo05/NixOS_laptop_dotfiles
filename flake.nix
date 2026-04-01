{
	inputs = {
		nixos-hardware.url = "github:NixOS/nixos-hardware/master";
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		nix-matlab = {
			inputs.nixpkgs.follows = "nixpkgs";
			url = "gitlab:doronbehar/nix-matlab";
		};
		# ...
	};
	
	# ...

	outputs = { self, nixpkgs, nix-matlab, ... }@inputs:
	let
		flake-overlays = [
			nix-matlab.overlay
		];
	in {
		nixosConfigurations = {
			god = nixpkgs.lib.nixosSystem {
				modules = [ ( import
					./configuration.nix
					flake-overlays )
				];
			};
		};
	};
}
