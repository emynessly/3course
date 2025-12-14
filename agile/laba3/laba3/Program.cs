class Program
{
    static void Main()
    {
        Apple apple = new Apple(140, 9);
        Orange orange = new Orange(220, 53.2);

        Console.WriteLine(apple.TasteDescription());
        Console.WriteLine(orange.TasteDescription());
    }
}
