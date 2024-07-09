from libqtile.config import Group, ScratchPad, DropDown, Match
import nerdfonts as nf

from preferences import preferences as pref

# groups = [Group(i) for i in "123456789"]


def init_group_names():
    return [
        (nf.icons.get("fa_firefox", "1"), {"layout": "max"}),
        (nf.icons.get("fa_terminal", "2"), {"layout": "monadtall"}),
        (nf.icons.get("fa_envelope", "3"), {"layout": "max"}),
        (nf.icons.get("fa_comment", "4"), {"layout": "max"}),
    ]


def init_scratchpads():
    return [
        ScratchPad(
            "scratchpad",
            DropDown("browser", [pref.browser]),
        )
    ]


def init_groups():
    return [
        # Group(name, **kwargs) for name, kwargs in init_group_names()
        Group(nf.icons.get("fa_firefox", "1"), layout="max"),
        Group(nf.icons.get("fa_terminal", "2"), layout="monadtall", layout_opts={"ratio": 0.75}),
        Group(nf.icons.get("fa_envelope", "3"), layout="max"),
        Group(nf.icons.get("fa_comment", "4"), layout="max"),
        ScratchPad(
            "scratchpad",
            [
                DropDown("browser", [pref.browser]),
                DropDown(
                    "teams",
                    "chromium --profile-directory=Default --app-id=cifhbcnohmdccbgoicgdjpfamggdegmo --class=teams-chromium-dropdown",
                    height=0.95,
                    width=0.95,
                    x=0.025,
                    y=0.025,
                    on_focus_lost_hide=False,
                    opacity=1.0,
                    warp_pointer=True,
                    match=Match(wm_class="teams-chromium-dropdown"),
                ),
                DropDown(
                    "term",
                    [pref.terminal.run],
                    height=0.8,
                    width=0.8,
                    x=0.1,
                    y=0.1,
                    on_focus_lost_hide=True,
                    opacity=1.0,
                    warp_pointer=True,
                ),
                DropDown(
                    "spotify",
                    ["spotify"],
                    height=0.8,
                    width=0.8,
                    x=0.1,
                    y=0.1,
                    on_focus_lost_hide=False,
                    opacity=0.95,
                    warp_pointer=True,
                ),
                DropDown(
                    "options",
                    ["gnome-control-center"],
                    height=0.8,
                    width=0.8,
                    x=0.1,
                    y=0.1,
                    on_focus_lost_hide=False,
                    opacity=1.0,
                    warp_pointer=True,
                ),
            ],
        ),
    ]
