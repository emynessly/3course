namespace OopStart;
public interface ITrack
{
    string Title { get; set; }
    int DurationSec { get; set; }
    int PositionSec { get; set; }

    void Seek(int seconds)
    {
        PositionSec = Math.Min(PositionSec + seconds, DurationSec);
    }
}
