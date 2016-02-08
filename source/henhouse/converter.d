module henhouse.converter;

import uni = std.uni;


string wordToChicken(string original)
{
    string chicken;

    for (int i = 0; i < original.length; i++) {
        if (uni.isLower(original[i])) {
            chicken ~= "chicken";

            while ((i + 1 < original.length) && uni.isLower(original[i + 1])) {
                i++;
            }

            continue;
        }

        if (uni.isUpper(original[i])) {
            if ((i + 1 == original.length) || uni.isLower(original[i + 1])) {
                chicken ~= "Chicken";

                while ((i + 1 < original.length) && uni.isLower(original[i + 1])) {
                    i++;
                }

                continue;
            }

            if ((i + 1 == original.length) || uni.isUpper(original[i + 1])) {
                chicken ~= "CHICKEN";

                while ((i + 1 < original.length) && uni.isUpper(original[i + 1])) {
                    i++;
                }
            }
        }
    }

    return chicken;
}

unittest
{
    assert("chicken" == wordToChicken("lowercase"));
    assert("Chicken" == wordToChicken("Capitalized"));
    assert("CHICKEN" == wordToChicken("UPPERCASE"));

    assert("chickenChicken" == wordToChicken("mixedCapitalized"));
    assert("ChickenChicken" == wordToChicken("MixedCapitalized"));
    assert("chickenCHICKEN" == wordToChicken("mixedCAPITALIZED"));
}
