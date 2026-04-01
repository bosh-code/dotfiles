# MARK: gclean

# Checkout main/master and delete local dev & tst branches
function gcleandt() {
    echo "🔍 Starting gcleandt..."

    echo "Checking for main branch..."
    if git show-ref --verify --quiet refs/heads/main; then
        echo "✅ Found main branch, checking it out..."
        git checkout main
    else
        echo "❌ main branch not found"

        echo "Checking for master branch..."
        if git show-ref --verify --quiet refs/heads/master; then
            echo "✅ Found master branch, checking it out..."
            git checkout master
        else
            echo "❌ No master branch found either"
            return 1
        fi
    fi

    echo "🔍 Looking for dev & tst branches..."
    branches_to_delete=$(git branch | grep -E "dev|tst" || echo "")

    if [ -n "$branches_to_delete" ]; then
        echo "Found branches to delete:"
        echo "$branches_to_delete"
        echo "🗑️  Deleting branches..."
        echo "$branches_to_delete" | xargs git branch -D
    else
        echo "❌ No dev or tst branches found :("
    fi

    echo "✨ gclean finished"
}

alias gclean="gcleandt" # git clean (dev tst)

# MARK: devmerge

# Remove local dev, merge current branch into it, push it.
function devmerge() {
    target_branch=${1:-dev}  # Use first argument if provided, otherwise use 'dev'
    echo "🔄 Starting merge to $target_branch..."

    # Store current branch name
    current_branch=$(git branch --show-current)
    echo "📌 Current branch: $current_branch"

    # Check if we're on a protected branch
    if [[ "$current_branch" =~ ^(dev|test|main|master)$ ]]; then
        echo "❌ Cannot merge from $current_branch - it's a \"protected\" branch"
        return 1
    fi

    # Delete local target branch if it exists
    echo "🗑️  Removing local $target_branch branch if it exists..."
    git branch -D "$target_branch" 2>/dev/null || echo "No local $target_branch branch to delete"

    # Fetch and checkout target branch
    echo "⬇️  Fetching and checking out $target_branch..."
    git fetch origin "$target_branch" && git checkout "$target_branch" || {
        echo "❌ Failed to fetch/checkout $target_branch branch"
        return 1
    }

    # Merge current branch into target
    echo "🔀 Merging $current_branch into $target_branch..."
    if git merge "$current_branch"; then
        # Push to remote
        echo "⬆️  Pushing to remote $target_branch..."
        if git push origin "$target_branch"; then
            # Return to original branch
            echo "↩️  Returning to $current_branch..."
            git checkout "$current_branch"
            echo "✅ All done! Merged $current_branch into $target_branch and pushed"
        else
            echo "❌ Failed to push to remote $target_branch"
            git checkout "$current_branch"
            return 1
        fi
    else
        echo "❌ Merge failed, returning to $current_branch"
        git merge --abort
        git checkout "$current_branch"
        return 1
    fi
}

alias gdm="devmerge" # git devmerge
alias gtm="devmerge tst" # git devmerge tst


# MARK: resetbranch

# Reset a branch to match origin/master
function git_reset_branch() {
    local target_branch="$1"
    local source_branch="${2:-master}"  # Default to master if not specified

    # Validate inputs
    if [[ -z "$target_branch" ]]; then
        echo "Error: Target branch must be specified"
        echo "Usage: git_reset_branch <target_branch> [source_branch]"
        return 1
    fi

    echo "Resetting branch '$target_branch' to match 'origin/$source_branch'"

    # Fetch latest changes
    echo "Fetching from origin..."
    git fetch origin

    # Checkout the target branch
    echo "Checking out $target_branch..."
    git checkout "$target_branch"

    # Reset hard to the source branch
    echo "Resetting $target_branch to origin/$source_branch..."
    git reset --hard "origin/$source_branch"

    # Force push with lease for safety
    echo "Pushing changes to origin/$target_branch..."
    git push --force-with-lease origin "$target_branch"

    echo "Successfully reset $target_branch to origin/$source_branch"
}

alias grst="git_reset_branch"
alias grstd="grst dev"
alias grstt="grst tst"

# MARK: gclcd

# Git clone + cd function
function gclcdir() {
    if [[ -z "$1" ]]; then
        echo "Usage: gclcdir <repository_url>"
        return 1
    fi

    git clone "$1" && cd "$(basename "$1" .git)" || return
}

alias gcld="gclcdir"
