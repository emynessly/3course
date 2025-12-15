namespace CharEffects;
public delegate void EffectHandler(CharacterContext context);

public class EffectSystem
{
    public EffectHandler? Effects { get; set; }

    public void Run(CharacterContext context)
    {
        if (context == null)
        {
            throw new ArgumentNullException(nameof(context));
        }

        Effects?.Invoke(context);
    }
}
