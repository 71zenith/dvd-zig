// zig fmt: off
const rl = @import("raylib");
const rm = @import("raylib-math");
const std = @import("std");

pub fn getRandomColor() rl.Color {
    return rl.Color{
        .r = @intCast(rl.getRandomValue(100, 255)),
        .g = @intCast(rl.getRandomValue(100, 255)),
        .b = @intCast(rl.getRandomValue(100, 255)),
        .a = @as(u8, 255)
    };
}

pub fn main() anyerror!void {
    const screenWidth = 1920;
    const screenHeight = 1080;

    rl.initWindow(screenWidth, screenHeight, "raylib-zig dvd animation");
    defer rl.closeWindow();

    rl.setTargetFPS(74);
    rl.toggleFullscreen();
    defer rl.toggleFullscreen();
    rl.hideCursor();
    std.debug.print("Size: {}", .{rl.getScreenWidth()});

    var logo: rl.Texture = undefined;
    const logofile = "/usr/share/dvd/logo.png";
    if (rl.fileExists(logofile)) {
        logo = rl.loadTexture(logofile);
    } else {
        logo = rl.loadTexture("logo.png");
    }
    defer rl.unloadTexture(logo);

    const logoWidth: f32 = @floatFromInt(logo.width);
    const logoHeight: f32 = @floatFromInt(logo.height);
    const logoScale: f32 = 0.1;

    var playerPos = rl.Vector2{
        .x = @floatFromInt(rl.getRandomValue(screenWidth * 1/4, screenWidth * 3/4)),
        .y = @floatFromInt(rl.getRandomValue(screenHeight * 1/4, screenHeight * 3/4)),
    };

    var playerVel = rl.Vector2{ .x = 200, .y = 250 };

    var randomColor = getRandomColor();


    outer: while (!rl.windowShouldClose()) {
        // ---- LOGIC ---- //
        const dt = rl.getFrameTime();
        playerPos.x += playerVel.x * dt;
        playerPos.y += playerVel.y * dt;

        if (playerPos.x < 0 or (playerPos.x + (logoWidth * logoScale)) > @as(f32, screenWidth)) {
            playerVel.x *= -1;
            randomColor = getRandomColor();
        }
        if (playerPos.y < 0 or (playerPos.y + (logoHeight * logoScale)) > @as(f32, screenHeight)) {
            playerVel.y *= -1;
            randomColor = getRandomColor();
        }

        if (rl.getKeyPressed() != rl.KeyboardKey.key_null or rm.vector2Equals(rl.getMouseDelta(), rl.Vector2{ .x = 0, .y = 0 } ) != 1 ) {
            // TODO: detect mouse input 100%
            // hyprland does weird shit with mouse. need a delay
            // std.debug.print("NOT THIS AGAIN {} \n {}\n", .{rl.getKeyPressed() , rl.getMouseDelta()});
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
