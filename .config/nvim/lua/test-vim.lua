function nmap(shortcut, command)
  vim.api.nvim_set_keymap('n', shortcut, command, { noremap = true })
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end


--can't make it work yet, try again in the future
--function NeotermTest(cmd)
  --if vim.g.neoterm["last_active"] > 0 then
    --local id = vim.g.neoterm.last_id
    --local instance = vim.g.neoterm.instances[tostring(id)]

    --if vim.fn['bufwinnr'](instance.origin.last_buffer_id) <= 0 then
      --vim.api.nvim_command('split')
      --vim.api.nvim_command('resize 20')
      --vim.api.nvim_exec("call neoterm#open({ 'target':  " .. id .. " })", false)
    --end
    --vim.api.nvim_exec("call neoterm#do({ 'cmd': '" .. cmd .. "', 'target': " .. id .. "})", false)
  --else
    --vim.api.nvim_command('split')
    --vim.api.nvim_command('resize 20')
    --vim.api.nvim_command('enew')
    --vim.api.nvim_exec("call neoterm#new()", false)
    --vim.api.nvim_exec("call neoterm#do({ 'cmd': '" .. cmd .. "'})", false)
  --end
--end

-- custom strategy
vim.cmd([[
  function! NeotermTest(cmd)
    if g:neoterm.has_any()
      let l:id = g:neoterm.last_id
      let l:instance = g:neoterm.instances[l:id]
      if bufwinnr(l:instance.buffer_id) <= 0
        execute "split"
        execute "resize 20"
        call neoterm#open({ 'target': l:id })
      endif
      call neoterm#do({ 'cmd': a:cmd, 'target': l:id })
    else
      execute "split"
      execute "resize 20"
      execute "enew"
      call neoterm#new()
      call neoterm#do({ 'cmd': a:cmd })
    endif
  endfunction
]])

-- settings
-- vim.g.test = {}
-- vim.g["test#custom_strategies"] = {
  -- CustomNeotermStrategy = NeotermTest
-- }
-- vim.g["test#strategy"] = 'CustomNeotermStrategy'
vim.g["test#preserve_screen"] = 1
vim.g.neoterm_autoscroll = 1 -- always scroll to the end of the command output

-- vim.g['test#php#phpunit#executable'] = 'docker exec suitecrm-suitecrm-1 ./vendor/bin/phpunit --configuration ./tests/phpunit.xml.dist --stop-on-failure'
vim.g['test#php#phpunit#executable'] = 'docker exec erp_api-erp_api-1 ./vendor/bin/phpunit'

-- mappings
nmap('<leader>tn', ':TestNearest<CR>')
nmap('<leader>tf', ':TestFile<CR>')
nmap('<leader>ts', ':TestSuite<CR>')
nmap('<leader>tl', ':TestLast<CR>')
nmap('<leader>tv', ':TestVisit<CR>')
