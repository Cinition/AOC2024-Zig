const std = @import("std");

pub fn execute() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const buffer = try allocator.alloc(u8, 20000);
    defer allocator.free(buffer);

    const content = try std.fs.cwd().readFile("./input.txt", buffer);

    var leftList = std.ArrayList(u32).init(allocator);
    var rightList = std.ArrayList(u32).init(allocator);
    defer leftList.deinit();
    defer rightList.deinit();

    var lines = std.mem.tokenizeAny(u8, content, "\n");
    while (lines.next()) |line| {
        var numbers = std.mem.tokenizeAny(u8, line, " ");

        const leftNumber = try std.fmt.parseInt(u32, numbers.next().?, 10);
        const rightNumber = try std.fmt.parseInt(u32, numbers.next().?, 10);

        try leftList.append(leftNumber);
        try rightList.append(rightNumber);
    }

    std.mem.sort(u32, leftList.items, {}, std.sort.asc(u32));
    std.mem.sort(u32, rightList.items, {}, std.sort.asc(u32));

    var totalDistance: u32 = 0;

    for (0..leftList.items.len) |i| {
        const leftNumber: u32 = leftList.items[i];
        const rightNumber: u32 = rightList.items[i];

        totalDistance += @abs(leftNumber - rightNumber);
    }

    std.debug.print("Output: {}\n\n", .{totalDistance});
}
