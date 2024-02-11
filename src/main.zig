const std = @import("std");
const io = std.io;
const fmt = std.fmt;
const RndGen = std.rand.DefaultPrng;
const time = std.time;

pub fn main() !void {
    const stdout = io.getStdOut().writer();
    const stdin = io.getStdIn();

    try stdout.print("Guess the number!!\n", .{});
    try stdout.print("Please input your guess.\n", .{});

    var line_buf: [20]u8 = undefined;

    var rnd = RndGen.init(@intCast(time.milliTimestamp()));
    const random_num = @mod(rnd.random().int(i32), 100);

    // try stdout.print("The secret number is: {}\n", .{random_num});

    while (true) {
        const amt = try stdin.read(&line_buf);
        if (amt == line_buf.len) {
            try stdout.print("Input too long.\n", .{});
        }
        const line = std.mem.trimRight(u8, line_buf[0..amt], "\r\n");
        const user_input = try fmt.parseInt(u128, line, 10);
        if (random_num > user_input) {
            try stdout.print("Too small!!\n", .{});
        } else if (random_num < user_input) {
            try stdout.print("Too big!!\n", .{});
        } else if (random_num == user_input) {
            try stdout.print("You win!!\n", .{});
            return;
        }
    }
}
