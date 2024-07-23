local M = {}

function M.create(alias, command, nargs, complete, options)
  vim.api.nvim_create_user_command(alias,
    function(opts)

      local args = {}

      for _, arg in ipairs(opts.fargs) do
        args = vim.tbl_extend("keep", args, vim.split(arg, " ", { trimempty = true }))
      end

      vim.api.nvim_cmd({
        cmd = command,
        args = args,
      }, {
        output = false,
      })

      vim.api.nvim_win_set_config(0, {
        width = math.floor(vim.o.columns / 2),
        height = math.floor(vim.o.lines / 1.2),
        row = 0,
        col = vim.o.columns,
        border = 'rounded',
        relative = "editor",
        anchor = "NE",
        style = "minimal",
        title = "Help",
        title_pos = "center",
        fixed = true,
      })
    end,
    {
      nargs = nargs,
      complete = complete,
    })
end

function M.setup(options)
  vim.g.did_setup_float = true
end

return M
