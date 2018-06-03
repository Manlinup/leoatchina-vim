" This is leoatchina's vim config forked from https://github.com/spf13/spf13-vim
" Sincerely thank him for his great job, and I have made some change according to own requires.
"                    __ _ _____              _
"         ___ _ __  / _/ |___ /      __   __(_)_ __ ___
"        / __| '_ \| |_| | |_ \ _____\ \ / /| | '_ ` _ \
"        \__ \ |_) |  _| |___) |_____|\ V / | | | | | | |
"        |___/ .__/|_| |_|____/        \_/  |_|_| |_| |_|
"            |_|
" You can find spf13's origin config at http://spf13.com

" Basics
set nocompatible        " Must be first line
nnoremap _ %
vnoremap _ %
set encoding=utf-8
set fileencodings=utf-8,gbk,gb18030,gk2312,chinese,latin-1
set background=dark     " Assume a dark background
set mouse=a             " Automatically enable mouse usage
set mousehide           " Hide the mouse cursor while typing
" Identify platform
silent function! OSX()
    return has('macunix')
endfunction
silent function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
    return  (has('win32') || has('win64'))
endfunction
" Basics
if !WINDOWS()
    set shell=/bin/sh
    set term=xterm-256color
else
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
    set term=win32
    set guifont=YaHei\ Consolas\ Hybrid:h11
endif
" Use before config
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
" Use plugs config
if filereadable(expand("~/.vimrc.plugs"))
    source ~/.vimrc.plugs
endif
set noimdisable
" set timeout
set timeout
set timeoutlen=500 ttimeoutlen=50
" GUI Settings
if has('gui_running')
    set lines=40                " 40 lines of text instead of 24
