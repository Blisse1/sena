let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/Documents/projects/jidoka-sena
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +1 ~/Documents/projects/jidoka-sena/database.sql
badd +24 ~/Documents/projects/jidoka-sena/index.js
badd +17 ~/Documents/projects/jidoka-sena/public/index.html
badd +15 package.json
badd +1 ~/Documents/projects/jidoka-sena/views/log-in.html
badd +114 ~/Documents/projects/jidoka-sena/views/clientes.html
badd +8 ~/Documents/projects/jidoka-sena/views/header.html
badd +20 public/styles/index-styles.css
badd +34 ~/Documents/projects/jidoka-sena/views/categorias.html
badd +71 ~/Documents/projects/jidoka-sena/views/productos.html
badd +83 ~/Documents/projects/jidoka-sena/views/facturas.html
badd +1 README.md
argglobal
%argdel
$argadd oil:///home/bliss/Documents/projects/jidoka-sena/
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
nohlsearch
let g:this_session = v:this_session
let g:this_obsession = v:this_session
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
