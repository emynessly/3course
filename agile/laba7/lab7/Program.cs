using CharEffects;
class Program
{
    static void Main()
    {
        var character = new CharacterContext
        {
            Health = 100,
            Armor = 0,
            Poisoned = false
        };

        var system = new EffectSystem();

        Console.WriteLine("Первый ход");
        Console.WriteLine(" " + character);

        system.Effects += Effects.AddShield;
        Console.WriteLine("  +3 армора");

        system.Effects += Effects.ApplyPoison;
        Console.WriteLine("  отравлен -5хп");

        system.Run(character);
        Console.WriteLine("Эффекты наложены:");
        Console.WriteLine(" " + character);

        Console.WriteLine("- - - - -");
        Console.WriteLine("Второй ход");
        Console.WriteLine(" " + character);

        system.Effects += Effects.Regenerate;
        Console.WriteLine("  +10 хп");

        Console.WriteLine("  яд снят");

        system.Effects -= Effects.AddShield;
        Console.WriteLine("  армор больше не накладывается");

        system.Run(character);
        Console.WriteLine("Эффекты наложены:");
        Console.WriteLine(" " + character);
    }
}
