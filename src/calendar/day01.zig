const std = @import("std");
const safePrint = @import("..\\util.zig").safePrint;

const data = @embedFile("..\\input\\day01.txt");

const numbers = [_][]const u8{ "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" };

pub fn run(skip: bool) !void {
    if (skip)
        return;

    try safePrint("Day 1.\n", .{});

    // On each line, the calibration value can be found by combining the first digit and the last digit (in that order) to form a single two-digit number.
    // Consider your entire calibration document. What is the sum of all of the calibration values?
    try partOne(false);

    // It looks like some of the digits are actually spelled out with letters: one, two ...
    // you now need to find the real first and last digit on each line
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
            start = @intCast(line[i] - '0'); // lägg på minnet värdelös konvention som borde ha bättre alternativ
            break;
        }

        const slice = line[i..];
        for (numbers, 0..) |n, j| {
            if (std.mem.startsWith(u8, slice, n)) {
                start = @intCast(j + 1); // + för 0-index array
                break :outer;
            }
        }
    }

    start *= 10;
    var end: u32 = 0;

    var i: usize = line.len - 1;
    outer: while (i >= 0) : (i -= 1) {
        if (std.ascii.isDigit(line[i])) {
            end = @intCast(line[i] - '0'); // lägg på minnet värdelös konvention som borde ha bättre alternativ
            break;
        }

        const slice = line[i..];
        for (numbers, 0..) |n, j| {
            if (std.mem.startsWith(u8, slice, n)) {
                end = @intCast(j + 1); // + för 0-index array
                break :outer;
            }
        }
    }

    return start + end;
}
