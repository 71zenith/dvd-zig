old school dvd screensaver but in raylib and zig


# install instructions
## source
install `zig` `libGL` `wayland-scanner` `wayland` `libxkbcommon`

```sh
zig build
sudo cp ./zig-out/bin/dvd /usr/bin/dvd
mkdir -p /usr/share/dvd
sudo cp ./logo.png /usr/share/dvd/logo.png
```

## nix
in `flakes.nix`
```nix
inputs = {
    dvd-zig.url = "github:71zenith/dvd-zig";
}
```
define overlay
```nix
nixpkgs.overlays = [
    inputs.dvd-zig.overlays.default
]
```
now it is available as `pkgs.dvd-zig`


# example usage
## hypridle
```
general {
  ignore_dbus_inhibit=false
}
listener {
  on-timeout=/usr/bin/dvd
  timeout=300
}
```

## same but for nix
```nix
services.hypridle = {
    enable = true;
    settings = {
        general = {
            ignore_dbus_inhibit = false;
        };
        listener = {
            timeout = 300;
            on-timeout = "${lib.getExe pkgs.dvd-zig}";
        };
    };
};
```


# TODO
- support multiple monitors
