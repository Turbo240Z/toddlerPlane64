.PHONY: setHeader
all:
	mkdir -p build
	cat globalDefs.s main.s irq.s moveDusty.s scrollScreen.s background.s paintColors.s > build/combined.s
	tools/bin2hex -s 2000 -n sprites -f assets/dustySprites.raw 	>> build/combined.s
	tools/bin2hex -s 3000 -n chars   -f assets/scene-charset.bin	>> build/combined.s
	tools/bin2hex -s 4400 -n mcolors -f assets/scene-colors.bin	>> build/combined.s
	tools/bin2hex -s 9000 -n lvl	 -f assets/map.raw	>> build/combined.s
	cd build ;/usr/local/bin/mac2c64 -r combined.s
	tools/linker build/combined.rwa build/combined.rwb build/combined.rwc build/combined.rwd build/combined.rwe > build/combined.prg
	tools/exomizer sfx 0x0801 -q build/combined.prg -o build/toddlerplane64.prg
setHeader:
	clang++ -o tools/setHeader setHeader/setHeader.cpp
