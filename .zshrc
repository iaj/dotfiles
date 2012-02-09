# Author:  iaj (tyberion@googlemail.com)
#
# NOTE:
# This .zshrc does define LANG and LC_CTYPE.  If you don't want en_US.UTF-8 and
# C, search for those variable names and change them in the section "Environment
# Variables".
#
# NOTE:
# If you're editing this in Vim and don't know how folding works, type zR to
# unfold them all.

### Path settings
# These settings are only for interactive shells. Return if not interactive.
# This stops us from ever accidentally executing, rather than sourcing, .zshrc
[[ -o nointeractive ]] && return

export LIBXCB_ALLOW_SLOPPY_LOCK=true
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PYTHONPATH=/usr/local/lib/python2.6/site-packages:"${PYTHONPATH}"
# coreutils nowadays puts its stuff in /opt/local/libexec/gnubin/ ...
if [ -d /opt/local/libexec/gnubin ]; then
    PATH=/opt/local/libexec/gnubin:$PATH
fi
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

### Colors
# Use colorized output, necessary for prompts and completions.
autoload -U colors && colors
# Some shortcuts for colors.
local red="%{${fg[red]}%}" #FF6B60
local blue="%{${fg[blue]}%}"
local boldblue="%B%{${fg[blue]}%}"
local green="%{${fg[green]}%}"
local boldgreen="%B%{${fg[green]}%}" #CEFFAB
local magenta="%{${fg[magenta]}%}"
local boldmagenta="%B%{${fg[magenta]}%}" #CEFFAB
local yellow="%{${fg[yellow]}%}" #FFFFB6
local boldyellow="%B%{${fg[yellow]}%}"
local default="%{${fg[default]}%}"
local white="%B%{${fg[white]}%}"

# Customize the colors used by ls, if we have the right tools
# Also changes colors for completion, if initialized first
if [ -f $HOME/.dircolors ]; then
    which dircolors &>/dev/null && eval `dircolors -b $HOME/.dircolors`
fi

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
setopt CompleteInWord      3>/dev/null
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
#setopt CompleteAliases     2>/dev/null
# Allow short forms of function contructs
setopt ShortLoops          2>/dev/null
# Automatically continue disowned jobs
setopt AutoContinue        2>/dev/null
# Attempt to spell-check command names - I mistype a lot.
setopt Correct             2>/dev/null
# Attempt to spell-check command names - I mistype a lot.
setopt AUTO_CD             2>/dev/null
#setopt NoAutoMenu

# Returns whether its argument should be considered "true"
# Succeeds with "1", "y", "yes", "t", and "true", case insensitive
booleancheck() { [[ -n "$1" && "$1" == (1|[Yy]([Ee][Ss]|)|[Tt]([Rr][Uu][Ee]|)) ]] }

#### Environment variables
export PAGER=less
export ACK_COLOR_MATCH='red'
if [[ $OSTYPE == darwin* ]]; then
    # this one causes me some headaches lately
    # export EDITOR="mvim -f --remote-wait-silent"
    export EDITOR="vim"
else
    export EDITOR="vim"
fi
export SHELL=$(whence -p zsh)               # Let apps know the full path to zsh
export DIRSTACKSIZE=10                      # Max number of dirs on the dir stack
if booleancheck "$shellopts[utf8]" ; then
    export LANG=en_US.UTF-8                 # Use a unicode english locale
    #export LC_CTYPE=C                      # but fix stupid not-unicode man pages
fi
export HISTSIZE=500000                      # Lines of history to save in mem
export SAVEHIST=500000                      # Lines of history to write out
export HISTFILE="$HOME/.zsh/.zsh_history"   # File to which history will be saved
export HOST=${HOST:-$HOSTNAME}              # Ensure that $HOST contains hostname

### Setup
# These settings are only for interactive shells. Return if not interactive.
# This stops us from ever accidentally executing, rather than sourcing, .zshrc
[[ -o nointeractive ]] && return

