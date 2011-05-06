# LMKset - kodos
#
# This script sets android's lowmemorykill thresholds and adj values, updating both
# the /proc knobs used by the kernel, and the android system properties (i.e. 
# getprop/setprop) used by the android framework, keeping them in synch with each other.
#
# Users shoudln't modify or call this script directly - you can choose a preset by doing
# 'setprop persist.lmkset.preset <preset #>', then rebooting to apply. A user-defined 
# preset can be defined in lmk_user (see that file for details).
#
# Currently the script defaults to preset 2, as these are the only stock settings I've 
# been able to find which don't appear to have been hacked at by a drunken monkey.
#
# If you manage to work up a preset that you think works better than any of these, 
# please submit it to me at kodos96@gmail.com
#
# Currently defined presets:
#  0: User-defined
#  1: JVB stock settings (kind of)
#  2: JV1/Nexus S stock settings
#  3: kodos
#  4: kodos (experimental)

if [ -e /data/local/lmk_user ]; then
 source /data/local/lmk_user
fi;

#1: JVB stock settings (kind of) : This is the closest I could come to replicating the 
#JVB stock settings without intentionally re-introducing a Samsung bug
PRESET_1_ADJ_1=0
PRESET_1_ADJ_2=1
PRESET_1_ADJ_3=1
PRESET_1_ADJ_4=2
PRESET_1_ADJ_5=2
PRESET_1_ADJ_6=2
PRESET_1_ADJ_7=4
PRESET_1_ADJ_8=7
PRESET_1_ADJ_9=15
PRESET_1_MEM_1=2560
PRESET_1_MEM_2=4096
PRESET_1_MEM_3=4096
PRESET_1_MEM_4=4096
PRESET_1_MEM_5=6144
PRESET_1_MEM_6=6144
PRESET_1_MEM_7=6144
PRESET_1_MEM_8=10240
PRESET_1_MEM_9=12288
PRESET_1_Amap_1=1
PRESET_1_Amap_2=2
PRESET_1_Amap_3=4
PRESET_1_Amap_4=7
PRESET_1_Amap_5=8
PRESET_1_Amap_6=9
PRESET_1_Mmap_1=1
PRESET_1_Mmap_2=2
PRESET_1_Mmap_3=5
PRESET_1_Mmap_4=8
PRESET_1_Mmap_5=8
PRESET_1_Mmap_6=9

#2: JV1/Nexus S stock settings
PRESET_2_ADJ_1=0
PRESET_2_ADJ_2=1
PRESET_2_ADJ_3=2
PRESET_2_ADJ_4=3
PRESET_2_ADJ_5=4
PRESET_2_ADJ_6=5
PRESET_2_ADJ_7=6
PRESET_2_ADJ_8=7
PRESET_2_ADJ_9=15
PRESET_2_MEM_1=2048
PRESET_2_MEM_2=3072
PRESET_2_MEM_3=4096
PRESET_2_MEM_4=4096
PRESET_2_MEM_5=6144
PRESET_2_MEM_6=6144
PRESET_2_MEM_7=6144
PRESET_2_MEM_8=7168
PRESET_2_MEM_9=8192
PRESET_2_Amap_1=1
PRESET_2_Amap_2=2
PRESET_2_Amap_3=3
PRESET_2_Amap_4=5
PRESET_2_Amap_5=8
PRESET_2_Amap_6=9
PRESET_2_Mmap_1=1
PRESET_2_Mmap_2=2
PRESET_2_Mmap_3=3
PRESET_2_Mmap_4=5
PRESET_2_Mmap_5=8
PRESET_2_Mmap_6=9

#3: kodos
PRESET_3_ADJ_1=0
PRESET_3_ADJ_2=1
PRESET_3_ADJ_3=1
PRESET_3_ADJ_4=2
PRESET_3_ADJ_5=2
PRESET_3_ADJ_6=3
PRESET_3_ADJ_7=4
PRESET_3_ADJ_8=5
PRESET_3_ADJ_9=15

