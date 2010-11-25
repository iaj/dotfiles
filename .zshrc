# Author:  iaj (tyberion@gmail.com)
#
# Feel free to do whatever you would like with this file as long as you give
# credit where credit is due.
#
# If nothing else, you should at least look at the Behavior Overrides section
# to see if there's anything that you want to disable.  (Most people probably
# won't like that it changes their terminals' colors, but, who cares, I like
# it, and they can disable it. :-D )
#
# NOTE:
# This .zshrc does define LANG and LC_CTYPE.  If you don't want en_US.UTF-8 and
# C, search for those variable names and change them in the section "Environment
# Variables".
#
# NOTE:
# If you're editing this in Vim and don't know how folding works, type zR to
# unfold them all.
#
### myPathzj
# These settings are only for interactive shells. Return if not interactive.
# This stops us from ever accidentally executing, rather than sourcing, .zshrc
[[ -o nointeractive ]] && return
export PAGER=less
export EDITOR=vim
export LIBXCB_ALLOW_SLOPPY_LOCK=true
export MPD_PORT=1337
export MPD_HOST=127.0.0.1
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PYTHONPATH=/usr/local/lib/python2.6/site-packages:"${PYTHONPATH}"

if [ -d /opt/local/bin ]; then
  PATH=/opt/local/bin:$PATH
  MANPATH=$MANPATH:/opt/local/man
  INFOPATH=$INFOPATH:/opt/local/info
fi
if [ -d /opt/local/libexec/git-core ]; then
  PATH=/opt/local/libexec/git-core:$PATH
fi
if [ -d ~/bin ]; then
  PATH=~/bin:$PATH
  MANPATH=~/man:$MANPATH
  INFOPATH=~/info:$INFOPATH
fi

# Fast directory-pathing
    #bp=/Users/iaj/java/VeriDebug/Documents
    #bps=/Users/iaj/java/VeriDebug/src
    #w=$HOME/Documents/work
    #ba=$HOME/ba
    #logs=$HOME/Documents/textual\ logs/irc.freenode.net/Channels
    #queries=$HOME/Documents/textual\ logs/irc.freenode.net/Queries

# Use colorized output, necessary for prompts and completions.
autoload -U colors && colors
# Some shortcuts for colors.
local red="%{${fg[red]}%}"
local blue="%{${fg[blue]}%}"
local boldblue="%b%{${fg[blue]}%}"
local green="%{${fg[green]}%}"
local magenta="%{${fg[magenta]}%}"
local yellow="%{${fg[yellow]}%}"
local boldyellow="%B%{${fg[yellow]}%}"
local default="%{${fg[default]}%}"
local white="%B%{${fg[white]}%}"

# Colorize stderr in red. Very useful when looking for errors. Thanks to
# http://gentoo-wiki.com/wiki/Zsh for the basic script and Mikachu in #zsh on
# Freenode (2010-03-07 04:03) for some improvements (-r, printf). It's not yet
# perfect and doesn't work with su and git for example, but it can handle most
# interactive output quite well (even with no trailing new line) and in cases
# it doesn't work, the E alias can be used as workaround.
exec 2>>(while read -r -k -u 0 line; do
    printf '\e[91m%s\e[0m' "$line";
    #printf ${red} "$line";
    print -n $'\0';
done &)

### SETUP
# These settings are only for interactive shells. Return if not interactive.
# This stops us from ever accidentally executing, rather than sourcing, .zshrc
[[ -o nointeractive ]] && return

# Disable flow control, since it really just annoys me.
stty -ixon &>/dev/null

