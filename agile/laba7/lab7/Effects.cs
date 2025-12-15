namespace CharEffects;
public static class Effects
{
    public static void Regenerate(CharacterContext context)
    {
        context.Health += 10;
    }

    public static void ApplyPoison(CharacterContext context)
    {
        if (context.Poisoned)
        {
            context.Poisoned = false;
            return;
        }
        context.Health -= 5;
        context.Poisoned = true;
    }

    public static EffectHandler AddShield => context => context.Armor += 3;
}
