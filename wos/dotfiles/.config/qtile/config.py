# weakOS
# Desktop qtile config

# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
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

# Imports
# =======

import os
import re
import socket
import subprocess
from libqtile import qtile
from libqtile import images
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen, ScratchPad, DropDown
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from typing import List  # noqa: F401


# Settings
# ========

# which key is modkey. mod4 is super (windows) key. Options key on Mac
mod = "mod4"

# Default teminal
terminal = "alacritty"

# Heighth of the status bar
bar_height = 24

# Font and font size for text shown in the status bar
text_font = "Cantarell"
text_size = "14"

# Icon font and size of icon font shown in the status bar
icon_font = "FontAwesome"
icon_size = 14

# Element font (font for separators in the widgets) and size of element font shwon in the status bar 
element_font = "mononoki Nerd Font"
element_size = bar_height


# Nord color palette
color = [  "#292d3e", # color[0] bar background
           "#5e81ac", # color[1] highlight color
           "#ffffff", # color[2] foreground for dark background
           "#000000", # color[3] foreground for light background
           "#7BA0C0", # color[4] Light background for widgets
           "#4B5569", # color[5] Dark background for widgets
        ]

# Keyboard shortcuts
# ==================
keys = [
    # Switch between windows
    Key([mod], "h",
            lazy.layout.left(), 
            desc="Move focus to left"),
    Key([mod], "l",
            lazy.layout.right(),
            desc="Move focus to right"),
    Key([mod], "j",
            lazy.layout.down(),
            desc="Move focus down"),
    Key([mod], "k",
            lazy.layout.up(),
            desc="Move focus up"),
    
    # Switch layouts
    Key([mod], 'space', 
            lazy.next_layout()),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"],"h",
            lazy.layout.shuffle_left(),
            desc="Move window to the left"),
    Key([mod, "shift"], "l",
            lazy.layout.shuffle_right(),
            desc="Move window to the right"),
    Key([mod, "shift"], "j",
            lazy.layout.shuffle_down(),
            desc="Move window down"),
    Key([mod, "shift"], "k",
            lazy.layout.shuffle_up(),
            desc="Move window up"),

    # Switch to last visited group
    Key([mod], "Tab", 
            lazy.screen.toggle_group()),
    

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h",
            lazy.layout.grow_left(),
            desc="Grow window to the left"),
    Key([mod, "control"], "l",
            lazy.layout.grow_right(),
            desc="Grow window to the right"),
    Key([mod, "control"], "j", 
            lazy.layout.grow_down(),
            desc="Grow window down"),
    Key([mod, "control"], "k",
            lazy.layout.grow_up(),
            desc="Grow window up"),
    Key([mod], "n",
            lazy.layout.normalize(),
            desc="Reset all window sizes"),

	Key([mod], "i",
             lazy.layout.grow(),
             lazy.layout.increase_nmaster(),
             desc='Expand window (MonadTall), increase number in master pane (Tile)'
             ),
    Key([mod], "o",
             lazy.layout.shrink(),
             lazy.layout.decrease_nmaster(),
             desc='Shrink window (MonadTall), decrease number in master pane (Tile)'
             ),
    
    Key([mod], 'f', lazy.window.toggle_fullscreen()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", 
            lazy.layout.toggle_split(),
            desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", 
            lazy.spawn(terminal),
             desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key(["mod1"], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "q", lazy.spawn("xkill -all"), desc="Kill focused window"),


    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawn("rofi -show drun -show-icons"), desc="Spawn a command using a prompt widget"),
    Key([], "Print", lazy.spawn("/home/weak/.config/wos/scripts/wos-screenshot"), desc="Pořídí snímek obrazovky"),
    Key([mod], "Print", lazy.spawn("/home/weak/.config/wos/scripts/wos-screenshot -w"), desc="Pořídí snímek obrazovky"),
    
    # Change the volume if your keyboard has special volume keys
    Key([], "XF86AudioRaiseVolume",lazy.spawn("pulseaudio-ctl up 5")),
    Key([], "XF86AudioLowerVolume",lazy.spawn("pulseaudio-ctl down 5")),
    Key([], "XF86AudioMute",lazy.spawn("amixer set Master togglemute")),
    
    Key([mod], "b", lazy.spawn("/home/weak/.config/wos/menus/wos-rofi-beats.sh")),
    Key([mod], "f", lazy.spawn("/home/weak/.config/wos/menus/wos-favorites.sh")),
    Key([mod], "c", lazy.spawn("/home/weak/.config/wos/menus/wos-configs.sh")),
    
    

    # Shortcuts for Applications 
    # ==========================                                                                        
    
    # Firefox
    Key([mod], "w", lazy.spawn("firefox"), desc="firefox"),
    # Lutris
    Key(["mod1"], "l", lazy.spawn("lutris"), desc="Lutris"),
    # Filemanager - Nemo
    Key([mod, "shift"], "Return", lazy.spawn("nemo"), desc="Nemo"),
    # Sound Control - Pavucontrol
    Key(["mod1"], "p", lazy.spawn("pavucontrol"), desc="Pavucontrol"),
    # Fullscreen Powermenu
    Key(["mod1", "control"], "Delete", lazy.spawn("/home/weak/.config/wos/menus/wos-powermenu.sh wos-powermenu-fullscreen"), desc="PowerMenu"),
    # Screen Locker
    # Key([mod], "c", lazy.spawn("wos-lock"), desc="Zámek Obrazovky"),
    KeyChord([mod], "a", [
        Key([], "s", lazy.spawn("steam")),
        Key([], "l", lazy.spawn("lutris")),
    ])
    
    

]

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]



