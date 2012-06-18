set -x xterm-256color

function fish_prompt -d "Write out the prompt"
  printf '%s@%s%s%s%s> '  (whoami) (hostname|cut -d . -f 1) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if status --is-login
  for p in /usr/bin /usr/local/bin /opt/local/ ~/bin $HOME/.rbenv/bin $HOME/.rbenv/shims
    if test -d $p
      set PATH $p $PATH
    end
  end
end

set fish_greeting ""

function parse_git_branch
  sh -c 'git branch --no-color 2> /dev/null' | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
end

function fish_prompt -d "Write out the prompt"
  printf '%s%s@%s%s' (set_color brown) (whoami) (hostname|cut -d . -f 1) (set_color normal)

  # Color writeable dirs green, read-only dirs red
  if test -w "."
    printf ' %s%s' (set_color green) (prompt_pwd)
  else
    printf ' %s%s' (set_color red) (prompt_pwd)
  end

        # Print subversion tag or branch
        if test -d ".svn"
                printf ' %s%s%s' (set_color normal) (set_color blue) (parse_svn_tag_or_branch)
        end

  # Print subversion revision
  if test -d ".svn"
    printf '%s%s@%s' (set_color normal) (set_color blue) (parse_svn_revision)
  end

  # Print git branch
  if test -d ".git"
    printf ' %s%s/%s' (set_color normal) (set_color blue) (parse_git_branch)
  end
  printf '%s> ' (set_color normal)
end

rbenv rehash >/dev/null ^&1

function git
  hub $argv
end

function taskpaper
  vim ~/Dropbox/todo/todo.taskpaper
end

function gba
  git branch -a $argv
end

function gc
  git commit -v $argv
end

function gca
  git commit -a -v $argv
end

function gd
  git diff $argv
end

function gl
  git pull $argv
end

function glod
  git log --oneline --decorate $argv
end

function gp
  git push $argv
end

function gpr
  git pull --rebase $argv
end

function gst
  git status $argv
end

function glv
  git log -p -40 | vim - -R -c 'set foldmethod=syntax' $argv
end

function sc
  script_rails console $argv
end

function ss
  script_rails server -u $argv
end

function sdbc
  script_rails dbconsole -p $argv
end

function rtags
  rdoc -f tags app lib vendor config $argv
end

