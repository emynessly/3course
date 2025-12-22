using LoanRates.Context;

namespace LoanRates.OopApproach;

public abstract class BorrowerBand
{
    private readonly int baseRate;

    protected BorrowerBand(int baseRate)
    {
        this.baseRate = baseRate;
    }

    public int BaseRate => baseRate;

    public virtual int GetRate(LoanContext context)
    {
        return BaseRate;
    }

    protected static int ApplyModifiers(
        int rate,
        LoanContext context)
    {
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

        return Math.Max(rate, 0);
    }
}