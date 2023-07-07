#include <sdkhooks>
#include <sdktools>
#include <sourcemod>
#pragma newdecls required
#pragma semicolon 1

public Plugin myinfo =
{
	name		= "weaponRestrict",
	author		= "StannArax",
	description = "Restricts weapons",
	version		= "1.0.0",
	url			= "https://github.com/StannArax/weaponRestrict"
};

public void OnPluginStart()
{
	PrintToServer("Weapon Restriction Plugin Has Been Loaded Successfully");
	HookEvent("round_start", OnRoundStart);
}

int whoUsedTaser[20];
int currentIndex = 0;

public Action CS_OnBuyCommand(int client, const char[] weapon)
{
	if (!IsClientInGame(client)) { return Plugin_Continue; PrintToConsole(client, "false"); }
	else {
		if (strcmp(weapon, "weapon_nova") == 0 || strcmp(weapon, "weapon_xm1014") == 0 || strcmp(weapon, "weapon_mag7") == 0 || strcmp(weapon, "weapon_sawedoff") == 0)
		{
			char message[128];
			Format(message, sizeof(message), "You cannot buy this weapon! %s", weapon);
			PrintToChat(client, message);
		}
		else if (GetTeamClientCount(GetClientTeam(client)) <= 3)
		{
			char clientTeam[32];

			if (strcmp(weapon, "weapon_m249") == 0 || strcmp(weapon, "weapon_negev") == 0 || strcmp(weapon, "weapon_awp") == 0 || strcmp(weapon, "weapon_p90") == 0 || strcmp(weapon, "weapon_g3sg1") == 0 || strcmp(weapon, "weapon_scar20") == 0 || strcmp(weapon, "weapon_bizon") == 0)
			{
				char message[128];
				Format(message, sizeof(message), "%s Team needs to have more than 2 players!", clientTeam);
				PrintToChat(client, message);
			}
			else {
				GivePlayerItem(client, weapon);
			}
		}
		else if (GetTeamClientCount(GetClientTeam(client)) > 3) {
			GivePlayerItem(client, weapon);
		}
		else if (strcmp(weapon, "weapon_taser")) {
			for (int i = 0; i < sizeof(whoUsedTaser); i++)
			{
				if (GetClientUserId(client) == whoUsedTaser[i])
				{
					char message[128];
					Format(message, sizeof(message), "You can use the taser on every half.");
					PrintToChat(client, message);
				}
				else
				{
					GivePlayerItem(client, weapon);
					whoUsedTaser[currentIndex] = GetClientUserId(client);
					currentIndex++;
				}
			}
		}
	}

	return Plugin_Handled;
}

public Action OnRoundStart(Event event, const char[] name, bool dontBroadcast)
{
	if (GetTeamScore(2) + GetTeamScore(3) == 15)
	{
		currentIndex = 0;
		for (int i = 0; i < sizeof(whoUsedTaser); i++)
		{
			whoUsedTaser[i] = -1;
		}
	}

	return Plugin_Continue;
}

public void OnPluginEnd()
{
	UnhookEvent("round_start", OnRoundStart);
}

public void OnMapStart()
{
	currentIndex = 0;
	for (int i = 0; i < sizeof(whoUsedTaser); i++)
	{
		whoUsedTaser[i] = -1;
	}
}