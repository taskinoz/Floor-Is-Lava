global function startthething

void function startwaiting()
{
	wait 2
	entity ent  = GetPlayerByIndex( 0 );
	printt("Start Watch")
	if ( IsValid(ent) ) {
		printt("Valid Ent")
		thread floorIsLava(ent)
		//break
	}
	else {printt("nope"+GetPlayerByIndex( 0 ))}
	WaitFrame()

}

entity function floorIsLava( entity ent )
{
	printt("Start Floorislava")
  while (true)
  {
    if ( ent != null && IsValid(ent) ){
      if ( ent.IsOnGround() )
      {
        if ( !ent.IsWallRunning() && !ent.IsWallHanging() )
        {
					if (IsAlive(ent)) {
						ent.SetHealth(ent.GetHealth()- ( ( GetConVarString("sp_difficulty").tointeger() + 1 ) * 20 ) )
						printt("Ouch")
					}
					else {
						break
					}
        }
      }
    }
    else{
      break
    }

    WaitFrame();
  }

}


void function startthething()
{
  thread startwaiting()
}
