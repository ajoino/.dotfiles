"""
My implementation of the Ubuntu yaru theme for qtile
"""

from colors import colors, yaru_accent_bg_color

# The main accent color and the matching text value
accent_bg_color = yaru_accent_bg_color
accent_fg_color = colors["light_1"]
accent_color = yaru_accent_bg_color

# destructive-action buttons
destructive_bg_color = colors["red_4"]
destructive_fg_color = colors["light_1"]
destructive_color = colors["red_4"]

# Levelbars, entries, labels and infobars. These don't need text colors
success_bg_color = colors["green_4"]
success_fg_color = colors["light_1"]
success_color = colors["green_4"]

warning_bg_color = colors["yellow_5"]
warning_fg_color = colors["light_1"]
warning_color = colors["yellow_5"]

error_bg_color = colors["red_4"]
error_fg_color = colors["light_1"]
error_color = colors["red_4"]

# The secondary accent color and the matching text value - Yaru change
fill_bg_color = colors["yaru_accent_bg_color"]
fill_fg_color = colors["light_1"]

# Window
window_bg_color = if($variant == 'light', #fafafa, lighten(#181818, 8%));
window_fg_color = if($variant=='light', '@dark_3', '@light_2');

# Views - e.g. text view or tree view
view_bg_color = "#ffffff" if variant == 'light' else "#1e1e1e"
view_fg_color = "#000000" if variant == 'light' else "#ffffff"

"""
# Not implemented yet

# Header bar, search bar, tab bar
headerbar_bg_color = "#ebebeb" if variant == 'light' else "#303030"
headerbar_fg_color = if($variant == 'light', transparentize(black, .2), white);
headerbar_border_color = if($variant == 'light', transparentize(black, .2), white);
headerbar_backdrop_color = colors["window_bg_color"]
headerbar_shade_color = if($variant == 'light', transparentize(black, .93), transparentize(black, .64));

# Cards, boxed lists
card_bg_color = if($variant == 'light', #ffffff, transparentize(white, .92));
card_fg_color = if($variant == 'light', transparentize(black, .2), white);
card_shade_color = if($variant == 'light', transparentize(black, .93), transparentize(black, .64));

# Popovers
popover_bg_color = if($variant == 'light', #ffffff, lighten($dark_4, 2%));
popover_fg_color = if($variant == 'light', transparentize(black, .2), white);

# Miscellaneous
shade_color = if($variant == 'light', transparentize(black, .93), transparentize(black, .64));
scrollbar_outline_color = if($variant == 'light', white, transparentize(black, .5));
window_outline_color = if($variant == 'light', transparent, white);
window_border_color = if($variant == 'light', transparentize(black, 0.77), transparentize(black, 0.25));
window_border_backdrop_color = if($variant == 'light', transparentize(black, 0.82), transparentize(black, 0.25));
"""
