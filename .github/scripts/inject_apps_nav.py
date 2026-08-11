#!/usr/bin/env python3
"""Expand glob patterns in zensical.toml's nav section (e.g. "apps/*" or
"apps/*.md") into an explicit entry per matching file under docs/ --
zensical's nav parser has no glob support, so the file list must be
generated instead."""

import pathlib
import re
import sys

DOCS_DIR = pathlib.Path("docs")
TOML_PATH = pathlib.Path("zensical.toml")

# Matches a nav array line whose string value contains a "*", e.g.:
#     "apps/*",
#     "apps/*.md",
GLOB_LINE = re.compile(r'^(?P<indent>[ \t]*)"(?P<pattern>[^"]*\*[^"]*)",[ \t]*$', re.MULTILINE)


def expand_pattern(pattern: str) -> list[str]:
    glob_pattern = pattern if pattern.endswith(".md") else pattern.rstrip("*") + "*.md"
    return sorted(p.relative_to(DOCS_DIR).as_posix() for p in DOCS_DIR.glob(glob_pattern))


def replace(match: re.Match) -> str:
    indent, pattern = match.group("indent"), match.group("pattern")
    files = expand_pattern(pattern)
    if not files:
        raise SystemExit(f"Glob '{pattern}' matched no files under {DOCS_DIR}")
    return "\n".join(f'{indent}"{f}",' for f in files)


def main() -> int:
    content = TOML_PATH.read_text()
    new_content, count = GLOB_LINE.subn(replace, content)
    if count == 0:
        print("No glob patterns found in zensical.toml nav", file=sys.stderr)
        return 0
    TOML_PATH.write_text(new_content)
    print(f"Expanded {count} glob pattern(s)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
