using System.Numerics;

class Program
{

    static void Main()
    {
        Bank bank = new Bank("Ryusui", "40817810500001846336", 40000);

        bank.Top_up(3000);
        bank.Withdraw(7000);
        Console.WriteLine(bank);
    }
}