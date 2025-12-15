namespace OopStart;
class Program
{
    static void Main()
    {
        ITrack track1 = new BasicTrack("Murders", 222);
        track1.Seek(150);
        Console.WriteLine($"{track1.Title} - Позиция: {track1.PositionSec}/{track1.DurationSec} сек.");

        ManagedPlaylist playlist = new ManagedPlaylist();
        playlist.CrossfadeSec = 5;

        playlist.Add(new BasicTrack("Labyrinth", 152));
        playlist.Add(new BasicTrack("Time Machine", 252));
        playlist.Add(new BasicTrack("Stranded Lullaby", 220));

        Console.WriteLine($"Общая длительность плейлиста: {playlist.DurationSec} секунд, " +
                          $"кол-во песен: {playlist.Count}.");

        playlist.Seek(100);
        Console.WriteLine($"Позиция плейлиста после 100 секунды: {playlist.PositionSec} секунда.");

        playlist.Seek(200);
        Console.WriteLine($"Позиция плейлиста после 200 секундыc: {playlist.PositionSec} секунда.");

        playlist.Seek(700);
        Console.WriteLine($"Позиция плейлиста после 700 секунды: {playlist.PositionSec} секунда.");
    }
}
