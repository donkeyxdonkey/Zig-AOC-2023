const std = @import("std");
const safePrint = @import("..\\util.zig").safePrint;

const data = @embedFile("..\\input\\day20.txt");

pub fn run(skip: bool) !void {
    if (skip)
        return;

    try safePrint("Day 20.\n", .{});
    try partOne(false);
    try partTwo(false);
}

fn partOne(debugPrint: bool) !void {
    var lines = std.mem.splitSequence(u8, data, "\n");
    var result: u32 = 0;
    _ = &lines;
    _ = &result;
    _ = &debugPrint;

    try safePrint("Result Part1: {}\n", .{result});
}

fn partTwo(debugPrint: bool) !void {
    var lines = std.mem.splitSequence(u8, data, "\n");
    var result: u32 = 0;
    _ = &lines;
    _ = &result;
    _ = &debugPrint;

    try safePrint("Result Part2: {}\n", .{result});
}
