Config { 
    font = "Ubuntu Mono 10"
  , additionalFonts = ["Font Awesome 6 Free Solid 10"]
  , bgColor = "#24273a"
  , fgColor = "#cad3f5"
  , position = Top
  , border = BottomB
  , borderColor = "#5b6078"
  , borderWidth = 1
  , sepChar = "%"
  , alignSep = "}{"
  , template = " %XMonadLog% }{ %battery% | %memory% | %cpu% | %dynnetwork% | %bright% | %alsa:default:Master% | %date% "
  , lowerOnStart = False
  , hideOnStart = False
  , allDesktops = True
  , overrideRedirect = True
  , pickBroadest = False
  , persistent = True 
  , iconRoot = "."
  , commands = 
      [ Run XMonadLog
      , Run Date "<fc=#f5bde6><fn=1>\xf017 </fn></fc> %a %Y-%m-%d %H:%M:%S" "date" 10
      , Run BatteryP ["BAT0"]
          ["-t", "<fc=#a6da95><fn=1>\xf240 </fn></fc><acstatus>"
          , "-L", "10"
          , "-H", "80"
          , "-p", "3"
          , "--"
          , "-O", "<left>%"
          , "-o", "<left>%"
          , "-h", "#a6da95"
          , "-l", "#ed8796"
          ] 50  
      , Run BatteryP ["BAT1"]
          ["-t", "<fc=#a6da95><fn=1>\xf241 </fn></fc><acstatus>"
          , "-L", "10"
          , "-H", "80"
          , "-p", "3"
          , "--"
          , "-O", "<left>%"
          , "-o", "<left>%"
          , "-h", "#a6da95"
          , "-l", "#ed8796"
          ] 50          
      , Run Cpu 
          [ "-t", "<fc=#f5a97f><fn=1>\xf4bc </fn></fc><total>%"
          , "-L", "30"
          , "-H", "70"
          , "-h", "#ed8796"
          , "-l", "#a6da95"
          , "-n", "#eed49f"
          ] 10
      , Run Memory
          [ "-t", "<fc=#c6a0f6><fn=1>\xefc5 </fn></fc><usedratio>%"
          , "-L", "30"
          , "-H", "80"
          , "-h", "#ed8796"
          , "-l", "#a6da95"
          , "-n", "#eed49f"
          ] 10
      , Run DynNetwork
          [ "-t", "<fc=#91d7e3><fn=1>\xf1eb </fn></fc>↓<rx>KiB ↑<tx>KiB"
          , "-L", "1000"
          , "-H", "5000"
          , "-h", "#a6da95"
          , "-l", "#cad3f5"
          , "-n", "#eed49f"
          ] 10
      , Run Alsa "default" "Master"
          [ "-t", "<fc=#8aadf4><fn=1>\xf028  </fn></fc><volume>"
          , "-S", "True"
          , "--"
          , "-O", ""
          , "-o", " <fc=#ed8796>MUTE</fc>"
          , "-h", "#8aadf4"
          , "-l", "#ed8796"
          ]
      , Run Brightness
          [ "-t", "<fc=#eed49f><fn=1>\xf0eb </fn></fc><percent>%"
          , "--"
          , "-D", "intel_backlight"
          ] 10
      ]
}