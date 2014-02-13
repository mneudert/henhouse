module henhouse.file;

import file   = std.file;
import io     = std.stdio;
import stdlib = std.c.stdlib;
import uni    = std.uni;

import hhc = henhouse.converter;


void translate(string infile, string outfile)
{
    if (!file.exists(infile)) {
        io.writefln("input file not found: %s", infile);
        stdlib.exit(1);
    }

    if (file.exists(outfile)) {
        io.writefln("output file already exists: %s", outfile);
        stdlib.exit(1);
    }

    io.writeln("converting to chickens...");
    translateFile(infile, outfile);
    io.writeln("done.");
}

void translateFile(string infile, string outfile)
{
    string original = cast(string) file.readText(infile);
    string chicken  = translateText(original);

    file.append(outfile, chicken);
}

string translateText(string original)
{
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

    return chicken;
}

unittest
{
    string original = "Much chicken! So convert!";
    string chicken  = "Chicken chicken! Chicken chicken!";

    assert(chicken == translateText(original));
}
