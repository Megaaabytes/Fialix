# Pagix (Page disking system)

As of right now, it will just print "Hello World" in 15 colours constantly. It does flash pretty quickly, so if you have epilepsy be careful when starting up the kernel. 

The build script will mostly fail on linux computers which do not have the $GCC and $GCC64 environment variables set. This is because the $PATH variable did not work for me. $GCC should be the i686 gcc compiler and linker, and the $GCC64 should be the 86_64 gcc compiler and linker. Make sure they are configured properly.

Also, the built boot.iso file won't boot in vmware, it boots in QEMU just fine. Make sure you use the x86_64-system-qemu however. The kernel will complain if its i386.

TODO:
- Implement filesystem

# References
https://osdev.org
