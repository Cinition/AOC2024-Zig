const std = @import("std");

var allocator: std.mem.Allocator = undefined;

pub fn execute() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    allocator = gpa.allocator();

    const buffer = try allocator.alloc(u8, 20000);
    defer allocator.free(buffer);

    const content = try std.fs.cwd().readFile("src/day03/input.txt", buffer);

    std.debug.print("Problem 1 output: {d}\n\n", .{try problem1(content)});
    std.debug.print("Problem 2 output: {d}\n\n", .{try problem2(content)});
}

fn problem1(data: []const u8) !i32 {
    var value: i32 = 0;
    var offset: usize = 0;
    outer: while (std.mem.indexOfPos(u8, data, offset, "mul(")) |pos| {
        offset = pos + 1;
        var localOffset = pos;

        localOffset += 4; // offset "mul("
        var commaPos: usize = 0;
        if (std.mem.indexOfPos(u8, data, localOffset, ",")) |index| {
            commaPos = index;
        } else {
            continue :outer;
        }

        std.debug.print("localOffset:{} | commaPos:{}\n", .{ localOffset, commaPos });
        std.debug.print("LocalOffset Char:{c} | commaPos Char:{c}\n", .{ data[localOffset], data[commaPos] });

        const var1Slice = data[localOffset..commaPos];
        const variable1 = std.fmt.parseInt(i32, var1Slice, 10) catch {
            continue :outer;
        };

        localOffset += var1Slice.len + 1; // offset var1 and ','
        var closingPos: usize = 0;
        if (std.mem.indexOfPos(u8, data, localOffset, ")")) |index| {
            closingPos = index;
        } else {
            continue :outer;
        }

        std.debug.print("localOffset:{} | closingPos:{}\n", .{ localOffset, closingPos });
        std.debug.print("LocalOffset Char:{c} | closingPos Char:{c}\n", .{ data[localOffset], data[closingPos] });

        const var2Slice = data[localOffset..closingPos];
        const variable2 = std.fmt.parseInt(i32, var2Slice, 10) catch {
            continue :outer;
        };

        std.debug.print("mul({},{})\n", .{ variable1, variable2 });
        value += (variable1 * variable2);
    }

    return value;
}

fn problem2(data: []const u8) !i32 {
    _ = data;
    return 0;
}
