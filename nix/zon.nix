{
  linkFarm,
  fetchzip,
}:
linkFarm "zig-packages" [
  {
    name = "12204a223b19043e17b79300413d02f60fc8004c0d9629b8d8072831e352a78bf212";
    path = fetchzip {
      url = "https://github.com/Not-Nik/raylib-zig/archive/43d15b05c2b97cab30103fa2b46cff26e91619ec.tar.gz";
      hash = "sha256-e+7fLj3ETQ4/FhFelse87pwRxd2hrb5Zj1jDuKh1yak=";
    };
  }
  {
    name = "1220aa75240ee6459499456ef520ab7e8bddffaed8a5055441da457b198fc4e92b26";
    path = fetchzip {
      url = "https://github.com/raysan5/raylib/archive/5767c4cd059e07355ae5588966d0aee97038a86b.tar.gz";
      hash = "sha256-vdV69W9ic7ZjYBl7BxsxKQNKjuhx61nRSYQvgUy5sDI=";
    };
  }
  {
    name = "122002d98ca255ec706ef8e5497b3723d6c6e163511761d116dac3aee87747d46cf1";
    path = fetchzip {
      url = "https://github.com/raysan5/raygui/archive/4b3d94f5df6a5a2aa86286350f7e20c0ca35f516.tar.gz";
      hash = "sha256-+UVvUOp+6PpnoWy81ZCqD8BR6sxZJhtQNYQfbv6SOy0=";
    };
  }
]
