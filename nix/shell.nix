{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    glfw
    wayland-scanner
    wayland
    libxkbcommon
  ];
  buildInputs = with pkgs; [
    lolcat
    zig
    zls
  ];
  shellHook = ''
    printf "\e[3m\e[1m%s\em\n" "Initiating Zig env..." | lolcat
  '';
}
