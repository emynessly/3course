namespace lab8;

public class BatteryMonitor
{
    public delegate void BatteryEventHandler(
        BatteryMonitor sender, 
        int level);

    public event BatteryEventHandler? LevelChanged;

    private EventHandler<int>? criticalHandlers;

    public event EventHandler<int> CriticalLowReached
    {
        add
        {
            criticalHandlers += value;
            Console.WriteLine("CriticalLowReached: подписчик добавлен");
        }
        remove
        {
            criticalHandlers -= value;
            Console.WriteLine("CriticalLowReached: подписчик удалён");
        }
    }
    
    private readonly Random random;
    private int level;

    public int Level => level;

    public BatteryMonitor(int startLevel, int seed)
    {
        if (startLevel < 5 || startLevel > 100)
            throw new ArgumentOutOfRangeException(
                nameof(startLevel));

        level = startLevel;
        random = new Random(seed);
    }
    
    public void Start(int steps)
    {
        if (steps < 1)
            throw new ArgumentOutOfRangeException(
                nameof(steps));

        for (int i = 0; i < steps; i++)
        {
            int step = random.Next(6, 17);
            int next = level - step;

            if (next < 5)
                next = 5;

            level = next;

            LevelChanged?.Invoke(this, level);

            if (level < 15)
                criticalHandlers?.Invoke(this, level);
        }
    }
}