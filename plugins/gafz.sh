gafz() {
    # Get unstaged files (modified, new, deleted)
    local files
    files=$(git status --porcelain | grep -E '^[?M D]' | cut -c4-)
    
    # Check if there are any unstaged files
    if [ -z "$files" ]; then
        echo "No unstaged files found."
        return 1
    fi
    
    # Use fzf to select files (multi-select with tab)
    local selected_files
    selected_files=$(echo "$files" | fzf --multi \
        --preview '(git diff --color=always {} 2>/dev/null | delta | grep -q . && git diff --color=always {} 2>/dev/null ) || bat --color=always --style=plain --theme=ansi {} 2>/dev/null || cat {}' \
        --preview-window=right:60% \
        --color=bg:-1;preview-bg:1 \
        --header="Select files to add (TAB to multi-select, ENTER to confirm)")
    
    # Check if any files were selected
    if [ -z "$selected_files" ]; then
        echo "No files selected."
        return 1
    fi
    
    # Add selected files
    echo "Adding files:"
    echo "$selected_files" | while IFS= read -r file; do
        echo "  $file"
        git add "$file"
    done
    
    echo "Files added successfully!"
}
