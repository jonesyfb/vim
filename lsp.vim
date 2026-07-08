let lspOpts = #{autoHighlightsDiags: v:true}
autocmd User LspSetup call LspOptionsSet(lspOpts)
let lspServers = [
            \ #{
            \   name: 'rust-analyzer',
            \   filetype: ['rust'],
            \   path: 'rust-analyzer',
            \   args: [],
            \   initializationOptions: #{
            \     check: #{ command: 'clippy' }
            \   }
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

autocmd BufWritePre *.rs,*.py LspFormat

autocmd FileType rust setlocal omnifunc=lsp#complete

autocmd User LspSetup call LspOptionsSet(#{
            \   diagSignErrorText: '✘',
            \   diagSignWarningText: '▲',
            \   diagSignInfoText: '»',
            \   diagSignHintText: '⚑',
            \ })
