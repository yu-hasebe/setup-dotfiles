# setup-dotfiles
**setup-dotfiles** is a script to create/delete symlinks (pointing to dotfiles) at `$HOME`.
It is assumed that you have a dotfiles directory that has dotfiles.
You can specifiy that directory to create symlinks at `$HOME`.

## setup.sh

You can see how to use that command:
```bash
./setup.sh --help
```

`install` creates symlinks.
`.`, `..`, and `.git` are excluded for this specification.
```bash
./setup.sh install --target path/to/dotfiles/.*
```

`--force` option overwrites the existing files.
```bash
./setup.sh install --target path/to/dotfiles/.* --force
```

`uninstall` deletes symlinks.
```bash
./setup.sh uninstall --target path/to/dotfiles/.*
```
