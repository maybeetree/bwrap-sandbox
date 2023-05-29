## What
bwrap-sandbox is a small utility that lets you create lightweight sandboxes
for desktop apps.
It's designed specifically for "portable applications"
(i.e. apps that are distributed as a single tarball
containing the binary and resources, and don't have an installer).

## Why
1. Don't let programs clutter up your home directory with their files
1. Don't let programs accidentally delete files due to typo's in their code

## How
1. Let's say you have a program that lives in the directory `~/Apps/SomeProgram`
with an entrypoint at `~/Apps/SomeProgram/someprogram.sh`.
1. Run `bwrap-sandbox-create.sh ~/Apps/SomeProgram someprogram.sh`
1. The script will create `~/Apps/SomeProgram.bwrap-sandbox`
that contains the sandboxed home directory and the script that will run
your program in the sandbox.
1. Edit `~/Apps/SomeProgram.bwrap-sandbox/run.sh` to change the sandbox
parameters. For example, replace `--unshare-net` with `--share-net` to
allow the sandboxed program to access the internet.
1. Launch the sandboxed program by running
`~/Apps/SomeProgram.bwrap-sandbox/run.sh`
