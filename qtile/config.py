from libqtile import bar, layout, widget, hook
from libqtile.config import Key, Screen, Group, Drag, Click, Match
from libqtile.lazy import lazy
import os
import subprocess
from libqtile.backend.wayland import InputConfig
from libqtile.widget.battery import Battery, BatteryState
from libqtile.widget import base, Backlight
from libqtile.widget.wlan import get_status

##############################################
# Custom widgets
##############################################

class MyBacklight(Backlight):
    ICONS = [
        (0.75, "󰃠"),
        (0.50, "󰃟"),
        (0.25, "󰃝"),
        (0.00, "󰃞") 
    ]
    DEFAULT_ICON = "󰳲"

    def poll(self):
        char = self.DEFAULT_ICON
        for threshold, icon in self.ICONS:
            if self._get_info() > threshold:
                char = icon
                break
        
        return self.format.format(char=char)

class MyWlan(base.InLoopPollText):
    ICONS = [
        (60, "󰤨"),
        (40, "󰤢"),
        (20, "󰤟"),
        (0, "󰤯")
    ]
    DEFAULT_ICON = "󰤮"

    orientations = base.ORIENTATION_HORIZONTAL
    defaults = [
        ("interface", "wlan0", "The interface to monitor"),
        ("update_interval", 1, "The update interval."),
        ("disconnected_message", "Disconnected", "String to show when the wlan is disconnected."),
        ("format", "{char} {essid}", 'Display format. For percent use "{char} {percent:2.0%}"'),
    ]

    def __init__(self, **config):
        super().__init__(**config)
        self.add_defaults(MyWlan.defaults)

    def poll(self):
        essid, quality = get_status(self.interface)
        disconnected = essid is None
        if disconnected:
            return self.disconnected_message

        char = self.DEFAULT_ICON
        for threshold, icon in self.ICONS:
            if quality >= threshold:
                char = icon
                break
        
        return self.format.format(
            char=char,
            essid=essid
        )

class MyBattery(Battery):
    CHARGING_ICONS = [
        (0.90, "󰂅"), (0.80, "󰂋"), (0.70, "󰂊"), (0.60, "󰢞"), (0.50, "󰂉"),
        (0.40, "󰢝"), (0.30, "󰂈"), (0.20, "󰂇"), (0.10, "󰂆"), (0.0, "󰢜")
    ]
    DISCHARGING_ICONS = [
        (0.90, "󰁹"), (0.80, "󰂂"), (0.70, "󰂁"), (0.60, "󰂀"), (0.50, "󰁿"), 
        (0.40, "󰁾"), (0.30, "󰁽"), (0.20, "󰁼"), (0.10, "󰁻"), (0.00, "󰁺")
    ]
    FULL_ICON = "󰁹"  # Battery Full
    EMPTY_ICON = "󱃍"  # Battery Empty or Unknown
    DEFAULT_ICON = "󰁹"  # Default charging icon when uncertain

    def build_string(self, status):
        if self.layout is not None:
            self.foreground = self.low_foreground if (
                status.state == BatteryState.DISCHARGING
                and status.percent < self.low_percentage
            ) else self.normal_foreground

        if status.state == BatteryState.CHARGING:
            icons = self.CHARGING_ICONS
        elif status.state == BatteryState.DISCHARGING:
            icons = self.DISCHARGING_ICONS
        elif status.percent >= 1 or status.state == BatteryState.FULL:
            char = self.FULL_ICON
        elif status.state == BatteryState.EMPTY or (status.state == BatteryState.UNKNOWN and status.percent == 0):
            char = self.EMPTY_ICON
        else:
            char = self.DEFAULT_ICON

        if status.state in {BatteryState.CHARGING, BatteryState.DISCHARGING}:
            for threshold, icon in icons:
                if status.percent > threshold:
                    char = icon
                    break

        return self.format.format(char=char, percent=status.percent)


##############################################
# Key Bindings
##############################################

