from pathlib import Path

from libqtile import bar
from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration

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
        background = "#00000000",
        length=width,
        decorations=[],
    )

def widget_fill(radius=corner_radius):
    return RectDecoration(
        colour="#2C001E",
        radius=radius,
        filled=True,
        padding_y=2,
    )

left_box = [corner_radius, 0, 0, corner_radius]
right_box = [0, corner_radius, corner_radius, 0]

widgets = [
    separator(4),
    widget.CurrentLayout(
        decorations=[widget_fill(left_box)],
    ),
    separator(),
    widget.GroupBox(
        decorations=[widget_fill(right_box)],
        highlight_method='text',
        this_current_screen_border="#ffaa00",
    ),
    separator(),
    widget.Prompt(),
    separator(bar.STRETCH),
    widget.WindowName(
        width=420,
        max_chars=50,
        decorations=[widget_fill()]
    ),
    #separator(),
    #widget.Chord(
    #chords_colors={
    #"launch": ("#ff0000", "#ffffff"),
    #},
    #name_transform=lambda name: name.upper(),
    #),
    #separator(),
    #widget.StatusNotifier(icon_theme=icon_path),
    separator(bar.STRETCH),
    widget.CheckUpdates(
        distro="Ubuntu",
        no_update_string="↻",
        display_format="↻ {updates}",
        restart_indicator=" (!)",
        update_interval=60,
        #execute=f"aptitude search '~U'",
        decorations=[widget_fill(left_box)],
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
        decorations=[widget_fill(0)],
    ),
    #separator(),
    #widget.Bluetooth(),
    separator(),
    widget.UPowerWidget(
        border_color='#dbdbe0',
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
        decorations=[widget_fill(right_box)]
    ),
    separator(4),
]

