"  _       _ _         _
" (_)_ __ (_) |___   _(_)_ __ ___
" | | '_ \| | __\ \ / / | '_ ` _ \
" | | | | | | |_ \ V /| | | | | | |
" |_|_| |_|_|\__(_)_/ |_|_| |_| |_|

" Create plugin directories if not already created
" Plz install curl

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

" VimPlugs.
    call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
    Plug 'ap/vim-css-color'
    Plug 'junegunn/goyo.vim'
    Plug 'mhinz/vim-startify'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'vimwiki/vimwiki'
    Plug 'daveyarwood/vim-alda'
    call plug#end()

let mapleader=","
set clipboard+=unnamedplus
set encoding=utf-8
set go=a
set ignorecase smartcase
set mouse=a
set nocompatible
set noswapfile
set number relativenumber
set title
set exrc
set guicursor=
set nohlsearch
set hidden
set termguicolors
set scrolloff=8
set updatetime=50

" Minimalistic status line (I hate plug-ins.).
    set statusline=
    set statusline+=%#Cursor#                   " colour
    set statusline+=\ %n\                       " buffer number
    set statusline+=%#CursorIM#                 " colour
    set statusline+=\ \[%M                      " modified [+] flag
    set statusline+=%R\]\                       " read-only flag
    set statusline+=%{&spell?'\ SPELL\ ':''}    " spell check indicator
    set statusline+=%#Cursor#                   " colour
    set statusline+=\ %F                        " long file name

    set statusline+=%=                          " right align
    set statusline+=\ %y\                       " file type
    set statusline+=%#CursorIM#                 " colour
    set statusline+=\ %3l:%-2c\                 " line + column
    set statusline+=%#Cursor#                   " colour
    set statusline+=\ %P\                       " percentage

" Indents that consist of 4 space characters but are entered with the tab key.
    set tabstop=4 softtabstop=4 expandtab shiftwidth=4 smartindent smarttab

" Some basics.
    filetype plugin indent on
    nnoremap N   Nzz
    nnoremap c "_c
    nnoremap n   nzz

" Auto spell check on certain file types.
    autocmd FileType tex,latex,markdown setlocal spell spelllang=en_gb

" Enable auto completion.
    set wildmode=longest,list,full

" Disables automatic commenting on newline.
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Perform dot commands over visual blocks.
    vnoremap . :normal .<CR>

" Goyo plug-in makes text more readable when writing prose.
    map <silent> <leader>g :Goyo \| hi CursorLineNr ctermbg=NONE \| hi Normal ctermbg=NONE \| set linebreak<CR>

" Spell-check set to <leader>o, 'o' for 'orthography'.
    map <silent> <leader>o :setlocal spell! spelllang=en_gb<CR>

" Short cutting split navigation, saving a key press.
    map <c-h> <c-w>h
    map <c-j> <c-w>j
    map <c-k> <c-w>k
    map <c-l> <c-w>l
    map <s-h> <c-w><
    map <s-l> <c-w>>
    map <s-j> <c-w>-
    map <s-k> <c-w>+

" Replace ex mode with gq.
    map Q gq

" Check file in shellcheck.
    map <leader>s :!clear && shellcheck -x %<CR>

" Open my bibliography file in split.
    map <leader>b :vsp<space>$BIB<CR>
    map <leader>r :vsp<space>$REFER<CR>

" Replace all is aliased to S.
    nnoremap S :%s//g<Left><Left>

" Word count.
    map <leader>wc :w !detex \| wc -w<CR>

" Compile document, be it groff/LaTeX/markdown/etc.
    map <leader>c :w! \| !compiler "<c-r>%"<CR>

" Open corresponding .pdf/.html or preview.
    map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
    autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want.
    let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
    map <leader>v :VimwikiIndex
    let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
    autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
    autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
    autocmd BufRead,BufNewFile *.tex set filetype=tex

