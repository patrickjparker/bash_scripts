git_switch_interactive() {
  local branch
  branch=$(
    git branch --format='%(refname:short)' | grep -v "^\*" |
      fzf --height 40% --reverse \
        --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" --color=always {}' \
        --preview-window=right:50%:wrap \
        --bind 'ctrl-l:execute(git log --date=short --pretty="format:%C(auto)%cd %h%d %s" --color=always {} | less -r)' \
        --header 'CTRL-l to view full log'
  )
  if [ -n "$branch" ]; then
    git switch "$branch"
  else
    echo "No branch selected. Operation cancelled."
    return 1
  fi
}
