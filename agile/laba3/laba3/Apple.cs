class Apple : Fruit
{
    public int SweetnessLevel { get; set; }

    public Apple(double fruitWeight, int sweetnessLevel)
        : base("Яблоко", fruitWeight)
    {
        SweetnessLevel = sweetnessLevel;
    }

    public override string TasteDescription()
    {
        return $"Это яблоко весом {FruitWeight} граммов, с уровнем сладости {SweetnessLevel}.";
    }
}
