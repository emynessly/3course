using System;
using LoanRates.Context;
using LoanRates.EnumApproach;
using LoanRates.OopApproach;

class Program
{
    static void Main()
    {
        var context = new LoanContext(
            hasCollateral: true,
            isFirstTime: false,
            hasPromo: false
        );

        Console.WriteLine("Данные кредита:");
        Console.WriteLine($"Имеет залог: {(context.HasCollateral ? "да" : "нет")}");
        Console.WriteLine($"Первый раз: {(context.IsFirstTime ? "да" : "нет")}");
        Console.WriteLine($"Промо-ставка: {(context.HasPromo ? "да" : "нет")}");

        PrintHeader("Часть A — enum + switch");

        var enumCalc = new InterestCalculatorEnum();

        foreach (CreditBand band in Enum.GetValues(typeof(CreditBand)))
        {
            int enumRate = enumCalc.Calculate(band, context);
            Console.WriteLine($"{band}: {enumRate}%");
        }

        PrintHeader("Часть B — Иерархия классов");

        var oopCalc = new InterestCalculatorOop();

        BorrowerBand[] bands = new BorrowerBand[]
        {
            new BandA(),
            new BandB(),
            new BandC(),
            new BandD(),
            new GovGuaranteed()
        };

        foreach (var b in bands)
        {
            int oopRate = oopCalc.Calculate(b, context);
            Console.WriteLine($"{b.GetType().Name}: {oopRate}%");
        }
    }

    static void PrintHeader(string title)
    {
        Console.WriteLine();
        Console.WriteLine("----------------------------");
        Console.WriteLine(title);
        Console.WriteLine("----------------------------");
    }
}