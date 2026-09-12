---
NoteType: documentation
DocsCategory: tutorial
category:
SoucesCited:
  - "[[RAG with Verba]]"
  - google ai
  - kde system settings
parent:
  - Ollama
  - tumbleweed
  - "[[tumbleweed utilities]]"
next:
prev:
  - "[[RAG with Verba]]"
tags:
  - 4BitQuantization
  - optimization
  - ai
  - local
  - RAG
  - prompts
  - configs
  - settings
  - setup
  - preferences
  - admin
  - agents
  - models
  - BestPractice
  - troubleshooting
  - hardware
  - opensuse
  - OLLAMA
  - opensource
  - organization
  - finetune
  - software
  - logs
  - to-do
  - units
  - timers
  - systemd
  - system
  - buildsystems
  - recommendation
  - LLMs
  - Installing
  - customization
  - modelfile
  - automation
  - cache
  - daemons
  - documentation
  - multi-agent-architecture
  - tips
aliases:
---

# Optimizing for local ai


> [!NOTE]
> Although I sourced these recommendations/bits of advice from AI's answer to a simply google query, these practices worked well with my system when running endeavouros. I figure, same laptop but different distro would have similar positive results.

So although these tips were already notated elsewhere[^1], they are hard to navigate without wanting to install Verba for RAG just yet. Here, I attempt to collect the advice together to present as a coherent list of advice personalized for my hardware.

## My hardware setup


According to KDE system settings, my basic hardware setup is:

```text
Operating System: openSUSE Tumbleweed 20260809
KDE Plasma Version: 6.7.4
KDE Frameworks Version: 6.28.0
Qt Version: 6.11.1
Kernel Version: 7.1.7-1-default (64-bit)
Graphics Platform: Wayland
Processors: 16 × AMD Ryzen 7 PRO 5850U with Radeon Graphics
Memory: 16 GiB of RAM (14.9 GiB usable)
Graphics Processor: AMD Radeon Graphics
Manufacturer: HP
Product Name: HP EliteBook 855 G8 Notebook PC
System Version: SBKPF
```



