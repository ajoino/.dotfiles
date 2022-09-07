from libqtile.config import Group
import nerdfonts as nf

# groups = [Group(i) for i in "123456789"]


def init_group_names():
    return [
        (nf.icons.get("fa_firefox", "1"), {"layout": "max"}),
        (nf.icons.get("fa_terminal", "2"), {"layout": "monadtall"}),
        (nf.icons.get("fa_envelope", "3"), {"layout": "max"}),
        (nf.icons.get("fa_comment", "4"), {"layout": "max"}),
    ]


def init_groups():
    return [Group(name, **kwargs) for name, kwargs in init_group_names()]
