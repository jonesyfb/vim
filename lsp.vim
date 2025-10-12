let lspOpts = #{autoHighlightsDiags: v:true}
autocmd User LspSetup call LspOptionsSet(lspOpts)
let lspServers = [
            \ #{
            \   name: 'rust-analyazer',
            \   filetype: ['rust'],
            \   path: 'rust-analyzer',
            \   args: []
            \ }
            \ #{
            \   name: 'pyright',
            \   filetype: ['python'],
            \   path: 'pyright',
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

autocmd FileType rust setlocal omnifunc=lsp#complete

autocmd User LspSetup call LspOptionsSet(#{
            \   diagSignErrorText: '✘',
            \   diagSignWarningText: '▲',
            \   diagSignInfoText: '»',
            \   diagSignHintText: '⚑',
            \ })
