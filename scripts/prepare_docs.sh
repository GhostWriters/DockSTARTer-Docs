#!/usr/bin/env bash
set -Eeuo pipefail

# Generates the docs pages that are copied in rather than committed:
#   docs/README.md   the home page, from the repo-root README.md
#   docs/apps/*.md   app pages, from a DockSTARTer-Templates checkout
#
# Usage: scripts/prepare_docs.sh [templates-dir]
# Without templates-dir only the home page is generated.

docs_edit="https://github.com/GhostWriters/DockSTARTer-Docs/edit/main"
templates_edit="https://github.com/GhostWriters/DockSTARTer-Templates/edit/main"

# copy_doc <src> <dest> <edit_url> [sed-script]: copies src to dest with
# edit_url added to its front matter (a new block when src has none), so the
# page's edit button opens src's real source (see theme/partials/actions.html).
# An edit_url src already sets is kept. sed-script, when given, edits src's
# content on the way.
copy_doc() {
	sed -e "${4-}" "$1" | awk -v url="$3" '
		{ line = $0; sub(/\r$/, "", line) }
		NR == 1 && line != "---" {
			print "---"; print "edit_url: " url; print "---"
		}
		NR == 1 && line == "---" { in_fm = 1; print; next }
		in_fm && line == "---" {
			if (!has_url) print "edit_url: " url
			in_fm = 0
		}
		in_fm && line ~ /^edit_url[ \t]*:/ { has_url = 1 }
		{ print }
	' > "$2"
}

templates="${1:+$(cd "$1" && pwd)}"
cd "$(dirname "${BASH_SOURCE[0]}")/.."

# The root README links its images as docs/assets/... so they show on GitHub
# for any branch; on the site the page lives in docs/, so drop the prefix.
copy_doc README.md docs/README.md "${docs_edit}/README.md" \
	's#\](docs/#](#g; s#src="docs/#src="#g'

[[ -n ${templates} ]] || exit 0

mkdir -p docs/apps
# App docs are README.md, co-located with each app's own template files --
# rename to <appname>.md on copy so the apps' identically named READMEs don't
# collide once flattened into docs/apps/.
for appdir in "${templates}"/.apps/*/; do
	appname="$(basename "${appdir}")"
	# Skip non-alphanumeric folder names (e.g. legacy duplicates like
	# minecraft_bedrock_server, superseded by minecraftbedrockserver).
	case "${appname}" in
		*[!a-zA-Z0-9]*) continue ;;
	esac
	if [[ -f "${appdir}README.md" ]]; then
		copy_doc "${appdir}README.md" "docs/apps/${appname}.md" \
			"${templates_edit}/.apps/${appname}/README.md"
	fi
done
# Orphaned docs with no matching .apps/ folder (e.g. removed/renamed apps).
for doc in "${templates}"/docs/apps/*.md; do
	[[ -f ${doc} ]] || continue
	copy_doc "${doc}" "docs/apps/$(basename "${doc}")" \
		"${templates_edit}/docs/apps/$(basename "${doc}")"
done
