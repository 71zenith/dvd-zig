{
  lib,
  stdenv,
  callPackage,
  zig,
  libGL,
  wayland-scanner,
  wayland,
  libxkbcommon,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "dvd";
  version = "latest";

  src = ../.;

  postPatch = ''
    ln -s ${callPackage ./zon.nix {}} $ZIG_GLOBAL_CACHE_DIR/p
  '';

  nativeBuildInputs = [
    zig.hook
    libGL
    wayland-scanner
    wayland
    libxkbcommon
  ];

  postFixup = ''
    mkdir -p $out/share/dvd
    cp -r ${finalAttrs.src}/logo.png $out/share/dvd
    patchelf $out/bin/dvd \
      --add-needed libwayland-client.so \
      --add-needed libwayland-cursor.so \
      --add-needed libwayland-egl.so \
      --add-needed libxkbcommon.so \
      --add-needed libEGL.so \
      --add-rpath ${lib.makeLibraryPath [wayland libxkbcommon libGL]}
  '';

  meta = {
    description = "DVD screensaver in zig";
    mainProgram = "dvd";
    homepage = "https://github.com/71zenith/dvd-zig";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [_71zenith];
    platforms = lib.platforms.unix;
  };
})
