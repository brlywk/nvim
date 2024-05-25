# Neovim config

Personal Neovim config. Feel free to take inspiration, or outright use it as is if you like 😉
This readme mostly exists to remind myself of how to actually use some of the stuff I late at night thought were smart choices...

## Per project config

I use the wonderful [Neoconf](https://github.com/folke/neoconf.nvim) plugin to setup per project configuration, mostly for the wonderful world of Web Development, with JS / TS being neverending sources of conflicting LSP / Linter / Formatter and other tooling configurations. The main reason is that I like using Vue / Nuxt, but Volar wants to be TSServer, all Eslint configs for Vue are just weird, and Prettier thinks it's a great idea to dictate how formatting HAS to be done, no matter what a language's good practices say.

This is the format to configure said tools per project (example being for a Vue / Nuxt project):

```jsonc
{
  "lsp": {
    "disable": "tsserver",
  },
  "linter": {
    // if disable is set, linting will cancel if the linter specified is valid for the open filetype
    "disable": "eslint",
    // overwrite the default linter in neovim config with the linter specified here
    "javascript": "biomejs",
    "typescript": "biomejs",
  },
}
```
