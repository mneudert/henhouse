module henhouse.translator.factory;

import path = std.path;
import str  = std.string;

import hht_h = henhouse.translator.html;
import hht_i = henhouse.translator.itranslator;
import hht_m = henhouse.translator.markdown;
import hht_t = henhouse.translator.text;


hht_i.ITranslator getTranslator(string filename)
{
    switch (str.toLower(path.extension(filename)))
    {
        case ".htm":
        case ".html":
            return new hht_h.Translator();

        case ".md":
        case ".markdown":
            return new hht_m.Translator();

        default:
            return new hht_t.Translator();
    }
}
