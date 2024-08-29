let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/Documents/projects/jidoka-sena/api
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +63 ~/Documents/projects/jidoka-sena/api/index.js
badd +1 combined.log
badd +27 app-error.log
badd +1 ~/Documents/projects/jidoka-sena/api/exception.log
badd +1 ~/Documents/projects/jidoka-sena/api/exceptions.log
badd +1 ~/Documents/projects/jidoka-sena/api/rejections.log
badd +1 app-info.log
badd +1 routes/clientes.js
badd +47 routes/cliente.js
badd +78 ~/Documents/projects/jidoka-sena/api/routes/clientes/clientes.js
badd +1 db/connection.js
badd +15 ~/Documents/projects/jidoka-sena/api/routes/categorias/categoria.js
badd +15 ~/Documents/projects/jidoka-sena/api/routes/categorias/categorias.js
badd +21 routes/productos/producto.js
badd +15 ~/Documents/projects/jidoka-sena/api/routes/productos/productos.js
badd +5 ~/Documents/projects/jidoka-sena/api/routes/producto.js
badd +72 ~/Documents/projects/jidoka-sena/api/routes/productos.js
badd +6 ~/Documents/projects/jidoka-sena/api/routes/categoria.js
badd +15 ~/Documents/projects/jidoka-sena/api/routes/categorias.js
badd +41 ~/Documents/projects/jidoka-sena/api/routes/facturas.js
badd +43 routes/detalle-facturas.js
badd +1 package.json
badd +1 ~/Documents/projects/jidoka-sena/api/bun.lockb
argglobal
%argdel
$argadd oil:///home/bliss/Documents/projects/jidoka-sena/api/
edit ~/Documents/projects/jidoka-sena/api/index.js
argglobal
balt app-error.log
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 54 - ((14 * winheight(0) + 14) / 29)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 54
normal! 0
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
