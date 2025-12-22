using LoanRates.Context;

namespace LoanRates.OopApproach;

public class GovGuaranteed : BorrowerBand
{
    public GovGuaranteed() : base(3) { }

    public override int GetRate(LoanContext context)
    {
        return BaseRate;
    }
}