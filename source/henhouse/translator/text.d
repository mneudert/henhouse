module henhouse.translator.text;

import file = std.file;
import uni  = std.uni;

import hhc   = henhouse.converter;
import hht_i = henhouse.translator.itranslator;


/**
 * Plaintext Translator.
 */
class Translator : hht_i.ITranslator
{
    string translateFile(string filename)
    {
        string original = cast(string) file.readText(filename);

        return translateText(original);
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
        Translator trans = new Translator();
        string original  = "Much chicken! So convert!";
        string chicken   = "Chicken chicken! Chicken chicken!";

        assert(chicken == trans.translateText(original));
    }
}
