#! /bin/sh

set -euf -o pipefail

GDB_SCRIPT=gdb-debug-script
GDB=arm-none-eabi-gdb
TMUX_SESSION=gdb-server

function clean_up {
    tmux kill-session -t $TMUX_SESSION
    rm $GDB_SCRIPT
    exit
}

trap "clean_up" SIGHUP SIGINT SIGTERM

#tmux new -s $TMUX_SESSION -d "JLinkGDBServer -device 'MKL25Z128xxx4 (allow security)' -if swd -speed 1000"
tmux new -s $TMUX_SESSION -d "JLinkGDBServer -device 'MKL25Z128xxx4' -if swd -speed 1000"
#MKL46Z256xxx4 (allow security)
touch $GDB_SCRIPT

echo $1
echo $0

echo "target remote localhost:2331" >> $GDB_SCRIPT
echo "symbol-file $1" >> $GDB_SCRIPT
echo "load $1" >> $GDB_SCRIPT
echo "b main" >> $GDB_SCRIPT
echo "b HardFault_Handler" >> $GDB_SCRIPT
echo "mon reset 2" >> $GDB_SCRIPT
echo "c" >> $GDB_SCRIPT

$GDB -x $GDB_SCRIPT

clean_up
