rigol_vendor_bin is a command line utility to
decode and encode the vendor.bin file from a Rigol oscilloscope

Precompiled Linux, Windows and ARM64 binaries are included 

Rigol 'vendor.bin' encoder/decoder v1.1 - Zelea

rigol_vendor_bin [options] [vendor_bin_file]
 - -M #    set scope model
 - -n      random serial number
 - -N #    set serial number
 - -a      random MAC address
 - -A #    set MAC address

Option strings require 'RKey.data' (or 'Key.data')
 - -l      list available options
 - -o      generate all option strings for the current series
 - -O #    generate option string for feature #
 - -d      debug switch

Step-by-step guide:
 - Install adb on your linux or windows computer (if you haven't already)
 - connect your scope to your local network and find its IP address then
 - adb connect IP:55555
 - adb -s IP:55555 pull /rigol/data/vendor.bin
 - adb -s IP:55555 pull /rigol/data/RKey.data
 - make sure that the generator and the 2 files you've downloaded are in the same directory and then generate all options
 - rigol_vendor_bin -o
 - Optional step: you can also modify your vendor.bin file (to change the scope type, serial number or MAC address) and then send it back to your scope with a push command
 - open a browser and go to the scope IP address and click on SCPI commands
 - copy and paste each option you desire installed in your browser and press "Send" (RLU for memory etc...)
 - you won't get any confirmation in the browser but you'll see a message on your scope's display after each successful option is installed

If all you want is to generate options for your oscilloscope a much simpler way is
to transfer the ARM64 executable to your scope then run it: 
 - adb connect IP:55555
 - adb -s IP:55555 push generate_all_options /rigol/data
 - adb -s IP:55555 shell
 - cd /rigol/data
 - ./generate_all_options
This will create all the option.lic files which will be installed at next reboot.
