# rofi dotfiles

Shared rofi config for app launching, powermenu, and audio sink switching. Used by both [i3](../i3) and [hyprland](../hyprland).

Based on [adi1090x/rofi](https://github.com/adi1090x/rofi).

## What's included

- **launchers** — app launcher themes (type-1 through type-7)
- **powermenu** — power menu themes (type-1 through type-6)
- **applets** — volume, brightness, battery, screenshot, etc.
- **scripts/sink-switcher.sh** — rofi-based PulseAudio/PipeWire sink switcher (replaces pasystray on Wayland)

## Install

```bash
cd ~/.dotfiles
stow rofi
```

## Dependencies

- [rofi](https://github.com/davatorium/rofi)
- [pamixer](https://github.com/cdemoulins/pamixer) — volume control
- [pavucontrol](https://freedesktop.org/software/pulseaudio/pavucontrol/) — full audio settings

## Notes

- The sink-switcher is wired to middle-click on waybar's pulseaudio module. It also moves active streams to the newly selected sink.
