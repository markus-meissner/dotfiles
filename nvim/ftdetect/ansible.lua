-- https://raw.githubusercontent.com/mfussenegger/nvim-ansible/refs/heads/main/ftdetect/ansible.lua

if vim.filetype then
  vim.filetype.add {
    pattern = {
      ['setup-.*%.yml'] = 'yaml.ansible',
      ['site.*%.yml'] = 'yaml.ansible',
      ['.*/host_vars/.*%.ya?ml'] = 'yaml.ansible',
      ['.*/group_vars/.*%.ya?ml'] = 'yaml.ansible',
      ['.*/group_vars/.*/.*%.ya?ml'] = 'yaml.ansible',
      ['.*/playbook.*%.ya?ml'] = 'yaml.ansible',
      ['.*/playbooks/.*%.ya?ml'] = 'yaml.ansible',
      ['.*/roles/.*/tasks/.*%.ya?ml'] = 'yaml.ansible',
      ['.*/roles/.*/handlers/.*%.ya?ml'] = 'yaml.ansible',
      ['.*/tasks/.*%.ya?ml'] = 'yaml.ansible',
      ['.*/roles/.*/template/.*'] = 'jinja2',
      ['.*/molecule/.*%.ya?ml'] = 'yaml.ansible',
    },
  }
else
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = {
      'setup-*.yml',
      'site*.yml',
      '*/host_vars/*.yml',
      '*/host_vars/*.yaml',
      '*/group_vars/*.yml',
      '*/group_vars/*.yaml',
      '*/group_vars/*/*.yml',
      '*/group_vars/*/*.yaml',
      '*/playbook*.yml',
      '*/playbook*.yaml',
      '*/playbooks/*.yml',
      '*/playbooks/*.yaml',
      '*/roles/*/tasks/*.yml',
      '*/roles/*/tasks/*.yaml',
      '*/roles/*/handlers/*.yml',
      '*/roles/*/handlers/*.yaml',
      '*/tasks/*.yml',
      '*/tasks/*.yaml',
      '*/molecule/*.yml',
      '*/molecule/*.yaml',
    },
    callback = function()
      vim.bo.filetype = 'yaml.ansible'
    end,
  })
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = {
      'roles/*/templates/*',
    },
    callback = function()
      vim.bo.filetype = 'jinja2'
    end,
  })
end
