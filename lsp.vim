let lspOpts = #{autoHighlightsDiags: v:true}
autocmd User LspSetup call LspOptionsSet(lspOpts)
let lspServers = [
            \ #{
            \   name: 'rust-analyzer',
            \   filetype: ['rust'],
            \   path: 'rust-analyzer',
            \   args: []
            \ },
            \ #{
            \   name: 'pyright',
            \   filetype: ['python'],
            \   path: 'pyright-langserver',
            \   args: ['--stdio'],
            \   features: #{ diagnostics: v:false }
            \ },
            \ #{
            \   name: 'ruff',
            \   filetype: ['python'],
            \   path: 'ruff',
            \   args: ['server'],
            \   features: #{ documentFormatting: v:true, diagnostics: v:true }
            \ },
            \ #{
            \   name: 'html-language-server',
            \   filetype: ['html'],
            \   path: 'vscode-html-language-server',
            \   args: ['--stdio']
            \ },
            \ #{
            \   name: 'sqls',
            \   filetype: ['sql'],
            \   path: 'sqls',
            \   args: []
            \ }
            \ ]

autocmd User LspSetup call LspAddServer(lspServers)

nnoremap gd :LspGotoDefinition<CR>
nnoremap gr :LspShowReferences<CR>
nnoremap K :LspHover<CR>
nnoremap gl :LspDiag current<CR>
nnoremap <leader>nd :LspDiag next \| LspDiag current<CR>
nnoremap <leader>pd :LspDiag prev \| LspDiag current<CR>
nnoremap <silent> <C-Space> <C-x><C-o>
nnoremap <leader>f :LspFormat<CR>

" Format-on-save shells out directly to rustfmt/ruff instead of going
" through the LSP server, so it stays fast while rust-analyzer/pyright
" are still indexing (LspFormat would otherwise block on them).
function! s:FormatWithCmd(cmd) abort
  if !executable(split(a:cmd)[0])
    return
  endif
  let l:view = winsaveview()
  let l:out = systemlist(a:cmd, getline(1, '$'))
  if v:shell_error == 0 && !empty(l:out)
    silent! undojoin
    silent! %delete _
    call setline(1, l:out)
  endif
  call winrestview(l:view)
endfunction

autocmd BufWritePre *.rs call s:FormatWithCmd('rustfmt --edition 2021')
autocmd BufWritePre *.py call s:FormatWithCmd('ruff format -')

autocmd FileType rust setlocal omnifunc=lsp#complete

autocmd User LspSetup call LspOptionsSet(#{
            \   diagSignErrorText: '✘',
            \   diagSignWarningText: '▲',
            \   diagSignInfoText: '»',
            \   diagSignHintText: '⚑',
            \ })