mod = "mod4"
terminal = "foot"

keys = [
    # Essentials
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "Tab", lazy.next_layout(), desc="Switch to next layout"),
    Key([mod, "shift"], "s", lazy.spawn("bash -c ~/scripts/screenshot_river.sh"), desc="Take screenshot"),
    Key([mod], "b", lazy.spawn("firefox"), desc="Launch Firefox"),
    Key([mod], "v", lazy.spawn("/home/daniel/scripts/cliphist-rofi"), desc="Launch Clipboard Manager"),
    Key([mod], "h", lazy.spawn("foot -e btop"), desc="Launch Btop"),
    Key([mod], "y", lazy.spawn("foot -e yazi"), desc="Launch yazi"),
    Key([mod], "n", lazy.spawn("foot -e nvim"), desc="Launch Neovim"),
    Key([mod], "a", lazy.spawn("pavucontrol"), desc="Launch Pavucontrol"),
    Key([mod], "w", lazy.spawn("networkmanager_dmenu"), desc="Launch NetworkManager"),
    Key([mod], "t", lazy.spawn("thunar"), desc="Launch Thunar"),
    Key([mod], "c", lazy.spawn("code"), desc="Launch VS Code"),
    Key([mod], "d", lazy.spawn("j4-dmenu-desktop --no-generic --skip-i3-exec-check -b --dmenu bemenu -t foot"), desc="Launch bemenu"),
    Key([mod], "p", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),


    # Volume and Brightness
    Key([], "XF86AudioRaiseVolume", lazy.spawn("sh -c 'wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+ && ~/scripts/volume.sh'"), desc="Raise volume"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("sh -c 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && ~/scripts/volume.sh'"), desc="Lower volume"),
    Key([], "XF86AudioMute", lazy.spawn("sh -c 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && ~/scripts/muteaudio.sh'"), desc="Mute audio"),
    Key([], "XF86AudioMicMute", lazy.spawn("sh -c 'wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && ~/scripts/mic.sh'"), desc="Mute mic"),
    Key([], "XF86MonBrightnessUp", lazy.spawn("sh -c 'brightnessctl set +5% && ~/scripts/brightness.sh'"), desc="Increase brightness"),
    Key([], "XF86MonBrightnessDown", lazy.spawn("sh -c 'brightnessctl set 5%- && ~/scripts/brightness.sh'"), desc="Decrease brightness"),


    # Layout management
    Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),

    Key([mod, "shift"], "Left", lazy.layout.swap_left(), desc="Move window to the left"),
    Key([mod, "shift"], "Right", lazy.layout.swap_right(), desc="Move window to the right"),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),

    Key([mod, "control"], "Left", lazy.layout.shrink_main(), desc="shrink main"),
    Key([mod, "control"], "Right", lazy.layout.grow_main(), desc="grow main"),
    Key([mod, "control"], "Down", lazy.layout.shrink(), desc="shrink window"),
    Key([mod, "control"], "Up", lazy.layout.grow(), desc="grow window"),
    # Window management
    Key([mod, "shift"], "space", lazy.window.toggle_floating(), desc="Toggle floating"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    # Restart/Shutdown
    Key([mod, "shift"], "c", lazy.reload_config(), desc="Reload the config"),
    Key([mod], "e", lazy.spawn("/home/daniel/scripts/dmenu_logout.sh"), desc="Logout"),
    Key([mod], "u", lazy.spawn("/home/daniel/scripts/prompt.sh"), desc="Prompt"),

]

# Keys to change VT
keys.extend([
    Key(['mod1', 'control'], f"F{n}", lazy.core.change_vt(n), desc=f"Switch to virtual terminal #{n}") for n in range(1, 7)
])
##############################################
# Layouts
##############################################

