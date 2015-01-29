cd %1
D:
sdasz80 -o crt0.s
sdcc -mz80 -c main.c
sdcc -mz80 --code-loc 0x1347 --data-loc 0x2000 --no-std-crt0 -o bpb.ihx main.rel crt0.rel
makebin -p bpb.ihx bpb.bin
pause