PRESET_3_MEM_1=1920
PRESET_3_MEM_2=2304
PRESET_3_MEM_3=2560
PRESET_3_MEM_4=3072
PRESET_3_MEM_5=3840
PRESET_3_MEM_6=4352
PRESET_3_MEM_7=5376
PRESET_3_MEM_8=6400
PRESET_3_MEM_9=15360

PRESET_3_Amap_1=1
PRESET_3_Amap_2=2
PRESET_3_Amap_3=4
PRESET_3_Amap_4=6
PRESET_3_Amap_5=8
PRESET_3_Amap_6=9

PRESET_3_Mmap_1=1
PRESET_3_Mmap_2=2
PRESET_3_Mmap_3=3
PRESET_3_Mmap_4=4
PRESET_3_Mmap_5=8
PRESET_3_Mmap_6=9

#4: kodos: experimental
PRESET_4_ADJ_1=0
PRESET_4_ADJ_2=1
PRESET_4_ADJ_3=1
PRESET_4_ADJ_4=2
PRESET_4_ADJ_5=6
PRESET_4_ADJ_6=3
PRESET_4_ADJ_7=4
PRESET_4_ADJ_8=5
PRESET_4_ADJ_9=15

PRESET_4_MEM_1=1920
PRESET_4_MEM_2=2304
PRESET_4_MEM_3=2560
PRESET_4_MEM_4=3072
PRESET_4_MEM_5=6912
PRESET_4_MEM_6=4096
PRESET_4_MEM_7=5120
PRESET_4_MEM_8=6400
PRESET_4_MEM_9=15360

PRESET_4_Amap_1=1
PRESET_4_Amap_2=2
PRESET_4_Amap_3=4
PRESET_4_Amap_4=6
PRESET_4_Amap_5=8
PRESET_4_Amap_6=9

PRESET_4_Mmap_1=1
PRESET_4_Mmap_2=2
PRESET_4_Mmap_3=3
PRESET_4_Mmap_4=4
PRESET_4_Mmap_5=8
PRESET_4_Mmap_6=9

if [ "$(getprop persist.lmkset.preset)" == "" ]; then
 setprop persist.lmkset.preset 2
fi;

PRESET=`getprop persist.lmkset.preset`

eval export set LMKSET_ADJ_1=\${"PRESET_${PRESET}_ADJ_1"}
eval export set LMKSET_ADJ_2=\${"PRESET_${PRESET}_ADJ_2"}
eval export set LMKSET_ADJ_3=\${"PRESET_${PRESET}_ADJ_3"}
eval export set LMKSET_ADJ_4=\${"PRESET_${PRESET}_ADJ_4"}
eval export set LMKSET_ADJ_5=\${"PRESET_${PRESET}_ADJ_5"}
eval export set LMKSET_ADJ_6=\${"PRESET_${PRESET}_ADJ_6"}
eval export set LMKSET_ADJ_7=\${"PRESET_${PRESET}_ADJ_7"}
eval export set LMKSET_ADJ_8=\${"PRESET_${PRESET}_ADJ_8"}
eval export set LMKSET_ADJ_9=\${"PRESET_${PRESET}_ADJ_9"}

eval export set LMKSET_MEM_1=\${"PRESET_${PRESET}_MEM_1"}
eval export set LMKSET_MEM_2=\${"PRESET_${PRESET}_MEM_2"}
eval export set LMKSET_MEM_3=\${"PRESET_${PRESET}_MEM_3"}
eval export set LMKSET_MEM_4=\${"PRESET_${PRESET}_MEM_4"}
eval export set LMKSET_MEM_5=\${"PRESET_${PRESET}_MEM_5"}
eval export set LMKSET_MEM_6=\${"PRESET_${PRESET}_MEM_6"}
eval export set LMKSET_MEM_7=\${"PRESET_${PRESET}_MEM_7"}
eval export set LMKSET_MEM_8=\${"PRESET_${PRESET}_MEM_8"}
eval export set LMKSET_MEM_9=\${"PRESET_${PRESET}_MEM_9"}

