using LoanRates.Context;

namespace LoanRates.EnumApproach;

public class InterestCalculatorEnum
{
    private const int MinRate = 0;

    public int Calculate(
        CreditBand band,
        LoanContext context)
    {
        int rate = GetBaseRate(band);

        if (band == CreditBand.GovGuaranteed)
        {
            return rate;
        }

        if (context.HasCollateral)
        {
            rate -= 3;
        }

        if (context.IsFirstTime)
        {
            rate += 2;
        }

        if (context.HasPromo)
        {
            rate -= 2;
        }

        return Math.Max(rate, MinRate);
    }

    private static int GetBaseRate(CreditBand band)
    {
        return band switch
        {
            CreditBand.A => 8,
            CreditBand.B => 12,
            CreditBand.C => 18,
            CreditBand.D => 25,
            CreditBand.GovGuaranteed => 3,
            _ => throw new ArgumentOutOfRangeException()
        };
    }
}