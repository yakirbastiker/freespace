# freespace
bash script

You are required to write a bash script called "freespace" which can (recursively) traverse a folder of files - often log files - and free the space they are taking by:
- zipping them, and removing the original
- deleting "old" zips

Following is a synopsis of the script:

freespace [-r] [-t ###] file [file...]
If file is not compressed - will zip it under name “fc-<origname>”
If file is compressed - will move it to name “fc-<origname>” and 'touch' it
If file is called “fc-*” AND is older than 48 hours - will rm it
If file is a folder - will go over all non-folder files in it
If in recursive mode - will also follow folders recursively

Flags:
-r - recursive mode
-t - alternative timeout in hours. Default is 48.

Some notes:
- A file is considered "compressed" (no need to zip further) if it is zipped, tgzed, bzipped or compressed
- You can assume that all files named "fc-*" are actually named by you. No need to worry about deleting them once the are "old".
