const std = @import("std");

var allocator: std.mem.Allocator = undefined;

pub fn execute() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    allocator = gpa.allocator();

    const buffer = try allocator.alloc(u8, 20000);
    defer allocator.free(buffer);

    const content = try std.fs.cwd().readFile("src/day01/input.txt", buffer);

    std.debug.print("Problem 1 output: {d}\n\n", .{try problem1(content)});
    std.debug.print("Problem 2 output: {d}\n\n", .{try problem2(content)});
}

fn problem1(data: []const u8) !i32 {
    var leftList = std.ArrayList(i32).init(allocator);
    var rightList = std.ArrayList(i32).init(allocator);
    defer leftList.deinit();
    defer rightList.deinit();

    var lines = std.mem.tokenizeAny(u8, data, "\r\n");
    while (lines.next()) |line| {
        var numbers = std.mem.tokenizeAny(u8, line, "   ");
        const leftInput = numbers.next().?;
        const rightInput = numbers.next().?;

        const leftNumber = try std.fmt.parseInt(i32, leftInput, 10);
        const rightNumber = try std.fmt.parseInt(i32, rightInput, 10);

        try leftList.append(leftNumber);
        try rightList.append(rightNumber);
    }

    std.mem.sort(i32, leftList.items, {}, std.sort.asc(i32));
    std.mem.sort(i32, rightList.items, {}, std.sort.asc(i32));

    var totalDistance: i32 = 0;

    for (0..leftList.items.len) |i| {
        const leftNumber: i32 = leftList.items[i];
        const rightNumber: i32 = rightList.items[i];
        const value: i32 = @bitCast(@abs(leftNumber - rightNumber));

        totalDistance += value;
    }

    return totalDistance;
}

fn problem2(data: []const u8) !i32 {
    var leftList = std.ArrayList(i32).init(allocator);
    var rightList = std.ArrayList(i32).init(allocator);
    defer leftList.deinit();
    defer rightList.deinit();

    var lines = std.mem.tokenizeAny(u8, data, "\r\n");
    while (lines.next()) |line| {
        var numbers = std.mem.tokenizeAny(u8, line, "   ");
        const leftInput = numbers.next().?;
        const rightInput = numbers.next().?;

        const leftNumber = try std.fmt.parseInt(i32, leftInput, 10);
        const rightNumber = try std.fmt.parseInt(i32, rightInput, 10);

        try leftList.append(leftNumber);
        try rightList.append(rightNumber);
    }

    var totalDistance: i32 = 0;

    for (0..leftList.items.len) |i| {
        var num: i32 = 0;
        for (rightList.items) |item| {
            if (item == leftList.items[i]) {
                num += 1;
            }
        }
        totalDistance += leftList.items[i] * num;
    }

    return totalDistance;
}
