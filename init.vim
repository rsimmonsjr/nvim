" ---------- Plugins

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'cespare/vim-toml'
Plug 'elixir-editors/vim-elixir'
Plug 'tpope/vim-endwise'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'OmniSharp/omnisharp-vim'
Plug 'wsdjeg/vim-fetch', {'tag': 'v3.0.0'}

call plug#end()

" ---------- Core

set mouse=
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
" yank, etc always to register +
" set clipboard=unnamedplus
" prefer vertical split in diffs
set diffopt=vertical
set signcolumn=yes

" Stop it from auto-inserting. Now <C-n> to complete and <Enter> to select.
set completeopt=menu,menuone,noinsert

" Set margin marker per source file
autocmd FileType markdown setlocal colorcolumn=100
autocmd FileType markdown setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType rust setlocal colorcolumn=100
autocmd FileType rust setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType elixir setlocal colorcolumn=98
autocmd FileType elixir setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType elixir let @i = 'a |> IO.inspect(label: "----->>>>>")'

" ---------- COC
let g:coc_global_extensions = [
						\ 'coc-clangd',
						\ 'coc-json',
						\ 'coc-git',
						\ 'coc-elixir',
						\ 'coc-sql',
						\ 'coc-rome',
						\ 'coc-sh',
						\ 'coc-xml',
						\ 'coc-yaml',
						\ 'coc-python',
                        \ 'coc-rust-analyzer',
						\ ]

" ---------- Gruvbox

let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='hard'
let g:gruvbox_italicize_strings='1'
let g:gruvbox_italicize_comments='1'

" ---------- NERDTree

let NERDTreeShowHidden=1

" ---------- FZF
let g:fzf_vim = {}
let g:fzf_vim.preview_window = ['hidden,right,50%', 'ctrl-/']

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

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview('hidden,right:50%', 'ctrl-/'),
  \   <bang>0)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" ---------- Fugitive

" ---------- General Key Mappings

noremap <silent> <M-Right> <C-W><C-L>
noremap <silent> <M-Left> <C-W><C-H>
noremap <silent> <M-Up> <C-W><C-K>
noremap <silent> <M-Down> <C-W><C-J>
noremap <silent> <M--> <C-w>5-<CR>
noremap <silent> <M->> <C-w>5><CR>
noremap <silent> <M-=> <C-w>5+<CR>
noremap <silent> <M-<> <C-w>5<<CR>
noremap <silent> <F4> :set hlsearch! hlsearch?<CR>
noremap <silent> <M-c> :noh<CR>
noremap <silent> <M-t> :NERDTreeToggle<CR>
noremap <silent> <M-n> :NERDTreeFind<CR>
noremap <silent> <M-h> :History:<CR>
noremap <silent> <M-m> :Marks<CR>
noremap <silent> <M-b> :Buffers<CR>
noremap <silent> <M-l> :BLines<CR>
noremap <silent> <M-k> :Maps<CR>
noremap <silent> <M-g> :GFiles<CR>
noremap <silent> <M-r> :Rg<CR>
noremap <silent> <M-f> :Files<CR>
noremap <silent> <M-q> :bw<CR>
noremap <leader>rg :Rg<Space>
noremap <silent> <leader>se :setlocal spell spelllang=en_us<CR>
noremap <silent> <leader>sd :set nospell<CR>
noremap <silent> <leader>ss :split<CR>
noremap <silent> <leader>vv :vsplit<CR>
noremap <silent> <leader>gf :GFiles<CR>
noremap <silent> <leader>gh :BCommits<CR>
noremap <silent> <leader>gb :Gblame<CR>
noremap <silent> <leader>gs :Git<CR>:res 10<CR>
noremap <silent> <leader>gd :Gdiff<CR>
noremap <silent> <leader>gb :Git blame<CR>
noremap <silent> <leader>gc :Git commit<CR>
noremap <leader>xm :delmarks A-Za-z0-9<CR>

" ---------- Coc Key Mappings

nmap <silent> <M-R> <Plug>call CocActionAsync('rename')<CR>
nmap <silent> <M-F> <Plug>(coc-format)
nmap <silent> <M-V> <Plug>(coc-format-selected)
nmap <silent> <M-o> :CocList outline<cr>
nmap <silent> <M-d> :CocList diagnostics<cr>
nmap <silent> <M-s> :CocList -I symbols<cr>

" Navigating hover diagnostics.
:nnoremap <nowait><expr> <C-Up> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-Up>"
:nnoremap <nowait><expr> <C-Down> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-Down>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> gp <Plug>(coc-diagnostic-prev)
nmap <silent> gn <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Tab Completion in coc-nvim
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
inoremap <silent><expr> <cr> "\<c-g>u\<CR>"

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Strip trailing whitespace on save.
autocmd BufWritePre * :%s/\s\+$//e
