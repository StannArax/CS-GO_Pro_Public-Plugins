#include <sdkhooks>
#include <sdktools>
#include <sourcemod>
#pragma newdecls required
#pragma semicolon 1

public Plugin myinfo =
{
	name		= "autoArmor",
	author		= "StannArax",
	description = "Automatically gives armor and helmet to all players int he server after the 3rd round.",
	version		= "1.0.0",
	url			= "https://github.com/StannArax/autoArmor"
};

int roundCount = 0;

public void OnPluginStart()
{
	HookEvent("round_start", OnRoundStart);
}

public Action OnRoundStart(Event event, const char[] name, bool dontBroadcast)
{
	if (roundCount == 3){
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsClientInGame(i) && (GetClientTeam(i) == 2 || GetClientTeam(i) == 3))
			{
				GivePlayerItem(i, "item_kevlar");
			}
		}
	}
	else if (roundCount > 3)
	{
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsClientInGame(i) && (GetClientTeam(i) == 2 || GetClientTeam(i) == 3))
			{
				GivePlayerItem(i, "item_assaultsuit");
			}
		}
	}
	roundCount++;
	return Plugin_Handled;
}

public void OnMapStart(){
	roundCount = 0;
}

public void OnPluginEnd(){
	UnhookEvent("round_start", OnRoundStart);
}