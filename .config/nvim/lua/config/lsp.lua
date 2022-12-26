local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
        end,
    },
    mapping = {
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    },

    sources = cmp.config.sources({
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        -- { name = 'vsnip' }, -- For vsnip users.
        { name = "luasnip" }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = "buffer" },
        { name = "path" },
    }),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

-- LSP settings
local nvim_lsp = require("lspconfig")
local on_attach = function(client, bufnr)
    require("lsp_signature").on_attach()

    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local opts = { noremap = true, silent = true }
    local keymap = {
        { "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>" },
        { "gd", "<cmd>lua vim.lsp.buf.definition()<CR>" },
        { "K", "<cmd>lua vim.lsp.buf.hover()<CR>" },
        { "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>" },
        { "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>" },
        { "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>" },
        { "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>" },
        { "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>" },
        { "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>" },
        { "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>" },
        { "gr", "<cmd>lua vim.lsp.buf.references()<CR>" },
        { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>" },
        { "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>" },
        { "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>" },
        { "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>" },
        { "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>" },
        { "<leader>so", [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]] },
    }

    for _, key_val in ipairs(keymap) do
        local key, val = unpack(key_val)
        vim.api.nvim_buf_set_keymap(bufnr, "n", key, val, opts)
    end
    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
end

-- nvim-cmp supports additional completion capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Enable the following language servers
local servers = { "rnix", "clojure_lsp", "elmls" }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

nvim_lsp.sumneko_lua.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
        },
    },
})

local on_attach_rust = function(client, bufnr)
    local keymap = vim.keymap.set
    local key_opts = { silent = true }

    -- formatting is done by the null-ls
    client.server_capabilities.formatting = false
    client.server_capabilities.range_formatting = false

    keymap("n", "<leader>rh", "<cmd>RustSetInlayHints<Cr>", key_opts)
    keymap("n", "<leader>rhd", "<cmd>RustDisableInlayHints<Cr>", key_opts)
    keymap("n", "<leader>th", "<cmd>RustToggleInlayHints<Cr>", key_opts)
    keymap("n", "<leader>rr", "<cmd>RustRunnables<Cr>", key_opts)
    keymap("n", "<leader>rem", "<cmd>RustExpandMacro<Cr>", key_opts)
    keymap("n", "<leader>roc", "<cmd>RustOpenCargo<Cr>", key_opts)
    keymap("n", "<leader>rpm", "<cmd>RustParentModule<Cr>", key_opts)
    keymap("n", "<leader>rjl", "<cmd>RustJoinLines<Cr>", key_opts)
    keymap("n", "<leader>rha", "<cmd>RustHoverActions<Cr>", key_opts)
    keymap("n", "<leader>rhr", "<cmd>RustHoverRange<Cr>", key_opts)
    keymap("n", "<leader>rmd", "<cmd>RustMoveItemDown<Cr>", key_opts)
    keymap("n", "<leader>rmu", "<cmd>RustMoveItemUp<Cr>", key_opts)
    keymap("n", "<leader>rsb", "<cmd>RustStartStandaloneServerForBuffer<Cr>", key_opts)
    keymap("n", "<leader>rd", "<cmd>RustDebuggables<Cr>", key_opts)
    keymap("n", "<leader>rv", "<cmd>RustViewCrateGraph<Cr>", key_opts)
    keymap("n", "<leader>rw", "<cmd>RustReloadWorkspace<Cr>", key_opts)
    keymap("n", "<leader>rss", "<cmd>RustSSR<Cr>", key_opts)
    keymap("n", "<leader>rxd", "<cmd>RustOpenExternalDocs<Cr>", key_opts)

    on_attach(client, bufnr)
end

require("rust-tools").setup({
    tools = {
        on_initialized = function()
            vim.cmd([[
            autocmd BufEnter,CursorHold,InsertLeave,BufWritePost *.rs silent! lua vim.lsp.codelens.refresh()
          ]])
        end,
    },
    server = {
        on_attach = on_attach_rust,
        capabilities = capabilities,
        settings = {
            ["rust-analyzer"] = {
                lens = {
                    enable = true,
                },
                checkOnSave = {
                    command = "clippy",
                },
            },
        },
    },
})
--nvim_lsp.rust_analyzer.setup({
--    on_attach = on_attach_rust,
--    capabilities = capabilities,
--})