#### Functions for VCS-INFO
# Load the git-completion functions
if [ -d ~/git/zsh/Completion ]; then
    fpath=(~/git/zsh/Completion/*/*(/) $fpath)
fi
# Load the VCS Infobar
if [ -d ~/git/zsh/Functions/VCS_Info/ ]; then
    fpath=(~/git/zsh/Functions/VCS_Info/ ~/git/zsh/Functions/VCS_Info/Backends $fpath)
fi
# Set correct fpath to allow loading my functions (including completion
# functions). in this case: my own functions
#if [[ -d ~/git/zsh/Functions ]]; then
    #fpath=(~/.zsh/functions $fpath)
    #autoload ${fpath[1]}/^_*(^/:t)
#fi

# Originally from Jonathan Penn, with modifications by Gary Bernhardt
function whodoneit() {
    (set -e &&
        for x in $(git grep -I --name-only $1); do
            git blame -f -- $x | grep $1;
        done
    )
}

# Autoload add-zsh-hook to add/remove zsh hook functions easily.
autoload -Uz add-zsh-hook

#### Optional Behaviors
# Setting any of these options will modify the behavior of a new shell to
# better suit your needs.  These values given specify the default for each
# option when the shell starts.  At the moment, changing shellopts[utf8] during
# an execution does nothing whatsoever, as it only sets up some aliases and
# variables when the shell starts.  However, all of the other options can be
# changed while the shell is running to change its behavior from that point
# forward.
typeset -A shellopts
shellopts[utf8]=1         # Set up a few programs for UTF-8 mode
shellopts[titlebar]=1     # Whether the titlebar can be dynamically changed
shellopts[screen_names]=1 # Dynamically change window names in GNU screen
shellopts[preexec]=1      # Run preexec to update screen title and titlebar
shellopts[precmd]=1       # Run precmd to show job count and retval in RPROMPT
shellopts[rprompt]=1      # Show the right-side time, retval, job count prompt.

#### Helper Functions
# Checks if a file can be autoloaded by trying to load it in a subshell.
# If we find it, return 0, else 1
function autoloadable {
  ( unfunction $1 ; autoload -U +X $1 ) &>/dev/null
}
# Returns whether its argument should be considered "true"
# Succeeds with "1", "y", "yes", "t", and "true", case insensitive
function booleancheck {
  [[ -n "$1" && "$1" == (1|[Yy]([Ee][Ss]|)|[Tt]([Rr][Uu][Ee]|)) ]]
}
function dl {
  cd /Users/iaj/Downloads
}
function w {
  cd /Users/iaj/Documents/work
}
function ba {
  cd /Users/iaj/ba
}
function db {
  cd /Users/iaj/Dropbox/
}
function logs {
  cd /Users/iaj/.irssi/logs/FreeNode
}
function logsb {
  cd /Users/iaj/.irssi/logs/bitlbee/
}
# Performs the same job as pidof, using only zsh capabilities
function pids {
  local i
  for i in /proc/<->/stat
  do
    [[ "$(< $i)" = *\((${(j:|:)~@})\)* ]] && echo $i:h:t
  done
}

# Replaces the current window title in Gnu Screen with its positional parameters
function set-screen-title {
  echo -n "\ek$*\e\\"
}

# Replaces the current terminal titlebar with its positional parameters.
function set-window-title {
  echo -n "\e]2;"${${(pj: :)*}[1,254]}"\a"
}

# Replaces the current terminal icon text with its positional parameters.
function set-icon-title {
  echo -n "\e]1;"${${(pj: :)*}[1,254]}"\a"
}

# Given a command as a single word and an optional directory, this generates
# a titlebar string like "hostname> dir || cmd" and assigns that to an element
# in PSVAR for use by the prompt, and to the exported variable TITLE for use by
# other applications.  If the directory is omitted, it will default to the
# current working directory.  It then takes the first word of that command
# (splitting on whitespace), excluding variable assignments, the word sudo, and
# command flags, and assigns that to an element in PSVAR for use as a screen
# name and icon title, as well as to the exported variable ICON.  Finally, it
# actually writes those strings as the screen name and title bar text.
function set-title-by-cmd {
  # Rather than setting the screen name and titlebar to "fg..." when fg is
  # executed, we determine what the user is trying to foreground and change the
  # screen name and titlebar to that, before actually calling fg.  So, we take
  # our current job texts and directories and use them, in a subshell from a
  # process substitution, to set the title properly.
  if [[ "${1[(w)1]}" == (fg|%*)(\;|) ]]; then
    # The first word of the command either was 'fg' or began with '%'
    if [[ "${1[(wi)%*(\;|)]}" -eq 0 ]]; then
      local arg="%+"              # No arg began with %, default to %+
    else
      local arg=${1[(wr)%*(\;|)]} # Found a % arg, use it
    fi
    # Make local copies of our jobtexts and jobdirs vars, for use in a subshell
    local -A jt jd
    jt=(${(kv)jobtexts}) jd=(${(kv)jobdirs})
    # Run the jobs command with the chosen % arg.  If it can't find a matching
    # job, we discard the error message and continue setting the title as
    # though we hadn't found a command that should change the foreground app.
    # If it finds a matching job, we redirect the output into a process
    # substitution that handles getting the job number and calling
    # set-title-by-cmd-impl with the job description and job CWD.  We use a
    # process substitution so that the text processing can be done in a
    # subshell, leaving the 'jobs' command run in the current shell.  This
    # should work fine with older versions of zsh.
    jobs $arg 2>/dev/null > >( read num rest
                               set-title-by-cmd-impl \
                                 "${(e):-\$jt$num}" "${(e):-\$jd$num}"
                             ) || set-title-by-cmd-impl "$1" "$2"
  else
    # Not foregrounding an app, just continue with setting title
    set-title-by-cmd-impl "$1" "$2"
  fi
}

# This function actually does the work for set-title-by-command, described
# above.
function set-title-by-cmd-impl {
  set "$1" "${2:-$PWD}"                      # Replace $2 with $PWD if blank
  psvar[1]=${(V)$(cd "$2"; print -Pn "%m> %~ || "; print "$1")} # The new title
  if [ ${1[(wi)^(*=*|sudo|-*)]} -ne 0 ]; then
    psvar[2]=${1[(wr)^(*=*|sudo|-*)]}        # The one-word command to execute
  else
    psvar[2]=$1                              # The whole line if only one word
  fi                                         # or a variable assignment, etc

  if booleancheck "$shellopts[screen_names]" ; then
    set-screen-title "$psvar[2]"           # set the command as the screen title
  fi
  if booleancheck "$shellopts[titlebar]" ; then
    set-icon-title   "$psvar[2]"
    set-window-title "$psvar[1]"
  fi
  export TITLE=$psvar[1]
  export ICON=$psvar[2]
}

#### Capability checks
# Xterm, URxvt, Rxvt, aterm, mlterm, Eterm, and dtterm can set the titlebar
# TODO So can quite a few other terminal emulators...  If I'm missing a
# terminal emulator that you know can set the titlebar, please let me know.
[[ -n "$STY" || "$TERM" == ((x|a|ml|dt|E)term*|(u|)rxvt*|screen*) ]] || shellopts[titlebar]=0

# [[ -n "$STY˝ ]] || "export TERM=xerm-256color"

# TODO Should probably check terminal emulator really is using unicode...
# [[ TEST IF UNICODE WORKS ]] || shellopts[utf8]=0

# Dynamically change a screen name to the last command used when in Gnu Screen
[[ "$TERM" == (screen*) ]] || shellopts[screen_names]=0

### Colon-separated Arrays
# Tie colon separated arrays to zsh-arrays, like (MAN)PATH and (man)path
typeset -T INFOPATH           infopath
typeset -T LD_LIBRARY_PATH    ld_library_path
typeset -T LD_LIBRARY_PATH_32 ld_library_path_32
typeset -T LD_LIBRARY_PATH_64 ld_library_path_64
typeset -T CLASSPATH          classpath
typeset -T LS_COLORS          ls_colors

### Aliases
# First off, allow commands after sudo to still be alias expanded.
# An alias ending in a space allows the next word on the command line to
# be alias expanded as well.
alias :q='echo "This is not Vim!" >&2'
alias sudo="sudo "
alias l='ls -CF'
alias c=clear
alias d=cd
alias s="sudo "
alias lN='l -lt | head'
alias la='ls -A'
alias ll='ls -l'
alias ls='ls --color=auto -B'
alias ltree=find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
alias grep='grep --color=auto'
alias pu='pushd'
alias po='popd'
alias ..='cd ..'
alias ...='cd ../..'
alias cd..='cd ..'
alias cd/='cd /'
alias g='mvim --remote-silent'
alias vi=vim
alias v=vim
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
source /Users/iaj/.zsh/gitaliases
source /Users/iaj/.zsh/functions/git.zsh
alias -g L='|less'
alias -g T='|tail'
alias -g H='|head'
alias -g C='|pbcopy'
#alias -g V='|vim -'
#alias -g B='&>/dev/null &'
#alias -g D='&>/dev/null &|'
booleancheck "$shellopts[utf8]" && alias screen="screen -U"
#alias m='mplayer -fs'
alias m='/Applications/VLC.app'

alias history='history -EfdD'
alias h='history'
alias gh='h 1 | grep'

#alias x='apvlv'
#alias pl='pdflatex'
alias -s pdf='/Applications/Skim.app'
### Options
#### Shell Options
# I don't want to be told if the zsh version I'm using is missing some of these.
# I'll figure it out on my own.  So, redirect error messages to /dev/null
     # Allow comments in an interactive shell.
setopt InteractiveComments 2>/dev/null
     # Don't interrupt me to let me know about a finished bg task
setopt NoNotify            2>/dev/null
     # Run backgrounded processes at full speed
setopt NoBgNice            2>/dev/null
     # Turn off terminal beeping
setopt NoBeep              2>/dev/null
     # Automatically list ambiguous completions
setopt AutoList            2>/dev/null
     # Don't require an extra tab before listing ambiguous completions
setopt NoBashAutoList      2>/dev/null
     # Don't require an extra tab when there is an unambiguous pre- or suffix
setopt NoListAmbiguous     2>/dev/null
     # Tab on ambiguous completions cycles through possibilities
setopt AutoMenu            2>/dev/null
     # Allow extended globbing syntax needed by preexec()
setopt ExtendedGlob        2>/dev/null
     # Before storing an item to the history, delete any dups
setopt HistIgnoreAllDups   2>/dev/null
     # Append each line to the history immediately after it is entered
setopt ShareHistory        2>/dev/null
     # Complete Mafile to Makefile if cursor is on the f
setopt ExtendedHistory     2>/dev/null
     # Save History with timestamp
setopt CompleteInWord      2>/dev/null
     # Allow completion list columns to be different sizes
setopt ListPacked          2>/dev/null
     # cd adds directories to the stack like pushd
setopt AutoPushd           2>/dev/null
     # the same folder will never get pushed twice
setopt PushdIgnoreDups     2>/dev/null
     # - and + are reversed after cd
setopt PushdMinus          2>/dev/null
     # pushd will not print the directory stack after each invocation
setopt PushdSilent         2>/dev/null
     # pushd with no parameters acts like 'pushd $HOME'
setopt PushdToHome         2>/dev/null
     # if alias foo=bar, complete as if foo were entered, rather than bar
setopt CompleteAliases     2>/dev/null
     # Allow short forms of function contructs
setopt ShortLoops          2>/dev/null
     # Automatically continue disowned jobs
setopt AutoContinue        2>/dev/null
     # Attempt to spell-check command names - I mistype a lot.
setopt Correct             2>/dev/null
     # Attempt to spell-check command names - I mistype a lot.
setopt AUTO_CD             2>/dev/null
#setopt NoAutoMenu

#### Environment variables
export SHELL=$(whence -p zsh)             # Let apps know the full path to zsh
export DIRSTACKSIZE=10                    # Max number of dirs on the dir stack

if booleancheck "$shellopts[utf8]" ; then
  export LANG=en_US.UTF-8                 # Use a unicode english locale
  #export LC_CTYPE=C                      # but fix stupid not-unicode man pages
fi

export HISTSIZE=500000                      # Lines of history to save in mem
export SAVEHIST=500000                      # Lines of history to write out
export HISTFILE="$HOME/.zsh/.zsh_history"   # File to which history will be saved
export HOST=${HOST:-$HOSTNAME}              # Ensure that $HOST contains hostname

### Key bindings
bindkey -v                                         # Use vi keybindings

TRAPINT() { zle && print -s -r -- $BUFFER; return $1 }

if zmodload -i zsh/terminfo; then
  [ -n "${terminfo[khome]}" ] &&
  bindkey "${terminfo[khome]}" beginning-of-line # Home
  [ -n "${terminfo[kend]}" ] &&
  bindkey "${terminfo[kend]}"  end-of-line       # End
  [ -n "${terminfo[kdch1]}" ] &&
  bindkey "${terminfo[kdch1]}" delete-char       # Delete
fi

if [[ $TERM == screen* || $TERM == xterm* || $TERM == rxvt* ]]; then
    # Is set to a non empty value to reset the window name in the next
    # precmd() call.
    window_reset=yes
    # Is set to a non empty value when the shell is running as root.
    if [[ $(id -u) -eq 0 ]]; then
        window_root=yes
    fi

    window_preexec() {
        # Get the program name with its arguments.
        local program_name=$1

        # When sudo is used use real program name instead, but with an
        # exclamation mark at the beginning (handled below).
        local program_sudo=
        if [[ $program_name == sudo* ]]; then
            program_name=${program_name#sudo }
            program_sudo=yes
        fi
        # Remove all arguments from the program name.
        program_name=${program_name%% *}

        # Ignore often used commands which are only running for a very short
        # time. This prevents a "blinking" name when it's changed to "cd" for
        # example and then some milliseconds later back to "zsh".
        [[ $program_name == (cd*|ls|la|ll|clear|c) ]] && return

        # Change my shortcuts so the real name of the program is displayed.
        case $program_name in
            e)
                program_name=elinks
                ;;
            g)
                program_name=git
                ;;
            m)
                program_name=mutt
                ;;
            v)
                program_name=vim
                ;;
        esac

        # Add an exclamation mark at the beginning if running with sudo or if
        # running zsh as root.
        if [[ -n $program_sudo || -n $window_root ]]; then
            program_name=!$program_name
        fi

        # Add an at mark at the beginning if running through ssh on a
        # different computer.
        if [[ -n $SSH_CONNECTION ]]; then
            program_name="@$program_name"
            # If screen is running in SSH then display "@:hostname" as title
            # in the term/outer screen.
            if [[ $program_name == @screen ]]; then
                program_name="@:${$(hostname)//.*/}"
            # Use "@:!hostname" for root screens.
            elif [[ $program_name == @!screen ]]; then
                program_name="@:!${$(hostname)//.*/}"
            fi
        fi
        # Set the window name to the currently running program.
        window_title "$program_name"

        # Tell precmd() to reset the window name when the program stops.
        window_reset=yes
    }

    window_precmd() {
        # Abort if no window name reset is necessary.
        [[ -z $window_reset ]] && return

        # Reset the window name to 'zsh'.
        local name=zsh
        # If the function was called with an argument then reset the window
        # name to '.zsh' (used by clear alias).
        if [[ -n $1 ]]; then
            name=.zsh
        fi

        # Prepend prefixes like in window_preexec().
        if [[ -n $window_root ]]; then
            name="!$name"
        fi
        if [[ -n $SSH_CONNECTION ]]; then
            name="@$name"
        fi
        window_title $name

        # Just reset the name, so no screen reset necessary for the moment.
        window_reset=
    }

    # Sets the window title. Works with screen, xterm and rxvt. (V) escapes
    # all non-printable characters. Thanks to Mikachu in #zsh on Freenode
    # (2010-08-07 17:09 CEST).
    if [[ $TERM == screen* ]]; then
        window_title() {
            print -n "\ek${(V)1}\e\\"
        }
    elif [[ $TERM == xterm* || $TERM == rxvt* ]]; then
        window_title() {
            print -n "\e]2;${(V)1}\e\\"
        }
    else
        # Fallback if another TERM is used.
        window_title() { }
    fi
    # Add the preexec() and precmd() hooks.
    add-zsh-hook preexec window_preexec
    add-zsh-hook precmd window_precmd
