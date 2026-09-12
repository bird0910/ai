# clean-ai notes
*A bash script executed as a service automatically, weekly, in the background*

## Purpose
On linux systems, ollama stores models in one of either `/usr/share/ollama/.ollama` or `~/.ollama`. Logs and temporary manifests will bloat over time without doing regular maintenance which is not handled easily via ollama CLI, configs, or any settings or preferences in a GUI. And it's basically impossible to remember without an alert or notification, which is always at an annoying time so it just never gets done unless automated.

## Setup
To automate this process to run in the background (without bothering you with any alerts/notifications/logs/errors) at a specific time on a specific day of the week (or at any interval you want):
    1. move the clean-ai.sh file into your local bin (find where that is with `echo $PATH` but it's usually ~/.local/bin) 
    2. run the following to make it executable:
        `sudo chmod +x clean-ai.sh`
    3. to make sure it works, test it like:
        `cd ~/.local/bin` # or where you saved the script
        `sudo ./clean-ai.sh` # if it doesn't throw any errors, you're good.
    4. edit clean-ai.service to fill in your path to clean-ai.sh for ExecStart
    5. from inside your local bin, run:
        `mv clean-ai.service /etc/systemd/system/clean-ai.service`
        `mv clean-ai.timer /etc/systemd/system/clean-ai.timer`
    6. enable service, activate timer, verify. Run the following in order:
```sh
# Reload the daemon
sudo systemctl daemon-reload

# Enable service, start timer
sudo systemctl enable --now clean-ai.timer

# Confirm successful completion (look for clean-ai.timer in the list)
systemctl list-timers --all
```
### Usage
While this setup will automatically clear the `journalctl` logs every week, sometimes you want to check on the results of these cleanups manually, like as part of a debugging process or to make sure it's actually doing what it's supposed to.
There's 2 ways to check on this, and each way gives you different information about the process.

#### Through journalctl
This is the 'preferred' way because it's where the logs get stored, as well as past errors and all that.
Run:
    `journalctl -u clean-ai.service`

#### Through systemctl
Run:
    `systemctl status clean-ai`

#### Other ways
You can squeeze out even more detailed information about how/when/why/what happens for when scheduled services run, check the following documention for more commands:
    1. `man journalctl`
    2. `journalctl --help`
    3. `man systemctl`
    4. `man systemd`
    5. 'systemctl --help`
    6. etc.
