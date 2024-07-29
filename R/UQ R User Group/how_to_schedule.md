# How to schedule

## Using taskscheduleR

Load the library

```R
library(taskscheduleR)
```

Store the file path of the script you'd like to run. This **must** be an absolute path.

```R
script_path <- file.path("C:/Users/.../file.R")
```

Schedule the task

```R
taskscheduler_create(taskname = "task_name", rscript = script_path, 
                     schedule = "ONCE", starttime = format(Sys.time() + 62, "%H:%M"))
```

A few notes

- Don't schedule code from the same file, because the Task Scheduler runs an entire script and will then schedule more recursively
- Open *Windows Task Scheduler* and click *Task Scheduler Library* (top left) to find your task. You then run it and edit it with *Run* and *Properties* on the right.
- Either use `exec_path = ` inside `taskscheduler_create()` or use the function `setwd()` to set the working directory. **Especially important for exporting or importing files and data**, since they will otherwise crop up in your command line's default.

## Using Windows Task Scheduler

We need to use the program `Rscript.exe` (located in the same folder as your `R.exe` installation, likely `/R-4.x.x/bin/`) to run any R scripts through the command line. Windows task scheduler is the same. There are two options:

1. Use Rscripts directly (requires finding the path for `Rscripts.exe`)
1. Create a batch script (may help avoid issues with Windows Task Scheduler)


### Option 1: Use Rscripts directly

Windows Task Scheduler runs programs through the command line through tasks. Before we create one, we need to locate two things:

- The absolute file path for your R file
- The absolute file path for `Rscript.exe`

Once you have these, create a task with the following:

1. Click *Create Basic Task...* in the top right
1. Name it, choose the frequency and select *Start a program* at the appropriate prompts
1. In *Program/Script*, paste the path for **`Rscript.exe`** (e.g. `"C:/Program Files/ ... /R-4.x.x/bin/Rscript.exe`)
1. In *Add arguments*, paste the path for **your R file**.

Your task is now scheduled and will run!

If you'd like to run it immediately,

1. Navigate to *Task Scheduler Library* (top left)
1. Find and click on your task
1. Select *Run* on the right


### Option 2: Use a Batch file

#### Step 1 - Create a `.bat` file

Create a `.bat` file which runs your R file, using Rscript

```bat
Rscript "C:/absolute/file_path/to/your/file.R"
```

> You **must** use forward slashes `/` *or* double back slashes `\\` and use an **absolute** path

> Note: If you receive the error `'Rscript' is not recognized as an internal or external command, operable program or batch file.`, you'll need to include it in your PATH variable for the operating system.

#### Step 2 - Run the batch file to ensure your R script is set up

Run the new file to check that runs the R script as intended.

If you are exporting or importing any files or data, **ensure that you explicitly set the working directory in the R script**, otherwise the files will crop up at your terminal's default, **not** the file's location:

```R
setwd("C:/absolute/file_path/to/your/")
```

#### Step 3 - Set up a task in Windows Task Scheduler

1. Click *Create Basic Task...* in the top right
1. Name it, choose the frequency and select *Start a program* at the appropriate prompts
1. Browse for the location of your `.bat` file. Don't add optional arguments.

Your task is now scheduled and will run!

If you'd like to run it immediately,

1. Navigate to *Task Scheduler Library* (top left)
1. Find and click on your task
1. Select *Run* on the right