# Groups with matches
# ===================

workspaces = [
    {"name": "", "key": "plus", "layout": "monadtall"},
    {"name": "", "key": "ecaron", "layout": "monadtall", "matches": [Match(wm_class='code-oss'),Match(wm_class='vim')]},
    {"name": "", "key": "scaron", "layout": "monadtall", "matches": [Match(wm_class='nemo')]},
    {"name": "", "key": "ccaron", "layout": "monadtall", "matches": [Match(wm_class='firefox')]},
    {"name": "", "key": "rcaron", "layout": "monadtall", "matches": [Match(wm_class='lutris'),Match(wm_class='Steam')]},
    {"name": "", "key": "zcaron", "layout": "monadtall", "matches": [Match(wm_class='vlc'), Match(wm_class='spotify')]},
    {"name": "", "key": "yacute", "layout": "monadtall", "matches": [Match(wm_class='geany'),Match(wm_class='vim')]},
    {"name": "", "key": "aacute", "layout": "monadtall", "matches": [Match(wm_class='evolution')]},
    {"name": "", "key": "iacute", "layout": "monadtall", "matches": [Match(wm_class='telegram-desktop')]},
   # {"name": "other", "key": "eacute", "layout": "monadtall", "matches": [Match(wm_class='gimp')]},
]

groups = []

for workspace in workspaces:
    matches = workspace["matches"] if "matches" in workspace else None
    lay = workspace["layout"] if "layout" in workspace else None
    groups.append(Group(workspace["name"], matches=matches, layout=lay))
    keys.append(Key([mod], workspace["key"], lazy.group[workspace["name"]].toscreen()))
    keys.append(Key([mod, "shift"], workspace["key"], lazy.window.togroup(workspace["name"])))

layout_color_focus = color[1]
layout_color_normal = "#383c4a"

# Layouts
# =======

def init_layout_theme():
    return {"margin":5,
            "border_width":2,
            "border_focus": layout_color_focus,
            "border_normal": layout_color_normal,
            "single_border_width": 0,
            "single_margin": 0
            }

layout_theme = init_layout_theme()   

layouts = [
    # layout.Columns(**layout_theme),
    layout.Max(**layout_theme),
    # layout.Stack(num_stacks=2, **layout_theme),
    layout.Bsp(**layout_theme),
    # layout.Matrix(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    # layout.RatioTile(**layout_theme),
    # layout.Tile(**layout_theme),
    # layout.TreeTab(**layout_theme),
    # layout.VerticalTile(**layout_theme),
    # layout.Zoomy(**layout_theme),
]


#Colors
bar_background = "#292d3e"
widget_light_foreground = "#000000"
widget_light_background = "#7BA0C0"
widget_dark_foreground = "#ffffff"
widget_dark_background = "#4B5569"


# Status bar and widgets
# ======================

widget_defaults = dict(
    font = text_font,
    fontsize= text_size,
    padding=3,
    margin=10,
    background=bar_background,
)
extension_defaults = widget_defaults.copy()


screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    highlight_method = "line",
                    font = icon_font,
                    fontsize = icon_size,
                    active = color[2],
                    foreground = "#000000",
                    highlight_color = "#5e81ac",
                    inactive = "#555555",
                    rounded = False,
                    this_current_screen_border = "#5e81ac",
                    this_screen_border = "215578"
                
                ),
               
                widget.WindowName(),
                widget.Systray(),
                widget.Spacer(length=10),
                
                # Layouts Widget
                # ==============
                
                widget.TextBox(
                    text = "",
                    font = element_font,
                    fontsize= element_size,
                    padding = 0,
                    foreground = color[4],
                 ),
                widget.CurrentLayoutIcon(
                    custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons/layouts-dark/")],
                    background = color[4],
                    foreground = color[3],
                    padding = 0,
                    scale = 0.7
                    ),
                widget.TextBox(
                    text = "",
                    fontsize=21,
                    padding = 0,
                    foreground = color[5],
                    background = color[4],
                    ),
                
                # Hdd Usage widget
                # ================
                
                # icon
                widget.TextBox(
                    text="",
                    fontsize = "14",
                    background = widget_dark_background
                    ),
                # widget
                widget.GenPollText(
                    update_interval=1, 
                    func=lambda: subprocess.check_output("/home/weak/.config/qtile/scripts/hddusage.sh").decode("utf-8"),
                    background=widget_dark_background,
                    ),
                # separator
                widget.TextBox(
                    text = "",
                    fontsize=21,
                    padding = 0,
                    foreground = widget_light_background,
                    background = widget_dark_background
                    ),
                
                # Pacman updates
                # ==============
                
                # icon
                widget.TextBox(
                    text = "  ",
                    font = "FontAwesome",
                    padding = 0,
                    background = widget_light_background,
                    foreground = widget_light_foreground,
                    ),
                # widget
                widget.GenPollText(
                    margin="0",
                    update_interval=3600, 
                    func=lambda: subprocess.check_output("/home/weak/Projekty/Skripty/wos/wos-updates").decode("utf-8"),
                    background=widget_light_background,
                    foreground=widget_light_foreground,
                    ),
                
                # OpenWeather widget
                # ==================

                # separator
                widget.TextBox(
                    text = "",
                    fontsize=21,
                    padding = 0,
                    foreground = widget_dark_background,
                    background = widget_light_background
                       ),
                # widget
                widget.OpenWeather(
                    appkey="7834197c2338888258f8cb94ae14ef49",
                    cityid=3078910,
                    language="cz",
                    icon_font="Weather Icons",
                    format="{temp:.1f}˚C {weather_details}",
                    background=widget_dark_background,
                    update_interval=600
                    ),
                
                # For laptops

                # Battery widget
                # ==============
                #*# separator
                #*widget.TextBox(
                #*    text = "",
                #*    fontsize=21,
                #*    padding = 0,
                #*    foreground = widget_light_background,
                #*    background = widget_dark_background
                #*    ),
                #*# widget
                #*widget.Battery(
                #*    charge_char = "",
                #*    discharge_char = "",
                #*    full_char = "",
                #*    empty_char = "",
                #*    format="{char} {percent: 2.0%}",
                #*    background=widget_light_background,
                #*    foreground=widget_light_foreground,
                #*    update_interval=1
                #*    ),
                #*
                #*#separator
                #*widget.TextBox(
                #*    text = "",
                #*    fontsize=21,
                #*    padding = 0,
                #*    foreground = widget_dark_background,
                #*    background = widget_light_background
                #*    ),
                #*# Backlight
                #*# =========
                #*
                #*#separator
                #*widget.TextBox(
                #*    font="UbuntuMono Nerd Font",
                #*    text = "",
                #*    background = widget_dark_background,
                #*    foreground = widget_dark_foreground
                #*    ),
                #*# widget
                #*widget.Backlight(
                #*    backlight_name = "intel_backlight",
                #*    brightness_file= "brightness",
                #*    max_brightness_file = "max_brightness",
                #*    change_command = "xbacklight -set {0}",
                #*    background = widget_dark_background,
                #*    foreground = widget_dark_foreground
                #*    ),
                #*    
                
                # Pulseaudio volume widget
                # ========================
                
                # separator
                widget.TextBox(
                    text = "",
                    fontsize=21,
                    padding = 0,
                    foreground = widget_light_background,
                    background = widget_dark_background
                    ),
                # icon
                widget.TextBox(
                    font="FontAwesome",
                    text = "",
                    padding = 0,
                    background = widget_light_background,
                    foreground = widget_light_foreground
                    ),
                # widget
                widget.PulseVolume(
                    background = widget_light_background,
                    foreground = widget_light_foreground,
                    update_interval = 0.2,
                    ),
                
                # Clock widget
                # ============
                
                # separator
                widget.TextBox(
                    text = "",
                    padding = 0,
                    fontsize=21,
                    foreground = widget_dark_background,
                    background = widget_light_background
                    ),
                # icon
                widget.TextBox(
                    font="FontAwesome",
                    text = "",
                    padding = 0,
                    background = widget_dark_background,
                    ),
                # widget
                widget.Clock(
                    format='%A, %d.%m %Y | %H:%M',
                    background = widget_dark_background,
                    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn("alacritty -e htop")}
                    ),
                
                # Power icon widget
                # =================

                widget.Spacer(length=5,
                    background = widget_dark_background),
                # widget
                widget.TextBox(
                      font="FontAwesome",
                      text = "",
                       padding = 0,
                       background = widget_dark_background,
                       # foreground = widget_dark_foreground,
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn("/home/weak/.config/wos/menus/wos-powermenu.sh wos-powermenu-widget")}
                       ),
                widget.Spacer(length=5,
                    background = widget_dark_background),
            ],
            bar_height
        ),
    ),
]

# Drag floating layouts.



dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='oblogout'),
    Match(wm_class='galculator'),
    Match(wm_class='gnome-calculator'),
    Match(wm_class='pavucontrol'),
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(wm_class='xfce4-appfinder'),
    Match(wm_class='MEGAsync'),
    Match(wm_class='megasync'),
    Match(wm_class='origin'),
    Match(wm_class='Origin'),
    Match(title='Origin'),
    Match(wm_type='dialog'),
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
], **layout_theme)
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"


# Autostart
@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])
