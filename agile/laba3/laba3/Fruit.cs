class Fruit
{
    public string FruitType { get; set; }
    public double FruitWeight { get; set; }

    public Fruit(string fruitType, double fruitWeight)
    {
        FruitType = fruitType;
        FruitWeight = fruitWeight;
    }

    public virtual string TasteDescription()
    {
        return "Описание вкуса";
    }
}
