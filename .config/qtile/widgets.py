from pathlib import Path

from libqtile import bar
from libqtile.config import Screen
from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration

icon_path = Path("/usr/share/icons/Yaru-dark/24x24/panel/")

widget_defaults = dict(
    font="fira sans",
    fontsize=16,
    padding=8,
    theme_path=icon_path,
    background="#00000000",
    decorations=[
        RectDecoration(colour="#2C001E", radius=5, filled=True, padding_y=2)
    ],
)
extension_defaults = widget_defaults.copy()

def separator(width=5):
    return widget.Spacer(
        background = "#00000000",
        length=width,
        decorations=[],
    )


widgets = [
    widget.CurrentLayout(),
    separator(),
    widget.GroupBox(),
    separator(),
    widget.Prompt(),
    separator(),
    widget.WindowName(),
    separator(),
    widget.Chord(
        chords_colors={
            "launch": ("#ff0000", "#ffffff"),
        },
        name_transform=lambda name: name.upper(),
    ),
    separator(),
    widget.StatusNotifier(icon_theme=icon_path),
    separator(),
    widget.CheckUpdates(
        distro="Ubuntu",
        no_update_string="↻",
        display_format="↻ {updates}",
        restart_indicator=" (!)",
        update_interval=60,
        execute=f"aptitude search ~U",
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
    ),
    separator(),
    widget.OpenWeather(
        location="Luleå, SE",
        format="{location_city}: {main_temp:.0f} °{units_temperature}",
        update_interval=300,
    ),
    # widget.Systray(),
    separator(),
    widget.Clock(format="%a %Y-%m-%d | %H:%M", padding=20),
    # vc.Widget(mode='icon'),
    separator(),
    widget.PulseVolume(
        emoji=True,
        theme_path=None,
        # theme_path=icon_path.parents[2] / "16x16/panel",
        mute_command=[
            "amixer",
            "-q",
            "set",
            "Master",
            "toggle",
        ],
    ),
    separator(),
    widget.Bluetooth(),
    separator(),
    widget.UPowerWidget(),
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
    ),
]

