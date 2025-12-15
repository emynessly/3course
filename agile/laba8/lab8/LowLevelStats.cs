namespace lab8;

public class LowLevelStats
{
    private const int LowLevelThreshold = 30;
    private int countBelow30;

    public void OnLevelChanged(
        BatteryMonitor sender,
        int level
    )
    {
        if (level < LowLevelThreshold)
        {
            countBelow30++;
        }
    }

    public void Report()
    {
        Console.WriteLine($"Ниже 30% было {countBelow30} раз(а)");
    }
}
