module henhouse.translator.itranslator;


/**
 * Interface for individual translators.
 */
interface ITranslator
{
    /**
     * Reads a file and returns the converted contents.
     *
     * Params:
     *      filename    file to read from
     * Returns:
     *      converted contents
     */
    string translateFile(string filename);

    /**
     * Converts a string.
     *
     * Params:
     *      original    text to convert
     * Returns:
     *      converted text
     */
    string translateText(string original);
}
