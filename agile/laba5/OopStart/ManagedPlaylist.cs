namespace OopStart;
public class ManagedPlaylist : ITrack, IPlaylist
{
    private List<ITrack> tracks = new();
    private int positionSec;
    private int crossfadeSec;

    public int CrossfadeSec
    {
        get => crossfadeSec;
        set => crossfadeSec = Math.Max(0, value);
    }

    public int Count => tracks.Count;

    public string Title { get; set; } = "Playlist";

    public int DurationSec
    {
        get
        {
            int total = 0;
            for (int i = 0; i < tracks.Count; i++)
            {
                total += tracks[i].DurationSec;
                if (i < tracks.Count - 1)
                    total += CrossfadeSec;
            }
            return total;
        }
        set {}
    }

    public int PositionSec
    {
        get => positionSec;
        set => positionSec = Math.Clamp(value, 0, DurationSec);
    }

    public void Add(ITrack track)
    {
        if (track != null)
            tracks.Add(track);
    }

    public void Seek(int seconds)
    {
        if (seconds <= 0) return;

        int remaining = DurationSec - PositionSec;
        int advance = Math.Min(seconds, remaining);

        int pos = PositionSec;
        for (int i = 0; i < tracks.Count; i++)
        {
            var t = tracks[i];
            if (pos < t.DurationSec)
            {
                int spaceInTrack = t.DurationSec - pos;
                if (advance <= spaceInTrack)
                {
                    PositionSec += advance;
                    return;
                }
                else
                {
                    PositionSec += spaceInTrack + CrossfadeSec;
                    advance -= spaceInTrack;
                    pos = 0;
                }
            }
            else
            {
                pos -= t.DurationSec;
            }
        }
        PositionSec = Math.Min(PositionSec + advance, DurationSec);
    }
}
