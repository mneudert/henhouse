module henhouse.translator.html;

import file = std.file;
import uni  = std.uni;

import hhc   = henhouse.converter;
import hht_t = henhouse.translator.text;


class Translator : hht_t.Translator
{
    override string translateText(string original)
    {
        char   current;
        string chicken;
        string buffer;

        for (int i = 0; i < original.length; i++) {
            current = original[i];

            if ('<' == current) {
                if (0 < buffer.length) {
                    chicken ~= hhc.wordToChicken(buffer);
                    buffer   = "";
                }

                do {
                    chicken ~= original[i];
                    i++;
                }
                while ('>' != original[i]);

                chicken ~= '>';
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
        string original  = "<html><body><h1>HTML</h1><p>Converted text!</p></body></html>";
        string chicken   = "<html><body><h1>CHICKEN</h1><p>Chicken chicken!</p></body></html>";

        assert(chicken == trans.translateText(original));
    }
}
