namespace Animals;

class Animal
{
    private string name;
    private int age;

    public string Name
    {
        get { return name; }
        set
        {
            if (string.IsNullOrWhiteSpace(value))
                throw new ArgumentException("Имя не может быть пустым.");
            name = value;
        }
    }

    public int Age
    {
        get { return age; }
        set
        {
            if (value < 0)
                throw new ArgumentException("Возраст не может быть отрицательным.");
            age = value;
        }
    }
    public Animal(string name, int age)
    {
        Name = name;
        Age = age;
    }

    public void Describe()
    {
        Console.WriteLine($"Животное: {Name}, возраст: {Age}");
    }

    public void Birthday()
    {
        Age++;
    }

    public virtual string Speak()
    {
        return "...";
    }
}
