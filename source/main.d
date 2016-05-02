module main;

import io     = std.stdio;
import stdlib = core.stdc.stdlib;

import hhf = henhouse.file;


/**
 * Application entry point.
 *
 * Params:
 *      args    command line arguments
 */
void main(string[] args)
{
    if (3 != args.length) {
        printUsage(args);
        stdlib.exit((1 == args.length) ? 0 : 1);
    }

    hhf.translate(args[1], args[2]);
}

/**
 * Prints cli usage information.
 *
 * Params:
 *      args    command line arguments
 */
void printUsage(string[] args)
{
    io.writeln("Henhouse\n");
    io.writefln("Usage: %s INPUT_FILE OUTPUT_FILE", args[0]);
}
