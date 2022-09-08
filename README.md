# bfi_restart
Script to automatically run RestartProject regularly with slurm

## Instructions

### Clone
Important to do this in home, and to rename file to make it hidden.
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
```shell
cd ~
sbatch -J <BFIProject> --export=EMAIL=<YOUREMAIL> .bfi_restart/Submit.sh
```
For example, `<BFIProject>="q8_7d"` and `<YOUREMAIL>="vijay.varma392@gmail.com"`.

This will stay in queue for two days, run RestartProject, relaunch itself,
stay in queue for two days, and so on. So, in effect, RestartProject is
run once every two days. It will also send you an email with a summary.

### Terminate
When you are done with the project, remove the job using `scancel`.
