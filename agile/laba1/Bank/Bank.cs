class Bank
{
    public string AccountHolder { get; init; }
    public string AccountNumber { get; private set; }
    public float Balance { get; private set; }

    public Bank(string accountHolder, string accountNumber, float balance)
    {
        AccountHolder = accountHolder;
        AccountNumber = accountNumber;
        Balance = balance;
    }

    public void Top_up(float amount)
    {
        Balance += amount;
        Console.WriteLine($"Счет {AccountNumber} пополнен на {amount} рублей. Текущий баланс: {Balance} рублей.");
    }

    public void Withdraw(float amount)
    {
        if (amount <= Balance)
        {
            Balance -= amount;
            Console.WriteLine($"Со счета {AccountNumber} снято {amount} рублей. Текущий баланс: {Balance} рублей.");
        }
        else
        {
            Console.WriteLine($"Недостаточно средств");
        }
    }

    public override string ToString()
    {
        return $"Баланс счета {AccountNumber} ({AccountHolder}): {Balance} рублей.";
    }
}