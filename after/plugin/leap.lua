-- The below settings make Leap's highlighting closer to what you've been
-- used to in Lightspeed.

local leap = require('leap')
leap.add_default_mappings()
leap.opts.safe_labels = {}
-- leap.opts.case_sensitive = true

-- bidirectional jumps
-- vim.keymap.set("n", "s", function ()
--   local current_window = vim.fn.win_getid()
--   require('leap').leap { target_windows = { current_window } }
-- end)
