{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    glfw
    wayland-scanner
    wayland
    libxkbcommon
  ];
  buildInputs = with pkgs; [
    zon2nix
    lolcat
    zig
    zls
  ];
  shellHook = ''
    printf "\e[3m\e[1m%s\em\n" "Initiating Zig env..." | lolcat
  '';
}
