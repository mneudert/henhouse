module main;

import io     = std.stdio;
import stdlib = std.c.stdlib;

import hhf = henhouse.file;


version(unittest)
{
    void main() {
        io.writeln("All Tests Successful!");
    }
}
else
{
    void main(string[] args)
    {
        io.writeln("Henhouse\n");

        if (3 != args.length) {
            printUsage(args);
            stdlib.exit(1);
        }

        hhf.translate(args[1], args[2]);
    }
}

void printUsage(string[] args)
{
    io.writefln("Usage: %s INPUT_FILE OUTPUT_FILE", args[0]);
}
