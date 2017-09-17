set history=50
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set nobackup
set nocompatible  " Use Vim settings, rather then Vi settings
set noswapfile
set nowritebackup
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set ignorecase
set smartcase
set autoread
au CursorHold * checktime

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" Set up vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/vundle'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tomtom/tcomment_vim'
Plugin 'timcharper/textile.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'thoughtbot/vim-rspec'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'rking/vim-detailed'
Plugin 'othree/html5.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'elixir-lang/vim-elixir'
Plugin 'mileszs/ack.vim'
Plugin 'AndrewRadev/ember_tools.vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'vimperator/vimperator.vim'
call vundle#end()

filetype plugin indent on

augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Local config
if filereadable("~/.vimrc.local")
  source ~/.vimrc.local
endif

" " Use Ack instead of Grep when available
" if executable("ack")
"   set grepprg=ack\ -H\ --nogroup\ --nocolor
" endif

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  set grepprg=ag\ --vimgrep
endif

" Numbers
set relativenumber
set number
set numberwidth=5
" set relativenumber

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Tab completion options
set wildmode=list:longest,list:full
" set complete=.,w,t

" Indent if we're at the beginning of a line. Else, do completion.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Switch and manage tabs more better
nnoremap <Tab> <C-W>w
" nnoremap <Bar> <C-W>v<C-W><Right>
" nnoremap -     <C-W>s<C-W><Down>


" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Improve syntax highlighting
au BufRead,BufNewFile *.cap set filetype=ruby
au BufRead,BufNewFile Gemfile set filetype=ruby
au BufRead,BufNewFile Berksfile set filetype=ruby
au BufRead,BufNewFile Vagrantfile set filetype=ruby
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.mkd set filetype=markdown
au BufRead,BufNewFile *.coffee set filetype=coffee
au BufRead,BufNewFile *.less set filetype=css
au BufRead,BufNewFile *.bats set filetype=sh
au BufRead,BufNewFile *.properties.erb set filetype=jproperties
au BufRead,BufNewFile OpsWorks*.template set filetype=json
au BufRead,BufNewFile *.exs set filetype=elixir
au BufRead,BufNewFile *.ex set filetype=elixir
au BufRead,BufNewFile *.eex set filetype=elixir

" Leader: set to <Space>
" Space is inserted via <C-v><Space>
" see ':h map_space' in vim for further info
let mapleader = ","
" map <Leader>i mmgg=G`m<CR>
nnoremap <Leader>= mmgg=G`mzz

map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
nnoremap <Leader>n :tabn<CR>
nnoremap <Leader>p :tabp<CR>
nnoremap <Leader>e :tabe
nnoremap <Leader><Left> :vertical resize -5<cr>
nnoremap <Leader><Down> :resize +5<cr>
nnoremap <Leader><Up> :resize -5<cr>
nnoremap <Leader><Right> :vertical resize +5<cr>

let g:rspec_command = "!bundle exec rspec -fd {spec}"
" let g:rspec_command = "!spring rspec -fd {spec}"

set mousehide
set mouse=v
set guioptions-=m
set guioptions-=T

set colorcolumn=80

let cwd=getcwd()

map <F2> :mksession! ~/.vim_session <cr> " Quick write session with F2
map <F3> :source ~/.vim_session <cr>     " And load session with F3

" set cm=blowfish

set scrolloff=5

" Make CtrlP use ag for listing the files.
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching = 0

" Color scheme
colorscheme detailed

" hi NonText ctermfg=250 ctermbg=none
hi Normal          ctermfg=252 ctermbg=none

let g:airline_powerline_fonts = 1

" if !exists('g:airline_symbols')
" let g:airline_symbols = {}
" endif
"
" let g:airline_left_sep = '▶️'
" let g:airline_left_alt_sep = '▶️'
" let g:airline_right_sep = '◀️'
" let g:airline_right_alt_sep = '◀️'
" let g:airline_symbols.branch = '🔰'
" let g:airline_symbols.readonly = '📕'
" let g:airline_symbols.linenr = '〰️'
"
" let g:startify_custom_header =
"       \ map(split(system('figlet -f future `shuf -n1 ~/.vim/palindromes.txt`'), '\n'), '"   ". v:val') + ['','']

set undofile
set undodir=$HOME/.vim/undo/
set undolevels=1000
set undoreload=10000

if exists("g:initialized_vim") && g:initialized_vim
  finish
endif

let g:initialized_vim = 1
" Everything below here runs only on initialization and is not re-sourced.
