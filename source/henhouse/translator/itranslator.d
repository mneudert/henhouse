module henhouse.translator.itranslator;


interface ITranslator
{
    string translateFile(string filename);
    string translateText(string original);
}
