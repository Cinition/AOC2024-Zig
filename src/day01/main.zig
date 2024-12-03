const std = @import("std");

pub fn execute() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const buffer = try allocator.alloc(u8, 20000);
    defer allocator.free(buffer);

    const content = try std.fs.cwd().readFile("src/day01/input.txt", buffer);

    var leftList = std.ArrayList(i32).init(allocator);
    var rightList = std.ArrayList(i32).init(allocator);
    defer leftList.deinit();
    defer rightList.deinit();

    var lines = std.mem.tokenizeAny(u8, content, "\r\n");
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

    var totalDistance: u32 = 0;

    for (0..leftList.items.len) |i| {
        const leftNumber: i32 = leftList.items[i];
        const rightNumber: i32 = rightList.items[i];

        totalDistance += @abs(leftNumber - rightNumber);
    }

    std.debug.print("Output: {}\n\n", .{totalDistance});
}
