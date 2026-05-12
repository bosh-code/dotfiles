#!/usr/bin/env zsh
#
# pbmd.test.zsh - tests for the pbmd function.
#

emulate -L zsh
setopt no_unset pipe_fail

# Use zsh's builtin mkdir/rm/etc — no PATH dependency, no shadowing.
zmodload -F zsh/files b:mkdir b:rm b:chmod

# Ensure standard system utilities are reachable. When zsh is invoked as
# `zsh some-script.zsh` it runs as a non-interactive, non-login shell and
# skips zprofile/zshrc, so PATH may not include /usr/bin etc.
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:${PATH:-}"

# test for needed commands before we start, so we don't get false failures due to missing utils
for cmd in mkdir cat stat sed mktemp; do
  if ! command -v $cmd >/dev/null 2>&1; then
    print -u2 "pbmd.test.zsh: required command '$cmd' not found in PATH"
    print -u2 "PATH=$PATH"
    exit 1
  fi
done
# echo "[debug] No commands missing. Starting pbmd tests..." >&2

# ---------------------------------------------------------------------------
# Test harness
# ---------------------------------------------------------------------------
typeset -gi PBMD_TESTS_RUN=0 PBMD_TESTS_FAILED=0
typeset -g  PBMD_CLIPBOARD_FILE

_red()   { print -P "%F{red}$*%f"; }
_green() { print -P "%F{green}$*%f"; }
_dim()   { print -P "%F{8}$*%f"; }

assert_eq() {
  local name=$1 expected=$2 actual=$3
  (( PBMD_TESTS_RUN++ ))
  if [[ $expected == $actual ]]; then
    _green "  ✓ $name"
  else
    (( PBMD_TESTS_FAILED++ ))
    _red   "  ✗ $name"
    _dim   "    expected:"
    print -r -- "$expected" | sed 's/^/      | /'
    _dim   "    actual:"
    print -r -- "$actual"   | sed 's/^/      | /'
  fi
}

assert_contains() {
  local name=$1 needle=$2 haystack=$3
  (( PBMD_TESTS_RUN++ ))
  if [[ $haystack == *$needle* ]]; then
    _green "  ✓ $name"
  else
    (( PBMD_TESTS_FAILED++ ))
    _red   "  ✗ $name"
    _dim   "    expected to contain:"
    print -r -- "$needle"   | sed 's/^/      | /'
    _dim   "    actual:"
    print -r -- "$haystack" | sed 's/^/      | /'
  fi
}

# ---------------------------------------------------------------------------
# Setup: stub pbcopy and load pbmd
# ---------------------------------------------------------------------------
PBMD_TMPDIR=$(mktemp -d -t pbmd-test.XXXXXX)
PBMD_CLIPBOARD_FILE="$PBMD_TMPDIR/clipboard"
trap 'rm -rf "$PBMD_TMPDIR"' EXIT
# Debug trap for unexpected errors. Uncomment to get a line number and exit code on failure.
# trap 'print -u2 "[trap] ERR at line $LINENO (last command exit=$?)"' ZERR

# Replace pbcopy with a function that writes to a file we can inspect.
pbcopy() { cat > "$PBMD_CLIPBOARD_FILE"; }

# Helper: read what was "copied" in the most recent pbmd call.
clipboard() { [[ -f $PBMD_CLIPBOARD_FILE ]] && cat "$PBMD_CLIPBOARD_FILE"; }

# Reset clipboard between tests.
reset_clipboard() { : > "$PBMD_CLIPBOARD_FILE"; }

# Load the function under test (autoload-style sourcing).
PBMD_SCRIPT="${0:A:h}/../functions/pbmd"
# echo "[debug] Loading pbmd from $PBMD_SCRIPT" >&2
[[ -r $PBMD_SCRIPT ]] || { _red "cannot find pbmd at $PBMD_SCRIPT"; exit 1 }

# Wrap pbmd in a function so each invocation gets its own scope.
pbmd() {
  ( source "$PBMD_SCRIPT" "$@" )
}

# ---------------------------------------------------------------------------
# Fixture builder
# ---------------------------------------------------------------------------
fixture() {
  local name=$1; shift
  local path="$PBMD_TMPDIR/$name"
  mkdir -p "${path:h}"
  print -rn -- "$*" > "$path"
  print -r -- "$path"
}

# ---------------------------------------------------------------------------
# Tests
# ---------------------------------------------------------------------------
printf "\nRunning pbmd tests...\n"
print

# --- language detection --------------------------------------------------
print "Language detection:"

