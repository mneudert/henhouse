module henhouse.translator.factory;

import hht_i = henhouse.translator.itranslator;
import hht_t = henhouse.translator.text;


hht_i.ITranslator getTranslator(string filename)
{
    return new hht_t.Translator();
}