else
    # Fallback if another TERM is used, necessary to run screen (see below in
    # "RUN COMMANDS").
    window_preexec() { }
fi

function search-backwords; {
  zle history-incremental-search-backward $BUFFER
}
zle -N search-backwords

bindkey -M vicmd "^R" search-backwords
bindkey "^Y" yank
bindkey -M viins '^r' search-backwords
bindkey -M vicmd '^r' search-backwords
function paste-xclip; {
  BUFFER=$BUFFER"`pbpaste`"
  zle end-of-line
}
function yank-pb; { echo $BUFFER | pbcopy }
zle -N paste-xclip

zle -N yank-pb
#bindkey -M viins "^X" paste-xclip
bindkey -M viins "^R\*" yank-pb
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M viins "^[^M" self-insert-unmeta
bindkey -M viins "^[x" execute-named-cmd
#bindkey -M viins "^R\*" paste-xclip
bindkey -M viins "^O" accept-line-and-down-history
bindkey -M viins "^[h" run-help
bindkey "\e[1~"   beginning-of-line              # Another Home
bindkey "\e[4~"   end-of-line                    # Another End
bindkey "\e[3~"   delete-char                    # Another Delete
bindkey "\e[1;5A" up-line-or-search              # Ctrl - Up in xterm
bindkey "\e[1;5B" down-line-or-search            # Ctrl - Down in xterm
bindkey "\e[1;5C" forward-word                   # Ctrl - Right in xterm
bindkey "\e[1;5D" backward-word                  # Ctrl - Left in xterm
bindkey "\eOa"    up-line-or-search              # Another ctrl-up
bindkey "\eOb"    down-line-or-search            # Another ctrl-down
bindkey "\eOc"    forward-word                   # Another possible ctrl-right
bindkey "\eOd"    backward-word                  # Another possible ctrl-left
bindkey "\e[Z"    reverse-menu-complete          # S-Tab menu completes backward
bindkey " "       magic-space                    # Space expands history subst's
bindkey "^@"	  _history-complete-older        # C-Space to complete from hist
bindkey "^]."	  insert-last-word
bindkey 'jj'	  vi-cmd-mode
# No Delays please, we want flashy SPEEDZ
KEYTIMEOUT=10

