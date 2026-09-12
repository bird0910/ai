#!/bin/bash
# clean-ai.sh--sets up optimal local environment for running LLMs, does automatic weekly maintenance & cleaning of manifests,
#     filesystem, logs but keeps models/modelfiles. Don't forget to make executable. No `sudo`s here since automatically ran
#     as SU from systemd service.
#
echo "Pausing ollama service..."
systemctl stop ollama

echo "1/3: Cleaning up temp manifests and logs..."
# Cleans the ollama logs from past week (change if ran at different interval)
journalctl --vacuum-time=7d --unit=ollama

# finds your local cache in one of two places (unless modified ENV VAR, if so, edit this part accordingly)
if [ -d ~/.ollama/models/blobs ] ; then
	[ find ~/.ollama/models/blobs -type f -atime +30 -delete ] ; &
	echo "Your ollama cache lives at ~/.ollama, cleaning now..." &&
		continue
elif [ -d /usr/share/ollama/.ollama/models/blobs ] ; then
	[ find /usr/share/ollama/.ollama/models/blobs -type f -atime +30 -delete ] ; &
	echo "Your ollama cache lives at /usr/share/ollama/.ollama - cleaning now..." &&
		continue
else
	echo "Error: cannot locate your ollama cache automatically, skipping..." >&2
	continue
fi

# clean filesystem
echo "3/3: Optimizing your filesystem (TRIM)..." &
fstrim -av &&
	continue

# Finish
echo "Restarting ollama service..." &
systemctl restart ollama &&
	echo "Finished successfully! Local AI environment is refreshed." &&
	exit 0
