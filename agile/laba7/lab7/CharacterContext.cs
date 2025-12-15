public class CharacterContext
{
    public int Health { get; set; }
    public int Armor { get; set; }
    public bool Poisoned { get; set; }

    public override string ToString()
    {
        return $"HP = {Health}, Armor = {Armor}, Poisoned = {Poisoned}";
    }
}
