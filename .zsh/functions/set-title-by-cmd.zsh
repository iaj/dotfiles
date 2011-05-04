### Set window title
# Given a command as a single word and an optional directory, this generates
# a titlebar string like "hostname> dir || cmd" and assigns that to an element
# in PSVAR for use by the prompt, and to the exported variable TITLE for use by
# other applications.  If the directory is omitted, it will default to the
# current working directory.  It then takes the first word of that command
# (splitting on whitespace), excluding variable assignments, the word sudo, and
# command flags, and assigns that to an element in PSVAR for use as a screen
# name and icon title, as well as to the exported variable ICON.  Finally, it
# actually writes those strings as the screen name and title bar text.
set-title-by-cmd() {
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
set-title-by-cmd-impl() {
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

