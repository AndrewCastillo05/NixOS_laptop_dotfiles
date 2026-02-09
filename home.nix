{ config, pkgs, ...}:

{
	home.username = "god";
	home.homeDirectory = "/home/god";
	home.stateVersion = "25.11";

	programs.bash = {
		enable = true;
		shellAliases = {
			nrs = "sudo nixos-rebuild switch";
		};
		initExtra = ''
			export PS1='\u in \W \\$ '
		'';
	};
	
	programs.git = {
		enable = true;
		settings = {
			user = {
				name = "god";
				email = "andrew.castillo05169@gmail.com";
			};
			init.defaultBranch = "main";
			safe.directory = "/etc/nixos";
		};
	};

	programs.kitty = {
		enable = true;
		font.size = 11.0;
		font.name = "fira-code";
		font.package = pkgs.fira-code;
		settings = {
			background_opacity = 0.5;
			scrollback_lines = 200;
			scrollbar = "always";
			scrollbar_interactive = "yes";
			scrollbar_jump_on_click = "yes";
			scrollbar_radius = 0;
		};
	};
	
	home.pointerCursor = {
		#hyprcursor = {
		#	enable = true;
		#	size = 32;
		#};
		package = pkgs.rose-pine-cursor;
		size = 24;
		name = "cursor-dark";
	};

	home.packages = with pkgs; [
		bat
		fira-code
		rose-pine-cursor
	];
}
