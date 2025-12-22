using LoanRates.Context;

namespace LoanRates.OopApproach;

public class InterestCalculatorOop
{
    public int Calculate(
        BorrowerBand band,
        LoanContext context)
    {
        return band.GetRate(context);
    }
}