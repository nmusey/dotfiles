let mapleader=" "

" Tabs
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>T :tabnew %<CR>
nnoremap <leader>j :tabp<CR>
nnoremap <leader>k :tabn<CR>
nnoremap <leader>J :tabm -<CR>
nnoremap <leader>K :tabm +<CR>

" Panes
nnoremap <leader>Y :vsplit<CR>
nnoremap <leader>U :split<CR>

" Navigation between files
nnoremap <leader>ft :NERDTreeToggle<CR>
nnoremap <leader>fo :NERDTree<CR>
nnoremap <leader>fq :NERDTreeClose<CR>
nnoremap <leader>ff :NERDTreeFocus<CR>
nnoremap <leader>ffc :NERDTreeFind<CR>
nnoremap <leader>r :grep<CR>
nnoremap <leader>R :grep <C-r><C-w><CR>
nnoremap <leader>s :Files<CR>

" Navigation in file
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gt <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)
nmap <leader>E <Plug>(coc-diagnostic-prev)
nmap <leader>e <Plug>(coc-diagnostic-next)
nmap <silent><C-s> <Plug>(coc-range-select)
xmap <silent><C-s> <Plug>(coc-range-select)

" Information
nnoremap <silent>K :call ShowDocumentation()<CR>
nnoremap <leader>g :GitGutterPreviewHunk<CR>

" COC keybinds
inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : coc#refresh
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : coc#refresh
inoremap <silent><expr> <C-l> coc#pum#visible() ? coc#pum#confirm() : coc#refresh

" Refactoring 
nmap <leader>rn <Plug>(coc-rename)
xmap <leader>pt <Plug>(coc-format-selected)
nmap <leader>pt <Plug>(coc-format-selected)
nmap <leader>ac <Plug>(coc-codeaction)
nmap <leader>qf <Plug>(coc-fix-current)
nmap <leader>re <Plug>(coc-codeaction-refactor)
xmap <leader>rf  <Plug>(coc-codeaction-refactor-selected)
nmap <leader>rf  <Plug>(coc-codeaction-refactor-selected)
nmap <silent><C-z> <Plug>(coc-codelens-action)

" Helper functions
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

command! -nargs=0 Format :call CocActionAsync('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
