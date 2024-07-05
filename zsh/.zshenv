
# Source Cargo environment only if it exists
# tmux loading slowly is not because this, so don't mind
if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
else
    # Optional: Print a message if you want to be notified that Cargo is not installed
    # echo "Cargo environment not found. If you need Rust, please install it."
fi
