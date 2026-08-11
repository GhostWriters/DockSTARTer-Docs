# Contributing

All code in this repository should be neat and tidy.

More important than being beautiful is being functional. This repository is primarily shell scripts and YAML files.

We use [GitHub Actions](https://github.com/GhostWriters/DockSTARTer/actions) to run [checks](https://github.com/GhostWriters/DockSTARTer/tree/main/.github/workflows) on the code in the repository. Code must pass checks run by GitHub Actions in order to merge to the `main` branch of the repository.

Try not to [code like a cowboy](https://en.wikipedia.org/wiki/Cowboy_coding).

## Setting up your Dev Environment

1. Fork this repository and clone it onto your system. In later steps we'll refer to the location of your local repository as `/path/to/your/ds-repo`
1. Run `bash /path/to/your/ds-repo/main.sh`
1. The `ds` symlink should be created but let's verify. We'll run `whereis` to see where `ds` is and then run `ls -l` on this path to ensure the symlink points to `/path/to/your/ds-repo/main.sh`. E.g:

```shell
dev0@dev0:~/gitsource/DockSTARTer$ whereis ds
ds: /usr/bin/ds /usr/local/bin/ds
dev0@dev0:~/gitsource/DockSTARTer$ ls -l /usr/bin/ds
lrwxrwxrwx 1 root root 40 Jun 30 12:36 /usr/bin/ds -> /path/to/your/ds-repo/main.sh
```

Now you are free to develop and test as usual. All changes in your git repo can be tested in the ds GUI and with `ds` in the CLI.

## Shell scripts

- Remember [Shell Scripts Matter](https://dev.to/thiht/shell-scripts-matter)
- [Use the Unofficial Bash Strict Mode](http://redsymbol.net/articles/unofficial-bash-strict-mode/)
- Follow the [Shell Style Guide](https://google.github.io/styleguide/shell.xml)
- Use [Defensive BASH Programming](https://web.archive.org/web/20180917174959/http://www.kfirlavi.com/blog/2012/11/14/defensive-bash-programming/)
- Should be validated using the following tools (recommended to be installed locally):
  - [shellcheck](https://github.com/koalaman/shellcheck)
  - [shfmt](https://github.com/mvdan/sh)

## Markdown files

- Should be checked with [markdownlint](https://github.com/markdownlint/markdownlint)
  - [Rules](https://github.com/markdownlint/markdownlint/blob/master/docs/RULES.md#rules) MD013, MD033, and MD034 are exempted from linting. E.g. running from the CLI `mdl -r ~MD013,~MD033,~MD034 <.md file path>`
