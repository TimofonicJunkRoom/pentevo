
@ECHO OFF

cd fat_boot\source

..\..\..\tools\asw\bin\asw -U -L micro_boot_fat.a80
..\..\..\tools\asw\bin\p2bin micro_boot_fat.p micro_boot_fat.rom -r $-$ -k
..\..\..\tools\mhmt\mhmt -mlz micro_boot_fat.rom micro_boot_fat_pack.rom

cd ..\..\page0\source

..\..\..\tools\asw\bin\asw -U -L main.a80
..\..\..\tools\asw\bin\p2bin main.p main.rom -r $-$ -k

..\..\..\tools\asw\bin\asw -U -L make_cmosset.a80
..\..\..\tools\asw\bin\p2bin make_cmosset.p cmosset.rom -r $-$ -k

..\..\..\tools\mhmt\mhmt -mlz main.rom main_pack.rom
..\..\..\tools\mhmt\mhmt -mlz cmosset.rom cmosset_pack.rom
..\..\..\tools\mhmt\mhmt -mlz chars_eng.bin chars_pack.bin

..\..\..\tools\asw\bin\asw -U -L services.a80
..\..\..\tools\asw\bin\p2bin services.p ..\services.rom -r $-$ -k

del main.rom
del cmosset.rom
del main_pack.rom
del cmosset_pack.rom

cd ..\..\page1\evo-dos

..\..\..\tools\asw\bin\asw -U -L evo-dos_emu3d13.a80
..\..\..\tools\asw\bin\p2bin evo-dos_emu3d13.p ..\evo-dos_emu3d13.rom -r $-$ -k

..\..\..\tools\asw\bin\asw -U -L evo-dos_virt.a80
..\..\..\tools\asw\bin\p2bin evo-dos_virt.p ..\evo-dos_virt.rom -r $-$ -k

cd ..\..\page2\source

..\..\..\tools\asw\bin\asw -U -L spec128_0.a80
..\..\..\tools\asw\bin\p2bin spec128_0.p ..\basic128.rom -r $-$ -k

cd ..\..\page3\source

..\..\..\tools\asw\bin\asw -U -L basic48.a80
..\..\..\tools\asw\bin\p2bin basic48.p ..\basic48_128.rom -r $-$ -k

cd ..\..\atm_cpm\source

..\..\..\tools\asw\bin\asw -U -L rbios.a80
..\..\..\tools\asw\bin\p2bin rbios.p ..\rbios.rom -r $-$ -k

cd ..\..\page5\source

..\..\..\tools\mhmt\mhmt -mlz 8x8_ar.fnt 8x8_ar_pack.bin
..\..\..\tools\mhmt\mhmt -mlz 866_code.fnt 866_code_pack.bin
..\..\..\tools\mhmt\mhmt -mlz atm_code.fnt atm_code_pack.bin
..\..\..\tools\asw\bin\asw -U -L rst8service.a80
..\..\..\tools\asw\bin\p2bin rst8service.p ..\rst8service.rom -r $-$ -k

del 8x8_ar_pack.bin
del 866_code_pack.bin
del atm_code_pack.bin

cd ..\..\trdos_v6\source

..\..\..\tools\asw\bin\asw -U -L trdos_v6.a80
..\..\..\tools\asw\bin\p2bin trdos_v6.p ..\dosatm3.rom -r $-$ -k

cd ..\..

copy /B /Y page3\basic48_128.rom+page1\evo-dos_virt.rom+ff_16k.rom+atm_cpm\rbios.rom+page5\rst8service.rom+page3\basic48_128.rom+page1\evo-dos_emu3d13.rom+page2\basic128.rom+page0\services.rom ers.rom
copy /B /Y page3\2006.rom+trdos_v6\dosatm3.rom+page2\basic128.rom+page0\glukpen.rom glukpent.rom
copy /B /Y ff_16k.rom+page3\basic48_128_std.rom+page2\128_std.rom+page3\basic48_orig.rom basics_std.rom

rem          64            64           64                   128          192
copy /B /Y ff_64k.rom+basics_std.rom+glukpent.rom+profrom\evoprofrom.rom+ers.rom zxevo.rom

copy /B /Y zxevo.rom ..\tools\unreal_fix\0.37.6\fix_build\x32\zxevo.rom
copy /B /Y zxevo.rom d:\unrealspeccy\zxevo.rom

del ers.rom
del glukpent.rom
del basics_std.rom

pause
