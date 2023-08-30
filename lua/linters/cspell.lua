-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- config for cspell
-- https://github.com/streetsidesoftware/cspell

local M = {
  lintSource = 'cspell',
  lintCommand = 'cspell --no-color --no-progress --no-summary ${INPUT}',
  lintIgnoreExitCode = false,
  lintStdin = false,
  lintFormats = { '%f:%l:%c - %m', '%f:%l:%c %m' },
  lintSeverity = 4, -- HINT
}

return M
