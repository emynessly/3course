namespace OopStart;
public class BasicTrack : ITrack
{
    private string title = string.Empty;
    private int durationSec;
    private int positionSec;

    public string Title
    {
        get => title;
        set => title = string.IsNullOrWhiteSpace(value) ? "Unknown" : value;
    }

    public int DurationSec
    {
        get => durationSec;
        set => durationSec = value < 0 ? 0 : value;
    }

    public int PositionSec
    {
        get => positionSec;
        set => positionSec = Math.Clamp(value, 0, DurationSec);
    }

    public BasicTrack(string title, int durationSec)
    {
        Title = title;
        DurationSec = durationSec;
        PositionSec = 0;
    }
}
