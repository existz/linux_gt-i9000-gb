#!/sbin/ext/busybox sh

/sbin/ext/busybox sh /sbin/boot/ramset.sh

read sync < /data/sync_fifo_ramset
rm /data/sync_fifo_ramset
