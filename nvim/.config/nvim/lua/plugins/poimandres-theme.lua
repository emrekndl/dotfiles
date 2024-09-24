return { 
  'olivercederborg/poimandres.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    disable_background = true,
    disable_float_background = false, 
    disable_italics = false, 
  },

  init = function()
    vim.cmd("colorscheme poimandres")
  end
}
