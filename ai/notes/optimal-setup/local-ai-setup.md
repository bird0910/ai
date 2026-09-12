# Setting up system environment for local ai

> [!NOTE]
> Although I sourced these recommendations/bits of advice from AI's answer to a simply google query, these practices worked well with my system when running endeavouros. I figure, same laptop but different distro would have similar positive results.
> So although these tips were already notated elsewhere[^1], they are hard to navigate without wanting to install Verba for RAG just yet. Here, I attempt to collect the advice together to present as a coherent list of advice personalized for my hardware.


## Basics

### Hw setup
*from kde sys settings -> system -> about*

Operating System: EndeavourOS 
KDE Plasma Version: 6.7.4
KDE Frameworks Version: 6.29.0
Qt Version: 6.11.2
Kernel Version: 7.2.3-arch1-3 (64-bit)
Graphics Platform: Wayland
Processors: 16 × AMD Ryzen 7 PRO 5850U with Radeon Graphics
Memory: 16 GiB of RAM (14.9 GiB usable)
Graphics Processor: AMD Radeon Graphics
Manufacturer: HP
Product Name: HP EliteBook 855 G8 Notebook PC
System Version: SBKPF

See also: /home/kait-bird/proj/coding/ai/cfg/hw_specs.txt is much more detailed (is stdout from command `lscpu`) - should be under .gitigore for privacy, but above is ok.

> [!TIP] about my CPU/SSD spex...
> Analyzing long papers and research can be 'compute-heavy.' When you first upload a paper for context:
> - Your Ryzen 5850U will spike to 100% for a few seconds while it "indexes" the text.
> Ensure your PDF contextual research files are stored on your SSD (not an external hdd0. Fast read speeds are crucial.

Above tip has to do with RAG usage/setup.

## Optimization for Ryzen 7 5850U

> [!SUMMARY]
> The process listed here will:
> - Make best use of cpu cores/threads
> - Modify system swappiness to fix probability of moving models from RAM into CPU during hi-stress usage.
> - Modify power usage settings to be able to toggle between performance (for ai) and battery save (all else).
> - Create an automatic cleanup/env maintenance script to keep caches, temp data super lean
> - Show how to create and tweak modelfiles for best parameters
> - Utilize vulkan headers for acceleration w/o GPU cheat

### 1. Modify swappiness
In general and by default, most linux distros have a preference for saving available RAM by "swapping" data into the hard drive when things get heavy. This is a cool option for regular-use systems, like for web browsing or whatever. However, when running local AI you want the opposite tendency - e.g., a preference for NOT swapping data over into memory because it'll make models MUCH MUCH slower, esp. when with context.

**About the Values**:
The swappiness number is an integer between 1 - 100 (basically a percentage of swap probability). Some usage examples are:
- *General Use , e.g. Desktop/Browsing* 30-60 balances performance and memory usage.
- *Memory-Intensive Tasks, e.g. Gaming/AI* Lower values like 10-20 are beneficial to minimize swap usage and keep frequently accessed data in RAM. That's what we want for AI.
- *Server Environments* Values around 10 or lower are common to prioritize RAM utilization and reduce disk I/O.

> [!IMPORTANT]
> The caveat here is that there's no 'one-size-fits-all' that works across all systems. To figure out what works for you, you have to monitor system performance with some tool like `top` or `htop` over time/experiments to find the ideal number.

That said, 10 is a good place to start.

#### To check current swappiness
`cat /proc/sys/vm/swappiness`
default is usually 60.

#### To modify runtime swappiness (this boot only)
`sudo sysctl -w vm.swappiness=INTEGER`
try 10 to start

#### To persistently modify swappiness (saves permanently)
- Edit the file: `/etc/sysctl.conf` or create if doesn't exist
- Add/modify the line: `vm.swappiness=INT`
- Save file. To immediately apply changes, run `sudo sysctl -p` or `sudo systemctl soft-reboot`


