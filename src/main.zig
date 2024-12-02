const std = @import("std");

const day01 = @import("./day01/main.zig");

pub fn main() !void {
    std.debug.print("Welcome to AOC 2024. Zig Edition!!!\n\n", .{});

    std.debug.print("Day 01\n", .{});
    const day01_output = day01.execute();
    std.debug.print("Output: {s}\n\n", .{day01_output});
}
