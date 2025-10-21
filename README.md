# setup-dotfiles
**setup-dotfiles** is a script to create/delete symlinks (pointing to dotfiles) at `$HOME`.
It is assumed that you have a dotfiles directory that has dotfiles.
You can specify that directory to create symlinks at `$HOME`.

<img width="676" height="527" alt="Screenshot 2025-10-12 at 19 52 32" src="https://github.com/user-attachments/assets/c22a7adb-a8a8-419f-b208-68973a8ae3fc" />

## setup.sh

You can see how to use that command:
```bash
./setup.sh --help
```

`install` creates symlinks.
`.`, `..`, and `.git` are automatically excluded from this specification.
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
