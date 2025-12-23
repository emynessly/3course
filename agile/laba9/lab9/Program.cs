class Program
{
    static void Main()
    {
        var inventory = new Inventory();

        var sword = new Item("меч1", "Алмазный меч", Rarity.Epic);
        sword.AddEffect(new Effect("atk", 5));

        var bow = new Item("лук1", "Короткий лук", Rarity.Uncommon);
        bow.AddEffect(new Effect("atk", 3));
        bow.AddEffect(new Effect("crit", 4));

        var potion = new Item("зелье1", "Зелье здоровья", Rarity.Rare);
        potion.AddEffect(new Effect("hp", 20));

        inventory.Add(sword);
        inventory.Add(bow);
        inventory.Add(potion);

        Console.WriteLine("--- Все предметы ---");
        for (int i = 0; i < inventory.Count; i++)
        {
            Console.WriteLine(inventory[i]);
        }

        Console.WriteLine("\n--- Доступ по ID ---");
        Console.WriteLine(inventory["лук1"]);

        Console.WriteLine("\n--- Предметы с редкостью Uncommon и выше ---");
        foreach (var item in inventory.EnumerateByRarity(Rarity.Uncommon))
        {
            Console.WriteLine(item);
        }

        Console.WriteLine("\n--- Удаление предмета по индексу 0 ---");
        inventory.RemoveAt(0);
        foreach (var item in inventory)
        {
            Console.WriteLine(item);
        }

        Console.WriteLine("\n--- Удаление предмета по ID 'зелье1' ---");
        inventory.RemoveById("зелье1");
        foreach (var item in inventory)
        {
            Console.WriteLine(item);
        }
    }
}