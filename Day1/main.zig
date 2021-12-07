const std = @import("std");

const page_alloc = std.heap.page_allocator;
const data = @embedFile("input");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    var nums = std.ArrayList(u32).init(page_alloc);
    var tok = std.mem.tokenize(data, "\n");
    var increases: u32 = 0;

    while (tok.next()) |token| {
        //try stdout.print("The index {d}\n", .{tok.index});
        //This solution is better, just too lazy to figure it out. TODO:Figure this out!
        //const token_int = try std.fmt.parseUnsigned(u32, token, 10);
        //const next_int = if (tok.next()?) |token_nxt| try std.fmt.parseUnsigned(u32, token_nxt, 10);

        //increases = if (token_int < next_int) increases + 1 else increases;
        try nums.append(try std.fmt.parseUnsigned(u32, token, 10));
    }

    // Part 1
    for (nums.items) |num, index| {
        if (index > 0) {
            increases += if (num > nums.items[index - 1]) @as(u32, 1) else @as(u32, 0);
            //if (num > nums.items[index - 1]) {
            //    increases += 1;
            //}
        }
    }

    try stdout.print("There are {d} individual increases!\n", .{increases});

    // Part 2
    increases = 0;
    var sum1: u32 = 0;
    var sum2: u32 = 0;
    for (nums.items) |num, index| {
        if (index > 0 and index + 2 < nums.items.len) {
            sum1 = num + nums.items[index + 1] + nums.items[index + 2];
            sum2 = nums.items[index - 1] + num + nums.items[index + 1];
            increases += if (sum1 > sum2) @as(u32, 1) else @as(u32, 0);
        }
    }

    try stdout.print("There are {d} three-measurment increases!\n", .{increases});
}
