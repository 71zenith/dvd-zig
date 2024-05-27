{
  lib,
  stdenv,
  fetchFromGitHub,
  callPackage,
  zig_0_12,
  libGLU,
  wayland-scanner,
  wayland,
  libxkbcommon,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "dvd";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "71zenith";
    repo = "dvd-zig";
    rev = "v${finalAttrs.version}";
    hash = "sha256-1I90fsJZ2fMc4HUavtUC3vYz71tpWdC6KnD+mI4Srhs=";
  };
  runtimeDependencies = [
    wayland
    wayland-scanner
  ];
  postPatch = ''
    ln -s ${callPackage ./zon.nix {}} $ZIG_GLOBAL_CACHE_DIR/p
  '';

  buildInputs = [
    zig_0_12.hook
    libGLU
    wayland-scanner
    wayland
    libxkbcommon
  ];

  meta = {
    description = "DVD screensaver in zig";
    mainProgram = "dvd";
    homepage = "https://github.com/71zenith/dvd-zig";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [zen];
    platforms = lib.platforms.unix;
  };
})
