{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    lolcat
    pkg-config
    zig
    xorg.libX11
    zls
    libGLU
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXinerama
    xorg.xinput
    xorg.libXft
    xorg.libXi.dev
  ];
  shellHook = ''
    printf "\e[3m\e[1m%s\em\n" "Initiating Zig env..." | lolcat
  '';
}
