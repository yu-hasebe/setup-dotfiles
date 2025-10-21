# setup-dotfiles
**setup-dotfiles** is a script to create/delete symlinks (pointing to dotfiles) at `$HOME`.
It is assumed that you have a dotfiles directory that has dotfiles.
You can specify that directory to create symlinks at `$HOME`.

<img width="689" height="585" alt="Screenshot 2025-10-21 at 21 01 18" src="https://github.com/user-attachments/assets/233a725f-0d29-478e-90f4-0d52f30338e5" />

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
