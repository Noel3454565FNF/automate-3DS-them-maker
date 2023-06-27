title=theme-maker
echo off
mkdir out
magick -size 512x256! canvas:green test.png
magick -size 412x480! canvas:black 2.png
echo [frames] > config.rc && echo top.type=texture >> config.rc && echo top.frame=single >> config.rc && echo bottom.type=texture >> config.rc && echo bottom.frame=single >> config.rc


set /p themeName=what's the theme name: 

cls
echo all ready bro!
pause

cls
set themeIcon=icon.png
set topImage=top.png
set bottomImage=pot.png
magick %themeIcon% -resize 48x48! icon2.png
magick %topImage% -resize 412x240! up.png
magick %bottomImage% -resize 320x240! down.png
magick composite -gravity NorthWest up.png  test.png up-over.png
magick composite -gravity NorthWest down.png  test.png down-over.png
magick composite -gravity North up.png 2.png preview1.png
magick composite -gravity South down.png preview1.png preview.png
del test.png
del preview1.png
del 2.png
echo. >> config.rc && echo [textures] >> config.rc && echo top.image=up-over.png >> config.rc && echo bottom.image=down-over.png >> config.rc
pause

cls
set bgm=music.mp3
ffmpeg -i %bgm% -ar 22000 -ac 1 -c:a pcm_s16le bgm.wav
VGAudioCli -i bgm.wav -o bgm.bcstm
pause

cls
echo. >> config.rc && echo [kame-editor] >> config.rc && echo deploy=%themeName%.zip >> config.rc

cls
echo. >> config.rc && echo. [info] >> config.rc && echo shorttitle=%themeName% >> config.rc && echo longtitle=%themeName% >> config.rc
pause

cls
echo finishing!
echo. publisher=noel345 >> config.rc && echo icon=icon2.png >> config.rc && echo pegigen=44 >> config.rc && echo regions=regionfree >> config.rc
pause

cls
curl -L -o file.txt https://www.dropbox.com/s/3co0bban46z7yr7/there.txt?dl=0
type file.txt >> config.rc
echo bgm=bgm.bcstm >> config.rc
pause

cls
kame-tools make3dstheme -c config.rc -o out -n out
echo all done and remember kids, noel is a god
move icon2.png out
move preview.png out
pause