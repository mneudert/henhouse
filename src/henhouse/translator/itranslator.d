module hehouse.translator.itranslator;


interface ITranslator
{
    string translateFile(string filename);
    string translateText(string original);
}
