namespace LoanRates.Context;

public class LoanContext
{
    public bool HasCollateral { get; }
    public bool IsFirstTime { get; }
    public bool HasPromo { get; }

    public LoanContext(
        bool hasCollateral,
        bool isFirstTime,
        bool hasPromo)
    {
        HasCollateral = hasCollateral;
        IsFirstTime = isFirstTime;
        HasPromo = hasPromo;
    }
}