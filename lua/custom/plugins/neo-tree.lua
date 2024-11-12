vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  keys = {
    { '<C-n>', '<cmd> Neotree toggle focus <CR>', desc = 'NeoTree' },
    { '<leader>nf', '<cmd> Neotree focus <CR>', desc = 'Neotree focus' },
  },
  config = function()
    require('neo-tree').setup {
      event_handlers = {
        {
          event = 'neo_tree_buffer_enter',
          handler = function()
            vim.cmd [[
          setlocal relativenumber
          ]]
          end,
        },
        {
          event = 'file_opened',
          handler = function()
            -- auto close
            -- vimc.cmd("Neotree close")
            -- OR
            require('neo-tree.command').execute { action = 'close' }
          end,
        },
      },
      window = {
        mappings = {
          ['<BS>'] = 'close_node',
        },
      },
      filesystem = {
        window = {
          popup = {
            position = { col = '100%', row = '1' },
            size = function(state)
              local root_name = vim.fn.fnamemodify(state.path, ':~')
              local root_len = string.len(root_name) + 4
              return {
                width = math.max(root_len, 50),
                height = vim.o.lines - 6,
              }
            end,
          },
        },
      },
    }
  end,
}