# Vim like completions of previous executed commands (also enter Vi-mode). If
# called at the beginning it just recalls old commands (like cursor up), if
# called after typing something, only lines starting with the typed are
# returned. Very useful to get old commands quickly. Thanks to Mikachu in #zsh
# on Freenode (2010-01-17 12:47) for the information how to a use function
# with bindkey.
zle -N my-vi-history-beginning-search-backward
my-vi-history-beginning-search-backward() {
    local not_at_beginning_of_line
    if [[ $CURSOR -ne 0 ]]; then
        not_at_beginning_of_line=yes
    fi
    zle history-beginning-search-backward

    # Start Vi-mode and stay at the same position (Vi-mode moves one left,
    # this counters it).
    zle vi-cmd-mode
    if [[ -n $not_at_beginning_of_line ]]; then
        zle vi-forward-char
    fi
}
bindkey '^P' my-vi-history-beginning-search-backward
bindkey -a '^P' history-beginning-search-backward # binding for Vi-mode
# Here only Vi-mode is necessary as ^P enters Vi-mode and ^N only makes sense
# after calling ^P.
bindkey -a '^N' history-beginning-search-forward

# I don't need the arrow keys, I use ^N and ^P for this (see below).
bindkey -r '^[OA' '^[OB' '^[OC' '^[OD' '^[[A' '^[[B' '^[[C' '^[[D'
# Also not in Vi mode.
bindkey -a -r '^[OA' '^[OB' '^[OC' '^[OD' '^[[A' '^[[B' '^[[C' '^[[D'

