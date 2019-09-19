" ---------- Plugins

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'cespare/vim-toml'

call plug#end()

" ---------- Core

set hidden
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
set tabstop=4
set number
filetype plugin on
colo gruvbox
highlight Comment cterm=italic
highlight link SpecialComment GruvboxFg4
set spellcapcheck=0 
:set clipboard=unnamedplus "yank, etc always to register +
set diffopt=vertical "prefer vertical split in diffs

" Stop it from auto-inserting. Now <C-n> to complete and <Enter> to select. 
set completeopt=menu,menuone,noinsert  

" Set margin marker per source file
autocmd FileType markdown setlocal colorcolumn=100
autocmd FileType rust setlocal colorcolumn=100
autocmd FileType elixir setlocal colorcolumn=98

" ---------- Gruvbox

let g:gruvbox_contrast_dark='dark'
let g:gruvbox_italicize_strings='1'
let g:gruvbox_italicize_comments='1'

" ---------- FZF

let g:fzf_layout = { 'down': '~25%' }

let g:fzf_history_dir = '~/.local/share/fzf-history'

let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" ---------- Fugitive

" ---------- ALE
let g:ale_linters = {
\ 'elixir': ['elixir-ls'],
\ 'rust': ['rls'],
\ 'yaml': ['prettier'],
\ 'yml': ['prettier']
\}

let g:ale_fixers = {
\ 'elixir': ['mix_format'],
\ 'rust': ['rustfmt'],
\ 'yaml': ['prettier'],
\ 'yml': ['prettier']
\}

let g:ale_elixir_elixir_ls_release='~/dev/elixir-ls/rel'
let g:ale_lint_on_save = '1'
let g:ale_fix_on_save = '1'

" ---------- Deoplete

let g:deoplete#enable_at_startup = 1

call deoplete#custom#option('sources', {
\ '_': ['ale'],
\})

" ---------- Key Mappings

noremap <silent> <M-Right> <C-W><C-L>
noremap <silent> <M-Left> <C-W><C-H>
noremap <silent> <M-Up> <C-W><C-K>
noremap <silent> <M-Down> <C-W><C-J>
noremap <silent> <M--> <C-w>5-<CR>
noremap <silent> <M->> <C-w>5><CR>
noremap <silent> <M-=> <C-w>5+<CR>
noremap <silent> <M-<> <C-w>5<<CR>
noremap <silent> <leader>se :setlocal spell spelllang=en_us<CR>
noremap <silent> <leader>sd :set nospell<CR>
noremap <silent> <leader>ss :split<CR>
noremap <silent> <leader>vv :vsplit<CR>
noremap <silent> <M-t> :NERDTreeToggle<CR>
noremap <silent> <leader>m :Marks<CR> 
noremap <silent> <M-b> :Buffers<CR> 
noremap <silent> <leader>b :Buffers<CR> 
noremap <silent> <C-l> :BLines<CR> 
noremap <silent> <leader>l :BLines<CR> 
noremap <silent> <leader>km :Maps<CR> 
noremap <silent> <leader>ff :Files<CR> 
noremap <silent> <leader>rg :Rg<CR> 
noremap <silent> <leader>gb :Gblame<CR> 
noremap <silent> <leader>gf :GFiles<CR> 
noremap <silent> <leader>gg :GGrep<CR> 
noremap <silent> <leader>gc :BCommits<CR> 
noremap <silent> <leader>gb :Gblame<CR> 
noremap <silent> <leader>i :ALEDetail<CR>
noremap <silent> <leader>h :ALEHover<CR>
noremap <silent> <leader>r :ALEFindReferences<CR> 
noremap <silent> <leader>d :ALEGoToDefinition<CR> 
noremap <silent> <leader>t :ALEGoToTypeDefinition<CR> 
noremap <leader>s  :ALESymbolSearch<Space>
noremap <leader>n  :ALENext<CR> 
noremap <leader>p  :ALEPrevious<CR> 
noremap <leader>cm :delmarks A-Za-z0-9<CR>


