# **Hyprthemes** - theme manager for Hyprland

## What is this?
---

A simple **theme manager** using Fish and Wofi to handle most of the things. It is still customizable, you can change the things that you use - polybar instead of waybar for example - pretty easily.

## How to install?
---

First, this theme manager thinks that you already use the following items:

- [Hyprland](https://github.com/hyprwm/Hyprland) (Window Manager)
- [Waybar](https://github.com/Alexays/Waybar) (Bar)
- [Wofi](https://hg.sr.ht/~scoopta/wofi) (App launcher'n stuff)
- [swww](https://github.com/Horus645/swww) (Wallpaper handling) 
- [Fish](https://github.com/fish-shell/fish-shell) (Shell scripting)
- [Kitty](https://github.com/kovidgoyal/kitty) (Terminal)

If you dont, then you need to install them, here's a quick line to install them all (not going to put hyprland because this was literally made for it ...)

### Arch

Please, use yay.

`yay -Syu waybar-hyprland-git wofi swww fish`

Then, clone this repository and run

`sudo hyprtheme.fish`

This will create the themes folder in _$HOME/.config/hyprthemes/themes_ with an Example theme. The last thing to do it's to add these lines in your Hyprland configuration file:

`exec-once = ~/.config/hyprthemes/script/hyprtheme.fish --default`

`bind = $mainMod, INSERT_KEY_HERE, exec, pkill wofi || ~/.config/hyprthemes/script/hyprtheme.fish`

Then, for the color management of Hyprland, you will have to add the following line

`source=~/.config/hypr/theme.conf`

Among with substituting all of the theme.conf variables into your hyprland.conf, like this:
 
> **decoration** {
>       
>       rounding = $rounding
>       blur = $blur
>       blur_size = $blurSize
>       blur_passes = $blurPasses
>       blur_new_optimizations = on
>       blur_xray = false
>       dim_inactive = $dimInactive
>       dim_strength = $dimStrength
>       drop_shadow = $dropShadow
>       shadow_range = $shadowRange
>       shadow_render_power = $shadowRenderPower
>       col.shadow = $colShadow
>}


## How to use it?

---

Now that you successfully installed this thing, you can create new themes by pressing down the bind key, writing a new theme name and press enter (it will automatically create one). Or you can choose between those that you already have created.

To manage your themes, simply go to the hyprthemes directory and change the files in the desired theme's folder. 

**WARNING**: if you want to modify the kitty theme or hyprland colors, be sure to make them in the current kitty and theme.conf files in Kitty and Hyprland respectives locations, because they will replace the old ones in the theme's folder. This was made because it makes the experiences at styling your theme more easily, since that you can see how it's turning out.