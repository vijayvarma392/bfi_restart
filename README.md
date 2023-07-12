# bfi_restart
Script to automatically run RestartProject regularly with slurm

## Instructions

### Clone
Important to do this in home, and to rename the directory to make it hidden.
```shell
cd ~
git clone git@github.com:vijayvarma392/bfi_restart.git .bfi_restart
```

### Setup Submit file based on your machine
Example, on minerva:
```shell
cd .bfi_restart
ln -s Submit_minerva.sh Submit.sh
```

### Launch

This will stay in queue for two days, run RestartProject, relaunch itself,
stay in queue for two days, and so on. So, in effect, RestartProject is
run once every two days. It will also send you an email with a summary.

```shell
cd ~
sbatch -J <BFIProject> --export=ALL,EMAIL=<YOUREMAIL> .bfi_restart/Submit.sh
```

For example, `<BFIProject>=q8_7d` and `<YOUREMAIL>=vijay.varma@aei.mpg.de`.

So, `sbatch -J q8_7d --export=ALL,EMAIL=vijay.varma@aei.mpg.de .bfi_restart/Submit.sh`.

Be careful about the format!   
Note: Gmail may be less reliable than academic emails. Also, use your own damn email, not mine!

Note: As with any slurm job, this can occasionally get killed.   
This job should appear with `jobname=<BFIProject>`, so if you don't find it after a while, you may want to relaunch it.

### Terminate
When you are done with the project, remove the job using `scancel`.   
Don't forget to do this, as otherwise, it will just keep trying to restart forever!
