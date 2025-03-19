#!/usr/bin/env expect
set timeout -1
set install_dir [lindex $argv 0]
set version [lindex $argv 1]

spawn ./petalinux-v$version-final-installer.run --dir $install_dir  --platform "aarch64"

expect "*Enter to display the license agreements*"
send "\r"
send "q"

expect "*>*"
send "y"
send "\r"

expect "*(press RETURN)*"
send "\r"
expect "*(END)*"
send "q"

expect "*>*"
send "y"
send "\r"
send "q"

expect "*>*"
send "y"
send "\r"

expect "*Petalinux SDK has been installed to*"
send_user "auto install petalinux done\r"
send_user "wait several minutes to clean up\r"
exit
