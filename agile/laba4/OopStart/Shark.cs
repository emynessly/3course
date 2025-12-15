namespace Animals;

class Shark : Fish
{
    private int teeth;

    public int Teeth
    {
        get { return teeth; }
        set
        {
            if (value <= 0)
                throw new ArgumentException("Зубов должно быть больше 0.");
            teeth = value;
        }
    }

    public Shark(string name, int age, bool freshwater, int teeth)
        : base(name, age, freshwater)
    {
        Teeth = teeth;
    }

    public void Hunt()
    {
        Console.WriteLine($"{Name} ведет охоту с {Teeth} зубами.");
    }

    public override string Speak()
    {
        return "....";
    }
}