#### $fpath for enjoying most recent completion+rest
# Make sure every entry in $fpath is unique.
typeset -U fpath
# Load the git-completion functions
if [ -d ~/git/zsh/Completion ]; then
    fpath=(~/git/zsh/Completion/*/*(/) $fpath)
fi
# Load the VCS Infobar
if [ -d ~/git/zsh/Functions/VCS_Info/ ]; then
    fpath=(~/git/zsh/Functions/VCS_Info/ ~/git/zsh/Functions/VCS_Info/Backends ~/git/zsh/Functions/Misc $fpath)
fi
# Set correct fpath to allow loading my functions (including completion
# functions).
#fpath=(~/.zsh/functions $fpath)
# Autoload my functions (except completion functions and hidden files). Thanks
# to caphuso from the Zsh example files for this idea.
#if [[ -d ~/.zsh/functions ]]; then
    #autoload -Uz ${fpath[1]}/^_*(^/:t)
#fi
autoload -Uz cdm

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
autoloadable() { ( unfunction $1 ; autoload -U +X $1 ) &>/dev/null }
cdf() { cd *$1*/ } # stolen from @topfunky

# Access often used paths quickly
if [ -d $HOME/dev/qs ]; then qs=~/dev/qs/Quicksilver/Quicksilver; : ~qs ; fi
if [ -d $HOME/hg/dactyl ]; then dactyl=~/hg/dactyl; : ~dactyl ; fi
if [ -d $HOME/Library/Application\ Support ]; then asu=$HOME/Library/Application\ Support; : ~asu ; fi
if [ -d $HOME/Library/Application\ Support/Launchbar/Actions ]; then actions=$HOME/Library/Application\ Support/Launchbar/Actions; : ~actions ; fi
if [ -d $HOME/Library/Scripts/my\ AppleScripts ]; then myas=$HOME/Library/Scripts/my\ AppleScripts; : ~myas ; fi

if [ -d $HOME/Downloads ]; then
    dl() { cd $HOME/Downloads }
fi
if [ -d $HOME/Documents/jobs/marcgalal ]; then
    w() { cd $HOME/Documents/jobs/marcgalal }
fi
if [ -d $HOME/Documents/work ]; then
    ba() {
        if [[ $1 -eq 1 ]]; then
            cd $HOME/Documents/workspace/Animal
        elif [[ $1 -eq 2 ]]; then
            cd $HOME/Documents/workspace/AnimalScript2
        else
            cd $HOME/ba/tex
        fi
    }
fi


if [ -d $HOME/Dropbox ]; then db() { cd $HOME/Dropbox/ }; fi
# website=/mnt/mg/var/www/virtual/marcgalal.com/htdocs; : ~website

leo() { elinks "http://dict.leo.org/?search=$1"; }
dict() { elinks "http://dict.tu-chemnitz.de/?query=$1"; }
# using a perlre lookahead 'trick' to prevent grep from
# greping it's own process
# grep with --enable-pcre needed!
psg() { ps ax | grep -i -P "$1"'(?!\(\?\!)' }

# Replaces the current window title in Gnu Screen with its positional parameters
set-screen-title() { echo -n "\ek$*\e\\" }
# Replaces the current terminal titlebar with its positional parameters.
set-window-title() { echo -n "\e]2;"${${(pj: :)*}[1,254]}"\a" }
# Replaces the current terminal icon text with its positional parameters.
set-icon-title() { echo -n "\e]1;"${${(pj: :)*}[1,254]}"\a" }

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
# File with git-time-function since last commit
. $HOME/.zsh/functions/vcs_hooks.zsh
. $HOME/.zsh/customized.zsh
# colorize stderr in red...  TODO: fix for ls /usr/bin | vi -
# . $HOME/.zsh/colorizestderr.zsh
#. $HOME/.zsh/functions/git.zsh
#. $HOME/.zsh/vi-mode.zsh

