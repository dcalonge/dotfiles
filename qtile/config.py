from libqtile import bar, layout, widget, hook
from libqtile.config import Key, Screen, Group, Drag, Click, Match
from libqtile.lazy import lazy
import os
import subprocess
from libqtile.backend.wayland import InputConfig

mod = "mod4"
terminal = "foot"

keys = [
    # Essentials
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "Tab", lazy.next_layout(), desc="Switch to next layout"),
    Key([mod, "shift"], "s", lazy.spawn("bash -c ~/scripts/slurpshot.sh"), desc="Take screenshot"),
    Key([mod], "b", lazy.spawn("firefox"), desc="Launch Firefox"),
    Key([mod], "h", lazy.spawn("foot -e btop"), desc="Launch Btop"),
    Key([mod], "r", lazy.spawn("foot -e ranger"), desc="Launch Ranger"),
    Key([mod], "v", lazy.spawn("foot -e nvim"), desc="Launch Neovim"),
    Key([mod], "p", lazy.spawn("pavucontrol"), desc="Launch Pavucontrol"),
    Key([mod], "n", lazy.spawn("networkmanager_dmenu"), desc="Launch NetworkManager"),
    Key([mod], "t", lazy.spawn("thunar"), desc="Launch Thunar"),
    Key([mod], "d", lazy.spawn("rofi -show drun"), desc="Run launcher"),
    Key([mod], "c", lazy.spawn("code"), desc="Launch VS Code"),
    # Volume and Brightness
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn(
            "sh -c 'wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+ && ~/scripts/volume.sh'"
        ),
        desc="Raise volume",
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn(
            "sh -c 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && ~/scripts/volume.sh'"
        ),
        desc="Lower volume",
    ),
    Key(
        [],
        "XF86AudioMute",
        lazy.spawn(
            "sh -c 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && ~/scripts/muteaudio.sh'"
        ),
        desc="Mute audio",
    ),
    Key(
        [],
        "XF86AudioMicMute",
        lazy.spawn(
            "sh -c 'wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && ~/scripts/mic.sh'"
        ),
        desc="Mute mic",
    ),
    Key(
        [],
        "XF86MonBrightnessUp",
        lazy.spawn(
            "sh -c 'brightnessctl set +5% && ~/scripts/brightness.sh'"
        ),
        desc="Increase brightness",
    ),
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn(
            "sh -c 'brightnessctl set 5%- && ~/scripts/brightness.sh'"
        ),
        desc="Decrease brightness",
    ),
    # Layout management
    Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),
    Key(
        [mod, "shift"],
        "Left",
        lazy.layout.shuffle_left(),
        desc="Move window to the left",
    ),
    Key(
        [mod, "shift"],
        "Right",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),
    Key(
        [mod],
        "space",
        lazy.layout.next(),
        desc="Switch window focus to other pane(s) of stack",
    ),
    # Window management
    Key([mod, "shift"], "space", lazy.window.toggle_floating(), desc="Toggle floating"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    # Restart/Shutdown
    Key([mod, "shift"], "c", lazy.reload_config(), desc="Reload the config"),
    Key(
        [mod, "shift"],
        "e",
        lazy.spawn("/home/daniel/scripts/dmenu_logout_river.sh"),
        desc="Logout",
    ),
    Key(
        [mod, "shift"], "u", lazy.spawn("/home/daniel/scripts/prompt.sh"), desc="Prompt"
    ),
]

groups = [Group(i) for i in "1234567890"]

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
        ]
    )

layouts = [
    layout.Columns(margin=5, border_width=2, border_focus="#93a1a1", border_normal="#333333",margin_on_single=0,border_on_single=0),
    layout.Max(),
]

widget_defaults = dict(
    font="JetBrainsMono Nerd Font",
    fontsize=13,
    
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        wallpaper="/home/daniel/imagenes/arch.png",
        wallpaper_mode="fill",
        top=bar.Bar(
            [
                widget.CurrentLayout(foreground="#FFFFFF"),
                widget.GroupBox(foreground="#FFFFFF"),
                widget.Prompt(foreground="#FFFFFF"),
                widget.WindowName(foreground="#FFFFFF"),
                widget.CheckUpdates(
                    background="#00000000", 
                    foreground="#FFFFFF",  # White foreground
                    colour_have_updates="#FFFFFF",  # White foreground for updates
                    colour_no_updates="#FFFFFF",  # White foreground when no updates
                    distro='Arch_checkupdates',
                    display_format='UP: {updates}'
                ),
                widget.Spacer(length=8),
                widget.Backlight(
                    backlight_name="amdgpu_bl1",
                    brightness_file="brightness",
                    max_brightness_file="max_brightness",
                    format="BRI: {percent:1.0%}",
                    foreground="#FFFFFF"  # White foreground
                ),
                widget.Spacer(length=8),
                widget.Volume(
                    get_volume_command="pactl list sinks | grep \'Volume:\' | head -n 1 | awk '{print $5}'",
                    check_mute_command="pactl list sinks | grep \"Mute:\" | awk '{print $2}'",
                    check_mute_string="yes",
                    fmt="VOL: {}",
                    emoji=False,
                    foreground="#FFFFFF"  # White foreground
                ),
                widget.Spacer(length=8),
                widget.Wlan(
                    interface="wlan0",
                    format="WIFI: {percent:2.0%}",
                    foreground="#FFFFFF"  # White foreground
                ),
                widget.Spacer(length=8),
                widget.Battery(
                    format="BAT: {percent:2.0%}",
                    low_percentage=0.2,
                    low_foreground="ff0000",  # Keep as is for low battery warning
                    update_interval=60,
                    foreground="#FFFFFF"  # White foreground
                ),
                widget.Spacer(length=8),
                widget.Clock(
                    format="%H:%M %d/%m",
                    foreground="#FFFFFF"  # White foreground
                ),
                widget.Systray(foreground="#FFFFFF"),
            ],
            24,
        ),
    ),
]



# Autostart applications and scripts
@hook.subscribe.startup_once
def autostart():
    subprocess.Popen(["dunst"]) 
    subprocess.Popen(["/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"])
    subprocess.Popen(["wl-paste", "--watch", "cliphist", "store"])


mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="pavucontrol"),
    ]
)

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = {
    "type:keyboard": InputConfig(
        kb_repeat_rate=50,
        kb_repeat_delay=300,
        kb_layout="es",
    ),
    "type:touchpad": InputConfig(drag=True, tap=True, natural_scroll=True),
}

wmname = "LG3D"
