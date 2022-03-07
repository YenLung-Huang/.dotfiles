-- Netrw
-- let g:netrw_fastbrowse = 0 
vim.g.netrw_fastbrowse = 0 -- close buffer when open file
-- autocmd FileType netrw setl bufhidden=delete
-- let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
-- vim.g.netrw_list_hide='\(^\|\s\s\)\zs\.\S\+'
-- let g:netrw_localcopydircmd = 'cp -r'
-- let g:netrw_altv=1
vim.g.netrw_altv=1
vim.g.netrw_sizestyle='h'
-- let g:netrw_sizestyle = 'h'
-- hi! link netrwMarkFile Search
-- " rmdir 
-- function! s:rmdir()
--   if input('delete '.fnamemodify(bufname(''),':p').getline('.').' ? (y/n)') ==# 'y'
--     if !delete(fnamemodify(bufname(''),':p').getline('.'),'rf')
--       if search('^\.\/$','Wb')
--         exe "norm \<cr>"
--       endif
--     endif
--   endif
-- endfunction
-- command! Rmnetrw call <SID>rmdir()
-- nnoremap <leader>eo :Explore<CR> " Explore file current directory
-- nnoremap <leader>el :ex.<CR> " Explore project directory list
-- 
