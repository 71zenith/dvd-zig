// zig fmt: off
const rl = @import("raylib");
const rm = rl.math;
const std = @import("std");

pub fn getRandomColor() rl.Color {
    return rl.Color{
        .r = @intCast(rl.getRandomValue(100, 255)),
        .g = @intCast(rl.getRandomValue(100, 255)),
        .b = @intCast(rl.getRandomValue(100, 255)),
        .a = @as(u8, 255) };
}

pub fn main() anyerror!void {
    rl.initWindow(0, 0, "raylib-zig dvd animation");
    defer rl.closeWindow();

    const mon = rl.getCurrentMonitor();

    const screenWidth = rl.getMonitorWidth(mon);
    const screenHeight = rl.getMonitorHeight(mon);
    rl.setWindowSize(screenWidth, screenHeight);

    std.debug.print("THIS IMP = {}", .{rl.getMonitorCount()});

    rl.setTargetFPS(74);
    rl.hideCursor();
    rl.toggleFullscreen();
    const allocator = std.heap.page_allocator;

    const exe_dir = try std.fs.selfExeDirPathAlloc(allocator);
    defer allocator.free(exe_dir);

    const logofile = try std.fmt.allocPrint(allocator, "{s}/../share/dvd/logo.png", .{exe_dir});
    defer allocator.free(logofile);

    var mem = try allocator.alloc(u8, logofile.len + 1);
    defer allocator.free(mem);

    @memcpy(mem[0..logofile.len], logofile);
    mem[logofile.len] = 0;

    var logo: rl.Texture = undefined;
    if (rl.fileExists(mem[0..logofile.len :0])) {
        logo = rl.loadTexture(mem[0..logofile.len :0]);
    } else {
        logo = rl.loadTexture("logo.png");
    }
    defer rl.unloadTexture(logo);

    const logoWidth: f32 = @floatFromInt(logo.width);
    const logoHeight: f32 = @floatFromInt(logo.height);
    const logoScale: f32 = 0.1;

    var playerPos = rl.Vector2{
        .x = @floatFromInt(rl.getRandomValue(screenWidth * @as(i32, @intCast(1 / 4)), screenWidth * @as(i32, @intCast(1 / 4)))),
        .y = @floatFromInt(rl.getRandomValue(screenHeight * @as(i32, @intCast(1 / 4)), screenHeight * @as(i32, @intCast(1 / 4)))),
    };

    var playerVel = rl.Vector2{ .x = 200, .y = 200 };

    var randomColor = getRandomColor();

    outer: while (!rl.windowShouldClose()) {
        // ---- LOGIC ---- //
        const dt = rl.getFrameTime();
        playerPos.x += playerVel.x * dt;
        playerPos.y += playerVel.y * dt;

        if (playerPos.x < 0 or (playerPos.x + (logoWidth * logoScale)) > @as(f32, @floatFromInt(screenWidth))) {
            playerVel.x *= -1;
            randomColor = getRandomColor();
        }
        if (playerPos.y < 0 or (playerPos.y + (logoHeight * logoScale)) > @as(f32, @floatFromInt(screenHeight))) {
            playerVel.y *= -1;
            randomColor = getRandomColor();
        }

        if (rl.getKeyPressed() != rl.KeyboardKey.key_null or
            rm.vector2Equals(rl.getMouseDelta(), rl.Vector2{ .x = 0, .y = 0 }) != 1)
        {
            if (rl.getTime() > 0.5) {
                break :outer;
            }
        }

        // ---- DRAW ---- //
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.drawTextureEx(logo, playerPos, 0, logoScale, randomColor);
        rl.clearBackground(rl.Color.black);
    }
}
