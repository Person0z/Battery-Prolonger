#!/system/bin/sh

# Displaying Module Banner
ui_print " "
ui_print "  ____        _   _                    _____           _                              "
ui_print " |  _ \      | | | |                  |  __ \         | |                             "
ui_print " | |_) | __ _| |_| |_ ___ _ __ _   _  | |__) | __ ___ | | ___  _ __   __ _  ___ _ __  "
ui_print " |  _ < / _\` | __| __/ _ \ '__| | | | |  ___/ '__/ _ \| |/ _ \| '_ \ / _\` |/ _ \ '__| "
ui_print " | |_) | (_| | |_| ||  __/ |  | |_| | | |   | | | (_) | | (_) | | | | (_| |  __/ |    "
ui_print " |____/ \__,_|\__|\__\___|_|   \__, | |_|   |_|  \___/|_|\___/|_| |_|\__, |\___|_|    "
ui_print "                                __/ |                                 __/ |          "
ui_print "                               |___/                                 |___/           "
ui_print " "

# Setting Permissions
ui_print "Setting permissions for service.sh..."
set_perm $MODPATH/service.sh 0 0 0755

ui_print "Battery Prolonger Module Installed Successfully."