autoload -U edit-command-line
autoload zmv
#autoload zcalc
zle -N edit-command-line

#bindkey "^N"      complete-word
# Tab completes, never expands
# so expansion can be handled
# by a completer.

#export HQUICKFILE=$HOME/bin/hquickfile
#pd() { num=${1:-1}; C $num-; }
#C(){
#	cd "$( echo -n `$HQUICKFILE $@ `)"
#}
#pd() { num=${1:-1}; C $num-; }
#C(){
  #cd "$( $HQUICKFILE -n $@  )"
#}
#G(){
  #gvim "$( $HQUICKFILE -n "$@")"
#}
#V(){
  #vim "$( $HQUICKFILE -n "$@")"
#}

# Allow substitutions and expansions in the prompt, necessary for
# vcs_info.
setopt promptsubst
# Load vcs_info to display information about version control repositories.
autoload -Uz vcs_info
# Only look for git and mercurial repositories; the only I use.
zstyle ':vcs_info:*' enable git hg svn

# Set style of vcs_info display. The current branch (green) and VCS (blue)
# is displayed. If there is an special action going on (merge, rebase)
# it's also displayed (red).
zstyle ':vcs_info:*' formats \ "($green%b$default:$blue%s$default)"
zstyle ':vcs_info:*' actionformats \ "($green%b$default/$red%a$default:$blue%s$default)"
zstyle ':completion:*' special-dirs ..
# Call vcs_info as precmd before every prompt.
prompt_precmd() {
    vcs_info
}
add-zsh-hook precmd prompt_precmd

