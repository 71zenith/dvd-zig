{
  linkFarm,
  fetchzip,
}:
linkFarm "zig-packages" [
  {
    name = "122064a960fff658211413c4b3b56e1699719126c3d099d3ed43f9eaff17a936ad91";
    path = fetchzip {
      url = "https://github.com/Not-Nik/raylib-zig/archive/a03b65a76c527771aa2ea69ad39c78406eefd19c.tar.gz";
      hash = "sha256-810cf6jCREP+Mn4rDAKWnIBzRsDJdNLLOwhXUR5LXxY=";
    };
  }
  {
    name = "1220aa75240ee6459499456ef520ab7e8bddffaed8a5055441da457b198fc4e92b26";
    path = fetchzip {
      url = "https://github.com/raysan5/raylib/archive/5767c4cd059e07355ae5588966d0aee97038a86b.tar.gz";
      hash = "sha256-2wKecOJqtM207JIK7ZxhtpXkNa7LnFN86eHRWyfRjlg=";
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
