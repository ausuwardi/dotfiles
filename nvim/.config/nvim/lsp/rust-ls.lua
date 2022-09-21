-- To have rust lsp working:
--   1. Install rust-src with: `rustup component add rust-src`
--   2. Install rust-analyzer (see https://rust-analyzer.github.io/manual.html#rust-analyzer-language-server-binary)
require'lspconfig'.rust_analyzer.setup{}
