using lab8;
static class Program
{
    static void Main()
    {
        var monitor = new BatteryMonitor(
            startLevel: 100,
            seed: 7);

        var hud = new ConsoleHud();
        var stats = new LowLevelStats();

        monitor.LevelChanged += hud.OnLevelChanged;
        monitor.LevelChanged += stats.OnLevelChanged;

        monitor.CriticalLowReached += hud.OnCriticalLowReached;

        Console.WriteLine("Старт мониторинга батареи\n");

        monitor.Start(steps: 10);

        Console.WriteLine("\nОтписываем HUD от критического события\n");

        monitor.CriticalLowReached -= hud.OnCriticalLowReached;

        Console.WriteLine("\nСтатистика:");

        stats.Report();
    }
}