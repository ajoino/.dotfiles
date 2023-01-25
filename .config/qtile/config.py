# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
# Copyright (c) 2022 Jacob Nilsson
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import subprocess
from pathlib import Path

from libqtile import bar, layout, hook
from libqtile.config import Click, Drag, Match, Screen, Key
from libqtile.lazy import lazy
from libqtile.log_utils import logger

from widgets import widgets, widget_defaults, extension_defaults
from preferences import preferences as pref
from key_bindings import keys as keys
from groups import init_groups, init_group_names

mod = pref.mod_key


def log_subprocess_error(res: subprocess.CompletedProcess):
    logger.warning(f"Command {res.args} returned a non-zero returncode:")
    logger.warning(res.stderr)


@hook.subscribe.startup_once
def autostart():
    for command in pref.autostart_applications:
        res = subprocess.run(command.split())
        if res.returncode != 0:
            log_subprocess_error(res)


@hook.subscribe.startup
def startup():
    touchpads = map(
        # Extract the name of the touchpad
        lambda t: b" ".join(t.split()[2:5]),
        filter(
            # filter out touchpad devices
            lambda s: "touchpad" in s.decode().lower(),
            # Get list of input devices from xinput
            subprocess.run(
                "xinput list".split(), capture_output=True
            ).stdout.splitlines(),
        ),
    )

    for touchpad in touchpads:
        touchpad_string = touchpad.decode()
        res = subprocess.run(
            ["xinput", "set-prop", touchpad_string, "libinput Tapping Enabled", "1"],
            capture_output=True,
        )
        if res.returncode != 0:
            log_subprocess_error(res)
        res = subprocess.run(
            [
                "xinput",
                "set-prop",
                touchpad_string,
                "libinput Natural Scrolling Enabled",
                "1",
            ],
            capture_output=True,
        )
        if res.returncode != 0:
            log_subprocess_error(res)
        res = subprocess.run(
            [
                "xinput",
                "set-prop",
                touchpad_string,
                "libinput Middle Emulation Enabled",
                "1",
            ],
            capture_output=True,
        )
        if res.returncode != 0:
            log_subprocess_error(res)


layouts = [
    # layout.Columns(),
    layout.MonadTall(
        border_focus="#E95420", border_normal="#00000000", border_width=2, margin=2
    ),
    layout.Max(),
    layout.Floating(
        border_focus="#E95420",
        border_width=2,
    ),
    layout.MonadThreeCol(
        border_focus="#E95420",
        border_normal="#00000000",
        border_width=2,
        margin=2,
        new_client_position="after_current",
    ),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

if __name__ in {"config", "__main__"}:
    group_names = init_group_names()
    groups = init_groups()

    for i, (name, kwargs) in enumerate(group_names, 1):
        keys.append(Key([mod], str(i), lazy.group[name].toscreen()))
        keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name)))


# Setup screen with widgets
screens = [
    Screen(
        top=bar.Bar(
            widgets,
            28,
            border_width=[3, 0, 0, 0],
            # These colors make the bar transparent
            background="#00000000",
            border_color="#00000000",
        ),
    ),
]

# Drag floating layouts.
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


@hook.subscribe.resume
def lock_on_resume():
    subprocess.run("i3lock-fancy --p")
    logger.warn("Resuming from sleep")


@hook.subscribe.screen_change
def restart_on_randr(qtile):
    # TODO only if numbers of screens changed
    subprocess.run(str(Path("$HOME/.screenlayout/monitor-only-office.sh").expanduser()))
    qtile.cmd_restart()


@hook.subscribe.screens_reconfigured
def reset_layout():
    logger.warn("Resetting screen layout")
    lazy.spawn(str(Path("$HOME/.screenlayout/monitor-only-office.sh").expanduser()))


dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(title="splash"),  # Pycharm initial pop-up
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
