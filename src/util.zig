const std = @import("std");

pub fn safePrint(comptime fmt: []const u8, args: anytype) !void {
    std.debug.print(fmt, args);
    return;
}
