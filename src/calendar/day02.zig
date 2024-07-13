const std = @import("std");
const safePrint = @import("..\\util.zig").safePrint;

const data = @embedFile("..\\input\\day02.txt");

const Color = enum { red, green, blue, korv };

const Game = struct {
    id: u32,
    red: u32,
    green: u32,
    blue: u32,
};

const limit = Game{
    .id = 0,
    .red = 12,
    .green = 13,
    .blue = 14,
};

pub fn run(skip: bool) !void {
    if (skip)
        return;

    try safePrint("Day 2.\n", .{});
    try partOne(false);
    try partTwo(true);
}

fn partOne(debugPrint: bool) !void {
    var lines = std.mem.splitSequence(u8, data, "\n");
    var result: u32 = 0;
    var id: u32 = 1;
    while (lines.next()) |line| : (id += 1) {
        result += try parseLine(line, id);
        if (debugPrint) {
            try safePrint("result {d}\n", .{result});
        }
    }

    try safePrint("Result Part1: {}\n", .{result});
}

fn parseLine(line: []const u8, id: u32) !u32 {
    var count: u32 = 0;
    var i: usize = 0;
    var x: usize = 0;

    var values = std.mem.splitScalar(u8, line, ':');
    while (values.next()) |segment| : (i += 1) {
        if (i == 0) // skippar game id som kommer via params
            continue;

        var bice = std.mem.splitScalar(u8, segment[1..], ';'); // splittar bort ;
        while (bice.next()) |leBice| {
            var kice = std.mem.splitScalar(u8, leBice, ','); // och ,
            while (kice.next()) |leKice| {
                var fice = std.mem.splitScalar(u8, std.mem.trim(u8, leKice, " "), ' ');
                while (fice.next()) |leFice| : (x += 1) { // [0]siffra [1]färg
                    if (x == 0) {
                        count = try std.fmt.parseInt(u32, leFice, 10);
                        continue;
                    }

                    switch (colorFromString(leFice)) {
                        Color.red => if (count > limit.red) return 0,
                        Color.green => if (count > limit.green) return 0,
                        Color.blue => if (count > limit.blue) return 0,
                        else => {},
                    }
                }
                x = 0;
            }
        }
    }

    return id;
}

fn partTwo(debugPrint: bool) !void {
    var lines = std.mem.splitSequence(u8, data, "\n");
    var result: u32 = 0;
    _ = &lines;
    _ = &result;
    _ = &debugPrint;

    try safePrint("Result Part2: {}\n", .{result});
}

fn colorFromString(s: []const u8) Color {
    if (std.mem.eql(u8, s, "red")) {
        return Color.red;
    }

    if (std.mem.eql(u8, s, "green")) {
        return Color.green;
    }

    if (std.mem.eql(u8, s, "blue")) {
        return Color.blue;
    }

    return Color.korv;
}
