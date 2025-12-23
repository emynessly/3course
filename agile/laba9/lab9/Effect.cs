public class Effect
{
    public string Code { get; }
    public int Magnitude { get; }

    public Effect(string code, int magnitude)
    {
        if (string.IsNullOrWhiteSpace(code))
            throw new ArgumentException("Код не может содержать нули или пробелы.", nameof(code));

        Code = code;
        Magnitude = magnitude;
    }

    public override string ToString() => $"{Code}:{Magnitude}";
}