eval export set LMKSET_Amap_1=\${"PRESET_${PRESET}_Amap_1"}
eval export set LMKSET_Amap_2=\${"PRESET_${PRESET}_Amap_2"}
eval export set LMKSET_Amap_3=\${"PRESET_${PRESET}_Amap_3"}
eval export set LMKSET_Amap_4=\${"PRESET_${PRESET}_Amap_4"}
eval export set LMKSET_Amap_5=\${"PRESET_${PRESET}_Amap_5"}
eval export set LMKSET_Amap_6=\${"PRESET_${PRESET}_Amap_6"}

eval export set LMKSET_Mmap_1=\${"PRESET_${PRESET}_Mmap_1"}
eval export set LMKSET_Mmap_2=\${"PRESET_${PRESET}_Mmap_2"}
eval export set LMKSET_Mmap_3=\${"PRESET_${PRESET}_Mmap_3"}
eval export set LMKSET_Mmap_4=\${"PRESET_${PRESET}_Mmap_4"}
eval export set LMKSET_Mmap_5=\${"PRESET_${PRESET}_Mmap_5"}
eval export set LMKSET_Mmap_6=\${"PRESET_${PRESET}_Mmap_6"}

setprop ro.FOREGROUND_APP_ADJ $LMKSET_ADJ_1
setprop ro.VISIBLE_APP_ADJ $LMKSET_ADJ_2
setprop ro.PERCEPTIBLE_APP_ADJ $LMKSET_ADJ_3
setprop ro.HEAVY_WEIGHT_APP_ADJ $LMKSET_ADJ_4
setprop ro.SECONDARY_SERVER_ADJ $LMKSET_ADJ_5
setprop ro.BACKUP_APP_ADJ $LMKSET_ADJ_6
setprop ro.HOME_APP_ADJ $LMKSET_ADJ_7
setprop ro.HIDDEN_APP_MIN_ADJ $LMKSET_ADJ_8
setprop ro.EMPTY_APP_ADJ $LMKSET_ADJ_9

setprop ro.FOREGROUND_APP_MEM $LMKSET_MEM_1
setprop ro.VISIBLE_APP_MEM $LMKSET_MEM_2
setprop ro.PERCEPTIBLE_APP_MEM $LMKSET_MEM_3
setprop ro.HEAVY_WEIGHT_APP_MEM $LMKSET_MEM_4
setprop ro.SECONDARY_SERVER_MEM $LMKSET_MEM_5
setprop ro.BACKUP_APP_MEM $LMKSET_MEM_6
setprop ro.HOME_APP_MEM $LMKSET_MEM_7
setprop ro.HIDDEN_APP_MEM $LMKSET_MEM_8
setprop ro.EMPTY_APP_MEM $LMKSET_MEM_9

echo $(eval echo \$LMKSET_ADJ_${LMKSET_Amap_1}),$(eval echo \$LMKSET_ADJ_${LMKSET_Amap_2}),$(eval echo \$LMKSET_ADJ_${LMKSET_Amap_3}),$(eval echo \$LMKSET_ADJ_${LMKSET_Amap_4}),$(eval echo \$LMKSET_ADJ_${LMKSET_Amap_5}),$(eval echo \$LMKSET_ADJ_${LMKSET_Amap_6}) > /sys/module/lowmemorykiller/parameters/adj
echo $(eval echo \$LMKSET_MEM_${LMKSET_Mmap_1}),$(eval echo \$LMKSET_MEM_${LMKSET_Mmap_2}),$(eval echo \$LMKSET_MEM_${LMKSET_Mmap_3}),$(eval echo \$LMKSET_MEM_${LMKSET_Mmap_4}),$(eval echo \$LMKSET_MEM_${LMKSET_Mmap_5}),$(eval echo \$LMKSET_MEM_${LMKSET_Mmap_6}) > /sys/module/lowmemorykiller/parameters/minfree