layouts = [
    layout.MonadTall(
        margin=5,
        border_width=2,
        border_focus="#93a1a1",
        border_normal="#333333",
        single_margin=0,
        single_border_width=0,
        ratio=0.55,
        new_client_position="top",
    ),
    layout.Max(),
    layout.Floating(
        border_width=2,
        border_focus="#93a1a1",
        border_normal="#333333"
    ),
]

##############################################
# Workspace Management
############################################

groups = [Group(i) for i in "1234567890"]

for i in groups:
    keys.extend(
        [
            Key([mod], i.name, lazy.group[i.name].toscreen(), desc="Switch to group i"),
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True), desc="Switch to & move focused window to group {}".format(i.name)),
        ]
    )

##############################################
# Bar
##############################################
widget_defaults = dict(
    font="JetBrainsMono Nerd Font",
    fontsize=13,
    foreground="eeeeee",
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        wallpaper="/home/daniel/Pictures/montain.webp",
        wallpaper_mode="fill",
        top=bar.Bar(
            [
                widget.GroupBox(
                    margin_y=2,
                    margin_x=2,
                    active="#93a1a1",
                    inactive="#93a1a1",
                    highlight_method='text',
                    highlight_color="#000000",
                    this_current_screen_border="#eeeeee",
                    borderwidth=2,
                    hide_unused=True,
                ),
                widget.CurrentLayout(foreground="#93a1a1"),
                widget.Prompt(
                    foreground="#93a1a1"
                ),
                widget.Spacer(),
                widget.CheckUpdates(
                    background="#000000",
                    foreground="#eeeeee",  # White foreground
                    colour_have_updates="#eeeeee",  # White foreground for updates
                    colour_no_updates="#eeeeee",  # White foreground when no updates
                    distro="Arch_checkupdates",
                    display_format=" {updates}",
                    update_interval=3660,
                    no_update_string=""
                ),
                widget.Spacer(length=12),
                MyBacklight(
                    backlight_name="amdgpu_bl1",
                    format="{char}",
                    foreground="#eeeeee",  # White foreground
                ),
                widget.Spacer(length=14),
                widget.Volume(
                    get_volume_command="pactl list sinks | grep 'Volume:' | head -n 1 | awk '{print $5}'",
                    check_mute_command="pactl list sinks | grep \"Mute:\" | awk '{print $2}'",
                    check_mute_string="yes",
                    emoji = True,
                    emoji_list = ["󰖁", "󰕿", "󰖀", "󰕾"],
                    foreground="#eeeeee",  # White foreground
                ),
                widget.Spacer(length=12),
                MyWlan(
                    interface="wlan0",
                    format="{char}",
                    foreground="#eeeeee",  # White foreground
                    update_interval=10,
                ),
                widget.Spacer(length=12),
                MyBattery(
                    format="{char} {percent:1.0%}",
                    low_foreground="#ff0000",
                    show_short_text=False,
                    low_percentage=0.12,
                    notify_below=12,
                    foreground="#eeeeee"
                ),
                widget.Spacer(length=8),
                widget.Clock(
                    format="%H:%M %d/%m",
                    foreground="#eeeeee",  # White foreground
                ),
                widget.Systray(foreground="#eeeeee"),
            ],
            24,
        ),
    ),
]

##############################################
# Autostart applications and scripts
##############################################


@hook.subscribe.startup_once
def autostart():
    subprocess.Popen(["dunst"])
    subprocess.Popen(["/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"])
    subprocess.Popen(["wl-paste", "--watch", "cliphist", "store"])
    subprocess.Popen(
        [
            "dbus-update-activation-environment",
            "SEATD_SOCK WAYLAND_DISPLAY",
            "XDG_CURRENT_DESKTOP=sway",
        ]
    )
    subprocess.Popen(["swayidle", "-w", "before-sleep", "gtklock"])


##############################################
# Misc
##############################################

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
        kb_repeat_delay=500,
        kb_layout="es",
    ),
    "type:touchpad": InputConfig(drag=True, tap=True, natural_scroll=True),
}

wmname = "qtile"
