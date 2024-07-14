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

    // Each game is listed with its ID number
    // which games would have been possible if the bag contained only 12 red cubes, 13 green cubes, and 14 blue cubes?
    // What is the sum of the IDs of those games?
    try partOne(false);

    // what is the fewest number of cubes of each color that could have been in the bag to make the game possible?
    // The power of a set of cubes is equal to the numbers of red, green, and blue cubes multiplied together.
    // For each game, find the minimum set of cubes that must have been present.
    // What is the sum of the power of these sets?
    try partTwo(false);
}

fn partOne(debugPrint: bool) !void {
    var lines = std.mem.splitSequence(u8, data, "\n");
    var result: u32 = 0;
    var id: u32 = 1;
    while (lines.next()) |line| : (id += 1) {
        result += try parseLine1(line, id);
        if (debugPrint) {
            try safePrint("result {d}\n", .{result});
        }
    }

    try safePrint("Result Part1: {}\n", .{result});
}

fn parseLine1(line: []const u8, id: u32) !u32 {
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

    while (lines.next()) |line| {
        result += try parseLine2(line);
        if (debugPrint) {
            try safePrint("result {d}\n", .{result});
        }
    }

    try safePrint("Result Part2: {}\n", .{result});
}

fn parseLine2(line: []const u8) !u32 {
    var count: u32 = 0;
    var i: usize = 0;
    var x: usize = 0;

    var game = Game{ .id = 0, .red = 0, .green = 0, .blue = 0 };

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
                        Color.red => {
                            if (count > game.red) game.red = count;
                        },
                        Color.green => {
                            if (count > game.green) game.green = count;
                        },
                        Color.blue => {
                            if (count > game.blue) game.blue = count;
                        },
                        else => {
                            try safePrint("{b}", .{leFice}); // byte skräp print om ej enum parsear ... 1101 = \r
                        },
                    }
                }
                x = 0;
            }
        }
    }

    return game.red * game.green * game.blue;
}

fn colorFromString(s: []const u8) Color {
    const deJunk = std.mem.trim(u8, s, "\r\n ");
    if (std.mem.eql(u8, deJunk, "red")) {
        return Color.red;
    }

    if (std.mem.eql(u8, deJunk, "green")) {
        return Color.green;
    }

    if (std.mem.eql(u8, deJunk, "blue")) {
        return Color.blue;
    }

    return Color.korv;
}
