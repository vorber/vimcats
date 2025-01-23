require('set')
require('remap')

-- NOTE: register the extra lze handlers because we want to use them.
require('lze').register_handlers(require('lze.x'))
-- NOTE: also add another one that makes enabling a spec for a category nicer
require('lze').register_handlers(require('nixCatsUtils.lzUtils').for_cat)

require('config.plugins')
require('config.LSPs')

if nixCats('lint') then
  require('config.lint')
end
if nixCats('format') then
  require('config.format')
end
