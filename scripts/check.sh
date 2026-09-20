#!/usr/bin/env bash
# Pre-publish safety scan for this public repo.
# Exits non-zero (blocking a push) if it finds a private identifier, a disallowed em dash,
# a skill with broken frontmatter, or a skill missing the injection guardrail.
# Run it by hand any time:  scripts/check.sh
set -uo pipefail
cd "$(git rev-parse --show-toplevel)" || exit 2

fail=0
note() { echo "  $*"; }

# Markdown files, and skill files, tracked by git. LICENSE has no .md extension and is
# skipped on purpose: its copyright line is allowed to name the author.
MD=$(git ls-files '*.md')
SKILLS=$(git ls-files 'skills/*/SKILL.md')

# 1. Private-identifier leak scan.
LEAK='(/Users/|ARIBA-WORKSPACE|\.ariba-config|_cos/runs|Cognitive Endurance|Experience-Led Growth|Unmissables|Reading Room|WIN Forge|Label_[0-9]|direct competitor)'
if hits=$(grep -rniE "$LEAK" $MD 2>/dev/null); then
  echo "FAIL: private identifier(s) found:"; note "$hits"; fail=1
fi

# 2. Personal name outside the LICENSE.
if hits=$(grep -rniE '\b(ariba|jahan)\b' $MD 2>/dev/null); then
  echo "FAIL: personal name found in a .md file:"; note "$hits"; fail=1
fi

# 3. Em dashes. Banned everywhere except plain-english's teaching examples.
# Match the raw UTF-8 bytes for em dash (E2 80 94) and en dash (E2 80 93) under LC_ALL=C so
# the result does not depend on the shell's locale.
for f in $MD; do
  [ "$f" = "skills/plain-english/SKILL.md" ] && continue
  hits=$(LC_ALL=C grep -nE $'\xe2\x80\x94|\xe2\x80\x93' "$f" 2>/dev/null) || true
  if [ -n "$hits" ]; then
    echo "FAIL: em/en dash in $f:"; note "$hits"; fail=1
  fi
done

# 4. Every skill has valid frontmatter.
for f in $SKILLS; do
  if ! { head -1 "$f" | grep -q '^---'; } || ! grep -q '^name:' "$f"; then
    echo "FAIL: $f is missing frontmatter (--- and name:)"; fail=1
  fi
done

# 5. Every skill carries the injection guardrail.
for f in $SKILLS; do
  if [ "$(grep -c '## Reading untrusted content' "$f")" -lt 1 ]; then
    echo "FAIL: $f is missing the '## Reading untrusted content' guardrail"; fail=1
  fi
done

if [ "$fail" -eq 0 ]; then
  echo "check.sh: clean. No leaks, no stray em dashes, frontmatter and guardrails present."
else
  echo ""
  echo "check.sh: found problems above. Push blocked. Fix them, or bypass once with 'git push --no-verify' if you are certain."
fi
exit $fail
