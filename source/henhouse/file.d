module henhouse.file;

import file   = std.file;
import io     = std.stdio;
import stdlib = core.stdc.stdlib;

import hhtf = henhouse.translator.factory;


/**
 * Translates a file.
 *
 * Wraps translateFile/2 with error handling and process output.
 *
 * Params:
 *      infile      file to read from
 *      outfile     file to write to
 */
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

/**
 * Translates a file.
 *
 * Params:
 *      infile      file to read from
 *      outfile     file to write to
 */
void translateFile(string infile, string outfile)
{
    auto   trans   = hhtf.getTranslator(infile);
    string chicken = trans.translateFile(infile);

    file.append(outfile, chicken);
}
