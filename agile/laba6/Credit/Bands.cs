using LoanRates.Context;

namespace LoanRates.OopApproach;

public class BandA : BorrowerBand
{
    public BandA() : base(8) { }

    public override int GetRate(LoanContext context)
    {
        return ApplyModifiers(BaseRate, context);
    }
}

public class BandB : BorrowerBand
{
    public BandB() : base(12) { }

    public override int GetRate(LoanContext context)
    {
        return ApplyModifiers(BaseRate, context);
    }
}

public class BandC : BorrowerBand
{
    public BandC() : base(18) { }

    public override int GetRate(LoanContext context)
    {
        return ApplyModifiers(BaseRate, context);
    }
}

public class BandD : BorrowerBand
{
    public BandD() : base(25) { }

    public override int GetRate(LoanContext context)
    {
        return ApplyModifiers(BaseRate, context);
    }
}