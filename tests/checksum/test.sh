#!/bin/bash
# ^ bash for job control

dd if=/dev/urandom of=disk.img count=1 2>/dev/null
echo 'PLEASE WRITE ON THIS IMAGE' | dd of=disk.img conv=notrunc 2>/dev/null

sum=$(md5sum disk.img | awk '{print $1}')
qemu-system-i386 -net none -drive if=virtio,file=disk.img -display none	\
    -kernel rk.bin &

rv=1

# poll for results
for x in seq 5 ; do
	res=$(sed q disk.img)
	if [ "${res}" = "OK" ]; then
		emusum=$(sed -n '2{p;q;}' disk.img)
		if [ "${sum}" = "${emusum}" ]; then
			rv=0
		fi
		break
	fi
	sleep 1
done

# cleanup
kill %1
rm disk.img
exit ${rv}