### Aliases
# First off, allow commands after sudo to still be alias expanded.
# An alias ending in a space allows the next word on the command line to
# be alias expanded as well.
alias sudo="sudo "
alias l='ls -CF'
alias c=clear
alias d=cd
alias s="sudo "
alias lN='l -lt | head'
alias la='ls -A'
alias ll='ls -l'
# only on mac osx tho
alias :q="echo YOU FAIL"
alias sr="screen -r"
alias sx="screen -x"
alias pygrep="grep --include='*.py' $*"
alias rbgrep="grep --include='*.rb' $*"
alias awk="/opt/local/bin/gawk"

# Now we got mysql here for TYPO-Adminitration purposes
alias mysqlstart='sudo /opt/local/bin/mysqld_safe5 &'
alias mysqlstop='/opt/local/bin/mysqladmin5 -u root -p shutdown'

# on mac the gnutls are wicked...
# hidden in the clouds!
if [[ $OSTYPE == darwin* ]]; then
    alias df='gdf'
    alias sort='gsort'
    #alias find='gfind'
    alias du='gdu'
    alias ls='gls --color=auto -B'
    alias dircolors='gdircolors'
    alias g='mvim --remote-silent'
    alias m='mvim --remote-silent'
    alias mn='mvim'
    alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
    alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
    alias -s pdf='/Applications/Skim.app'
    alias mp='/Applications/VLC.app'

    #### Man and Info options
    # Make vim the manpage viewer or info viewer
    # Requires manpageview.vim from
    # http://vim.sourceforge.net/scripts/script.php?script_id=489
    manx() { mvim --remote-send "<ESC>:Man $*<CR>" ; osascript -e 'tell application "MacVim" to activate' }
    pledit() {
        plutil -convert xml1 ${1}
        $EDITOR -w ${1}
        plutil -convert binary1 ${1}
    }
else
    alias ls='ls --color=auto -B'
    alias g='vim'
    alias m='vim'
fi
alias pnc='pn `pwd`'
alias ltree=find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
alias grep='grep --color=auto'
alias pu='pushd'
alias po='popd'
alias ..='cd ..'
alias ...='cd ../..'
alias cd..='cd ..'
alias cd/='cd /'

alias vi=vim
#global aliases
alias -g L='|less'
alias -g T='|tail'
alias -g H='|head'
alias -g X='|pbcopy'
alias -g E='2>&1'
alias -g N='>/dev/null'
alias -g L='E | less'
alias -g G='| grep'
alias -g D='E | colordiff L'
alias -g S='| sort'
alias -g B='&>/dev/null &'
alias -g D='&>/dev/null &|'

#TODO: check those out!
alias -g NF='*(.om[1])'
alias -g ND='*(/om[1])'
alias -g NN='*(om[1])'
alias -g VIDEO="(#i)*.(mpg|avi|vob|mpeg|wmv|mov|asf)"
alias -g SEDQUOTE='sed -e "s/'\''/'\''\\\\'\'\''/g" -e "s/\(.*\)/'\''\1'\''/g"'

booleancheck "$shellopts[utf8]" && alias screen="screen -U"
#alias m='mplayer -fs'
alias history='history -EfdD'
alias h='history'
alias gh='h 1 | grep'
#### Git Aliases
# Display all branches (except stash) in gitk but only 200 commits as this is
# much faster. Also put in the background and disown. Thanks to sitaram in
# #git on Freenode (2009-04-20 15:51).
gitk() {
    command gitk \
        --max-count=200 \
        $(git rev-parse --symbolic-full-name --remotes --branches) \
        $@ &
    disown %command
}
# Same for tig (except the disown part as it's no GUI program).
tig() {
    command tig \
        --max-count=200 \
        $(git rev-parse --symbolic-full-name --remotes --branches) \
        $@
}
if [[ $OSTYPE == darwin* ]]; then
    alias gitx="open -b nl.frim.GitX"
