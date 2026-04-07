{
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		viAlias = true;
		vimAlias = true;
		configure = {
			customRC = ''
				set number
                                set autoindent
                                set tabstop=8
                                set shiftwidth=8
                                set softtabstop=8
                                set smartcase
                                set showcmd
                                set showmode
                                set noexpandtab
                                set cursorline
                                set cursorcolumn
                                syntax on
                                set cc=80
                                set statusline=
                                set statusline+=\ %F\ %M\ %Y\ %R
                                set statusline +=%=
                                set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%
                                set laststatus=2
                                set list
                                colorscheme industry
				'';
		};
	};
}
