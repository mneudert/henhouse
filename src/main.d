module main;

import stdlib = std.c.stdlib : exit;

import file = std.file  : exists, readText;
import io   = std.stdio : writefln, writeln;
import uni  = std.uni   : isAlpha, isLower, isUpper, isWhite;

version(unittest)
{
    void main() {
        writeln("All Tests Successful!");
    }
}
else
{
    void main(char[][] args)
    {
        writeln("Henhouse\n");

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

void convert(char[] infile, char[] outfile)
{
    char[] original = cast(char[]) file.readText(infile);

    char   current;
    char[] chicken;
    char[] buffer;

    for (int i = 0; i < original.length; i++) {
        current = original[i];

        if (uni.isAlpha(current)) {
            buffer ~= current;
            continue;
        }

        if (0 < buffer.length) {
            chicken ~= toChicken(buffer);
            buffer   = "".dup;
        }

        chicken ~= current;
    }

    file.append(outfile, chicken);
}

void printUsage(char[][] args)
{
    io.writefln("Usage: %s INPUT_FILE OUTPUT_FILE", args[0]);
}

char[] toChicken(char[] original)
{
    char[] chicken;

    for (int i = 0; i < original.length; i++) {
        if (uni.isLower(original[i])) {
            chicken ~= "chicken".dup;

            while ((i + 1 < original.length) && uni.isLower(original[i + 1])) {
                i++;
            }

            continue;
        }

        if (uni.isUpper(original[i])) {
            if ((i + 1 == original.length) || uni.isLower(original[i + 1])) {
                chicken ~= "Chicken".dup;

                while ((i + 1 < original.length) && uni.isLower(original[i + 1])) {
                    i++;
                }

                continue;
            }

            if ((i + 1 == original.length) || uni.isUpper(original[i + 1])) {
                chicken ~= "CHICKEN".dup;

                while ((i + 1 < original.length) && uni.isUpper(original[i + 1])) {
                    i++;
                }
            }
        }
    }

    return chicken;
}
