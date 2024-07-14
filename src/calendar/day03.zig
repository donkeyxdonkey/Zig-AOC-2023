const std = @import("std");
const safePrint = @import("..\\util.zig").safePrint;

const data = @embedFile("..\\input\\day03.txt");

pub fn run(skip: bool) !void {
    if (skip)
        return;

    try safePrint("Day 3.\n", .{});

    // The engineer explains that an engine part seems to be missing from the engine
    // If you can add up all the part numbers in the engine schematic, it should be easy to work out which part is missing.
    // any number adjacent to a symbol, even diagonally, is a "part number" and should be included in your sum.
    // (Periods (.) do not count as a symbol.)
    // What is the sum of all of the part numbers in the engine schematic?
    try partOne(false);

    //
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
