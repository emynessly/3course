class Orange : Fruit
{
    public double VitaminCContent { get; set; }

    public Orange(double fruitWeight, double vitaminCContent)
        : base("Апельсин", fruitWeight)
    {
        VitaminCContent = vitaminCContent;
    }

    public override string TasteDescription()
    {
        return $"Апельсин весом {FruitWeight} граммов, богатый витамином C ({VitaminCContent}).";
    }
}