fi
alias glol="git log --pretty=oneline"
alias gd="git diff --patience"
alias gf="git fetch"
alias gl="git log"
alias gs="git status"
alias gp="git pull"
alias gpsh="git push"
alias gi="git init"
alias gb="git branch"
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit"
alias gcm="git commit -m"
alias gca='git commit --amend'
alias gco="git checkout"
alias gCc='cat .git/config'
alias gCv='v .git/config'
alias gd="git diff"
alias gra="git ra"
alias gru="git remote update"
alias gm="git merge"
alias gmo="git merge origin/master"
alias gb="git branch"
alias gbv="git branch -av"
alias gka="gitk --all &"
alias gitkl="gitk \$(git branch | sed 's/*//' | sed 's@\<@heads/@' )"
alias gsu="git submodule update --init"
alias gsa="git submodule add"
alias hp="hg pull -u"
if [[ $OSTYPE == darwin* ]]; then
    alias gx="gitx"
    alias gxa="gitx -all"
fi

alias grc="git rebase --continue"
alias grab="git rebase --abort"
alias gri="git rebase -i"
alias gcp="git cherry-pick"
gdi() { git diff $* | view -; }
gdc() { gd --cached $*; }
# git svn
alias gsfr="git svn fetch && git-svn rebase"
gitSvnDcommit(){
  echo 'updating (git svn rebase)'  && \
    git svn rebase && \
    echo '(git stash)'  && \
    git stash && \
    echo comitting ..  && \
    git svn dcommit && \
    echo '(gsh apply)' && \
    git stash apply
}
alias adoc="asciidoc -b html5 -a icons -a iconsdir=/opt/local/etc/asciidoc/images/icons/ -a toc2 -a theme=flask"

### Keybindings
bindkey -v                                         # Use vi keybindings
# Helper function for using zkbd definitions with less clutter
function zbindkey() {
  [[ "$1" = "-s" ]] && {
    s=-s
    shift
  }
  [[ -n ${key[$1]} ]] && builtin bindkey $s "${key[$1]}" "$2"
}
TRAPINT() { zle && print -s -r -- $BUFFER; return $1 }
if zmodload -i zsh/terminfo; then
    [ -n "${terminfo[khome]}" ] &&
        bindkey "${terminfo[khome]}" beginning-of-line # Home
    [ -n "${terminfo[kend]}" ] &&
        bindkey "${terminfo[kend]}"  end-of-line       # End
    [ -n "${terminfo[kdch1]}" ] &&
        bindkey "${terminfo[kdch1]}" delete-char       # Delete
fi
zmodload zsh/stat
search-backwords() { zle history-incremental-search-backward $BUFFER }

bindkey -M vicmd "^R" search-backwords
bindkey "^Y" yank
bindkey -M viins '^r' search-backwords
bindkey -M vicmd '^r' search-backwords

paste-xclip() {
    BUFFER=$LBUFFER"`pbpaste`"
    zle end-of-line
}
zle -N paste-xclip
bindkey -M viins "^R\*" paste-xclip

yank-pb() {
    zle copy-region-as-kill $BUFFER
    echo $BUFFER | pbcopy
}
finder_position() {
    BUFFER=$BUFFER"`posd`"
    zle end-of-line
}
# Declare these as custom widget functions
#zle -N reset-prompt
zle -N search-backwords
zle -N finder_position
zle -N yank-pb
#zle -N shortpath
#zle -N fullpath
zle -N getlastpath

