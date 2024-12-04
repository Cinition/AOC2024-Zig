const std = @import("std");

var allocator: std.mem.Allocator = undefined;

pub fn execute() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    allocator = gpa.allocator();

    const buffer = try allocator.alloc(u8, 25000);
    defer allocator.free(buffer);

    const content = try std.fs.cwd().readFile("src/day02/input.txt", buffer);

    std.debug.print("Problem 1 output: {d}\n\n", .{try problem1(content)});
    std.debug.print("Problem 2 output: {d}\n\n", .{try problem2(content)});
}

fn problem1(data: []const u8) !i32 {
    var safeReports: i32 = 0;

    var lines = std.mem.tokenizeAny(u8, data, "\r\n");
    outer: while (lines.next()) |line| {
        var levels = std.mem.tokenizeAny(u8, line, " ");

        var lastValue: i32 = undefined;
        var increasingIndex: u32 = 0;
        var decreasingIndex: u32 = 0;

        var i: u32 = 0;
        while (levels.next()) |level| : (i += 1) {
            const value: i32 = try std.fmt.parseInt(i32, level, 10);
            const difference = @abs(lastValue - value);

            if (i == 0) {
                lastValue = value;
                continue;
            }

            switch (difference) {
                1...3 => {},
                else => {
                    continue :outer;
                },
            }

            if (value > lastValue) {
                decreasingIndex += 1;
            }

            if (value < lastValue) {
                increasingIndex += 1;
            }

            if (increasingIndex > 0 and decreasingIndex > 0) {
                continue :outer;
            }

            lastValue = value;
        }
        safeReports += 1;
    }

    return safeReports;
}

fn problem2(data: []const u8) !i32 {
    _ = data;
    const safeReports: i32 = 0;
    return safeReports;
}
