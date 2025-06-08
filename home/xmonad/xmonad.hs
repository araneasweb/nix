import Data.Map qualified as M
import Data.Maybe
import System.Exit
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.GroupNavigation
import XMonad.Actions.Navigation2D
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.Fullscreen
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ToggleLayouts
import XMonad.StackSet qualified as W
import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Util.WorkspaceCompare

colours =
        [ ("rosewater", "#f4dbd6")
        , ("flamingo", "#f0c6c6")
        , ("pink", "#f5bde6")
        , ("mauve", "#c6a0f6")
        , ("red", "#ed8796")
        , ("maroon", "#ee99a0")
        , ("peach", "#f5a97f")
        , ("yellow", "#eed49f")
        , ("green", "#a6da95")
        , ("teal", "#8bd5ca")
        , ("sky", "#91d7e3")
        , ("sapphire", "#7dc4e4")
        , ("blue", "#8aadf4")
        , ("lavender", "#b7bdf8")
        , ("text", "#cad3f5")
        , ("subtext1", "#b8c0e0")
        , ("subtext0", "#a5adcb")
        , ("overlay2", "#939ab7")
        , ("overlay1", "#8087a2")
        , ("overlay0", "#6e738d")
        , ("surface2", "#5b6078")
        , ("surface1", "#494d64")
        , ("surface0", "#363a4f")
        , ("base", "#24273a")
        , ("mantle", "#1e2030")
        , ("crust", "#181926")
        ]

getColour name = fromMaybe "#ffffff" (lookup name colours)

toggleFloat w = windows $ \s ->
        if M.member w (W.floating s)
                then W.sink w s
                else W.float w (W.RationalRect 0.2 0.2 0.6 0.6) s

scratchpads :: [NamedScratchpad]
scratchpads = [NS "terminal" "kitty --class scratchpad-terminal" (className =? "scratchpad-terminal") (customFloating $ W.RationalRect 0.2 0.2 0.6 0.6)]

xmobarConf =
        def
                { ppSep = " | "
                , ppCurrent = xmobarColor (getColour "mauve") "" . wrap "[" "]"
                , ppVisible = xmobarColor (getColour "blue") "" . wrap "(" ")"
                , ppHidden = xmobarColor (getColour "text") ""
                , ppHiddenNoWindows = xmobarColor (getColour "overlay0") ""
                , ppTitle = xmobarColor (getColour "pink") "" . shorten 60
                , ppLayout = xmobarColor (getColour "lavender") ""
                , ppUrgent = xmobarColor (getColour "red") "" . wrap "!" "!"
                , ppSort = getSortByIndex >>= \f -> return (filter (\ws -> W.tag ws /= "NSP") . f)
                }

layout = avoidStruts $ toggleLayouts (noBorders Full) $ smartBorders (Tall 1 (3 / 100) (1 / 2) ||| Full ||| Mirror (Tall 1 (3 / 100) (1 / 2)))

binds :: [(String, X ())]
binds =
        [ ("M-t", spawn "kitty")
        , ("M-f", spawn "zen-beta")
        , ("M-c", spawn "code")
        , ("M-d", spawn "discord")
        , ("M-e", spawn "thunar")
        , ("M-r", spawn "rofi -show drun")
        , ("M-w", kill)
        , ("M-m", io exitSuccess)
        , ("M-v", withFocused $ windows . W.sink)
        , ("M-S-v", withFocused toggleFloat)
        , ("M-p", sendMessage $ Toggle "Full")
        , ("M-h", windowGo L False)
        , ("M-l", windowGo R False)
        , ("M-k", windows W.focusUp)
        , ("M-j", windows W.focusDown)
        , ("M-S-j", windows W.swapDown)
        , ("M-S-k", windows W.swapUp)
        , ("M-<Tab>", nextWS)
        , ("M-S-<Tab>", prevWS)
        , ("M-<Print>", spawn "scrot -s")
        , ("M-S-<Print>", spawn "scrot")
        , ("<Print>", spawn "scrot -s")
        , ("<XF86AudioMute>", spawn "amixer set Master toggle")
        , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+")
        , ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%-")
        , ("<XF86MonBrightnessUp>", spawn "brightnessctl set +5%")
        , ("<XF86MonBrightnessDown>", spawn "brightnessctl set 5%-")
        , ("M-h", spawn "clipmenu")
        , ("M-s", namedScratchpadAction scratchpads "terminal")
        , ("M-<Space>", sendMessage NextLayout)
        , ("M-S-<Space>", sendMessage FirstLayout)
        ]

startup = spawnOnce "nitrogen --restore &" >> spawnOnce "picom &" >> spawnOnce "clipmenud &" >> spawnOnce "udiskie"

main :: IO ()
main =
        xmonad
                . ewmhFullscreen
                . ewmh
                . withSB (statusBarProp "xmobar /etc/nixos/home/xmonad/xmobarcc.hs" (pure xmobarConf))
                $ def
                        { modMask = mod4Mask
                        , terminal = "kitty"
                        , normalBorderColor = getColour "surface0"
                        , focusedBorderColor = getColour "mauve"
                        , startupHook = startup
                        , layoutHook = layout
                        , workspaces = map show [1 .. 9]
                        , focusFollowsMouse = True
                        , clickJustFocuses = False
                        }
                        `additionalKeysP` binds
