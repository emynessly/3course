namespace lab8;

public class ConsoleHud
{
    public void OnLevelChanged(
        BatteryMonitor sender,
        int level
    )
    {
        Console.WriteLine($"Уровень: {level}%");
    }

    public void OnCriticalLowReached(
        object? sender,
        int level
    )
    {
        Console.WriteLine(
            $"Низкий заряд: {level}% — включите энергосбережение"
        );
    }
}
