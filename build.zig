const std = @import("std");
const rlz = @import("raylib-zig");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const raylib_dep = b.dependency("raylib-zig", .{
        .target = target,
        .optimize = optimize,
        .linux_display_backend = .Wayland,
    });

    const raylib = raylib_dep.module("raylib");
    const raylib_artifact = raylib_dep.artifact("raylib");

    const exe = b.addExecutable(.{ .name = "dvd", .root_source_file = b.path("src/main.zig"), .optimize = optimize, .target = target });

    exe.linkLibrary(raylib_artifact);
    exe.root_module.addImport("raylib", raylib);

    const run_cmd = b.addRunArtifact(exe);
    const run_step = b.step("run", "Run dvd");
    run_step.dependOn(&run_cmd.step);

    b.installArtifact(exe);
}
