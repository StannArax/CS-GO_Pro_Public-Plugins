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
	if (!IsClientInGame(client))
	{
		return Plugin_Continue;
	}
	else {
		if (strcmp(weapon, "nova") == 0 || strcmp(weapon, "xm1014") == 0 || strcmp(weapon, "mag7") == 0 || strcmp(weapon, "sawedoff") == 0)
		{
			char message[128];
			Format(message, sizeof(message), "You cannot buy this weapon! %s", weapon);
			PrintToChat(client, message);
		}
		else if (GetTeamClientCount(GetClientTeam(client)) <= 3)
		{
			char clientTeam[32];

			if (strcmp(weapon, "m249") == 0 || strcmp(weapon, "negev") == 0 || strcmp(weapon, "awp") == 0 || strcmp(weapon, "p90") == 0 || strcmp(weapon, "g3sg1") == 0 || strcmp(weapon, "scar20") == 0 || strcmp(weapon, "bizon") == 0)
			{
				char message[128];
				Format(message, sizeof(message), "%s Team needs to have more than 2 players!", clientTeam);
				PrintToChat(client, message);
			}
			// else {
			// 	char item[128];
			// 	Format(item, sizeof(item), "weapon_%s", weapon);
			// 	GivePlayerItem(client, item);
			// }
		}
		else if (GetTeamClientCount(GetClientTeam(client)) > 3) {
			// char item[128];
			// Format(item, sizeof(item), "weapon_%s", weapon);
			// GivePlayerItem(client, item);
		}
		else if (strcmp(weapon, "taser")) {
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
					// char item[128];
					// Format(item, sizeof(item), "weapon_%s", weapon);
					// GivePlayerItem(client, item);
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