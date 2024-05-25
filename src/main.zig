// zig fmt: off
const rl = @import("raylib");

pub fn getRandomColor() rl.Color {
    return rl.Color{
        .r = @intCast(rl.getRandomValue(100, 255)),
        .g = @intCast(rl.getRandomValue(100, 255)),
        .b = @intCast(rl.getRandomValue(100, 255)),
        .a = @as(u8, 255)
    };
}

pub fn main() anyerror!void {
    const screenWidth = 800;
    const screenHeight = 450;

    rl.initWindow(screenWidth, screenHeight, "raylib-zig dvd animation");
    rl.toggleFullscreen();
    defer rl.closeWindow();
    rl.setTargetFPS(60);

    const logo = rl.loadTexture("logo.png");
    defer rl.unloadTexture(logo);

    var playerPos = rl.Vector2{ .x = 0, .y = 0 };
    var playerVel = rl.Vector2{ .x = 50, .y = 50 };

    var randomColor = getRandomColor();

    const logoWidth: f32 = @floatFromInt(logo.width);
    const logoHeight: f32 = @floatFromInt(logo.height);

    while (!rl.windowShouldClose()) {
        const dt = rl.getFrameTime();
        playerPos.x += playerVel.x * dt;
        playerPos.y += playerVel.y * dt;

        if (playerPos.x < 0 or (playerPos.x + (logoWidth * 0.1)) > @as(f32, screenWidth)) {
            playerVel.x *= -1;
            randomColor = getRandomColor();
        }
        if (playerPos.y < 0 or (playerPos.y + (logoHeight * 0.1)) > @as(f32, screenHeight)) {
            playerVel.y *= -1;
            randomColor = getRandomColor();
        }
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.drawTextureEx(logo, playerPos, 0, 0.1, randomColor);
        rl.clearBackground(rl.Color.black);

        // rl.drawFPS(50, 50);
        //rl.drawText("Congrats! You created your first window!", 190, 200, 20, rl.Color.light_gray);
    }
}
