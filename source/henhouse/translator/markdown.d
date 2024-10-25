module henhouse.translator.markdown;

import file = std.file;
import uni  = std.uni;

import hhc   = henhouse.converter;
import hht_t = henhouse.translator.text;


/**
 * Markdown Translator.
 */
class Translator : hht_t.Translator
{
    override string translateText(string original)
    {
        char   current;
        string chicken;
        string buffer;

        for (int i = 0; i < original.length; i++) {
            current = original[i];

            if ('[' == current) {
                do {
                    chicken ~= original[i];
                    i++;
                }
                while (']' != original[i]);

                chicken ~= ']';

                if ('(' == original[i + 1]) {
                    i++;

                    do {
                        chicken ~= original[i];
                        i++;
                    }
                    while (')' != original[i]);

                    chicken ~= ')';
                }

                continue;
            }

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

        const string original = "Very Markdown! [uncoverted](link)";
        const string chicken  = "Chicken Chicken! [uncoverted](link)";

        assert(chicken == trans.translateText(original));
    }
}
