# setup-dotfiles
**setup-dotfiles** is a script to create/delete symlinks (pointing to dotfiles) at `$HOME`.
It is assumed that you have a dotfiles directory that has dotfiles.
You can specifiy that directory to create symlinks at `$HOME`.

## setup.sh

You can see how to use that command:
```bash
./setup.sh -h
```

`install` creates symlinks.
`.`, `..`, and `.git` are excluded for this specification.
Use `-h` to see the help message for detail.
```bash
./setup.sh install -t path/to/dotfiles/.*
```

`-f` option overwrites the existing files.
Use `-h` to see the help message for detail.
```bash
./setup.sh install -t path/to/dotfiles/.* -f
```

`uninstall` deletes symlinks.
```bash
./setup.sh uninstall -t path/to/dotfiles/.*
```
