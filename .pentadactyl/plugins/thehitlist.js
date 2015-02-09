group.commands.add(['thl'], "Add a task to The Hit List",
    function thehitlist_task_add() {
        var taskTitle = '';
        var url = '';
        // use selection
        if (content.window.getSelection) {
            taskTitle = content.window.getSelection().toString();
        }
        if (taskTitle === '') {
            var frames = content.window.frames;
            for (var i = 0; i < frames.length; i++) {
                if (taskTitle === '') {
                    taskTitle = frames[i].content.document.getSelection().toString();
                } else {
                    break;
                }
            }
        }
        // nothing selected? show prompt
        if (taskTitle === null || taskTitle === "") {
            taskTitle = prompt("Enter a task description or leave empty to use this site's title:");
        }
        // prompt canceled? return
        if (taskTitle === null) {
            return false;
        }
        // nothing entered? use site's title
        if (taskTitle === "") {
            taskTitle = buffer.title;
        }
        // redirect to THL
        self.location = "thehitlist:///inbox/tasks?method=POST&title=" + encodeURIComponent(taskTitle) + "&url=" + encodeURIComponent(buffer.URL);
        return null;
    }
)
