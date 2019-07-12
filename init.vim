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

call plug#end()

" ---------- Core

set hidden
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
set tabstop=4
set number
filetype plugin on
set omnifunc=syntaxcomplete#Complete
colo gruvbox
highlight Comment cterm=italic
highlight link SpecialComment GruvboxFg4

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

noremap <silent> <leader>gb :Gblame<CR> 

" ---------- ALE
let g:ale_linters = {
\ 'elixir': ['elixir-ls'],
\ 'rust': ['rls']
\}

let g:ale_fixers = {
\ 'elixir': ['mix_format'],
\ 'rust': ['rustfmt']
\}

let g:ale_elixir_elixir_ls_release='~/dev/elixir-ls/rel'
let g:ale_lint_on_save = '1'
let g:ale_fix_on_save = '1'

" ---------- Key Mappings

noremap <silent> <M-Right> <C-W><C-L>
noremap <silent> <M-Left> <C-W><C-H>
noremap <silent> <M-Up> <C-W><C-K>
noremap <silent> <M-Down> <C-W><C-J>
noremap <silent> <M--> <C-w>5-<CR>
noremap <silent> <M-=> <C-w>5+<CR>
noremap <silent> <leader>ss :split<CR>
noremap <silent> <leader>vv :vsplit<CR>

noremap <silent> <leader>n :NERDTreeToggle<CR>

noremap <silent> <leader>b :Buffers<CR> 
noremap <silent> <leader>l :BLines<CR> 
noremap <silent> <leader>km :Maps<CR> 
noremap <silent> <leader>ff :Files<CR> 
noremap <silent> <leader>rg :Rg<CR> 
noremap <silent> <leader>gf :GFiles<CR> 
noremap <silent> <leader>gg :GGrep<CR> 
noremap <silent> <leader>gc :BCommits<CR> 
noremap <silent> <leader>gb :Gblame<CR> 

imap <C-Space> <Plug>(ale_complete)
noremap <silent> <leader>ai :ALEDetail<CR>
noremap <silent> <leader>ah :ALEHover<CR>
noremap <silent> <leader>ax :ALEDetail<CR>
noremap <silent> <leader>ar :ALEFindReferences<CR> 
noremap <silent> <leader>ad :ALEGoToDefinition<CR> 
noremap <silent> <leader>at :ALEGoToTypeDefinition<CR> 
noremap <leader>as  :ALESymbolSearch<Space>
noremap <leader>an  :ALENext<CR> 
noremap <leader>ap  :ALEPrevious<CR> 


