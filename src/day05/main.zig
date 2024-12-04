const std = @import("std");

var allocator: std.mem.Allocator = undefined;

pub fn execute() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    allocator = gpa.allocator();

    const buffer = try allocator.alloc(u8, 20000);
    defer allocator.free(buffer);

    const content = try std.fs.cwd().readFile("src/dayXX/input.txt", buffer);

    std.debug.print("Problem 1 output: {d}\n\n", .{try problem1(content)});
    std.debug.print("Problem 2 output: {d}\n\n", .{try problem2(content)});
}

fn problem1(data: []const u8) !i32 {
    var leftList = std.ArrayList(i32).init(allocator);
    var rightList = std.ArrayList(i32).init(allocator);
    defer leftList.deinit();
    defer rightList.deinit();

    _ = data;

    return 0;
}

fn problem2(data: []const u8) !i32 {
    var leftList = std.ArrayList(i32).init(allocator);
    var rightList = std.ArrayList(i32).init(allocator);
    defer leftList.deinit();
    defer rightList.deinit();

    _ = data;

    return 0;
}
