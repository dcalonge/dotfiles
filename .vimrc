" Disable compatibility with vi which can cause unexpected issues.
set nocompatible
set mouse=a
" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on
" Turn syntax highlighting on.
syntax on
" Add numbers to each line on the left-hand side.
set number
" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
" PLUGINS ---------------------------------------------------------------- {{{

call plug#begin('~/.vim/plugged')
" Start NERDTree and put the cursor back in the other window.

  Plug 'dense-analysis/ale'

  Plug 'preservim/nerdtree'

  Plug 'arcticicestudio/nord-vim'
  
  Plug 'vim-airline/vim-airline'

call plug#end()
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
let g:airline#extensions#tabline#enabled = 1
let NERDTreeShowHidden=1
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

colorscheme nord
" }}}
" MAPPINGS --------------------------------------------------------------- {{{

" Mappings code goes here.
  nnoremap <c-t> :tabnew<cr>
  nnoremap <c-w> :tabclose<cr>
  nnoremap <C-n> :NERDTreeMirror<CR>:NERDTreeFocus<CR>
" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" More Vimscripts code goes here.

" }}}


" STATUS LINE ------------------------------------------------------------ {{{

" Status bar code goes here.
 
" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
set statusline+=\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the second to last line.
set laststatus=2

" }}}
" }}}
