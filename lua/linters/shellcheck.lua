-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- config for shellcheck
-- https://github.com/koalaman/shellcheck

local M = {
  lintSource = 'shellcheck',
  lintCommand = 'shellcheck --color=never --format=gcc --external-sources -',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {
    '%f:%l:%c: %trror: %m',
    '%f:%l:%c: %tarning: %m',
    '%f:%l:%c: %tote: %m',
  },
}

return M
