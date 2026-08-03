# Shared default layout: shell (left) | nvim (middle) | claude (right)
# Parameterized via T_SESSION_NAME / T_SESSION_ROOT, set by the `t` script.

session_root "${T_SESSION_ROOT:-$PWD}"
# Ignore the root inherited from the tmux session that launched `t`.
unset TMUXIFIER_SESSION_ROOT

if initialize_session "${T_SESSION_NAME:-$(basename "$PWD" | sed 's/\./_/g')}"; then
  # new_window "name" runs `set-option -t "name"` without a session qualifier,
  # which errors (and aborts the layout, via set -e) when another session is
  # current. Create the window unnamed and name it with a qualified target.
  new_window
  tmux rename-window -t "$session:$window" "dev"
  tmux set-option -w -t "$session:$window" allow-rename off
  split_h 75   # pane 2: middle and right three-quarters
  split_h 33   # pane 3: right third of that, leaving the middle half-width
  select_pane 2
  run_cmd "nvim"
  select_pane 3
  run_cmd "claude"
  select_pane 2
fi

finalize_and_go_to_session