#bindkey -M viins "^R\*" yank-pb
# returns the current finder position
bindkey -M viins '^K'   finder_position
bindkey -M viins '^A'   beginning-of-line
bindkey -M viins '^E'   end-of-line
bindkey -M viins "^[^M" self-insert-unmeta
bindkey -M viins "^[x"  execute-named-cmd
bindkey -M viins "^O"   accept-line-and-down-history
bindkey -M viins "^[u"  undo
#bindkey -M viins   "^[h" run-help
bindkey -M vicmd        'yy' yank-pb
bindkey "\e[1~"         beginning-of-line              # Another Home
bindkey "\e[4~"         end-of-line                    # Another End
bindkey "\e[3~"         delete-char                    # Another Delete
bindkey "\e[1;5A"       up-line-or-search              # Ctrl - Up in xterm
bindkey "\e[1;5B"       down-line-or-search            # Ctrl - Down in xterm
bindkey "\e[1;5C"       forward-word                   # Ctrl - Righ~/bin/ba
bindkey "\e[1;5D"       backward-word                  # Ctrl - Left in xterm
bindkey "\eOa"          up-line-or-search              # Another ctrl-up
bindkey "\eOb"          down-line-or-search            # Another ctrl-down
bindkey "\eOc"          forward-word                   # Another possible ctrl-right
bindkey "\eOd"          backward-word                  # Another possible ctrl-left
bindkey "\e[Z"          reverse-menu-complete          # S-Tab menu completes backward
bindkey " "             magic-space                    # Space expands history subst's
bindkey "^@"            _history-complete-older        # C-Space to complete from hist
bindkey "^]."           insert-last-word

# TODO: check this one out...
bindkey "^],"     copy-earlier-word
bindkey 'jk'      vi-cmd-mode
bindkey '^T' _most_recent_file
lastpath() {
     LBUFFER+="${${(z)history[$#history]}[-1]:h}"
}
# bindkey '^_/' lastpath; zle -N lastpath;
# No Delays please, we want flashy SPEEDZ
KEYTIMEOUT=50

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

# Edit the command line using your usual editor.
# Binding this to 'v' in the vi command mode map,
#autoload edit-command-line
#zle -N edit-command-line
#bindkey -M vicmd v edit-command-line
# will give ksh-like behaviour for that key,
# except that it will handle multi-line buffers properly.

# Prompt to <<insert>> <<normal>> Modes on the right
#function zle-line-init zle-keymap-select {
#RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
#RPS2=$RPS1
#zle reset-prompt
#}
#zle -N zle-line-init
#zle -N zle-keymap-select