# Display the VCS information in the right prompt.
if [[ $ZSH_VERSION == (4.3.<9->|4.<4->*|<5->*) ]]; then
    RPROMPT='${vcs_info_msg_0_}'
# There is a bug in Zsh below 4.3.9 which displays a wrong symbol when
# ${vcs_info_msg_0_} is empty. Provide a workaround for those versions,
# thanks to Frank Terbeck <ft@bewatermyfriend.org> for it.
else
    RPROMPT='${vcs_info_msg_0_:- }'
fi

#### Function to hide prompts on the line - Will be replaced eventually
function TogglePrompt {
if [[ -n "$PS1" && -n "$RPS1" ]]; then
    OLDRPS1=$RPS1; OLDPS1=$PS1
    unset RPS1 PS1
else
    RPS1=$OLDRPS1; PS1=$OLDPS1
fi
zle reset-prompt
}
zle -N TogglePrompt

bindkey "^X^X" TogglePrompt

#### Function to allow Ctrl-z to toggle between suspend and resume
function Resume {
zle push-input
BUFFER="fg"
zle accept-line
}
zle -N Resume
bindkey "^Z" Resume

#### Allow interactive editing of command line in $EDITOR
if autoloadable edit-command-line; then
  autoload -U edit-command-line
  zle -N edit-command-line
  bindkey "\ee" edit-command-line
