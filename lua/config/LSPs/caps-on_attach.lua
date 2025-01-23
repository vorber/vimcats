local M = {}
function M.on_attach(_, bufnr)
  -- we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.

  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("C-k", vim.lsp.buf.signature_help, "Signature Documentation")

  nmap("<leader>rr", vim.lsp.buf.rename, "[R]efactor - [R]ename")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")

  nmap("gr", require('telescope.builtin').lsp_references, "[G]oto  [R]eferences")
  nmap("gI", vim.lsp.buf.implementation, "[G]oto  [I]mplementation")
  nmap("<leader>ds", require('telescope.builtin').lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", require('telescope.builtin').lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  if nixCats('general.telescope') then
    nmap('gr', function() require('telescope.builtin').lsp_references() end, '[G]oto [R]eferences')
    nmap('gI', function() require('telescope.builtin').lsp_implementations() end, '[G]oto [I]mplementation')
    nmap('<leader>ds', function() require('telescope.builtin').lsp_document_symbols() end, '[D]ocument [S]ymbols')
    nmap('<leader>ws', function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end, '[W]orkspace [S]ymbols')
  end

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  -- nmap('<leader>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, '[W]orkspace [L]ist Folders')
  --
  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    elseif vim.lsp.buf.formatting then
      vim.lsp.buf.formatting()
    end
  end, { desc = 'Format current buffer with LSP' })

  vim.api.nvim_buf_create_user_command(bufnr, "RefreshCodeLens", function()
    vim.lsp.codelens.refresh()
    print "Refreshing CodeLens"
  end, { bang = true, })

end

function M.get_capabilities(server_name)
  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  -- if you make a package without it, make sure to check if it exists with nixCats!
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  if nixCats('general.cmp') then
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
  end
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return capabilities
end
return M
