return {
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        "*",
        "!vim",
        "!help",
        "!gitcommit",
        "!gitrebase",
        "!gitconfig",
        "!gitignore",
      }, {
        RGB = true,
        RRGGBB = true,
        names = false,
        mode = "background",
      })
    end,
  }
}
