function minutes_since_last_commit {
    now=`date +%s`
    last_commit=`git log --pretty=format:'%at' -1`
    seconds_since_last_commit=$((now-last_commit))
    minutes_since_last_commit=$((seconds_since_last_commit/60))
    echo $minutes_since_last_commit
}
function scm_time_since_commit() {
#local -A pc
#pc=(${(kv)wunjo_prompt_colors})
local MINUTES_SINCE_LAST_COMMIT=`minutes_since_last_commit`
if [ "$MINUTES_SINCE_LAST_COMMIT" -gt 30 ]; then
    COLOR="${red}"
elif [ "$MINUTES_SINCE_LAST_COMMIT" -gt 10 ]; then
    COLOR="${yellow}"
else
    COLOR="${green}"
fi
local SINCE_LAST_COMMIT="${green}$(minutes_since_last_commit)m${default}"
echo $SINCE_LAST_COMMIT
print -P $SINCE_LAST_COMMIT
}
