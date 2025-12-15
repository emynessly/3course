namespace OopStart;
public interface IPlaylist
{
    int Count { get; }
    void Add(ITrack track);
}
