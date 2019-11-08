---
layout: single
title: KURO-BOX/PRO
date: 2008-11-25 02:01:25.000000000 +09:00
type: post
tags:
- 玄箱PRO
permalink: "/2008/11/kuro-boxpro/"
---
玄箱 PROでいろいろ遊んでみた。<br />
エレキジャックさんやBuffalo ARM9 Kernel Portのページを参考に、Debian化やカーネル再構築なんかをやってみた。<br />
今日はとりあえずブートログなんかをさらしてみる。

```
Linux version 2.6.26.8-1.kuroboxPRO (mura@skyline.local.stoic.jp) (gcc version 3.4.4 (release) (CodeSourcery ARM 2005q3-2)) #2 PREEMPT Mon Nov 24 21:43:21 JST 2008
CPU: Feroceon [41069260] revision 0 (ARMv5TEJ), cr=a0053177
Machine: Buffalo/Revogear Kurobox Pro
Clearing invalid memory bank 0KB@0xffffffff
Clearing invalid memory bank 0KB@0xffffffff
Clearing invalid memory bank 0KB@0xffffffff
Ignoring unrecognised tag 0x00000000
Ignoring unrecognised tag 0x00000000
Ignoring unrecognised tag 0x00000000
Ignoring unrecognised tag 0x41000403
Memory policy: ECC disabled, Data cache writeback
On node 0 totalpages: 32768
DMA zone: 256 pages used for memmap
DMA zone: 0 pages reserved
DMA zone: 32512 pages, LIFO batch:7
Normal zone: 0 pages used for memmap
Movable zone: 0 pages used for memmap
CPU0: D VIVT write-back cache
CPU0: I cache: 32768 bytes, associativity 1, 32 byte lines, 1024 sets
CPU0: D cache: 32768 bytes, associativity 1, 32 byte lines, 1024 sets
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: console=ttyS0,115200 root=/dev/sda2 rw panic=5 BOOTVER=1.09
PID hash table entries: 512 (order: 9, 2048 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 128MB = 128MB total
Memory: 126208KB available (3324K code, 231K data, 104K init)
Calibrating delay loop... 266.24 BogoMIPS (lpj=1331200)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
net_namespace: 324 bytes
NET: Registered protocol family 16
Orion ID: MV88F5182-A2. TCLK=166666667.
Applying Orion-1/Orion-NAS PCIe config read transaction workaround
PCI: bus0: Fast back to back transfers disabled
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
Switched to high resolution mode on CPU 0
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
NET: Registered protocol family 1
NetWinder Floating Point Emulator V0.97 (double precision)
JFFS2 version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
msgmni has been set to 246
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xf1012000 (irq = 3) is a 16550A
console [ttyS0] enabled
serial8250.0: ttyS1 at MMIO 0xf1012100 (irq = 4) is a 16550A
loop: module loaded
MV-643xx 10/100/1000 Ethernet Driver
eth0: port 0 with MAC address 00:16:01:a4:ef:b4
eth0: Scatter Gather Enabled
eth0: TX TCP/IP Checksumming Supported
eth0: RX TCP/UDP Checksum Offload ON
eth0: RX NAPI Enabled
Driver 'sd' needs updating - please use bus_type methods
sata_mv sata_mv.0: version 1.24
sata_mv sata_mv.0: slots 32 ports 2
scsi0 : sata_mv
scsi1 : sata_mv
ata1: SATA max UDMA/133 irq 29
ata2: SATA max UDMA/133 irq 29
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-8: Hitachi HDP725050GLA360, GM4OA52A, max UDMA/133
ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
ata2: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      Hitachi HDP72505 GM4O PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
NFTL driver: nftlcore.c $Revision: 1.98 $, nftlmount.c $Revision: 1.41 $
physmap platform flash device: 00040000 at f4000000
CFI: Found no physmap-flash.0 device at location zero
Found: SST 39LF020
physmap-flash.0: Found 1 x8 devices at 0x0 in 8-bit bank
number of JEDEC chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
RedBoot partition parsing not available
ftl_cs: FTL header not found.
NAND device: Manufacturer ID: 0x20, Chip ID: 0xda (ST Micro NAND 256MiB 3,3V 8-bit)
Scanning device for bad blocks
Bad eraseblock 1717 at 0x0d6a0000
Creating 3 MTD partitions on "orion_nand":
0x00000000-0x00400000 : "uImage"
ftl_cs: FTL header not found.
0x00400000-0x04400000 : "rootfs"
ftl_cs: FTL header not found.
0x04400000-0x10000000 : "extra"
ftl_cs: FTL header not found.
orion-ehci orion-ehci.0: Marvell Orion EHCI
orion-ehci orion-ehci.0: new USB bus registered, assigned bus number 1
orion-ehci orion-ehci.0: irq 17, io mem 0xf1050000
orion-ehci orion-ehci.0: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
orion-ehci orion-ehci.1: Marvell Orion EHCI
orion-ehci orion-ehci.1: new USB bus registered, assigned bus number 2
orion-ehci orion-ehci.1: irq 12, io mem 0xf10a0000
orion-ehci orion-ehci.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
usbcore: registered new interface driver usblp
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
rtc-rs5c372 0-0032: rs5c372a found, 24hr, driver version 0.5
rtc-rs5c372 0-0032: rtc core: registered rtc-rs5c372 as rtc0
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
VFP support v0.3: not present
rtc-rs5c372 0-0032: setting system clock to 2008-11-03 04:56:58 UTC (1225688218)
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem).
Freeing init memory: 104K
Adding 136544k swap on /dev/sda3.  Priority:-1 extents:1 across:136544k
EXT3 FS on sda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
warning: `ntpd' uses 32-bit capabilities (legacy support in use)
```