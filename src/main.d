module main;

import stdlib = std.c.stdlib;

import file = std.file;
import io   = std.stdio;
import uni  = std.uni;

import hhc = henhouse.converter;


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

        if (!file.exists(args[1])) {
            io.writefln("input file not found: %s", args[1]);
            stdlib.exit(1);
        }

        if (file.exists(args[2])) {
            io.writefln("output file already exists: %s", args[2]);
            stdlib.exit(1);
        }

        io.writeln("converting to chickens...");
        convert(args[1], args[2]);
        io.writeln("done.");
    }
}

void convert(string infile, string outfile)
{
    string original = cast(string) file.readText(infile);

    char   current;
    string chicken;
    string buffer;

    for (int i = 0; i < original.length; i++) {
        current = original[i];

        if (uni.isAlpha(current)) {
            buffer ~= current;
            continue;
        }

        if (0 < buffer.length) {
            chicken ~= hhc.wordToChicken(buffer);
            buffer   = "";
        }

        chicken ~= current;
    }

    file.append(outfile, chicken);
}

void printUsage(string[] args)
{
    io.writefln("Usage: %s INPUT_FILE OUTPUT_FILE", args[0]);
}
