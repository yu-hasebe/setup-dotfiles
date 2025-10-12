# setup-dotfiles
`setup.sh` creates symlinks (pointing to dotfiles) to `$HOME`.

You can see how to use that command:
```bash
./setup.sh -h
```

`install` creates symlinks.
`.`, `..`, `.git` are excluded for this specification.
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