endif
" Arrow Key Fix
" https://github.com/spf13/spf13-vim/issues/780
if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
    inoremap <silent> <C-[>OC <RIGHT>
endif
" Clipboard
if has('clipboard')
    if has('unnamedplus')  " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else         " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif
" Key (re)Mappings
if !exists('g:spf13_leader')
    let mapleader=' '
else
    let mapleader=g:spf13_leader
endif
if !exists('g:spf13_localleader')
    let maplocalleader = '\'
else
    let maplocalleader=g:spf13_localleader
endif
" 不同文件类型加载不同插件
filetype plugin indent on   " Automatically detect file types.
filetype on                 " 开启文件类型侦测
filetype plugin on          " 根据侦测到的不同类型:加载对应的插件
syntax on
" Allow using the repeat operator with a visual selection (!)
vnoremap . :normal .<CR>
" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null
" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
" <F9> for toggle the quick fix list
let g:quickfix_is_open = 0
function! ToggleQuickfix()
  if g:quickfix_is_open
    cclose
    let g:quickfix_is_open = 0
    execute g:quickfix_return_to_window . "wincmd w"
  else
    let g:quickfix_return_to_window = winnr()
    copen
    let g:quickfix_is_open = 1
  endif
endfunction
command! ToggleQuickfix
      \ call ToggleQuickfix()
nnoremap <silent><F9> :ToggleQuickfix<cr>
inoremap <silent><F9> <ESC>:ToggleQuickfix<cr>
vnoremap <silent><F9> <ESC>:ToggleQuickfix<cr>
" fullscreen mode for GVIM and Terminal, need 'wmctrl' in you PATH
if !WINDOWS()
    map <silent> <F11> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>
else
    au GUIEnter * simalt ~x
    " 按 F11 切换全屏
    noremap <F11> <esc>:call libcallnr('gvim_fullscreen.dll', 'ToggleFullscreen', 0)<cr>
    " 按 S-F11 切换窗口透明度
    noremap <S-F11> <esc>:call libcallnr('gvim_fullscreen.dll', 'ToggleTransparency', "247,180")<cr>
endif
set pastetoggle=<F12>      " pastetoggle (sane indentation on pastes)

" some internal key remap
map gt <Nop>
map gT <Nop>
"FIXME: c-s may cause halt within xshell5
map  <C-s> <Nop>
nmap ! :!
" Q
nnoremap ~ Q
nnoremap Q :q!<CR>
" remap c-a/e , for home/end
nmap <C-a> ^
smap <C-a> ^
imap <C-a> <Esc>I
nmap <C-e> $
smap <C-e> $<Left>
imap <expr><silent><C-e> pumvisible()? "\<C-e>":"\<ESC>A"

" C-f/b in insert mode
imap <C-f> <Right>
imap <C-b> <Left>
" Find merge conflict markers
nmap <C-f>c /\v^[<\|=>]{7}( .*\|$)<CR>
" and ask which one to jump to
nmap <C-f>w [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
nnoremap <C-x> <C-f>
nnoremap <C-y> <C-b>

" tab control
set tabpagemax=10 " Only show 10 tabs
cmap Tabe tabe
nnoremap <silent>- :tabprevious<CR>
nnoremap <silent><Tab> :tabnext<CR>
nnoremap <Leader>tp :tabprevious<CR>
nnoremap <Leader>tn :tabnext<CR>
nnoremap <leader>- :tabm -1<CR>
nnoremap <leader><Tab>  :tabm +1<CR>
nnoremap <leader><leader>- :tabfirst<CR>
nnoremap <leader><leader><Tab> :tablast<CR>
nnoremap <Leader>te :tabe<Space>
nnoremap <Leader>ts :tab split<CR>
nnoremap <Leader>tS :tabs<CR>
nnoremap <Leader>tm :tabm<Space>
" buffer switch
nnoremap <localleader>] :bn<CR>
nnoremap <localleader>[ :bp<CR>
" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap  <leader>y  "+y
nnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg
nnoremap  <leader>yy  "+yy
" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$
" p and P for paste
nnoremap <leader>p "p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P
" Easier horizontal scrolling
map zl zL
map zh zH
" Wrapped lines goes down/up to next row, rather than next line in file.
noremap <silent>j gj
noremap <silent>k gk
nmap <F1> :tab help<Space>
vmap <F1> <ESC>:tab help<Space>
autocmd FileType help  setlocal number
if isdirectory(expand($PLUG_PATH."/far.vim"))
    nmap <F2> :Far<Space>
endif

nnoremap <F3> <C-X>
nnoremap <F4> <C-A>
"F6 toggleFold
noremap <F6> :set nofoldenable! nofoldenable?<CR>
"F7 toggleWrap
noremap <F7> :set nowrap! nowrap?<CR>
"F8 toggle hlsearch
noremap <F8> :set nohlsearch! nohlsearch?<CR>
" 定义快捷键保存当前窗口内容
nmap <Leader>w :w<CR>
nmap <Leader>W :wq!<CR>
" 定义快捷键保存所有窗口内容并退出 vim
nmap <Leader>WQ :wa<CR>:q<CR>
" 定义快捷键关闭当前窗口
nmap <Leader>q :q!
" 不做任何保存，直接退出 vim
nmap <Leader>Q :qa!
" 设置分割页面
nmap <leader>\ :vsplit<Space>
nmap <Leader><leader>\ :split<Space>
nmap <leader>= <C-W>=
"设置垂直高度减增
nmap <Leader><Down> :resize -3<CR>
nmap <Leader><Up>   :resize +3<CR>
"设置水平宽度减增
nmap <Leader><Left> :vertical resize -3<CR>
nmap <Leader><Right>:vertical resize +3<CR>
" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv
nnoremap < <<
nnoremap > >>
" auto close qfixwindows when leave vim
aug QFClose
    au!
    au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

" Formatting
set number                      " set number"
set autoindent                  " Indent at the same level of the previous line
set nojoinspaces                " Prevents inserting two Spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
" 不生成back文件
set nobackup
"set noswapfile
set nowritebackup
"set noundofile
" 关闭拼写检查
set nospell
" 关闭声音
set noeb
set vb
" 列光标加亮
set nocursorcolumn
" 光标加亮
set cursorline
" 允许折行
set wrap
" 不折叠
set nofoldenable
" 标签控制
set showtabline=2
" 开启实时搜索功能
set incsearch
" 显示光标当前位置
set ruler
" 高亮显示搜索结果
set hlsearch
set incsearch                   " Find as you type search
set smartcase                   " Case sensitive when uc present
set ignorecase                  " Case insensitive search
" 一些格式
set backspace=indent,eol,start  " BackSpace for dummies
set linespace=0                 " No extra Spaces between rows
set showmatch                   " Show matching brackets/parenthesis
set winminheight=0              " Windows can be 0 line high
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " BackSpace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set nolist
set shiftwidth=4                " Use indents of 4 Spaces
set expandtab                   " Tabs are Spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backSpace delete indent
" 没有滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
" 没有菜单和工具条
set guioptions-=m
set guioptions-=T
" 总是显示状态栏
" set laststatus=2
" sepcial setting for different type of files
au BufNewFile,BufRead *.py
    \set shiftwidth=4
    \set tabstop=4
    \set softtabstop=4
    \set expandtab
    \set autoindent
    \set foldmethod=indent
au FileType python au BufWritePost <buffer> :%retab
" yaml
au BufNewFile,BufRead *.yml
    \set shiftwidth=2
    \set tabstop=2
    \set softtabstop=2
    \set expandtab
    \set autoindent
    \set foldmethod=indent
" Remove trailing whiteSpaces and ^M chars
au FileType markdown,vim,c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql au BufWritePre <buffer>  call StripTrailingWhiteSpace()
au BufNewFile,BufRead *.html.twig set filetype=html.twig
au BufNewFile,BufRead *.md,*.markdown,README set filetype=markdown
au BufNewFile,BufRead *.pandoc set filetype=pandoc
au FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
" preceding line best in a plugin but here for now.
au BufNewFile,BufRead *.coffee set filetype=coffee
" Workaround vim-commentary for Haskell
au FileType haskell setlocal commentstring=--\ %s
" Workaround broken colour highlighting in Haskell
au FileType haskell,rust setlocal nospell
" General
if !exists('g:spf13_no_autochdir')
    au BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
endif
" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
" Restore cursor to file position in previous editing session
if !exists('g:spf13_no_restore_cursor')
    function! ResCur()
        if line("'\"") <= line("$")
            silent! normal! g`"
            return 1
        endif
    endfunction
    augroup resCur
        au!
        au BufWinEnter * call ResCur()
    augroup END
endif
" To disable views add the following to your .vimrc.local file:
"   let g:spf13_no_views = 1
if !exists('g:spf13_no_views')
    " Add exclusions to mkview and loadview
    " eg: *.*, svn-commit.tmp
    let g:skipview_files = [
        \ '\[example pattern\]'
        \ ]
endif
" ctrlsf
if isdirectory(expand($PLUG_PATH."/ctrlsf.vim"))
    nmap     <C-F>s <Plug>CtrlSFPrompt
    vmap     <C-F>f <Plug>CtrlSFVwordPath
    vmap     <C-F>s <Plug>CtrlSFVwordExec
    nmap     <C-F>n <Plug>CtrlSFCwordPath
    nmap     <C-F>p <Plug>CtrlSFPwordPath
    nnoremap <C-F>o :CtrlSFOpen<CR>
    nnoremap <C-F>t :CtrlSFToggle<CR>
    inoremap <C-F>t <Esc>:CtrlSFToggle<CR>
    let g:ctrlsf_position='right'
endif
" indent_guides
if isdirectory(expand($PLUG_PATH."/vim-indent-guides/"))
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
    hi IndentGuidesOdd  ctermbg=black
    hi IndentGuidesEven ctermbg=darkgrey
endif
" conflict-marker
if isdirectory(expand($PLUG_PATH."/conflict-marker.vim/"))
    let g:conflict_marker_enable_mappings = 1
endif

" voom
if isdirectory(expand($PLUG_PATH."/voom/"))
    let g:conflict_marker_enable_mappings = 1
    let g:voom_python_versions = [g:python_version]
    let g:voom_tab_key = "_"
    nmap <F10> :VoomToggle<CR>
    let g:voom_ft_modes = {
                \ 'markdown': 'markdown',
                \ 'pandoc': 'pandoc',
                \ 'c': 'fmr2',
                \ 'cpp': 'fmr2',
                \ 'python':'python',
                \ 'tex': 'latex'}
endif
" multiple-cursors
if isdirectory(expand($PLUG_PATH."/vim-multiple-cursors/"))
    let g:multi_cursor_use_default_mapping=0
    " Default mapping
    let g:multi_cursor_start_word_key      = '<C-m>'
    let g:multi_cursor_select_all_word_key = '<C-b>'
    let g:multi_cursor_start_key           = '<leader><C-m>'
    let g:multi_cursor_select_all_key      = '<leader><C-b>'
    let g:multi_cursor_next_key            = '<C-m>'
    let g:multi_cursor_prev_key            = '<C-h>'
    let g:multi_cursor_skip_key            = '<C-x>'
    let g:multi_cursor_quit_key            = '<C-c>'
endif
" theme
if (empty($TMUX))
    if (has("nvim"))
        let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
    endif
endif
set background=dark
"set t_Co=256
if has('gui_running')
    colorscheme hybrid_material
else
    colorscheme gruvbox
endif
" vim-airline
if isdirectory(expand($PLUG_PATH."/vim-airline-themes/"))
    let g:airline_theme = 'bubblegum'
    let g:airline_powerline_fonts = 0
    let g:airline_symbols_ascii = 1
    let g:airline_exclude_preview = 0
    let g:airline_highlighting_cache = 1
    let g:airline#extensions#whiteSpace#enabled = 0
    " tab序号
    let g:airline#extensions#tabline#tab_nr_type = 1
    let g:airline#extensions#tabline#enabled = 1
    " disable buffers on topright
    let g:airline#extensions#tabline#tabs_label = ''
    let g:airline#extensions#tabline#show_splits = 0
    let g:airline#extensions#tabline#show_close_button = 0
    let g:airline#extensions#tabline#buffer_nr_show = 0
    let g:airline#extensions#bufferline#enabled = 1
    " shw full_path of the file,and the time
    let g:airline_section_c = "\ %F"
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline_symbols.crypt = '🔒'
    let g:airline_symbols.linenr = '☰'
    let g:airline_symbols.maxlinenr = ''
    let g:airline_symbols.branch = '⎇'
    let g:airline_symbols.paste = 'ρ'
    let g:airline_symbols.notexists = '∄'
    let g:airline_symbols.whiteSpace = 'Ξ'
    let g:airline_left_sep = '▶'
    let g:airline_left_alt_sep = '❯'
    let g:airline_right_sep = '◀'
    let g:airline_right_alt_sep = '❮'
elseif has('statusline')
    if isdirectory(expand($PLUG_PATH."/vim-fugitive"))
        set statusline=\ %{fugitive#statusline()}
    else
        set statusline=%<
    endif
    set statusline+=\ %F
    if isdirectory(expand($PLUG_PATH."/ale"))
        set statusline+=\ %{ALEGetStatusLine()}
    endif
    set statusline+=%=%25([%{&ff}/%Y]\ %p%%\ \ %l/%L:\ %c%)\ %<
endif

" NerdTree
if isdirectory(expand($PLUG_PATH."/nerdtree"))
    nmap <leader>nn :NERDTreeTabsToggle<CR>
    nmap <leader>nf :NERDTreeFind<CR>
    let g:NERDShutUp=1
    let s:has_nerdtree = 1
    let g:nerdtree_tabs_open_on_gui_startup=0
    let g:nerdtree_tabs_open_on_console_startup = 0
    let g:nerdtree_tabs_smart_startup_focus = 2
    let g:nerdtree_tabs_focus_on_files = 1
    let g:NERDTreeWinSize=30
    let g:NERDTreeShowBookmarks=1
    let g:nerdtree_tabs_smart_startup_focus = 0
    let g:NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
    let g:NERDTreeChDirMode=0
    let g:NERDTreeQuitOnOpen=1
    let g:NERDTreeMouseMode=2
    let g:NERDTreeShowHidden=1
    let g:NERDTreeKeepTreeInNewTab=1
    let g:nerdtree_tabs_focus_on_files = 1
    let g:nerdtree_tabs_open_on_gui_startup = 0
    let g:NERDTreeWinPos=0
    let g:NERDTreeDirArrowExpandable = '▸'
    let g:NERDTreeDirArrowCollapsible = '▾'
    au bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif
    " nerdtree-git
    if isdirectory(expand($PLUG_PATH."/nerdtree-git-plugin"))
        let g:NERDTreeIndicatorMapCustom = {
                    \ "Modified"  : "*",
                    \ "Staged"    : "+",
                    \ "Untracked" : "★",
                    \ "Renamed"   : "→ ",
                    \ "Unmerged"  : "=",
                    \ "Deleted"   : "X",
                    \ "Dirty"     : "●",
                    \ "Clean"     : "√",
                    \ "Unknown"   : "?"
                    \ }
    endif
endif

" End/Start of line motion keys act relative to row/wrap width in the
" presence of `:set wrap`, and relative to line for `:set nowrap`.
" Default vim behaviour is to act relative to text line in both cases
" If you prefer the default behaviour, add the following to your
" .vimrc.local file:
"   let g:spf13_no_wrapRelMotion = 1
" Same for 0, home, end, etc
function! WrapRelativeMotion(key, ...)
    let vis_sel=""
    if a:0
        let vis_sel="gv"
    endif
    if &wrap
        execute "normal!" vis_sel . "g" . a:key
    else
        execute "normal!" vis_sel . a:key
    endif
endfunction
" Map g* keys in Normal, Operator-pending, and Visual+select
noremap $ :call WrapRelativeMotion("$")<CR>
noremap 0 :call WrapRelativeMotion("0")<CR>
noremap ^ :call WrapRelativeMotion("^")<CR>
" Overwrite the operator pending $/<End> mappings from above
" to force inclusive motion with :execute normal!
onoremap $ v:call WrapRelativeMotion("$")<CR>
onoremap <End> v:call WrapRelativeMotion("$")<CR>
" Overwrite the Visual+select mode mappings from above
" to ensuwe the correct vis_sel flag is passed to function
vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
vnoremap <Home> :<C-U>call WrapRelativeMotion("^", 1)<CR>
vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>
" Stupid shift key fixes
if has("user_commands")
    command! -bang -nargs=* -complete=file E e<bang> <args>
    command! -bang -nargs=* -complete=file W w<bang> <args>
    command! -bang -nargs=* -complete=file Wq wq<bang> <args>
    command! -bang -nargs=* -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
endif
" Plugins
" ywvim,vim里的中文输入法
if isdirectory(expand($PLUG_PATH."/ywvim"))
    if count(g:spf13_plug_groups, 'pinyin')
        let g:ywvim_ims=[
                \['py', '拼音', 'pinyin.ywvim'],
                \['wb', '五笔', 'wubi.ywvim'],
            \]
    elseif count(g:spf13_plug_groups, 'wubi')
        let g:ywvim_ims=[
                \['wb', '五笔', 'wubi.ywvim'],
                \['py', '拼音', 'pinyin.ywvim'],
            \]
    endif
    let g:ywvim_py = { 'helpim':'wb', 'gb':0 }
    let g:ywvim_zhpunc = 0
    let g:ywvim_listmax = 8
    let g:ywvim_esc_autoff = 1
    let g:ywvim_autoinput = 2
    let g:ywvim_circlecandidates = 1
    let g:ywvim_helpim_on = 0
    let g:ywvim_matchexact = 0
    let g:ywvim_chinesecode = 1
    let g:ywvim_gb = 0
    let g:ywvim_preconv = 'g2b'
    let g:ywvim_conv = ''
    let g:ywvim_lockb = 1
    imap <silent> <C-\> <C-R>=Ywvim_toggle()<CR>
    cmap <silent> <C-\> <C-R>=Ywvim_toggle()<CR>
endif

" Shell
if has('nvim')

else
    if isdirectory(expand($PLUG_PATH."/vimshell.vim"))
        nmap <C-k>v :vsplit<cr>:VimShell<cr>
        nmap <C-k>s :split<cr>:VimShell<cr>
        nmap <C-k>V :VimShell<Space>
        nmap <C-k>S :VimShellSendBuffer<Space>
        nmap <C-k>c :VimShellClose<Cr>
        nmap <C-k>t :VimShellTab<Space>
        nmap <C-k>p :VimShellPop<Space>
        nmap <C-k>d :VimShellCurrentDir<Space>
        nmap <C-k>b :VimShellBufferDir<Space>
        nmap <C-k>e :VimShellExecute<Space>
        nmap <C-k>i :VimShellInteractive<Space>
        nmap <C-k>n :VimShellCreate<Space>
        vmap <C-k>  :VimShellSendString<cr>
        let g:vimshell_prompt_expr = 'escape(fnamemodify(getcwd(), ":~").">", "\\[]()?! ")." "'
        let g:vimshell_prompt_pattern = '^\%(\f\|\\.\)\+> '
        let g:vimshell_force_overwrite_statusline=1
    endif
endif

" startify
if isdirectory(expand($PLUG_PATH."/vim-startify"))
    let g:startify_custom_header = [
        \ '+----------------------------------------------------------+',
        \ '|  Welcome to use leoatchina vim config forked from spf13  |',
        \ '|                                                          |',
        \ '|  https://github.com/leoatchina/spf13-vim-leoathina       |',
        \ '|                                                          |',
        \ '|  https://github.com/spf13/spf13-vim                      |',
        \ '+----------------------------------------------------------+',
        \ ]
    let g:startify_session_dir = '~/.vim/session'
    let g:startify_files_number = 5
    let g:startify_session_number = 5
    let g:startify_list_order = [
        \ ['   最近项目:'],
        \ 'sessions',
        \ ['   最近文件:'],
        \ 'files',
        \ ['   快捷命令:'],
        \ 'commands',
        \ ['   常用书签:'],
        \ 'bookmarks',
        \ ]
    let g:startify_commands = [
        \ {'r': ['说明', '!vim -p ~/.vimrc.md']},
        \ {'h': ['帮助', 'help howto']},
        \ {'v': ['版本', 'version']}
        \ ]
endif
" PIV
if isdirectory(expand($PLUG_PATH."/PIV"))
    let g:DisableAutoPHPFolding = 0
    let g:PIVAutoClose = 0
endif
" fugitive
if isdirectory(expand($PLUG_PATH."/vim-fugitive"))
    nnoremap <leader>GG :Git<Space>
    nnoremap + :Git<Space>
endif
" TagBar
if isdirectory(expand($PLUG_PATH."/tagbar/"))
    let g:tagbar_sort = 0
    set tags=./tags;/,~/.vimtags
    " Make tags placed in .git/tags file available in all levels of a repository
    let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
    if gitroot != ''
        let &tags = &tags . ',' . gitroot . '/.git/tags'
    endif
    nmap <silent><leader>tt :TagbarToggle<CR>
    nnoremap <silent><leader>tj :TagbarOpen j<CR>
    " AutoCloseTag
    " Make it so AutoCloseTag works for xml and xhtml files as well
    au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
    nmap <Leader>ta <Plug>ToggleAutoCloseMappings
endif
" easy-align
if isdirectory(expand($PLUG_PATH."/vim-easy-align"))
    vmap <Cr> <Plug>(EasyAlign)
    if !exists('g:easy_align_delimiters')
        let g:easy_align_delimiters = {}
    endif
    let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String'] }
endif
" Go program
if count(g:spf13_plug_groups, 'go')
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_build_constraints = 1
    let g:go_fmt_command = "gofmt"
    let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
    let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
    au FileType go imap <C-g> <C-x><C-o>
    au FileType go nmap <Leader>i <Plug>(go-implements)
    au FileType go nmap <Leader>I <Plug>(go-info)
    au FileType go nmap <Leader>r <Plug>(go-rename)
    au FileType go nmap <leader>R <Plug>(go-run)
    au FileType go nmap <F5>      <Plug>(go-run)
    au FileType go nmap <leader>b <Plug>(go-build)
    au FileType go nmap <leader>t <Plug>(go-test)
    au FileType go nmap <Leader>d <Plug>(go-doc)
    au FileType go nmap <Leader>v <Plug>(go-doc-vertical)
    au FileType go nmap <leader>c <Plug>(go-coverage)
endif
" PyMode
if isdirectory(expand($PLUG_PATH."/python-mode"))
    " python version
    if has('python3')
        let g:pymode_python = 'python3'
    else
        let g:pymode_python = 'python'
    endif
    " disable pymode_rope and pymode_folding for slow problem
    let g:pymode_rope = 0
    let g:pymode_folding = 0
    let g:pymode_trim_whiteSpaces = 1
    let g:pymode_options = 0
    " doc for python
    let g:pymode_doc = 0
    " motion
    let g:pymode_motion = 1
    " run python
    let g:pymode_run_bind = '<leader>R'
    " breakpoint
    let g:pymode_breakpoint = 1
    let g:pymode_breakpoint_bind = '<LocalLeader>p'
    let g:pymode_breakpoint_cmd = 'import pdb;pdb.set_trace()'
    " pymode check disable
    if count(g:spf13_plug_groups, 'syntax')
        let g:pymode_lint = 0
    else
        nmap <C-l>l :PymodeLint<CR>
        let g:pymode_lint = 1
        let g:pymode_lint_signs = 1
        " no check when white
        let g:pymode_lint_on_write = 0
        " check when save
        let g:pymode_lint_unmodified = 0
        " not check of fly
        let g:pymode_lint_on_fly = 0
        " show message of error line
        let g:pymode_lint_message = 1
        " checkers
        let g:pymode_lint_checkers = ['pyflakes','pep8']
        "let g:pymode_lint_checkers = ['pep8']
        let g:pymode_lint_ignore = "E128,E2,E3,E501"
        " not Auto open cwindow (quickfix) if any errors have been found
        let g:pymode_lint_cwindow = 0
    endif
    if isdirectory(expand($PLUG_PATH."/python-syntax"))
        let g:pymode_syntax = 0
        let g:pymode_syntax_all = 0
    else
        let g:pymode_syntax = 1
        let g:pymode_syntax_all = 1
    endif
endif
" pytthon syntax highlight
if isdirectory(expand($PLUG_PATH."/python-syntax"))
    let g:python_highlight_all = 1
endif
" Rainbow
if isdirectory(expand($PLUG_PATH."/rainbow"))
    let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
endif
" LeaderF && ctrlp
if g:python_version > 0 && isdirectory(expand($PLUG_PATH."/LeaderF"))
    let g:Lf_ShortcutF = '<C-P>'
    let g:Lf_ShortcutB = '<leader>B'
    nmap <leader>ll :Leaderf
    nmap <leader>lf :LeaderfF
    nmap <leader>lb :LeaderfB
elseif isdirectory(expand($PLUG_PATH."/ctrlp.vim"))
    let g:ctrlp_working_path_mode = 'ar'
    let g:ctrlp_custom_ignore = {
        \ 'dir':  '\.git$\|\.hg$\|\.svn$',
        \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }
    if executable('ag')
        let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
    elseif executable('ack-grep')
        let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
    elseif executable('ack')
        let s:ctrlp_fallback = 'ack %s --nocolor -f'
        " On Windows use "dir" as fallback command.
    elseif WINDOWS()
        let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
    else
        let s:ctrlp_fallback = 'find %s -type f'
    endif
    if exists("g:ctrlp_user_command")
        unlet g:ctrlp_user_command
    endif
    let g:ctrlp_user_command = {
            \ 'types': {
            \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
            \ 2: ['.hg', 'hg --cwd %s locate -I .'],
            \ },
            \ 'fallback': s:ctrlp_fallback
        \ }
    if isdirectory(expand($PLUG_PATH."/ctrlp-funky/"))
        " CtrlP extensions
        let g:ctrlp_extensions = ['funky']
        " funky
        nnoremap <Leader>fu :CtrlPFunky<Cr>
    endif
    nnoremap <leader>mu :CtrlPMRU<CR>
endif

" UndoTree
if isdirectory(expand($PLUG_PATH."/undotree/"))
    nnoremap <silent><Leader>u :UndotreeToggle<CR>
    " If undotree is opened, it is likely one wants to interact with it.
    let g:undotree_SetFocusWhenToggle=1
endif

" language support
if v:version > 703
    " Youcompleteme
    if g:completable == 1
        au InsertLeave * if pumvisible() == 0|pclose|endif "离开插入模式后关闭预览窗口
        let g:ycm_python_binary_path = 'python'
        let g:acp_enableAtStartup = 0
        "  补全后关键窗口
        let g:ycm_autoclose_preview_window_after_completion = 1
        "  插入后关键窗口
        let g:ycm_autoclose_preview_window_after_insertion = 1
        " enable completion from tags
        let g:ycm_collect_identifiers_from_tags_files = 1
        let g:ycm_key_invoke_completion = '<Tab>'
        let g:ycm_key_list_select_completion = ['<C-n>','<Down>']
        let g:ycm_key_list_previous_completion = ['<C-p','<Up>']
        let g:ycm_filetype_blacklist = {
            \ 'tagbar' : 1,
            \ 'nerdtree' : 1,
        \}
        " Haskell post write lint and check with ghcmod
        " $ `cabal install ghcmod` if missing and ensure
        " ~/.cabal/bin is in your $PATH.
        if !executable("ghcmod")
            au BufWritePost *.hs GhcModCheckAndLintAsync
        endif
        let g:ycm_confirm_extra_conf=1 "加载.ycm_extra_conf.py提示
        let g:ycm_global_ycm_extra_conf = '$PLUG_PATH/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
        let g:ycm_collect_identifiers_from_tags_files=1    " 开启 YC基于标签引擎
        let g:ycm_min_num_of_chars_for_completion=2   " 从第2个键入字符就开始罗列匹配项
        let g:ycm_cache_omnifunc=0 " 禁止缓存匹配项,每次都重新生成匹配项
        let g:ycm_seed_identifiers_with_syntax=1   " 语法关键字补全
        let g:ycm_semantic_triggers =  {
      			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
      			\ 'cs,lua,javascript': ['re!\w{2}'],
  			\}
        let g:ycm_add_preview_to_completeopt = 0 " preview里不加入原型
        ""在注释输入中也能补全
        let g:ycm_complete_in_comments = 1
        "在字符串输入中也能补全
        let g:ycm_complete_in_strings = 1
        "注释和字符串中的文字也会被收入补全
        let g:ycm_collect_identifiers_from_comments_and_strings = 0
        " 跳转到定义处
        nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
    " asyncomplete
    elseif g:completable == 2
        let g:asyncomplete_auto_popup = 1
        let g:asyncomplete_remove_duplicates = 1
        " python
        if executable('pyls')
            " pip install python-language-server
            au User lsp_setup call lsp#register_server({
                \ 'name': 'pyls',
                \ 'cmd': {server_info->['pyls']},
                \ 'whitelist': ['python'],
                \ })
        endif
        " file"
        au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
            \ 'name': 'file',
            \ 'whitelist': ['*'],
            \ 'priority': 10,
            \ 'completor': function('asyncomplete#sources#file#completor')
            \ }))
        " buffer"
        call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
            \ 'name': 'buffer',
            \ 'whitelist': ['*'],
            \ 'blacklist': ['go'],
            \ 'completor': function('asyncomplete#sources#buffer#completor'),
            \ }))

        if g:use_ultisnips && g:python_version == 3
            call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
              \ 'name': 'ultisnips',
              \ 'whitelist': ['*'],
              \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
              \ }))
        else
            call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
              \ 'name': 'neosnippet',
              \ 'whitelist': ['*'],
              \ 'completor': function('asyncomplete#sources#neosnippet#completor'),
              \ }))
        endif
    " deoplete
    elseif g:completable == 3
        let g:deoplete#enable_at_startup = 1
        set completeopt=menuone,noinsert,noselect
        set rtp+=$PLUG_PATH.'/deoplete.nvim/'
        if !has('nvim')
            let g:deoplete#enable_yarp=1
            set rtp+=$PLUG_PATH.'/nvim-yarp/'
            set rtp+=$PLUG_PATH.'/vim-hug-neovim-rpc'
        endif
        let g:deoplete#enable_camel_case=1
        " Enable heavy omni completion.
        if !exists('g:deoplete#keyword_patterns')
            let g:deoplete#keyword_patterns = {}
            let g:deoplete#keyword_patterns.tex = '\\?[a-zA-Z_]\w*'
        endif
        au FileType go let g:deoplete#complete_method = "omnifunc"
        if !exists('g:deoplete#omni_patterns')
            let g:deoplete#omni_patterns      = {}
            let g:deoplete#omni_patterns.php  = '[^. \t]->\h\w*\|\h\w*::'
            let g:deoplete#omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
            let g:deoplete#omni_patterns.c    = '[^.[:digit:] *\t]\%(\.\|->\)'
            let g:deoplete#omni_patterns.cpp  = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
            let g:deoplete#omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
            let g:deoplete#omni_patterns.java = '[^. *\t]\.\w*'
            let g:deoplete#omni_patterns.go   = '[^. *\t]\.\w*'
            " call deoplete#custom#set('go', 'min_pattern_length', 1)
        endif
        " <BS>: close popup and delete backword char.
        inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"
        if g:use_ultisnips
            call deoplete#custom#source('ultisnips', 'matchers', ['matcher_fuzzy'])
        endif
    " completor
    elseif g:completable == 4
        let g:completor_set_options = 0
        let g:completor_auto_trigger = 1
        set completeopt=menuone,noinsert,noselect
    " neocomplete
    elseif g:completable == 5
        let g:acp_enableAtStartup = 1
        let g:neocomplete#enable_at_startup = 1
        let g:neocomplete#enable_smart_case = 1
        let g:neocomplete#enable_auto_select = 0
        let g:neocomplete#enable_camel_case = 1
        let g:neocomplete#enable_auto_delimiter = 0
        let g:neocomplete#max_list = 15
        let g:neocomplete#force_overwrite_completefunc = 1
        " Define dictionary.
        let g:neocomplete_dictionary_filetype_lists = {
                    \ 'default' : '',
                    \ 'vimshell' : $HOME.'/.vimshell_hist',
                    \ 'scheme' : $HOME.'/.gosh_completions'
                    \ }
        " Define keyword.
        if !exists('g:neocomplete_keyword_patterns')
            let g:neocomplete_keyword_patterns = {}
            let g:neocomplete_keyword_patterns.tex = '\\?[a-zA-Z_]\w*'
        endif
        " Enable heavy omni completion.
        if !exists('g:neocomplete_omni_patterns')
            let g:neocomplete_omni_patterns      = {}
            let g:neocomplete_omni_patterns.php  = '[^. \t]->\h\w*\|\h\w*::'
            let g:neocomplete_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
            let g:neocomplete_omni_patterns.c    = '[^.[:digit:] *\t]\%(\.\|->\)'
            let g:neocomplete_omni_patterns.cpp  = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
            let g:neocomplete_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
            " let g:neocomplete_omni_patterns.go   = '[^. *\t]\.\w*'
            let g:neocomplete_omni_patterns.go   = '[0-9a-zA-Z_\.]{3,}'
            " call neocomplete#custom#set('go', 'min_pattern_length', 1)
        endif
        " <BS>: close popup and delete backword char.
        inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    " neocomplcache
    elseif g:completable == 6
        let g:neocomplcache_enable_insert_char_pre = 1
        let g:neocomplcache_enable_at_startup = 1
        let g:neocomplcache_enable_auto_select = 0
        let g:neocomplcache_enable_camel_case_completion = 1
        let g:neocomplcache_enable_smart_case = 1
        let g:neocomplcache_enable_auto_delimiter = 0
        let g:neocomplcache_max_list = 15
        let g:neocomplcache_force_overwrite_completefunc = 1
        if !exists('g:neocomplcache_keyword_patterns')
            let g:neocomplcache_keyword_patterns = {}
            let g:neocomplcache_keyword_patterns.tex = '\\?[a-zA-Z_]\w*'
        endif
        " Define dictionary.
        let g:neocomplcache_dictionary_filetype_lists = {
                    \ 'default' : '',
                    \ 'vimshell' : $HOME.'/.vimshell_hist',
                    \ 'scheme' : $HOME.'/.gosh_completions'
                    \ }
        " Enable heavy omni completion.
        if !exists('g:neocomplcache_omni_patterns')
            let g:neocomplcache_omni_patterns = {}
            let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
            let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
            let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
            let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
            let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
        endif
        " <BS>: close popup and delete backword char.
        inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
    endif
    " smart completion use neosnippet to expand
    if g:completable > 0
        imap <expr><C-j> pumvisible()? "\<C-y>":"\<CR>"
        " headache confict
        if g:completable==1
            imap <expr><Cr>  pumvisible()? "\<C-[>a":"\<CR>"
        else
            imap <expr><Cr>  pumvisible()? "\<C-y>":"\<CR>"
        endif

        if g:use_ultisnips
            " remap Ultisnips for compatibility
            let g:UltiSnipsListSnippets="<C-l>"
            let g:UltiSnipsExpandTrigger = '<C-k>'
            let g:UltiSnipsJumpForwardTrigger = '<C-f>'
            let g:UltiSnipsJumpBackwardTrigger = '<C-b>'
            " Ulti python version
            if g:python_version == 3
                let g:UltiSnipsUsePythonVersion = 3
            else
                let g:UltiSnipsUsePythonVersion = 2
            endif
            " tab for ExpandTrigger
            function! g:UltiSnips_Tab()
                if pumvisible()
                    call UltiSnips#ExpandSnippet()
                    if g:ulti_expand_res
                        return "\<Right>"
                    else
                        if empty(v:completed_item) || !len(get(v:completed_item,'menu'))
                            return "\<C-n>"
                        else
                            return "\<C-y>"
                        endif
                    endif
                else
                    return "\<Tab>"
                endif
            endfunction
            au BufEnter * exec "inoremap <silent> <Tab> <C-R>=g:UltiSnips_Tab()<cr>"
            " Ulti的代码片段的文件夹
            let g:UtiSnipsSnippetDirectories=[$PLUG_PATH."/vim-snippets/UltiSnips",$PLUG_PATH."/vim-snippets/snipets"]
            inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
            inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
            inoremap <expr> <PageDown>  pumvisible() ? "\<PageDown>\<C-n>\<C-p>" : "\<PageDown>"
            inoremap <expr> <PageUp> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
        else
            let g:neosnippet#enable_completed_snippet=1
            " c-k to expand
            imap <C-k> <Plug>(neosnippet_expand)
            smap <C-k> <Plug>(neosnippet_expand)
            xmap <C-k> <Plug>(neosnippet_expand_target)
            " c-f to jump
            imap <C-f> <Right><Plug>(neosnippet_jump)
            smap <C-f> <Right><Plug>(neosnippet_jump)
            inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
            inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
            inoremap <expr> <PageDown>  pumvisible() ? "\<C-n>" : "\<PageDown>"
            inoremap <expr> <PageUp> pumvisible() ? "\<C-p>" : "\<PageUp>"
            function! g:Neo_Snippet_Tab()
                if pumvisible() "popup menu apeared
                    if neosnippet#expandable()
                        return neosnippet#mappings#expand_impl()
                    else
                        if empty(v:completed_item) || !len(get(v:completed_item,'menu'))
                            return "\<C-n>"
                        else
                            return "\<C-j>"
                        endif
                    endif
                else
                    return "\<Tab>"
                endif
            endfunction
            au BufEnter * exec "inoremap <silent> <Tab> <C-R>=g:Neo_Snippet_Tab()<cr>"
            " Use honza's snippets.
            let g:neosnippet#snippets_directory=$PLUG_PATH.'/vim-snippets/snippets'
            " Enable neosnippet snipmate compatibility mode
            let g:neosnippet#enable_snipmate_compatibility = 1
            " Enable neosnippets when using go
            let g:go_snippet_engine = "neosnippet"
        endif
    endif
    if isdirectory(expand($PLUG_PATH."/ale")) && g:vim_advance == 1
        let g:ale_completion_enabled   = 1
        let g:ale_lint_on_enter        = 0
        let g:ale_lint_on_text_changed = 'always'
        nmap <C-l>l :ALEToggle<CR>
        " signs fo
        let g:ale_sign_column_always   = 1
        let g:ale_set_signs            = 1
        let g:ale_set_highlights       = 0
        let g:ale_sign_error           = 'E'
        let g:ale_sign_warning         = 'w'
        " message format
        let g:ale_echo_msg_error_str   = 'E'
        let g:ale_echo_msg_warning_str = 'W'
        let g:ale_echo_msg_format      = '[%linter%] %s [%code%]'

        let g:ale_fix_on_save          = 0
        let g:ale_set_loclist          = 0
        let g:ale_set_quickfix         = 0
        let g:ale_statusline_format    = ['E:%d', 'W:%d', '']
        "highlight clear ALEErrorSign
        "highlight clear ALEWarningSign
        nmap <silent> <leader>[ <Plug>(ale_previous_wrap)
        nmap <silent> <leader>] <Plug>(ale_next_wrap)
        " 特定后缀指定lint方式
        let g:ale_pattern_options_enabled = 1
        let b:ale_warn_about_trailing_whiteSpace = 0
        let g:ale_fixers ={}
        nmap <leader>gt :ALEGoToDefinition<CR>
    elseif isdirectory(expand($PLUG_PATH."/syntastic")) && g:vim_advance ==0
        let g:syntastic_error_symbol             = 'E'
        let g:syntastic_warning_symbol           = 'W'
        let g:syntastic_check_on_open            = 0
        let g:syntastic_check_on_wq              = 0
        let g:syntastic_python_checkers          = ['pyflakes'] " 使用pyflakes,速度比pylint快
        let g:syntastic_javascript_checkers      = ['jsl', 'jshint']
        let g:syntastic_html_checkers            = ['tidy', 'jshint']
        let g:syntastic_enable_highlighting      = 0
        " to see error location list
        let g:syntastic_always_populate_loc_list = 0
        let g:syntastic_auto_loc_list            = 0
        let g:syntastic_loc_list_height          = 5
        function! ToggleErrors()
            let old_last_winnr                    = winnr('$')
            lclose
            if old_last_winnr == winnr('$')
                Errors
            endif
        endfunction
        nnoremap <C-l>l :call ToggleErrors()<cr>
        nnoremap <C-l>n :lnext<cr>
        nnoremap <C-l>p :lprevious<cr>>
    endif

    if isdirectory(expand($PLUG_PATH."/asyncrun.vim")) && g:vim_advance == 1
        nmap <Leader>tr :AsyncRun
        function! RUNIT()
            exec "w"
            cclose
            call asyncrun#quickfix_toggle()
            if &filetype == 'c'
                exec ":AsyncRun g++ % -o %<"
                exec ":AsyncRun ./%<"
            elseif &filetype == 'cpp'
                exec ":AsyncRun g++ % -o %<"
                exec ":AsyncRun ./%<"
            elseif &filetype == 'java'
                exec ":AsyncRun javac %"
                exec ":AsyncRun java %<"
            elseif &filetype == 'sh'
                exec ":AsyncRun bash %"
            elseif &filetype == 'python'
                exec ":AsyncRun python %"
            elseif &filetype == 'perl'
                exec ":AsyncRun perl %"
            elseif &filetype == 'go'
                exec ":AsyncRun go run %"
            endif
        endfunction
        nmap <F5> :call RUNIT()<CR>
        nmap <leader><F5> :AsyncStop!<CR>
    elseif isdirectory(expand($PLUG_PATH."/vim-quickrun")) && g:vim_advance == 0
        nnoremap <F5> :QuickRun<Cr>
        let g:quickrun_config={"_":{"outputter":"message"}}
    endif
endif
" Functions
" Initialize directories
function! InitializeDirectories()
    let parent = $HOME
    let prefix = 'vim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }
    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif
    " To specify a different directory in which to place the vimbackup,
    " vimviews, vimundo, and vimswap files/directories, add the following to
    " your .vimrc.local file:
    "   let g:spf13_consolidated_directory = <full path to desired directory>
    "   eg: let g:spf13_consolidated_directory = $HOME . '/.vim/'
    if exists('g:spf13_consolidated_directory')
        let common_dir = g:spf13_consolidated_directory . prefix
    else
        let common_dir = parent . '/.' . prefix
    endif
    for [dirname, settingname] in items(dir_list)
        let directory = common_dir . dirname . '/'
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction
call InitializeDirectories()
" Strip whiteSpace
function! StripTrailingWhiteSpace()
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
" Shell command
function! s:RunShellCommand(cmdline)
    botright new
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal nobuflisted
    setlocal noswapfile
    setlocal nowrap
    setlocal filetype=shell
    setlocal syntax=shell
    call setline(1, a:cmdline)
    call setline(2, substitute(a:cmdline, '.', '=', 'g'))
    execute 'silent $read !' . escape(a:cmdline, '%#')
    setlocal nomodifiable
    1
endfunction
command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:ExpandFilenameAndExecute(command, file)
    execute a:command . " " . expand(a:file, ":p")
endfunction
