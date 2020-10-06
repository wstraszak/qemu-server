/usr/bin/kvm \
  -id 8006 \
  -name simple \
  -chardev 'socket,id=qmp,path=/var/run/qemu-server/8006.qmp,server,nowait' \
  -mon 'chardev=qmp,mode=control' \
  -chardev 'socket,id=qmp-event,path=/var/run/qmeventd.sock,reconnect=5' \
  -mon 'chardev=qmp-event,mode=control' \
  -pidfile /var/run/qemu-server/8006.pid \
  -daemonize \
  -smbios 'type=1,uuid=7b10d7af-b932-4c66-b2c3-3996152ec465' \
  -smp '3,sockets=1,cores=3,maxcpus=3' \
  -nodefaults \
  -boot 'menu=on,strict=on,reboot-timeout=1000,splash=/usr/share/qemu-server/bootsplash.jpg' \
  -vnc unix:/var/run/qemu-server/8006.vnc,password \
  -cpu kvm64,enforce,+kvm_pv_eoi,+kvm_pv_unhalt,+lahf_lm,+sep \
  -m 768 \
  -object 'iothread,id=iothread-virtio0' \
  -object 'iothread,id=iothread-virtio1' \
  -device 'pci-bridge,id=pci.1,chassis_nr=1,bus=pci.0,addr=0x1e' \
  -device 'pci-bridge,id=pci.2,chassis_nr=2,bus=pci.0,addr=0x1f' \
  -device 'vmgenid,guid=c773c261-d800-4348-9f5d-167fadd53cf8' \
  -device 'piix3-usb-uhci,id=uhci,bus=pci.0,addr=0x1.0x2' \
  -device 'usb-tablet,id=tablet,bus=uhci.0,port=1' \
  -device 'VGA,id=vga,bus=pci.0,addr=0x2' \
  -device 'virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x3' \
  -iscsi 'initiator-name=iqn.1993-08.org.debian:01:aabbccddeeff' \
  -drive 'if=none,id=drive-ide2,media=cdrom,aio=threads' \
  -device 'ide-cd,bus=ide.1,unit=0,drive=drive-ide2,id=ide2' \
  -device 'lsi,id=scsihw0,bus=pci.0,addr=0x5' \
  -drive 'file=/var/lib/vz/images/8006/vm-8006-disk-0.qcow2,if=none,id=drive-scsi4,discard=on,format=qcow2,cache=none,aio=native,detect-zeroes=unmap' \
  -device 'scsi-hd,bus=scsihw0.0,scsi-id=4,drive=drive-scsi4,id=scsi4' \
  -drive 'file=/var/lib/vz/images/8006/vm-8006-disk-0.qcow2,if=none,id=drive-virtio0,discard=on,format=qcow2,cache=none,aio=native,detect-zeroes=unmap' \
  -device 'virtio-blk-pci,drive=drive-virtio0,id=virtio0,bus=pci.0,addr=0xa,iothread=iothread-virtio0' \
  -drive 'file=/var/lib/vz/images/8006/vm-8006-disk-0.qcow2,if=none,id=drive-virtio1,discard=on,format=qcow2,cache=none,aio=native,detect-zeroes=unmap' \
  -device 'virtio-blk-pci,drive=drive-virtio1,id=virtio1,bus=pci.0,addr=0xb,iothread=iothread-virtio1' \
  -netdev 'type=tap,id=net0,ifname=tap8006i0,script=/var/lib/qemu-server/pve-bridge,downscript=/var/lib/qemu-server/pve-bridgedown,vhost=on' \
  -device 'virtio-net-pci,mac=A2:C0:43:77:08:A0,netdev=net0,bus=pci.0,addr=0x12,id=net0' \
  -machine 'type=pc+pve0'
