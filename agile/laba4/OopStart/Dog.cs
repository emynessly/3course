namespace Animals;

class Dog : Animal
{
    private string breed;

    public string Breed
    {
        get { return breed; }
        set
        {
            if (string.IsNullOrWhiteSpace(value))
                throw new ArgumentException("Порода не может быть пустой.");
            breed = value;
        }
    }

    public Dog(string name, int age, string breed)
        : base(name, age)
    {
        Breed = breed;
    }

    public void Fetch()
    {
        Console.WriteLine($"{Name} несет палку.");
    }

    public override string Speak()
    {
        return "Woof!";
    }
}