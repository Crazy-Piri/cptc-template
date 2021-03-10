forward-to-backward = $(subst /,\,$1)
  
DISTDIR     = dist
BUILDDIR    = build

OUT = cptc-template
CODELOC = 0x400

CC = sdcc

COMBINATE   = $(BUILDDIR)/combinate
COMBINATE_SRCS  = tools/combinate.c	

XDF     = xdftool $(DISTDIR)/$(OUT).adf

CFLAGS   = -c -mz80 --vc
CFLAGS	+= --fomit-frame-pointer --allow-unsafe-read -Wp,-include,include/prefix.h
CFLAGS  +=  -I include/
# CFLAGS  += --max-allocs-per-node200000

LFLAGS   = --fomit-frame-pointer --allow-unsafe-read

c_sources := $(wildcard src/*.c) $(wildcard img/*.c)
c_objects := $(addprefix obj/,$(patsubst %.c,%.rel,$(notdir $(c_sources))))

asm_sources := $(wildcard src/asm/*.s)
asm_objects := $(addprefix obj/,$(patsubst %.s,%.rel,$(notdir $(asm_sources))))

aks_objects := song/MySuperSong.asm song/IntroSong.asm song/SoundEffects.asm

song_sources := song/arkostracker2.s
song_objects := $(addprefix obj/,$(patsubst %.s,%.rel,$(notdir $(song_sources))))

img_sources := $(wildcard img/*.png)
img_objects := $(addprefix obj/,$(patsubst %.png,%.rel,$(notdir $(img_sources))))

background_sources := img/lzsa/background_192x160.png
background_objects := obj/background_192x160.rel


objects := $(background_objects) $(c_objects) $(asm_objects) $(song_objects) $(img_objects)

all: $(OUT).dsk

$(OUT).dsk: main.ihx
	$(info Create disk $(OUT).dsk)
	$(eval LOADADDR=$(shell sed -n 's/^Lowest address  = 0000\([0-9]*\).*$$/\1/p' <main.log))
	$(eval RUNADDR=$(shell sed -n 's/^ *0000\([0-9A-F]*\) *_main  *.*$$/\1/p' <main.map))
	$(info -- Binary summary)
	$(info Load addr: 0x$(LOADADDR))
	$(info Execute addr: 0x$(RUNADDR))
	$(info Code loc:  $(CODELOC))
	@iDSK $(OUT).dsk -n >> main.log 2>> main.log
	iDSK ${OUT}.dsk -i disc.bas -t 0
	iDSK $(OUT).dsk -i main.bin -c $(LOADADDR) -e $(RUNADDR) -t 1 >> main.log 2>> main.log
	$(info)
	$(info -- Disk dump)
	@iDSK -l $(OUT).dsk 
	@du -b main.bin

main.ihx:  $(objects)
	$(info Linking $(OUT))
	sdcc -mz80 ${LFLAGS} -o main.ihx --code-loc $(CODELOC) --data-loc 0 --no-std-crt0 $(objects)
	@hex2bin -p 00 main.ihx > main.log

$(c_objects) : obj/%.rel : src/%.c
	@mkdir -p $(call forward-to-backward,$(dir $@))
	$(info Compiling $@ with $<)
	$(CC) $(CFLAGS) $< -o obj/
	


$(asm_objects) : obj/%.rel : src/asm/%.s
	@mkdir -p $(call forward-to-backward,$(dir $@))
	$(info Compiling $@ with $<)
	@sdasz80 -o -l -s $@ $<

$(song_objects) : obj/%.rel : song/%.s
	@mkdir -p $(call forward-to-backward,$(dir $@))
	$(info Compiling song $@ with $<)
	@sdasz80 -o -l -s $@ $<

$(aks_objects) : song/%.asm : song/%.aks
	@mkdir -p $(dir $@)
	$(info Compiling song aks $@ with $<)
	/tmp/tools/bin/SongToAkg -spskipcom --exportPlayerConfig --labelPrefix $(patsubst %.aks,%,$(notdir $<))_ $< $@

obj/background_192x160.rel : img/lzsa/background_192x160.png
	@mkdir -p $(dir $@)
	img2cpc -p /src/img/fwp.json -nm -scr -m 0 -o /tmp/g_ -of bin -h 160 -w 192 img/lzsa/background_192x160.png
	/tmp/tools/bin/lzsa -f 2 -r /tmp/g_background_192x160.bin /tmp/background_192x160.lzsa
	/tmp/tools/bin/bin2c /tmp/background_192x160.lzsa /tmp/background_192x160.c G_background_192x160
	$(info Compiling $@ with $<)
	$(CC) $(CFLAGS) /tmp/background_192x160.c -o obj/

obj/font6x8.rel : img/font6x8.png
	@mkdir -p $(dir $@)
	img2cpc -p img/fwp.json -of c -nm -m 0 -o /tmp/font6x8 -bn G_font6x8 -h 8 -w 6 img/font6x8.png
	$(CC) $(CFLAGS) /tmp/font6x8.c -o obj/

song/SoundEffects.asm : song/SoundEffects.aks
	@mkdir -p $(call forward-to-backward,$(dir $@))
	$(info Compiling song soundeffect $@ with $<)
	/tmp/tools/bin/SongToSoundEffects -spskipcom --exportPlayerConfig  --labelPrefix SoundEffects_ $< $@

song/arkostracker2.s : $(aks_objects)
	/tmp/tools/bin/rasm song/player/PlayerAndMusic.asm -o song/PlayerAndMusic -s -sl -sq
	/tmp/tools/bin/Disark song/PlayerAndMusic.bin song/arkostracker2.s --symbolFile song/PlayerAndMusic.sym --sourceProfile sdcc
	#$(info Compiling aks $@ with $<)

clean:
	rm -f *.sym *.rel *.noi *.map *.lst *.lk *.ihx *.asm *.rst *.prs
	rm -f src/*.sym src/*.rel src/*.noi src/*.map src/*.lst src/*.lk src/*.ihx src/*.asm src/*.rst src/*.prs
	rm -rf obj
	rm -rf andMasks.* orMasks.*
	rm -f song/*.asm song/PlayerAndMusic.sym song/PlayerAndMusic.bin
	rm -f song/arkostracker2.s
	rm -f screen1.ras raster.rst $(OUT).dsk main.log main.bin

#tools

$(COMBINATE): $(COMBINATE_SRCS)
	cc -o $@ $^