#### Setting the window title
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

        # Replace fg with the job name.
        if [[ $program_name == fg ]]; then
            program_name=${jobtexts[%+]}
        elif [[ $program_name == fg* ]]; then
            program_name=${jobtexts[${program_name#fg }]}
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
            vi)
                program_name=vim
                ;;
            /Applications/MacVim.app/Contents/MacOS/Vim)
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
    #add-zsh-hook precmd set-title-by-cmd
else
    # Fallback if another TERM is used, necessary to run screen (see below in
    # "RUN COMMANDS").
    window_preexec() { }
fi

# If the window naming feature is used (see above) then use ".zsh" (leading
# dot) as title name after running clear so it's clear to me that the window
# is empty. I open so much windows that I don't know in which I have something
# important. This helps me to remember which windows are empty (I run clear
# after I finished my work in a window).
if [[ -n $window_reset ]]; then
    alias clear='clear; window_reset=yes; window_precmd reset'
fi

### vcs_INFO - SCM in Prompt
# Allow substitutions and expansions in the prompt, necessary for vcs_info.
setopt promptsubst
autoload -U promptinit

# Load vcs_info to display information about version control repositories.
autoload -Uz vcs_info
# Only look for git and mercurial repositories; the only I use.
zstyle ':vcs_info:*' enable git hg svn

# Set style of vcs_info display. The current branch (green) and VCS (blue)
# is displayed. If there is an special action going on (merge, rebase)
# it's also displayed (red).
zstyle ':vcs_info:*' formats "($red%s%m$default|$white%b%u%c$default)"
zstyle ':vcs_info:*' actionformats "($red%b%u%c$default/$red%a$default:$blue%s$default)"
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '?'
zstyle ':vcs_info:*' stagedstr   '!'
zstyle ':completion:*' special-dirs ..

# Call vcs_info as precmd before every prompt.
prompt_precmd() { vcs_info }
add-zsh-hook precmd prompt_precmd

# for git repos, show the past time in minutes since last commit
zstyle ':vcs_info:git:*' formats "($red%m$default|$white%b%u%c$default)"
zstyle ':vcs_info:git*+set-message:*' hooks git-committime
function +vi-git-committime() {
hook_com[misc]=`scm_time_since_commit`
}

#### Allow interactive editing of command line in $EDITOR
if autoloadable edit-command-line; then
    autoload -U edit-command-line
    zle -N edit-command-line
    bindkey "\ee" edit-command-line
fi

### Functions
# Originally from Jonathan Penn, with modifications by Gary Bernhardt
whodoneit() {
    (set -e &&
        for x in $(git grep -I --name-only $1); do
            git blame -f -- $x | grep $1;
        done)
}
bash() { command bash E }
collapse_pwd() { echo $(pwd | sed -e "s,^$HOME,~,") }

# send last command to Quicksilver
export HISTCONTROL=erasedups:ignorespace
alias cpc=" history | cut -c 8- | tail -n 2 | head -n 1 | qs"

mkcd() {
    [[ -z $1 ]] && printf "usage: mkcd NEW-DIRECTORY" && return 1
    [[ -d $1 ]] && printf "mkcd: Directory %s already exists; cd-ing" $1
    command mkdir -p -- $1
    builtin cd -- $1
}

MAILDIR_ROOT=~/mail
mkmaildir() {
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
fullpath() {
    PS1="$PS1:s/\%~/%d/:s/40</400</"
    zle reset-prompt
}
shortpath() {
    PS1="$PS1:s/\%d/%~/:s/400</40</"
    zle reset-prompt
}

### Completion
if autoloadable compinit; then
    # Load the complist module which provides additions to completion lists
    # (coloring, scrollable).
    zmodload zsh/complist
    # Use new completion system, store dumpfile in ~/.zsh/cache to prevent
    # cluttering of ~/. $fpath must be set before calling this. Thanks to Adlai in
    # #zsh on Freenode (2009-08-07 21:05 CEST) for reminding me of the $fpath
    # problem.
    autoload -U compinit; compinit -d ~/.zsh/cache/zcompdump # Set up the required completion functions

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
    #zstyle ':completion:*' matcher-list 'm:{a-z-}={A-Z_}' 'r:|.=** r:|=*'
    #07:57:16   Patplu: iaj: you need to tweak matcher-list zstyle
    #07:57:28   Patplu: something like :
    zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z} l:|=*' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
    # Try to use verbose listings when we have more information
    zstyle ':completion:*' verbose true

    # Allows /u/l/b<TAB> to menu complete as though you typed /u*/l*/b*<TAB>
    zstyle ':completion:*:paths' expand suffix

    # Menu complete on ambiguous paths
    zstyle ':completion:*:paths' list-suffixes true

    # Have '/home//<TAB>' list '/home/*', rather than '/home/*/*'
    zstyle ':completion:*:paths' squeeze-slashes false

    if [[ -e $HOME/.ssh/known_hosts ]]; then
        zstyle ':completion:*' hosts ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*}
    fi

    # Enter "menu selection" if there are at least 2 choices while completing
    zstyle ':completion:*' menu select=2

    # vi or vim will match first files that don't end in a backup extension,
    # followed by files that do, followed last by files that are known to be binary
    # types that should probably not be edited.
    zstyle ':completion:*:*:(vi|vim):*:*' \
        file-patterns '*~(*.o|*~|*.old|*.bak|*.pro|*.zwc|*.swp|*.pdf|*.class|*.aux):regular-files' \
        '(*~|*.bak|*.old):backup-files' \
        '(*.o|*.pro|*.zwc|*.swp):hidden-files'

    # Provide a fallback completer which always completes files. Useful when Zsh's
    # completion is too "smart". Thanks to Frank Terbeck <ft@bewatermyfriend.org>
    # (http://www.zsh.org/mla/users/2009/msg01038.html).
    zle -C complete-files complete-word _generic
    zstyle ':completion:complete-files:*' completer _files
    bindkey '^F' complete-files

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
    zstyle ':completion:*' cache-path ~/.zsh/.zcache

    # Page long completion lists, using this prompt.
    zstyle ':completion:*' list-prompt %S%L -- More --%s

    zstyle ':completion:*:processes' command 'ps aux --sort=-%cpu'
    () {
        local arr
        arr=( '' 88 2 64 32 54 55 7 8 22 23 )
        zstyle ':completion:*:processes' list-colors "=(#b) #[^ ]#${(l:9*9:: #([^ ]#):)}*${(j:=38;5;:)arr}"
    }

    # Show a warning when no completions were found
    zstyle ':completion:*:warnings' format '%BNo matches for: %d%b'

    # Autocomplete to ./configure in the most cases
    zstyle ':completion:*:*:-command-:*' ignored-patterns './config.*'
