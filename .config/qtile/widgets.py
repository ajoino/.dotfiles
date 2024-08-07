from pathlib import Path
import subprocess

from libqtile import bar
from libqtile.lazy import lazy
from libqtile.log_utils import logger
from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration
from qtile_extras.popup.toolkit import PopupRelativeLayout, PopupText, _PopupLayout

from preferences import preferences as pref
import nerdfonts as nf

icon_path = Path("/usr/share/icons/Yaru-dark/24x24/panel/")

widget_defaults = dict(
    font="fira sans",
    fontsize=16,
    padding=8,
    theme_path=icon_path,
    background="#00000000",
)
extension_defaults = widget_defaults.copy()

corner_radius = 10


def separator(width=2):
    return widget.Spacer(
        background="#00000000",
        length=width,
        decorations=[],
    )


def widget_fill(radius=corner_radius):
    return RectDecoration(
        colour=pref.palette["purple_4"] + "b0",
        radius=radius,
        filled=True,
        padding_y=2,
    )


left_box = [corner_radius, 0, 0, corner_radius]
right_box = [0, corner_radius, corner_radius, 0]


widgets = [
    separator(4),
    widget.GroupBox(
        decorations=[widget_fill(left_box)],
        font="Fira Code Nerd Font",
        highlight_method="text",
        this_current_screen_border="#ffaa00",
        disable_drag=True,
        active=pref.palette["purple_1"],
        inactive="#F0F0F050",
    ),
    separator(),
    widget.CurrentLayoutIcon(
        decorations=[widget_fill(right_box)],
        scale=0.6,
    ),
    separator(),
    widget.Prompt(),
    separator(bar.STRETCH),
    widget.WindowName(width=420, max_chars=50, decorations=[widget_fill()]),
    # separator(),
    # widget.Chord(
    # chords_colors={
    # "launch": ("#ff0000", "#ffffff"),
    # },
    # name_transform=lambda name: name.upper(),
    # ),
    # separator(),
    # widget.StatusNotifier(icon_theme=icon_path),
    separator(bar.STRETCH),
    widget.CheckUpdates(
        distro="Ubuntu",
        no_update_string="↻",
        display_format="↻ {updates}",
        restart_indicator=" (!)",
        update_interval=60,
        decorations=[widget_fill(left_box)],
        # execute=show_upgradable_packages,
    ),
    separator(),
    widget.KeyboardLayout(
        configured_keyboards=[
            "us dvorak",
            "se svdvorak",
            "se",
        ],
        display_map={
            "us dvorak": "en",
            "se svdvorak": "sv dv",
            "se": "sv",
        },
        option="caps:ctrl_modifier",
        decorations=[widget_fill(0)],
    ),
    separator(),
    widget.OpenWeather(
        location="Luleå, SE",
        format="{location_city}: {main_temp:.0f} °{units_temperature}",
        update_interval=300,
        decorations=[widget_fill(0)],
    ),
    # widget.Systray(),
    separator(),
    widget.Clock(
        format="%a %b %d | %H:%M",
        decorations=[widget_fill(0)],
    ),
    # vc.Widget(mode='icon'),
    separator(),
    widget.PulseVolume(
        # emoji=True,
        theme_path=None,
        # theme_path=icon_path,
        decorations=[widget_fill(0)],
    ),
    separator(),
    widget.Bluetooth(
        default_text="\U0000f293 {connected_devices}",
        decorations=[widget_fill(0)],
    ),
    separator(),
    widget.UPowerWidget(
        border_color="#dbdbe0",
        border_charge_colour="#E95420",
        battery_height=12,
        battery_width=20,
        margin=5,
        spacing=3,
        decorations=[widget_fill(0)],
    ),
    # widget.WiFiIcon(interface="wlp58s0", active_color="ffffff"),
    # widget.BatteryIcon(),
    # widget.Battery(
    #    format="{percent:2.0%}",
    # ),
    separator(),
    widget.QuickExit(
        font="fira code",
        default_text="[X]",
        countdown_format="[{}]",
        decorations=[widget_fill(right_box)],
    ),
    separator(4),
]
