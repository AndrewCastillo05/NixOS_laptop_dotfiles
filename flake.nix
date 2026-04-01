{
	inputs = {
		# ...
		nix-matlab = {
			inputs.nixpkgs.follows = "nixpkgs";
			url = "gitlab:doronbehar/nix-matlab";
		};
		# ...
	};
	
	# ...

	outputs = { self, nixpkgs, nix-matlab }:
	let
		flake-overlays = [
			nix-matlab.overlay
		];
	in {
		nixosConfigurations = {
			hostname: = nixpkgs.lib.nixosSystem {
				modules = [
					(import 
					./configuration.nix
					hostname
					flake-overlays
					)
				];
			};
		};
	};
}
