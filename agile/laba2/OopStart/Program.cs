using System;
using System.Collections.Generic;

namespace laba2;

class Program
{
    static void Main()
    {
        MenuItem item1 = new MenuItem("Пицца Маргарита", 555, 792);
        MenuItem item2 = new MenuItem("Пенне Болоньезе", 699, 718);
        MenuItem item3 = new MenuItem("Мясная лазанья", 789, 862);
        MenuItem item4 = new MenuItem("Греческий салат", 679, 302);

        Cafe cafe = new Cafe("Патио", 36);
        cafe.AddMenuItem(item1);
        cafe.AddMenuItem(item2);
        cafe.AddMenuItem(item3);
        cafe.AddMenuItem(item4);

        Order order1 = new Order(DateTime.Now, new List<MenuItem>());
        order1.AddMenuItem(item1);
        order1.AddMenuItem(item2);

        Order order2 = new Order(DateTime.Now.AddMinutes(+15), new List<MenuItem>());
        order2.AddMenuItem(item2);
        order2.AddMenuItem(item3);
        order2.AddMenuItem(item4);

        Console.WriteLine(cafe.GetDescription());
        Console.WriteLine("\n");
        Console.WriteLine("Заказы:");
        Console.WriteLine(order1);
        Console.WriteLine("\n");
        Console.WriteLine(order2);
    }
}