" encodding of configs
scriptencoding utf-8

" кодировка по-умолчанию
set encoding=utf-8

" фиксим Backspace key won't move from current line
set backspace=indent,eol,start


"----------------------------------------------------------------------Ж
" terminal setup
"-----------------------------------------------------------------------
" Extra terminal things
if ($TERM == "rxvt-unicode") && (&termencoding == "")
   set termencoding=utf-8
endif

if &term =~ "xterm" || &term == "rxvt-unicode"
   if exists('&t_SI')
      let &t_SI = "\<Esc>]12;lightgoldenrod\x7"
      let &t_EI = "\<Esc>]12;grey80\x7"
   endif
endif

"-----------------------------------------------------------------------
" settings
"-----------------------------------------------------------------------
set nocompatible	" Use Vim settings, rather then Vi settings (much better!).

" Do clever indent things. Don't make a # force column zero.
set autoindent		" always set autoindenting on
set smartindent
inoremap # X<BS>#


" хранить swap в отдельном каталоге
set directory=~/.vim/swap

" Порядок применения кодировок и формата файлов
set ffs=unix,dos,mac
set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866

" фикс для русских клавиш
"set langmap=йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ъ],фa,ыs,вd,аf,пg,рh,оj,лk,дl,ж\\;,э',яz,чx,сc,мv,иb,тn,ьm,б\\,,ю.,ё`,ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х{,Ъ},ФA,ЫS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж:,Э\\",ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б<,Ю>,Ё~

" показывать буфер вводимой команды
set showcmd		" display incomplete commands

" set tab to 4 spaces
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

" Search options: incremental search, do clever case things, highlight search
set incsearch           " do incremental searching
set ignorecase          " Do case insensitive matching
set hlsearch is
set infercase

set showfulltag         " Show full tags when doing search completion


" Speed up macros
"set lazyredraw

" No annoying error noises
set noerrorbells
set visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=


" Try to show at least three lines and two columns of context when scrolling
set scrolloff=3
set sidescrolloff=2

" Enable folds
set foldenable
set foldmethod=syntax
set foldclose=all
" не сворачивать рекурсивно
set foldlevel=99

" Enable filetype settings
filetype on
filetype plugin on
filetype indent on
au BufRead,BufNewFile /etc/nginx/* set ft=nginx 


" включить сохранение резервных копий
set backup
" ... в отдельном каталоге
set backupdir=~/.vim/backup
"set backupdir=.,~/tmp,~/
" сохранять умные резервные копии ежедневно
function! BackupDir()
    " определим каталог для сохранения резервной копии
    let l:backupdir=$HOME.'/.vim/backup/'.
                \substitute(expand('%:p:h'), '^'.$HOME, '~', '')
    " если каталог не существует, создадим его рекурсивно
    if !isdirectory(l:backupdir)
        call mkdir(l:backupdir, 'p', 0700)
    endif

    " переопределим каталог для резервных копий
    let &backupdir=l:backupdir

    " переопределим расширение файла резервной копии
    let &backupext=strftime('~%Y-%m-%d~')
endfunction

" выполним перед записью буффера на диск
autocmd! bufwritepre * call BackupDir()

" включим автоотступы для новых строк
set ai

set backspace=indent,eol,start "Make backspace delete lots of things
set viminfo='1000,f1,:1000,/1000  " Enable a nice big viminfo file
set history=500		" keep 500 lines of command line history

" показывать первую парную скобку после ввода второй ...
set showmatch           " Highlight matching parens
" ... чуть меньше времени
set matchtime=1

" показывать строку вкладок всегда
"set showtabline=2

" показывать строку статуса всегда
set laststatus=2

map Q gq		" Don't use Ex mode, use Q for formatting

" читать параметры конфигурации из открытого файла
set modeline

" перечитывать изменённые файлы автоматически
set autoread

set mouse=a		" mouse in xterm

" не выгружать swap скрытого буфера
set hidden

" использовать больше цветов в терминале
set t_Co=256

" удалять лишние пробелы при отступе
set shiftround

" использовать диалоги вместо сообщений об ошибках
set confirm

" использовать сокращённые диалоги
set shortmess=fimnrxoOtTI


" формат строки статуса
set statusline=%1*%m%*%2*%r%*%F%=\ Col:%3*%03c%*\ Ln:%3*%03l%*/%3*%03L%*\ File:%3*%{&filetype}%*/%3*%{&fileformat}%*/%3*%{&fileencoding}%*%<

