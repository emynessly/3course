using Animals;
class Program
{
    static void Main()
    {
        Dog dog = new Dog("Гобби", 8, "Алабай");
        dog.Describe();
        dog.Fetch();
        Console.WriteLine(dog.Speak());

        Console.WriteLine();

        Fish fish = new Fish("Петушок", 2, true);
        fish.Describe();
        fish.Swim();
        Console.WriteLine(fish.Speak());

        Console.WriteLine();

        Shark shark = new Shark("Акула", 4, false, 260);
        shark.Describe();
        shark.Hunt();
        Console.WriteLine(shark.Speak());
    }
}