fi

### Misc
#### Some minicom options:
# linewrap use-status-line capture-file=/dev/null color=off
export MINICOM='-w -z  -C /dev/null -c off'

#### Man and Info options
# Make vim the manpage viewer or info viewer
# Requires manpageview.vim from
# http://vim.sourceforge.net/scripts/script.php?script_id=489
#function man { mvim -R -c "Man $*" -c "silent! only" }
function man { mvim --remote-send "<ESC>:Man $*<CR>" ; osascript -e 'tell application "MacVim" to activate' }
#function man { mvim --remote-silent -c "Man $*"}

if [[ -f $HOME/.vim/plugin/manpageviewPlugin.vim ]]; then
  function manx {
    [[ $# -eq 0 ]] && return 1
    #vim -R -c "Man $*" -c "silent! only"
    mvim --remote-send "<ESC>:Man $*<CR>" ; osascript -e 'tell application "MacVim" to activate'
    #g -R -c "Man $*" -c "silent! only"
  }
  function info {
    [[ $# -eq 1 ]] || return 1
    vim -R -c "Man $1.i" -c "silent! only"
  }
  function perldoc {
    [[ $# -eq 1 ]] || return 1
    vim -R -c "Man $1.pl" -c "silent! only"
  }
fi

#### Less and ls options
# make less more friendly for non-text input files, see lesspipe(1)
# If we have it, we'll use it.
which lesspipe &>/dev/null && eval "$(lesspipe)"

# customize the colors used by ls, if we have the right tools
# Also changes colors for completion, if initialized first
which dircolors &>/dev/null && eval `dircolors -b $HOME/.dircolors`

# Edit the command line using your usual editor.
# Binding this to 'v' in the vi command mode map,
#   autoload edit-command-line
#   zle -N edit-command-line
#   bindkey -M vicmd v edit-command-line
# will give ksh-like behaviour for that key,
# except that it will handle multi-line buffers properly.
function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

function mkcd() {
  [[ -z $1 ]] && printf "usage: mkcd NEW-DIRECTORY" && return 1
  [[ -d $1 ]] && printf "mkcd: Directory %s already exists; cd-ing" $1
  command mkdir -p -- $1
  builtin cd -- $1
}

MAILDIR_ROOT=~/mail
function mkmaildir() {
  ### Uses $MAILDIR_ROOT
  local root subdir
  root=${MAILDIR_ROOT:-${HOME}/Mail}
  if [[ -z ${1} ]] ; then
    print "Usage\n $0 <dirname>"
    return 1
  fi
  subdir=${1}
  mkdir -p ${root}/${subdir}/{cur,new,tmp}
}

# Prompt to <<insert>> <<normal>> Modes on the right
#function zle-line-init zle-keymap-select {
  #RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
  #RPS2=$RPS1
  #zle reset-prompt
#}
#zle -N zle-line-init
#zle -N zle-keymap-select

### Completion
if autoloadable compinit; then
autoload -U compinit; compinit # Set up the required completion functions

# Order in which completion mechanisms will be tried:
# 1. Try completing the results of an old list
#    ( for use with history completion on ctrl-space )
# 2. Try to complete using context-sensitive completion
# 3. Try interpretting the typed text as a pattern and matching it against the
#    possible completions in context
# 4. Try completing the word just up to the cursor, ignoring anything past it.
# 5. Try combining the effects of completion and correction.
zstyle ':completion:*' completer _oldlist _complete _match \
                                 _expand _prefix _approximate

# Don't complete backup files as executables
zstyle ':completion:*:*:(*pdf*|acroread|rm):*' file-sort time
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'

# If I don't have ``executable'', don't complete to the _executable completer
zstyle ':completion:*:functions' ignored-patterns '_*'

# Match lowercase letters to uppercase letters and dashes to underscores (not
# vice-versa), and allow ".t<TAB>" to list all files containing the text ".t"
zstyle ':completion:*' matcher-list 'm:{a-z-}={A-Z_}' 'r:|.=** r:|=*'

# Try to use verbose listings when we have more information
zstyle ':completion:*' verbose true

# Allows /u/l/b<TAB> to menu complete as though you typed /u*/l*/b*<TAB>
zstyle ':completion:*:paths' expand suffix

# Menu complete on ambiguous paths
zstyle ':completion:*:paths' list-suffixes true

# Have '/home//<TAB>' list '/home/*', rather than '/home/*/*'
zstyle ':completion:*:paths' squeeze-slashes false

# Enter "menu selection" if there are at least 2 choices while completing
zstyle ':completion:*' menu select=2

# vi or vim will match first files that don't end in a backup extension,
# followed by files that do, followed last by files that are known to be binary
# types that should probably not be edited.
zstyle ':completion:*:*:(vi|vim):*:*' \
    file-patterns '*~(*.o|*~|*.old|*.bak|*.pro|*.zwc|*.swp):regular-files' \
                  '(*~|*.bak|*.old):backup-files' \
                  '(*.o|*.pro|*.zwc|*.swp):hidden-files'

# Use colors in tab completion listings
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Add a space after an expansion, so that 'ls $TERM' expands to 'ls xterm '
zstyle ':completion:*:expand:*' add-space true

# Tweaks to kill: list processes using the given command and show them in a menu
zstyle ':completion:*:*:kill:*' command 'ps -u$USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always

# Use caching for commands that would like a cache.
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ${ZDOTDIR}/.zcache

# Page long completion lists, using this prompt.
zstyle ':completion:*' list-prompt %S%L -- More --%s

# Show a warning when no completions were found
zstyle ':completion:*:warnings' format '%BNo matches for: %d%b'

# Autocomplete to ./configure in the most cases
zstyle ':completion:*:*:-command-:*' ignored-patterns './config.*'
fi

autoload -U loadGitAliases
loadGitAliases

### Prompt
typeset +x PS1     # Don't export PS1 - Other shells just mangle it.

function leo () { elinks "http://dict.leo.org/?search=$1"; }
function dict () { elinks "http://dict.tu-chemnitz.de/?query=$1"; }
function psg {
    # using a perlre lookahead 'trick' to prevent grep from
    # greping it's own process
    # grep with --enable-pcre needed!
  ps ax | grep -i -P "$1"'(?!\(\?\!)'
}

function hg_prompt_info {
    hg prompt --angle-brackets "\
< on %{$fg[magenta]%}<branch>%{$reset_color%}>\
< at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
}
function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    #echo '○'
    echo '⤴'
}
#### Prompt setup functions
# Global color variable
    #PROMPT_COLOR_NUM=$(((${#${HOST#*.}}+11)%12)) #PROMPT_COLOR_NUM=10
function prompt-setup {
  #local CC=$'\e['$((PROMPT_COLOR_NUM>6))$'m\e[3'$((PROMPT_COLOR_NUM%6+1))'m'
  if booleancheck "$shellopts[titlebar]" ; then
    # <blue bright=1><truncate side=right len=20 string="..">
    PROMPT="${default}%n(${white}%!%b${default})${white}::%b${magenta}%35<..<%~%<<$(prompt_char)  ${default}%b"
  else
    # <truncate side=left len=33 string="..">pwd (home=~)</truncate>&gt;</blue>
    PS1=$'%{\e[1;37m%}%m%{\e[0m%}::%{'"$CC"$'%}%35<..<%~%<<>%{\e[0m%}'
  fi
}
prompt-setup

# Prompt for spelling corrections.
# %R is word to change, %r is suggestion, and Y and N are colored green and red.
SPROMPT=$'Should zsh correct "%R" to "%r" ? ([\e[0;32mY\e[0m]es/[\e[0;31mN\e[0m]o/[E]dit/[A]bort) '

### Attaching to a possibly running screen session
# If not already in screen reattach to a running session or create a new one.
# This also starts screen one a remote server when connecting through ssh.
export SHORTHOST=`hostname -s | tr '[:upper:]' '[:lower:]'`
if [[ $TERM != dumb && -z $STY ]]; then
    # Get running detached sessions.
    session=$(screen -list | grep 'Detached' | awk '{ print $1; exit }')
    # As we exec later we have to set the title here.
    #window_preexec "screen"
    # Create a new session if none is running.
    if [[ -z $session ]]; then
	exec screen
    # Reattach to a running session.
    else
	exec screen -r $session
    fi
fi
eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)
## vim:fdm=expr:fdl=99
#
## vim:fde=getline(v\:lnum)=~'^##'?'>'.(matchend(getline(v\:lnum),'##*')-2)\:'='
