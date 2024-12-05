const std = @import("std");

const day01 = @import("./day01/main.zig");
const day02 = @import("./day02/main.zig");
const day03 = @import("./day03/main.zig");

pub fn main() !void {
    std.debug.print("Welcome to AOC 2024. Zig Edition!!!\n\n", .{});

    std.debug.print("Day 01\n", .{});
    try day01.execute();

    std.debug.print("Day 02\n", .{});
    try day02.execute();

    std.debug.print("Day 03\n", .{});
    try day03.execute();
}
