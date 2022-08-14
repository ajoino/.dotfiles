from __future__ import annotations

from dataclasses import dataclass
from typing import TypedDict
from typing_extensions import Self
from pathlib import Path
try:
    import tomllib as toml
except ImportError:
    import tomli as toml

_default = Path("~/.config/qtile/preferences.toml").expanduser()

class _TerminalPreferences(TypedDict):
    application: str
    run_command: str
    run_command_hold: str

class _Preferences(TypedDict):
    mod_key: str
    browser: str
    file_manager: str
    autostart_applications: list[str]
    terminal: _TerminalPreferences
    palette: dict[str, str]


def _read_preferences(preferences_path: Path=_default) -> _Preferences:
    with open(preferences_path, 'rb') as pref_file:
        return toml.load(pref_file)

class Preferences:
    @dataclass
    class Terminal:
        run: str
        run_command: str
        hold_command: str

    def __init__(self, toml_data: _Preferences):
        self.mod_key = toml_data["mod_key"]
        self.browser = toml_data["browser"]
        self.file_manager = toml_data["file_manager"]
        self.autostart_applications = toml_data["autostart_applications"]
        self.terminal = self.Terminal(**toml_data["terminal"])
        self.palette = toml_data["palette"]

preferences = Preferences(_read_preferences(_default))