f=$(fixture script.py 'print("hi")')
reset_clipboard; pbmd -t "$f"
assert_contains "python by extension"     '```python' "$(clipboard)"
assert_contains "comment header for py"   '# script.py' "$(clipboard)"

f=$(fixture .zshenv 'export FOO=1')
reset_clipboard; pbmd -t "$f"
assert_contains "zsh by basename"         '```zsh' "$(clipboard)"

f=$(fixture data.json '{"a":1}')
reset_clipboard; pbmd -t "$f"
assert_contains "backticked header for json" '`data.json`:' "$(clipboard)"
assert_contains "json fence"              '```json'   "$(clipboard)"

# --- shebang fallback ----------------------------------------------------
print
print "Shebang detection:"

f=$(fixture noext "#!/usr/bin/env python
print(1)")
reset_clipboard; pbmd -t "$f"
assert_contains "shebang -> python"       '```python' "$(clipboard)"

f=$(fixture mystery "#!/usr/bin/env bash
echo hi")
reset_clipboard; pbmd -t "$f"
assert_contains "shebang -> bash"         '```bash'   "$(clipboard)"

# --- flags --------------------------------------------------------------
print
print "Flags:"

f=$(fixture deep/nested/file.ts 'export const x = 1')

reset_clipboard; pbmd "$f"
assert_contains "default uses full path"  "$f"        "$(clipboard)"

reset_clipboard; pbmd -t "$f"
assert_contains "--trim uses basename"    'file.ts'   "$(clipboard)"

reset_clipboard; pbmd -n "$f"
clip=$(clipboard)
[[ $clip != *"file.ts"* ]] && _green "  ✓ --no-header omits filename" || { _red "  ✗ --no-header omits filename"; (( PBMD_TESTS_FAILED++ )); }
(( PBMD_TESTS_RUN++ ))

reset_clipboard
out=$(pbmd -e -t "$f")
assert_contains "--echo prints to stdout" 'file.ts'   "$out"
assert_contains "--echo also copies"      'file.ts'   "$(clipboard)"

reset_clipboard
out=$(pbmd --no-copy -e -t "$f")
[[ -z $(clipboard) ]] && _green "  ✓ --no-copy leaves clipboard empty" || { _red "  ✗ --no-copy leaves clipboard empty"; (( PBMD_TESTS_FAILED++ )); }
(( PBMD_TESTS_RUN++ ))
assert_contains "--no-copy still echoes"  'file.ts'   "$out"

# --- forced language ----------------------------------------------------
reset_clipboard; pbmd -l rust -t "$f"
assert_contains "--lang overrides"        '```rust'   "$(clipboard)"

# --- size guard ---------------------------------------------------------
print
print "Size guard:"

big=$(fixture big.txt "$(printf 'x%.0s' {1..2000})")
reset_clipboard
err=$(PBMD_MAX_BYTES=100 pbmd -t "$big" 2>&1 >/dev/null) && true
assert_contains "refuses files over limit" 'refusing to copy' "$err"
[[ -z $(clipboard) ]] && _green "  ✓ clipboard untouched on refusal" || { _red "  ✗ clipboard untouched on refusal"; (( PBMD_TESTS_FAILED++ )); }
(( PBMD_TESTS_RUN++ ))

# --- fence escalation ---------------------------------------------------
print
print "Fence escalation:"

f=$(fixture inner.md '```sh
echo hi
```')
reset_clipboard; pbmd -t "$f"
assert_contains "uses 4-backtick outer fence" '````' "$(clipboard)"

# --- PBMD_DEFAULT_FLAGS -------------------------------------------------
print
print "PBMD_DEFAULT_FLAGS:"

f=$(fixture deep/nested/file.ts 'x')
reset_clipboard
PBMD_DEFAULT_FLAGS="-t" pbmd "$f"
assert_contains "default flags applied"   'file.ts'  "$(clipboard)"

# --- stdin --------------------------------------------------------------
print
print "Stdin:"

reset_clipboard
print -rn -- 'console.log(1)' | pbmd --stdin -l javascript
assert_contains "stdin with --lang"       '```javascript' "$(clipboard)"
assert_contains "stdin content copied"    'console.log(1)' "$(clipboard)"

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------
print
if (( PBMD_TESTS_FAILED == 0 )); then
  _green "All $PBMD_TESTS_RUN tests passed."
  exit 0
else
  _red "$PBMD_TESTS_FAILED of $PBMD_TESTS_RUN tests failed."
  exit 1
fi
