namespace Animals;

class Fish : Animal
{
    private bool freshwater;

    public bool Freshwater
    {
        get { return freshwater; }
        set { freshwater = value; }
    }

    public Fish(string name, int age, bool freshwater)
        : base(name, age)
    {
        Freshwater = freshwater;
    }

    public void Swim()
    {
        Console.WriteLine($"{Name} плавает.");
    }
}