fi

### Prompt
#### Function to hide prompts on the line - Will be replaced eventually
TogglePrompt() {
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
Resume() {
    zle push-input
    BUFFER="fg"
    zle accept-line
}
zle -N Resume
bindkey "^Z" Resume
typeset +x PS1     # Don't export PS1 - Other shells just mangle it.

hg_prompt_info() {
    hg prompt --angle-brackets "\
        < on %{$fg[magenta]%}<branch>%{$reset_color%}>\
        < at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
        %{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<
    patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
}
prompt_char() {
    #git branch >/dev/null 3>/dev/null && echo '±' && return
    #hg root >/dev/null 2>/dev/null && echo '☿' && return
    #echo '○'
    echo '$'
}

#### Prompt setup functions
if [[ -n $SSH_CONNECTION ]]; then
    COLOR="${magenta}"
    export SHORTHOST=`hostname | tr '[:upper:]' '[:lower:]'`
else
    COLOR="${boldgreen}"
    export SHORTHOST=`hostname -s | tr '[:upper:]' '[:lower:]'`
fi
# TODO: full prompt showing in PROMPT :D
prompt-setup() {
    if booleancheck "$shellopts[titlebar]" ; then
        PROMPT="${COLOR}${SHORTHOST}${default}:"
        # Trunchate after 30 Chars.. Use the ~ instead of $HOME
        PROMPT+="${blue}%30<..<%~%<<${default}%b"
        PROMPT+='${vcs_info_msg_0_}'
        PROMPT+="${default}%b ${magenta}$(prompt_char) ${default}%b"
        #PS1=$'%{'"$CC"$'%}%20>..>%1~%>>>%{\e[0m%}'
        #PS1=$'%{\e[1;37m%}%m%{\e[0m%}::%{'"$CC"$'%}%35<..<%~%<<>%{\e[0m%}'
    else
        PS1=$'%{\e[1;37m%}%m%{\e[0m%}::%{'"$CC"$'%}%35<..<%~%<<>%{\e[0m%}'
    fi
}
prompt-setup
# Display the VCS information in the right prompt.
# NOT anymore - Display the history information instead ;DD
#RPROMPT='${vcs_info_msg_0_}'
RPROMPT="${default}(${white}%!%b)"

# Prompt for spelling corrections.
# %R is word to change, %r is suggestion, and Y and N are colored green and red.
SPROMPT=$'Should zsh correct "%R" to "%r" ? ([\e[0;32mY\e[0m]es/[\e[0;31mN\e[0m]o/[E]dit/[A]bort) '

# autoload -Uz attach_to_running_screen
# attach_to_running_screen

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

## vim:fdm=expr
## vim:fde=getline(v\:lnum)=~'^##'?'>'.(matchend(getline(v\:lnum),'##*')-2)\:'='