> [!TIP] about my CPU/SSD
> Analyzing long papers and research can be 'compute-heavy.' When you first upload a paper for context:
> - Your Ryzen 5850U will spike to 100% for a few seconds while it "indexes" the text.
> Ensure your PDF contextual research files are stored on your SSD (not an external hdd0. Fast read speeds are crucial.

## Optimization for Ryzen 7 5850U

Google says,
> Since your CPU is a mobile Zen 3 chip with 16 threads, you can significantly speed up inference by letting Ollama use the maximum number of cores while conforming to 'best practice'[^2] procedure.

### 1. Thread optimization

By default, Ollama might only use a few cores. You can force it to use your full 5850U power by adding a parameter to your `Modelfile`.


> [!PROCESS]
> 1. Create a file called `Modelfile`.
> 2. Add the parameters in the codebox below.
> 3. In terminal, run `ollama create $MODELNAME -f Modelfile`

```text
FROM qwen2.5-coder:7b     # replace with the full name of ai model
PARAMETER num_thread 13
```


### 2. GPU acceleration

> Your [Radeon Graphics](https://www.google.com/search?ibp=oshop&prds=pvt:hg,pvo:29,imageDocid:5827597053033758790,headlineOfferDocid:2165779524513818919,productDocid:2165779524513818919,rds:PC_2092339291080450465%7CPROD_PC_2092339291080450465&q=product&sa=X&ved=2ahUKEwiUjsu3sv-SAxXrJNAFHep1MpcQxa4PegYIAQgHEAc) can help with the "heavy lifting." On Linux, you may need to add your user to the `render` or `video` group to allow Ollama to access the GPU:

```bash
sudo usermod -a -G render $USER # appends user to group -G w/o making any other changes

sudo usermod -a -G video $USER
```

For the above commands to take effect, the system must be restarted:
`systemctl soft-reboot`

**_Step completed on 08/13/26 for root and bird - add Mikey later?_**


### 3. Lean and private maintenance script

On linux, Ollama stores models in `/usr/share/ollama/.ollama` or `~/.ollama`. Logs and temporary manifests can bloat over time without doing regular maintenance which can be difficult to remember. To automate this process to run in the background on boot, create the following file in your local bin and name it `clean-ai.sh`:

```sh
#!/bin/bash
# A script to keep your local AI storage lean on a linux-based distro

echo "Stopping ollama service..."
sudo systemctl stop ollama

echo "Cleaning up temporary manifests and logs..."
# cleans the ollama logs
sudo journalctl --vacuum-time=1d --unit=ollama

# cleans the internal bloat (keep your models, remove the cruft)
find ~/.ollama/models/blobs -type f -atime +30 -delete

echo "Optimizing filesystem (TRIM)..."
sudo fstrim -av

echo "Restarting ollama service..."
sudo systemctl start ollama
echo "Finished successfully! Your local AI environment is now fresh."
```


#### Hands-free mode

In typical tumbleweed fashion, you can choose your preference between a few different methods of scheduling the automatic launch of any shell script or application (executable file). The most popular choices are `cronjobs` and `systemd unit/timer` pairs of files. One distinct advantage to the `systemd` method is the simplicity which `journalctl` lends to troubleshooting/debugging by easy log access; for more flexibility in scheduling tasks, though, it's easy to understand why despite its age, it still has its die-hard fans.
For me, working with `systemd` is more familiar and comfortable.

##### 1. Create the service file

This file, which will live at `/etc/systemd/system/clean-ai.service`, is instrumental for telling `systemd` what to run as well as any other pertinent details and specifications involved.

```TOML
[Unit]
Description=Cleanup and optimize local ai environment
After=network.target

[Service]
Type=oneshot
ExecStart=/home/bird/admin/bin/clean-ai.sh
# If the script doesn't require to be ran as su, then run as regular user
# User=bird

[Install]
WantedBy=multi-user.target
```


##### 2. Create the timer file

This file tells `systemd` when to run a unit service. It lives with all the other units and timers at `/etc/systemd/system/clean-ai.timer`:
```TOML
[Unit]
Description=Run AI system maintenance weekly

[Timer]
# Runs every Sunday at 11:00 PM
OnCalendar=Sun *-*-* 23:00:00
# When system is powered off at scheduled runtime, launch immediately on
# next boot.
Persistent=true

[Install]
WantedBy=timers.target
```

##### 3. Activate the timer

Run these commands in sequence so the system starts watching the clock.

```bash
# Reload the daemon
sudo systemctl daemon-reload

# Enable and start the timer
sudo systemctl enable --now clean-ai.timer

# Confirm successful completion (look for clean-ai.timer in the list)
systemctl list-timers --all
```


##### 4. Update sh file su avoid permissions confusion

> [!BUG]
> To avoid the script's failure when running on schedule, remember to eliminate any reason for bash to ask for user input; since services always run in the background as non-interactive processes, you will not be notified that bash needs information from you before proceeding. This type of error is referred to as **permission prompts that hang the background process**.
> **Solution A:** Fortunately, timers automatically run as `root` by default. As long as no user is listed in the unit file, no processes will hang as they await an answer that will never come.

> Also, ensure all paths involved in automated services, such as inside the script, unit file, or timer file are **always absolute** to ensure reliability.

##### 4.5 Usage

While this setup will automatically clear the `journalctl` logs every week, it often happens that you'll want to check on the results of these cleanups manually, such as part of debugging errors. There are two ways to do this, and each way will provide you with different details about the process.

```bash
# Through journalctl
jounalctl -u clean-ai.service

# Through systemctl
systemctl status clean-ai
```

To find ways of squeezing out even more detailed info about the running of a scheduled service, check the usual places[^3] for help.

### 4. Essential Modelfile tweaks for 5850U

For **Research** and **Coding** types of models, add these specific `PARAMETER` lines to the respective Modeliles. These are the "secret sauce" for 16GM RAM users:

#### Coding

Add these to prevent the model from "rambling" or being "lazy":
```text
PARAMETER temperature 0.0
PARAMETER top_p 0.9
PARAMETER repeat_penalty 1.1
PARAMETER stop "<|endoftext|>"
PARAMETER num_thread 10
```


> [!EXPLANATION]
> 1. A `temperature` value of `0.0` forces 100% logic and 0% creativity in responses - this is critical for proper syntax.
> 2. A `top_p` quantity of `0.9` keeps responses focused on high-probability tokens
> 3. The `repeat_penalty` value of `1.1` prevents the model from getting stuck in a loop while attempting to (over)explain their responses and the reasons they chose them based on your prompt and query.
> 4. Providing a `stop` clause of `"<|endoftext|>"` will ensure that the model will stop responding precisely when the code block ends for added token efficiency.
> 5. Lastly, as already discussed above, the `num_thread` specified as `10` tells the model that it is allowed to make use of 10 threads (out of the available 16). If the model isn't intended to be used as a member of a multi-agent setup, however, this number should be edited to `13` to make full use of available cores and maximize speed.

#### Research

Add the following to the specific `Modelfile` to help the agent handle long context for lengthy, technical files:

```text
PARAMETER num_ctx 24000
PARAMETER num_batch 128
PARAMETER num_thread 13
PARAMETER temperature 0.3
```


> [!EXPLANATION]
> 1. For 16GB RAM, the length of context balanced with your hardware comes out to the `num_ctx` value to be `24000`. This value translates into about 50 pages of a typical PDF.
> 2. The `num_batch` set to `128` allows a model to process chunks of text faster for CPUs such as mine.
> 3. The `num_thread` set to `13` is the maximum amount of cores accessible to the model (remembering to "leave room for jesus."
> 4. The `temperature` setting describes the ratio of tension between the opposing "build strategies" used for "constructing" responses. For a model expected to be both accurate and insightful, `0.3` is a value which is low enough to preserve attention to detail (accuracy) while being high enough for good synthesis in making connections about the data.


### 5. The KDE graphical environment tweak: CPU Governor

Since my system is forever worrying over amount of external power available because it is a laptop, my CPU is probably engaging in a somewhat opaque habit of "throttling" to conserve battery. This process is useful for extending the length of available computing time, but has an unintended price to pay when using local AI because these amendments to system performance as the battery drains cause AI to feel sluggish.
To remedy this, before you partake in research sessions with your local models, be sure to instruct your OS to go into **Performance Mode**:

```bash
# Install tool if not already available
sudo zypper install cpupower

# Set CPU to performance
sudo cpupower frequency-set -g performance

# Post-research setings to apply when finished with ai work, which will
# fall back to conserve power again
sudo cpupower frequency-set -g powersave
sudo cpupower frequency-set -g schedutil
```

*I think this is the same as the KDE power manager functions aleady in my toolbar? So this step would be redundant, IMO. Just remember to set to performance whenever using AI.*


### 6. Enable Vulkan acceleration

> You can squeeze significantly more speed out of the iGPU by letting the integrated Radeon cores handle the "Token Generation" while the 16GB RAM handles the model weight storage.

Process walked through below.

#### 1. Install the headers


> [!WARNING]
> The suggested package listed is the one recommended for Arch-based distros. Tumbleweed may very well call this something else; be sure to do some investigation before proceeding.

`sudo zypper vulkan-devel`

**_Default installations - these came with the install:_**

| Package Name              | Description                                                                          |
| ------------------------- | ------------------------------------------------------------------------------------ |
| libvulkan1                | The Vulkan 3D graphics and compute API                                               |
| libvulkan_1vp             | Mesa vulkan driver for LVP                                                           |
| libvulkan_radeon          | Mesa vulkan driver AMD GPU                                                           |
| Mesa-vulkan-anti-lag      | Vulkan layer to reduce the latency between inputs received and updates on the screen |
| Mesa-vulkan-device-select | Vulkan layer to select Vulkan devices provided by Mesa                               |
| vulkan-tools              | Diagnostic utilities for Vulkan                                                      |

None of these ^^ are it; the OpenSuse version of the needed package is called `vulkan-devel`, just as recommended...

#### 2. Set the environment variables

Edit `.bashrc` to ensure Ollama is alerted to look for the Vulkan driver. Append the following to the section dedicated to environment variables:

```.bashrc
export OLLAMA_GPU_OVERHEAD=1
export GGML_VULKAN=1
```

**_Completed on 8/13_**
#### 3.  Restart the service

`sudo systemctl restart ollama`


### 7. System swappiness tweak

> In general and by default, most Linux distros display an affinity for the enduring ingenuity of a little sleight-of-hand, so to speak, or method of saving RAM by "swapping' data to the hard drive (or SSD, "disk").
7/3
Since this behavior is precisely the inversion of conditions we want when using local ai. Therefore, to have the OS keep ai models confined to the RAM for as long as possible.

**About Values**:
- *General Use , e.g. Desktop/Browsing* 30-60 balances performance and memory usage.
- *Memory-Intensive Tasks, e.g. Gaming/AI* Lower values like 10-20 are beneficial to minimize swap usage and keep frequently accessed data in RAM.
- *Server Environments* Values around 10 or lower are common to prioritize RAM utilization and reduce disk I/O.
- *Experiment and Montior* No one-size fits all value. Needs to be observed and monitored with something like `top` or `htop` after making changes and adjusting as needed.

#### 1. Check current swappiness

`cat /proc/sys/vm/swappiness`
The most common amount is 60. **_Yes, mine is/was 60_**

#### 2. Runtime (temporary) change
`sudo sysctl -w vm.swappiness=YOUR_DESIRED_VALUE` # rec value: 10

#### 4. Persistent change
- Edit the file: `/etc/sysctl.conf`:
- Add/modify line: `vm.swappiness=10`
- Save file. To apply changes immediately, run `sudo sysctl -p`

---
## Footnotes, citations, see-alsos
2
[^1]: This is spread all throughout [[RAG with Verba]] tutorial in a confusing manner which is hard to navigate if I'm not interested in setting up Verba for RAG pipelines just yet. This page is the attempt to gather all the recommendations there into one coherent, step-by-step list, here.

[^2]: Keen observers will notice a discrepancy of 3 threads between the quantity assigned as 'available' for AI usage and the total amount available to the entire system. This is important because it "leaves room for jesus," so to speak, by  appropriating a minimum of 3 cores at all times to the randomness in requirements at any given time for `SWAP` processes (which everyone knows exist in an impenetrable black box of comprehensibility/logic).

[^3]: The usual places: `man journalctl` and/or `journalctl --help` and the equivalent commands for `systemctl`.

