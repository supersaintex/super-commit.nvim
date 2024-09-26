# super-commit.nvim

## Installation

- `lazy.nvim`

  ```lua
  local plugins = {
    {'supersaintex/super-commit.nvim'},
  }

  require('super-commit').setup()
  ```

## Test

```bash
nvim --headless --noplugin -u tests/minimal_init.lua -c \
  "PlenaryBustedDirectory tests {minimal_init = 'tests/minimal_init.lua'}"
```

## Before Contribution

Use `pre-commit`. Follow the [official Quick start][1].

```bash
pre-commit install -t pre-commit -t commit-msg
```

Use [Conventional Commits][2].

> [!WARNING]
> Permission error may occur to access `.npm` directory when you first commit
> after installing pre-commit. To solve it, please set the owner of the directory
> to the current user.

```zsh
sudo chown -R $(whoami) ~/.npm
```

[1]: https://pre-commit.com/index.html#quick-start
[2]: https://www.conventionalcommits.org/en/v1.0.0/
