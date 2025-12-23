using System.Collections;

public class Inventory : IEnumerable<Item>
{
    private readonly List<Item> _items = new();
    private readonly Dictionary<string, Item> _byId = new();

    public int Count => _items.Count;

    public Item this[int index]
    {
        get
        {
            if (index < 0 || index >= _items.Count)
                throw new ArgumentOutOfRangeException(nameof(index), 
                "Индекс выходит за пределы допустимого диапазона.");
            return _items[index];
        }
    }

    public Item this[string id]
    {
        get
        {
            if (id == null) throw new ArgumentNullException(nameof(id));
            if (!_byId.TryGetValue(id, out var item))
                throw new KeyNotFoundException(
                    $"Предмет с ID '{id}' не найден.");
            return item;
        }
    }

    public void Add(Item item)
    {
        if (item == null) throw new ArgumentNullException(nameof(item));
        if (_byId.ContainsKey(item.Id)) 
            throw new ArgumentException(
                $"Предмет с ID '{item.Id}' уже существует.");

        _items.Add(item);
        _byId[item.Id] = item;
    }

    public bool RemoveAt(int index)
    {
        if (index < 0 || index >= _items.Count) return false;

        var item = _items[index];
        _items.RemoveAt(index);
        _byId.Remove(item.Id);
        return true;
    }

    public bool RemoveById(string id)
    {
        if (id == null) throw new ArgumentNullException(nameof(id));
        if (!_byId.TryGetValue(id, out var item)) return false;

        _items.Remove(item);
        _byId.Remove(id);
        return true;
    }

    public IEnumerable<Item> EnumerateByRarity(Rarity minRarity)
    {
        foreach (var item in _items)
        {
            if (item.Rarity >= minRarity)
                yield return item;
        }
    }

    public IEnumerator<Item> GetEnumerator() => _items.GetEnumerator();
    IEnumerator IEnumerable.GetEnumerator() => GetEnumerator();
}