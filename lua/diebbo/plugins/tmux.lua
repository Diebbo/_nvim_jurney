return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
  keys = {
    { "<leader><c-h>",  "<cmd>TmuxNavigateLeft<cr>" },
    { "<leader><c-j>",  "<cmd>TmuxNavigateDown<cr>" },
    { "<leader><c-k>",  "<cmd>TmuxNavigateUp<cr>" },
    { "<leader><c-l>",  "<cmd>TmuxNavigateRight<cr>" },
    { "<leader><c-\\>", "<cmd>TmuxNavigatePrevious<cr>" },
  },
}
