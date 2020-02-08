# Install each requested virtual machine sequentially.
all_versions="6 7 8 9 10 11 EDGE"
for ver in ${IEVMS_VERSIONS:-$all_versions}
do
    while ! /usr/bin/env IEVMS_VERSION="${ver}" ./ievms.sh; do
       # If the build fails unexpectedly, force it to try again
       case "{$ver}" in
           6|7|8)
               VBoxManage controlvm "IE${ver} - WinXP" poweroff
               VBoxManage unregistervm "IE${ver} - WinXP" --delete
               ;;
           9|10|11)
               VBoxManage controlvm "IE${ver} - Win7" poweroff
               VBoxManage unregistervm "IE${ver} - Win7" --delete
               ;;
           EDGE)
               VBoxManage controlvm "MSEdge - Win10" poweroff
               VBoxManage unregistervm "MSEdge - Win10" --delete
               ;;
       esac
       sleep 1
    done
done