set aw
set bg=dark
set laststatus=2
set mouse=a
set softtabstop=3
set smartcase
set showmode

" Wrap on these
"set whichwrap+=b,s,h,l,<,>,~,[,]
set whichwrap+=<,>,[,]

" Use the cool tab complete menu
set wildmenu
set wildignore=*.o,*~
set wildmode=longest,list,list:full

" Allow edit buffers to be hidden
set hidden

set keywordprg=mova
set helpheight=18
set formatoptions=tcqnb
set nrformats=alpha,hex
set dictionary=/usr/share/dict/words
set makeprg=perl\ -c\ %
set printdevice=prn
set printoptions=header:0

" показывать строку с позицией курсора
set ruler

syntax on
set textwidth=80

" показывать непечатаемые символы
set list listchars=tab:··,trail:·,extends:>,precedes:<

"set digraph  " чтобы всякие иероглифы можно было набирать
set vb noeb lcs+=tab:>-,trail:_,extends:>,precedes:<
au FileType text setlocal tw=78
au FileType  c   setlocal cindent
au FileType mail setlocal tw=77 nolist nobackup whichwrap=<,>,[,]
"au BufWinLeave * mkview
"au BufWinEnter * silent loadview
map [[ ?{<CR>w99[{
map ]] /}<CR>b99]}
map ][ j0[[%/{<CR>
map [] k$][%?}<CR>
vnoremap > >gv
vnoremap < <gv

" переключение режима отступов при вставке
set pastetoggle=<F12>

" сохранение текущего буфера
imap <F2> <Esc>:w<CR>a
nmap <F2> :w<CR>

map <F4> :new<CR>:only!<CR>
imap <F4> <Esc>:new<CR>:only!<CR>

map <F6> :bn!<CR>
imap <F6> <Esc>:bn!<CR>
"map <F8> :bd<CR>
"imap <F8> <Esc>:bd<CR>
map <F10> :qa!<CR>
imap <F10> <Esc>:qa!<CR>

" поиск выделенного текста
vnoremap <silent>* <ESC>:call VisualSearch('/')<CR>/<C-R>/<CR>
vnoremap <silent># <ESC>:call VisualSearch('?')<CR>?<C-R>/<CR>

" удалить пробелы в конце строк
noremap <silent>,t :call RemoveTrailingSpaces()<CR>:echo 'trailing spaces removed'<CR>

" автоматическое закрытие скобок
"inoremap { {}<LEFT>
"inoremap ( ()<LEFT>
"inoremap [ []<LEFT>

" сохранять выделение при визуальном изменении отступа
vnoremap < <gv
vnoremap > >gv

" не перепрыгивать через длинные строки при включенном переносе строк
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <DOWN> gj
nnoremap <UP> gk
vnoremap <DOWN> gj
vnoremap <UP> gk
inoremap <DOWN> <C-O>gj
inoremap <UP> <C-O>gk

" сохранять позицию при page up/down
nnoremap <PAGEUP> <C-U><C-U>
nnoremap <PAGEDOWN> <C-D><C-D>
inoremap <PAGEUP> <C-O><C-U><C-O><C-U>
inoremap <PAGEDOWN> <C-O><C-D><C-O><C-D>
vnoremap <PAGEUP> <C-U><C-U>
vnoremap <PAGEDOWN> <C-D><C-D>

" новая вкладка
nnoremap <C-T> :tabnew<CR>

" предыдущая вкладка
nnoremap <silent><A-LEFT> :call TabJump('left')<CR>
inoremap <silent><A-LEFT> <C-O>:call TabJump('left')<CR>
vnoremap <silent><A-LEFT> <ESC>:call TabJump('left')<CR>

" следующая вкладка
nnoremap <silent><A-RIGHT> :call TabJump('right')<CR>
inoremap <silent><A-RIGHT> <C-O>:call TabJump('right')<CR>
vnoremap <silent><A-RIGHT> <ESC>:call TabJump('right')<CR>

" первая вкладка
nnoremap <A-UP> :tabfirst<CR>
inoremap <A-UP> <C-O>:tabfirst<CR>
vnoremap <A-UP> <ESC>:tabfirst<CR>

" последняя вкладка
nnoremap <A-DOWN> :tablast<CR>
inoremap <A-DOWN> <C-O>:tablast<CR>
vnoremap <A-DOWN> <ESC>:tablast<CR>

" умный прыжок в начало строки
nnoremap <silent><HOME> :call SmartHome('n')<CR>
inoremap <silent><HOME> <C-R>=SmartHome('i')<CR>
vnoremap <silent><HOME> <ESC>:call SmartHome('v')<CR>

" умный прыжок в конец строки
nnoremap <silent><END> :call SmartEnd('n')<CR>
inoremap <silent><END> <C-R>=SmartEnd('i')<CR>
vnoremap <silent><END> <ESC>:call SmartEnd('v')<CR>

" следующая ошибка
imap <C-F10> <Esc>:cn<CR>i
nmap <C-F10> :cn<CR>

" предыдущая ошибка
imap <S-F10> <Esc>:cp<CR>i
nmap <S-F10> :cp<CR>

" вкл/выкл отображения номеров строк
imap <F1> <Esc>:set<Space>nu!<CR>a
nmap <F1> :set<Space>nu!<CR>

" вкл/выкл отображения найденных соответствий
imap <S-F1> <Esc>:set<Space>hls!<CR>a
nmap <S-F1> :set<Space>hls!<CR>

map <F9> :w!<CR>:!aspell check %<CR>:e! %<CR>
imap <F9> <Esc>:w!<CR>:!aspell check %<CR>:e! %<CR>
map <F7> /
imap <F7> <Esc>/
map <F11> <Esc>:if smartsel<CR><ESC>V else<ESC>gV
map  <F5> :read /tmp/vimbuff<CR>
imap <F5> <Esc>:read /tmp/vimbuff<CR>i
vmap <F5> !tee /tmp/vimbuff<CR>
map <C-Y> dd
imap <C-Y> <Esc>ddi
" автодополнение по Control+Space
imap <C-Space> <C-N>

" 'умный' Home
nmap <Home> ^
imap <Home> <Esc>I


" no search
nmap <silent> <F3> :silent nohlsearch<CR>
imap <silent> <F3> <C-o>:silent nohlsearch<CR>

" список буферов
imap <S-F4> <Esc>:buffers<CR>
nmap <S-F4> :buffers<CR>

" закрыть буфер
imap <C-F4> <Esc>:bd<CR>a
nmap <C-F4> :bd<CR>

" добавляем гламурный file browser
nmap <silent> <Leader>p :NERDTreeToggle<CR>


" перекодировка
let b:encindex=0
function! RotateEnc()
    let y = -1
    while y == -1
        let encstring = "#8bit-cp1251#8bit-cp866#utf-8#koi8-r#"
        let x = match(encstring,"#",b:encindex)
        let y = match(encstring,"#",x+1)
        let b:encindex = x+1
        if y == -1
            let b:encindex = 0
        else
            let str = strpart(encstring,x+1,y-x-1)
            return ":set encoding=".str
        endif
    endwhile
endfunction

map <F8> :execute RotateEnc()<CR>


hi mailQuoted1 ctermfg=yellow
hi mailQuoted2 ctermfg=green
hi mailquoted3 ctermfg=cyan
hi mailQuoted4 ctermfg=yellow
hi mailQuoted5 ctermfg=green
hi mailquoted6 ctermfg=cyan
hi MailSignature ctermfg=red


" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

endif " has("autocmd")


" передвигаемся по вкладкам
function! TabJump(direction)
    let l:tablen=tabpagenr('$')
    let l:tabcur=tabpagenr()
    if a:direction=='left'
        if l:tabcur>1
            execute 'tabprevious'
        endif
    else
        if l:tabcur!=l:tablen
            execute 'tabnext'
        endif
    endif
endfunction

" передвигаем вкладки
function! TabMove(direction)
    let l:tablen=tabpagenr('$')
    let l:tabcur=tabpagenr()
    if a:direction=='left'
        if l:tabcur>1
            execute 'tabmove' l:tabcur-2
        endif
    else
        if l:tabcur!=l:tablen
            execute 'tabmove' l:tabcur
        endif
    endif
endfunction

" удалить пробелы в конце строк
function! RemoveTrailingSpaces()
    normal! mzHmy
    execute '%s/\s\+$//ge'
    normal! 'yzt`z
endfunction

" поиск выделенного текста
function! VisualSearch(cmd)
    let l:old_reg=getreg('"')
    let l:old_regtype=getregtype('"')
    normal! gvy
    let @/='\V'.substitute(substitute(substitute(escape(@@, a:cmd.'\'), '^\_s\+', '\\s\\+', ''), '\_s\+$', '\\s\\*', ''), '\_s\+', '\\_s\\+', 'g')
    normal! gV
    call setreg('"', l:old_reg, l:old_regtype)
endfunction

" умный прыжок в начало строки
function! SmartHome(mode)
    let l:curcol=col('.')
    if l:curcol>indent('.')+2
        call cursor(0, l:curcol-1)
    endif
    if l:curcol==1
        if &wrap
            normal! g^
        else
            normal! ^
        endif
    else
        if &wrap
            normal! g0
        else
            normal! 0
        endif
    endif
    if a:mode=='v'
        normal! msgv`s
    endif
    return ''
endfunction

" умный прыжок в конец строки
function! SmartEnd(mode)
    let l:curcol=col('.')
    let l:lastcol=a:mode=='i'?col('$'):col('$')-1
    "let l:lastcol=col('$')
    if l:curcol<l:lastcol-1
        call cursor(0, l:curcol+1)
    endif
    if l:curcol<l:lastcol
        if &wrap
            normal! g$
        else
            normal! $
        endif
    else
        normal! g_
    endif
    if a:mode=='i'
        call cursor(0, col('.')+1)
    endif
    if a:mode=='v'
        normal! msgv`s
    endif
    return ''
endfunction


"-----------------------------------------------------------------------
" plugin / script / app settings
"-----------------------------------------------------------------------

" Perl specific options
let perl_include_pod=1
let perl_fold=1
let perl_fold_blocks=1

" --- подсветка ---

" подсветка строки статуса
highlight user1 term=bold cterm=inverse,bold ctermbg=green gui=inverse,bold guibg=green
highlight user2 term=bold cterm=inverse,bold ctermbg=red gui=inverse,bold guibg=red
highlight user3 term=bold cterm=inverse,bold ctermbg=blue gui=inverse,bold guibg=blue

" подсветка непечатаемых символов
highlight specialkey ctermfg=lightgray guifg=lightgray
highlight nontext ctermfg=gray guifg=gray

" подсветка вкладок
highlight tabline term=none cterm=none ctermbg=lightgray guibg=lightgray
highlight tablinefill term=none cterm=none ctermbg=lightgray guibg=lightgray

