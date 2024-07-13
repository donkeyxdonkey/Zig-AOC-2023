const std = @import("std");
const safePrint = @import("..\\util.zig").safePrint;

const data = @embedFile("..\\input\\day01.txt");

const numbers = [_][]const u8{ "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" };

pub fn run(skip: bool) !void {
    if (skip)
        return;

    try safePrint("Day 1.\n", .{});
    try partOne(false);
    try partTwo(false);
}

fn partOne(debugPrint: bool) !void {
    var lines = std.mem.splitSequence(u8, data, "\n");
    var result: u32 = 0;
    while (lines.next()) |line| {
        result += try calcLine1(line);
        if (debugPrint) {
            try safePrint("{} result {s}\n", .{ result, line });
        }
    }

    try safePrint("Result Part1: {}\n", .{result});
}

fn calcLine1(line: []const u8) !u32 {
    var value = [_]u8{ '0', '0' };
    var firstSet = false;

    for (line) |char| {
        if (std.ascii.isDigit(char)) {
            if (!firstSet) {
                value[0] = char;
                firstSet = true;
            }
            value[1] = char;
        }
    }

    return try std.fmt.parseInt(u32, &value, 10);
}

fn partTwo(debugPrint: bool) !void {
    var lines = std.mem.splitSequence(u8, data, "\n");
    var result: u32 = 0;

    while (lines.next()) |line| {
        result += try calcLine2(line);
        if (debugPrint)
            try safePrint("{} result {s}\n", .{ result, line });
    }

    try safePrint("Result Part2: {}\n", .{result});
}

fn calcLine2(line: []const u8) !u32 {
    var start: u32 = 0;

    outer: for (0..line.len) |i| {
        if (std.ascii.isDigit(line[i])) {
            start = @intCast(line[i] - '0');
            break;
        }

        const slice = line[i..];
        for (numbers, 0..) |n, j| {
            if (std.mem.startsWith(u8, slice, n)) {
                start = @intCast(j + 1); // + för 0 index
                break :outer;
            }
        }
    }

    start *= 10;
    var end: u32 = 0;

    var i: usize = line.len - 1;
    outer: while (i >= 0) : (i -= 1) {
        if (std.ascii.isDigit(line[i])) {
            end = @intCast(line[i] - '0');
            break;
        }

        const slice = line[i..];
        for (numbers, 0..) |n, j| {
            if (std.mem.startsWith(u8, slice, n)) {
                end = @intCast(j + 1); // + för 0 index
                break :outer;
            }
        }
    }

    return start + end;
}
