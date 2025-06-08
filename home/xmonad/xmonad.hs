import XMonad
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig (additionalKeys)

main :: IO ()
main = xmonad $ def
    { modMask = mod4Mask
    , terminal = "kitty"
    }
    `additionalKeys`
    [ ((mod4Mask, xK_t), spawn "kitty") ]
