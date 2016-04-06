boolean is_avatar_potion( item it )
{
    return it.effect_modifier( "Effect" ).string_modifier( "Avatar" ) != "";
}

boolean has_avatar_active()
{
  int [effect] currentEffects = my_effects(); // Array of current active effects
  foreach buff in currentEffects{
    if (buff.string_modifier( "Avatar" ) != "")
    {
      return true;
    }
  }
  return false;
}

void main()
{
  int[item] inventory = get_inventory() ;
  foreach it in inventory
  {
    if (is_avatar_potion(it))
    {
      put_closet(inventory[it], it);
    }
  }
  // if we already have an avatar potion active, bail.
  if (has_avatar_active())
  {
    return;
  }

  item[int] potions;
  int count = 0;
  foreach it in $items[]
  {
    if (is_avatar_potion(it))
    {
      if (closet_amount(it) > 0)
      {
        potions[count] = it;
        count += 1;
      }
    }
  }
  if (count( potions ) == 0)
  {
    print("Sorry, no avatar changing potions found.");
    return;
  }

  sort potions by random(100000);
  item avatar_potion = potions[0];
  take_closet(1, avatar_potion);
  use(1, avatar_potion);
}
