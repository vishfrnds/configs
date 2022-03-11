mark_pane() {
    if [ -n "$TMUX_PANE" ]; then
        sed -i "/$TMUX_PANE/d" /tmp/marked_panes 2>/dev/null
        echo ${TMUX_PANE} >> /tmp/marked_panes
    fi
}

alias m="mark_pane"
alias unm="rm /tmp/marked_panes 2>/dev/null"
