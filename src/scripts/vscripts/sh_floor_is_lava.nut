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

bool function CheckLevelFlags(entity player)
{
	bool flagResult = true
	switch ( GetMapName() ){
		case "sp_hub_timeshift":
			if (!Flag( "AudioLogPlaying" ))
				flagResult = true
			else
				flagResult = false
		break
		case "sp_timeshift_spoke02":
			if (Flag( "AudioLogPlaying" ) ) {
				flagResult = false
			}
			else if (( !Flag( "approaching_fan_drop" ) && !Flag( "exited_intel_room3" ) ) || ( Flag( "approaching_fan_drop" ) && Flag( "exited_intel_room3" ) )) {
				flagResult = true
			}
			else {
				flagResult = false
			}
		break
		case "sp_crashsite":
			if ((!Flag("og_final_words") && (!Flag("first_wallrun_completed") || !Flag("BuddyTitanFlyout"))) || ( Flag("og_final_words") && (Flag("first_wallrun_completed") || Flag("BuddyTitanFlyout")) ) &&
			 		(!Flag("battery2ship_crawl_space") && !Flag("battery2ship_enable_loop_blocker") ) || ( Flag("battery2ship_crawl_space") && Flag("battery2ship_enable_loop_blocker") ) ) {
				flagResult = true
			}
			else {
				flagResult = false
			}
		break
	}
	return flagResult
}

entity function floorIsLava( entity ent )
{
	printt("Start Floorislava")
  while (true)
  {
    if ( ent != null && IsValid(ent) && ent.IsPlayer() ){
      if ( ent.IsOnGround() )
      {
        if (!ent.IsWallRunning() &&
						!ent.IsWallHanging() &&
						!ent.ContextAction_IsBusy() &&
						!ent.GetCinematicEventFlags() &&
						!ent.ContextAction_IsLeeching() &&
						!ent.ContextAction_IsActive() &&
						!ent.IsInvulnerable() &&
						CheckLevelFlags(ent)
						)
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
