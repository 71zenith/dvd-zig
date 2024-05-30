{
  lib,
  stdenv,
  callPackage,
  zig_0_12,
  libGL,
  wayland-scanner,
  wayland,
  libxkbcommon,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "dvd";
  version = "latest";

  src = ./.;

  postPatch = ''
    ln -s ${callPackage ./zon.nix {}} $ZIG_GLOBAL_CACHE_DIR/p
    mkdir -p $out/share/dvd
    cp -r logo.png $out/share/dvd
  '';

  nativeBuildInputs = [
    zig_0_12.hook
    libGL
    wayland-scanner
    wayland
    libxkbcommon
  ];

  postFixup = ''
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
    maintainers = with lib.maintainers; [zen];
    platforms = lib.platforms.unix;
  };
})
