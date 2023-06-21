#!/usr/bin/fish
set BASE_PATH "$HOME/.config/hyprthemes"
set THEMES_PATH $BASE_PATH/themes

function reload_theme
    # Closing other instances
    pkill hyprpaper
    pkill waybar

    # Wallpaper handling
    swww img --transition-type=wipe $THEMES_PATH/$CURRENT_THEME/wallpaper/wallpaper.*

    # Waybar handling
    nohup waybar -c $THEMES_PATH/$CURRENT_THEME/waybar/config -s $THEMES_PATH/$CURRENT_THEME/waybar/style.css >/dev/null 2>&1 &

    # Copying configuration files to their correct places
    cp $THEMES_PATH/$CURRENT_THEME/kitty/current-theme.conf ~/.config/kitty/ && kill -SIGUSR1 $(pgrep kitty)
    cp $THEMES_PATH/$CURRENT_THEME/hyprland/theme.conf ~/.config/hypr/ && hyprctl reload
end

function create_theme
    cp -r $BASE_PATH/default_theme_folder $BASE_PATH/themes/$TARGET_THEME # Example theme path
end

if test -d $BASE_PATH
    if test "$argv[1]" != --default
        echo $argv[1]
        set TARGET_THEME (ls $THEMES_PATH | wofi --show dmenu -i -b --prompt "Select or create a theme.")
        if test -e "$THEMES_PATH/$TARGET_THEME" && test "$TARGET_THEME" != "" && test "$TARGET_THEME" != "$CURRENT_THEME"
            # Theme does exist
            # Copy current configurations to theme folder (in case they suffer modifications)
            cp ~/.config/kitty/current-theme.conf $THEMES_PATH/$CURRENT_THEME/kitty/ && kill -SIGUSR1 $(pgrep kitty)
            cp ~/.config/hypr/theme.conf $THEMES_PATH/$CURRENT_THEME/hyprland/

            # Set and reload theme
            set -Ux CURRENT_THEME $TARGET_THEME
            reload_theme
            dunstify -a Hyprthemes "$TARGET_THEME theme has been applied."

        else
            if test "$TARGET_THEME" = "$CURRENT_THEME"
                dunstify -a Hyprthemes "Selected theme is already the current theme."
            else if test "$TARGET_THEME" != ""
                dunstify -a Hyprthemes "The $TARGET_THEME theme has been created."
                create_theme
                # Theme doesn't exist
            else
                dunstify -a Hyprthemes "The selected theme hasn't been found."
            end
        end
    else
        # Is default
        reload_theme

    end
else
    # Setup directories
    mkdir $BASE_PATH # Base path
    mkdir $BASE_PATH/themes # Themes path
    mkdir $BASE_PATH/script # Themes path
    cp -r default_theme_folder $BASE_PATH # Default theme path
    cp -r default_theme_folder $BASE_PATH/themes/Example # Example theme path
    cp hyprtheme.fish $BASE_PATH/script/hyprtheme.fish
    # Setup env variables
    set -Ux CURRENT_THEME Example
end
