alias grep="rg"
alias egrep="rg -e"
alias fgrep="rg -F"
alias sgrep="rg --files-with-matches --no-filename -C 5"

# Search function combining ripgrep and delta
# Usage: rgd <pattern> [path] [options]
rgd() {
    if [ $# -eq 0 ]; then
        echo "Usage: rgd <pattern> [path] [ripgrep options]"
        echo "Examples:"
        echo "  rgd 'handle'                    # Search in current directory"
        echo "  rgd 'handle' src/               # Search in specific directory"
        echo "  rgd 'handle' file.txt           # Search in specific file"
        echo "  rgd 'handle' . -i               # Case-insensitive search"
        echo "  rgd 'handle' . -t py            # Search only Python files"
        return 1
    fi

    local pattern="$1"
    shift
    
    # Default to current directory if no path specified
    local path="."
    if [ $# -gt 0 ] && [ -e "$1" ]; then
        path="$1"
        shift
    fi
    
    # Run ripgrep with JSON output and pipe to delta
    # rg --json -C 2 "$pattern" "$path" "$@" | delta
    # need the full paths for some reason, dunno
    /usr/bin/rg --json -C 2 "$pattern" "$path" "$@" | /home/linuxbrew/.linuxbrew/bin/delta
}
