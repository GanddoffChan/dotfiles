from typing import List
from libqtile import bar, layout, widget, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

mod = 'mod4'
terminal = 'alacritty'

keys = [
    Key([mod], 'k', lazy.layout.down(),
        desc='Move focus down in stack pane'),
    Key([mod], 'j', lazy.layout.up(),
        desc='Move focus up in stack pane'),
    Key([mod], 'space', lazy.layout.next(),
        desc='Switch window focus to other pane(s) of stack'),
    Key([mod], 'Return', lazy.spawn(terminal),
        desc='Launch terminal'),
    Key([mod], 'Tab', lazy.next_layout(),
        desc='Toggle between layouts'),
    Key([mod], 'q', lazy.window.kill(),
        desc='Kill focused window'),
    Key([mod], 'r', lazy.spawncmd(),
        desc='Spawn a command using a prompt widget'),
    Key([mod], 'b', lazy.spawn('brave'),
        desc='Launch browser'),
    Key([mod], 'd', lazy.spawn('dmenu_run -h 20'),
        desc='Launch dmenu'),
    Key([mod], 'f', lazy.spawn('pcmanfm'),
        desc='Launch file manager'),
    Key([mod], 's', lazy.spawn('spotify'),
        desc='Launch music player'),
    Key([mod], 'v', lazy.spawn('virtualbox'),
        desc='Launch hypervisor'),
    Key([mod], 'm', lazy.spawn('musescore'),
        desc='Launch compo'),
    Key([mod], 'p', lazy.spawn('PPSSPPSDL'),
        desc='Launch PSP'),
    Key([mod], 'g', lazy.spawn('gimp'),
        desc='Launch gimp'),
    Key([mod], 'y', lazy.spawn('myyt'),
        desc='Launch youtube'),

    Key([mod, 'shift'], 'k',
        lazy.layout.shuffle_down(),
        desc='Move window down in current stack '),
    Key([mod, 'shift'], 'j',
        lazy.layout.shuffle_up(),
        desc='Move window up in current stack '),
    Key([mod], 'h',
        lazy.layout.grow(), lazy.layout.increase_nmaster(),
        desc='Expand window (MonadTall), increase number in master pane (Tile)'),
    Key([mod], 'l',
        lazy.layout.shrink(), lazy.layout.decrease_nmaster(),
        desc='Shrink window (MonadTall), decrease number in master pane (Tile)'),

    Key([mod, 'shift'], 'r', lazy.restart(), desc='Restart qtile'),
    Key([mod, 'shift'], 'q', lazy.shutdown(), desc='Shutdown qtile'),
    Key([mod, 'shift'], 'l', lazy.spawn('slock -m \"$(cowsay $(fortune) | lolcat -ft)\"'), desc='Lock screen'),
    Key([mod, 'shift'], 'p', lazy.spawn('poweroff'), desc='Shut down'),

    Key([], 'XF86MonBrightnessDown', lazy.spawn('brightnessctl -e s 5%-')),
    Key([], 'XF86MonBrightnessUp', lazy.spawn('brightnessctl -e s +5%')),
    Key([], 'XF86AudioRaiseVolume', lazy.spawn('amixer set Master 5%+ unmute')),
    Key([], 'XF86AudioLowerVolume', lazy.spawn('amixer set Master 5%- unmute')),
    Key([], 'XF86AudioMute', lazy.spawn('amixer -q set Master toggle')),
    Key([], 'XF86AudioPrev', lazy.spawn('playerctl previous')),
    Key([], 'XF86AudioPlay', lazy.spawn('playerctl play-pause')),
    Key([], 'XF86AudioNext', lazy.spawn('playerctl next')),

    Key([], 'Print', lazy.spawn('scrot'), desc='Screenshot'),
]

groups = [Group(i) for i in '123456789']

for i in groups:
    keys.extend([
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc='Switch to group {}'.format(i.name)),
        Key([mod, 'shift'], i.name, lazy.window.togroup(i.name, switch_group=True),
            desc='Switch to & move focused window to group {}'.format(i.name)),
    ])

layout_theme = {'margin':5,
                'border_width':1,
                'border_focus':'AABBCC',
                'border_normal':'112233'}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.RatioTile(**layout_theme),
    layout.Max(**layout_theme),
]

widget_defaults = dict(
    font='Ubuntu Mono',
    fontsize=14,
    padding=2,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Image(
                    filename = '~/.config/qtile/icons/arch.png',
                    mouse_callbacks = {
                        'Button1': lambda: qtile.cmd_spawn(
                            'dmenu_run -l 42'
                        )
                    }
                ),
                widget.CurrentLayout(),
                widget.Clock(
                    format=' %H.%M.%S ', mouse_callbacks = {
                        'Button1': lambda: qtile.cmd_spawn(
                            'pystopwatch'
                        )
                    }
                ),
                widget.Clock(format='%a, %d %b %y ', mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn('st -e calcurse')}),
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                #widget.Net(format=' {up} ↑↓ {down} ', update_interval=0.25),
                widget.Memory(update_interval=1),
                #widget.CPU(update_interval=0.25),
                widget.Battery(format=' BAT {percent:2.1%} ', update_interval=1),
                widget.Systray(),
            ],
            20, background='#000000',
            opacity=0.69
        ),
    ),
]

mouse = [
    Drag([mod], 'Button1', lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], 'Button3', lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], 'Button2', lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = False
bring_front_click = True
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"

wmname = 'Qtile'
