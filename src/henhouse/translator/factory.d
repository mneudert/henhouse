module henhouse.translator.factory;

import str = std.string;

import hht_i = henhouse.translator.itranslator;
import hht_m = henhouse.translator.markdown;
import hht_t = henhouse.translator.text;


hht_i.ITranslator getTranslator(string filename)
{
    string ext;

    long posSlash = str.lastIndexOf(filename, '/');
    long posDot   = str.lastIndexOf(filename, '.');

    if (0 < posDot && posSlash < posDot) {
        ext = filename[(posDot + 1) .. $];
    }

    switch (str.toLower(ext))
    {
        case "md":
        case "markdown":
            return new hht_m.Translator();

        default:
            return new hht_t.Translator();
    }
}