" Save file as sudo on files that require root permission.
    cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Enable Goyo by default for mutt writing.
    autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
    autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set bg=dark
    autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
    autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>

" Automatically deletes all trailing white spaces and newlines at end of file on save.
    autocmd BufWritePre * %s/\s\+$//e
    autocmd BufWritePre * %s/\n\+\%$//e
    autocmd BufWritePre *.[ch] %s/\%$/\r/e

" Turns off highlighting on the bits of code that are changed, so that
" the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
    if &diff
        hi! link DiffText MatchParen
    endif

" Function for toggling the bottom status bar.
    let s:hidden_all = 0
    function! ToggleHiddenAll()
        if s:hidden_all  == 0
            let s:hidden_all = 1
            set noruler
            set laststatus=0
            set noshowcmd
        else
            let s:hidden_all = 0
            set noruler
            set laststatus=2
            set showcmd
        endif
    endfunction
    nnoremap <silent> <leader>h :call ToggleHiddenAll()<CR>

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction
nnoremap <leader>st :call SynStack()<CR>

"  ____        _                  _
" / ___| _ __ (_)_ __  _ __   ___| |_ ___
" \___ \| '_ \| | '_ \| '_ \ / _ \ __/ __|
"  ___) | | | | | |_) | |_) |  __/ |_\__ \
" |____/|_| |_|_| .__/| .__/ \___|\__|___/
"               |_|   |_|

" Navigating with guides
    inoremap <leader><leader> <Esc>/t<CR>"_c4l
    vnoremap <leader><leader> <Esc>/<++><CR>"_c4l
    map <leader><leader> <Esc>/<++><CR>"_c4l

" LaTeX
    autocmd FileType tex inoremap <leader>em \emph{}<++><Esc>T{i
    autocmd FileType tex inoremap <leader>bf \textbf{}<++><Esc>T{i
    autocmd FileType tex inoremap <leader>it \textit{}<++><Esc>T{i
    autocmd FileType tex inoremap <leader>ct \textcite{}<++><Esc>T{i
    autocmd FileType tex inoremap <leader>ct \textcite{}<++><Esc>T{i
    autocmd FileType tex inoremap <leader>() \left(\right)<++><Esc>T(i

    autocmd FileType tex inoremap <leader>ol \begin{enumerate}<CR><CR>\end{enumerate}<CR><CR><++><Esc>3kA\item<Space>
    autocmd FileType tex inoremap <leader>ul \begin{itemize}<CR><CR>\end{itemize}<CR><CR><++><Esc>3kA\item<Space>
    autocmd FileType tex inoremap <leader>li <CR>\item<Space>

    autocmd FileType tex inoremap <leader>rm \mathrm{}<++><Esc>T{i
    autocmd FileType tex inoremap <leader>m \(\)<Esc>hi
    autocmd FileType tex inoremap <leader>M \[\]<Esc>hi
    autocmd FileType tex inoremap <leader>beg \begin{DELRN}<CR><++><CR>\end{DELRN}<Esc>2k0fR:MultipleCursorsFind<Space>DELRN<CR>c

    autocmd FileType tex inoremap <leader>sec \section{}<CR><CR><++><Esc>2kf}i
    autocmd FileType tex inoremap <leader>ssec \subsection{}<CR><CR><++><Esc>2kf}i
    autocmd FileType tex inoremap <leader>sssec \subsubsection{}<CR><CR><++><Esc>2kf}i
    autocmd FileType tex inoremap <leader>st <Esc>F{i*<Esc>f}i

    autocmd FileType tex inoremap <leader>up <Esc>/usepackage<CR>o\usepackage{}<Esc>i
    autocmd FileType tex nnoremap <leader>up /usepackage<CR>o\usepackage{}<Esc>i

" html
    autocmd FileType html inoremap <leader><> <DELRN><++></DELRN><Esc>0fR:MultipleCursorsFind<Space>DELRN<CR>ce
