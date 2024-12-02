const std = @import("std");

const day01 = @import("./day01/main.zig");

pub fn main() !void {
    std.debug.print("Welcome to AOC 2024. Zig Edition!!!\n\n", .{});

    std.debug.print("Day 01\n", .{});
    try day01.execute();
}
