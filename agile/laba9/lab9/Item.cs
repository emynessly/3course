public class Item
{
    private readonly List<Effect> _effects = new List<Effect>();
    public string Id { get; }
    public string Name { get; }
    public Rarity Rarity { get; }

    public IReadOnlyList<Effect> Effects => _effects.AsReadOnly();

    public Item(string id, string name, Rarity rarity)
    {
        if (string.IsNullOrWhiteSpace(id)) 
            throw new ArgumentException("ID не может быть нулем или пустым", nameof(id));
        if (string.IsNullOrWhiteSpace(name)) 
            throw new ArgumentException("Имя не может быть нулем или пустым", nameof(name));

        Id = id;
        Name = name;
        Rarity = rarity;
    }

    internal void AddEffect(Effect effect)
    {
        if (effect == null) throw new ArgumentNullException(nameof(effect));
        _effects.Add(effect);
    }

    public override string ToString()
    {
        return $"{Name} ({Id}) [{Rarity}], Эффекты: {string.Join(", ", Effects)}";
    }
}