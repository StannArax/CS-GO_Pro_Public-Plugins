#include <sdkhooks>
#include <sdktools>
#include <sourcemod>
#include <cstrike>
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
	char message[128];
	Format(message, sizeof(message), "Kevlar  or Assaultsuit %s", weapon);
	PrintToChat(client, message);
	if (!IsClientInGame(client))
	{
		return Plugin_Continue;
	}
	else
	{
		if (strcmp(weapon, "nova") == 0 || strcmp(weapon, "xm1014") == 0 || strcmp(weapon, "mag7") == 0 || strcmp(weapon, "sawedoff") == 0)
		{
			char message[128];
			Format(message, sizeof(message), "You cannot buy this weapon!y %s ", weapon);
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
			else {
				char item[128];
				Format(item, sizeof(item), "weapon_%s", weapon);
				giveItemToPlayer(client, item);
			}
		}
		else if (GetTeamClientCount(GetClientTeam(client)) > 3) {
			char item[128];
			Format(item, sizeof(item), "weapon_%s", weapon);
			giveItemToPlayer(client, item);
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
					char item[128];
					Format(item, sizeof(item), "weapon_%s", weapon);
					giveItemToPlayer(client, item);
					whoUsedTaser[currentIndex] = GetClientUserId(client);
					currentIndex++;
				}
			}
		}
	}

	return Plugin_Handled;
}

public void giveItemToPlayer(int client, const char[] item)
{
	int	 weapon_money = getWeaponMoney(client, item);
	int	 player_money = GetEntProp(client, Prop_Send, "m_iAccount");
	char item[128];
	Format(item, sizeof(item), "money: %d", weapon_money);
	giveItemToPlayer(client, item);
	SetEntProp(client, Prop_Send, "m_iAccount", player_money - weapon_money);
	if (GetClientArmor(client) == 100 || weapon_money == 1000)
	{
		char message[128];
		Format(message, sizeof(message), "You already have kevlar, bought helmet");
		PrintToChat(client, message);
		SetEntProp(client, Prop_Send, "m_iAccount", player_money + 650);
	}
}

public int getWeaponMoney(int client, const char[] itemName)
{
	if (strcmp(itemName, "weapon_glock") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_GLOCK, false);
	}
	else if (strcmp(itemName, "weapon_usp_silencer") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_USP, false);
	}
	else if (strcmp(itemName, "weapon_hkp2000") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_HKP2000, false);
	}
	else if (strcmp(itemName, "weapon_p250") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_P250, false);
	}
	else if (strcmp(itemName, "weapon_elite") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_GLOCK, false);
	}
	else if (strcmp(itemName, "CSWeapon_ELITE") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_GLOCK, false);
	}
	else if (strcmp(itemName, "weapon_fiveseven") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_FIVESEVEN, false);
	}
	else if (strcmp(itemName, "weapon_cz75a") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_CZ75A, false);
	}
	else if (strcmp(itemName, "weapon_deagle") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_DEAGLE, false);
	}
	else if (strcmp(itemName, "weapon_revolver") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_REVOLVER, false);
	}
	else if (strcmp(itemName, "weapon_m249") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_M249, false);
	}
	else if (strcmp(itemName, "weapon_negev") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_NEGEV, false);
	}
	else if (strcmp(itemName, "weapon_mac10") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_MAC10, false);
	}
	else if (strcmp(itemName, "weapon_mp9") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_MP9, false);
	}
	else if (strcmp(itemName, "weapon_mp7") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_MP7, false);
	}
	else if (strcmp(itemName, "weapon_ump45") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_UMP45, false);
	}
	else if (strcmp(itemName, "weapon_bizon") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_BIZON, false);
	}
	else if (strcmp(itemName, "weapon_galilar") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_GALILAR, false);
	}
	else if (strcmp(itemName, "weapon_famas") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_FAMAS, false);
	}
	else if (strcmp(itemName, "weapon_ak47") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_AK47, false);
	}
	else if (strcmp(itemName, "weapon_m4a1") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_M4A1, false);
	}
	else if (strcmp(itemName, "weapon_m4a1_silencer") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_M4A1_SILENCER, false);
	}
	else if (strcmp(itemName, "weapon_ssg08") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_SSG08, false);
	}
	else if (strcmp(itemName, "weapon_sg556") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_SG556, false);
	}
	else if (strcmp(itemName, "weapon_aug") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_AUG, false);
	}
	else if (strcmp(itemName, "weapon_awp") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_AWP, false);
	}
	else if (strcmp(itemName, "weapon_g3sg1") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_G3SG1, false);
	}
	else if (strcmp(itemName, "weapon_scar20") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_SCAR20, false);
	}
	else if (strcmp(itemName, "weapon_flashbang") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_FLASHBANG, false);
	}
	else if (strcmp(itemName, "weapon_decoy") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_DECOY, false);
	}
	else if (strcmp(itemName, "weapon_hegrenade") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_HEGRENADE, false);
	}
	else if (strcmp(itemName, "weapon_incgrenade") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_INCGRENADE, false);
	}
	else if (strcmp(itemName, "weapon_molotov") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_MOLOTOV, false);
	}
	else if (strcmp(itemName, "weapon_smokegrenade") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_SMOKEGRENADE, false);
	}
	else if (strcmp(itemName, "weapon_kevlar") == 0)
	{
		char message[128];
		Format(message, sizeof(message), "KEVLAR");
		PrintToChat(client, message);
		return CS_GetWeaponPrice(client, CSWeapon_KEVLAR, false);
	}
	else if (strcmp(itemName, "weapon_assaultsuit") == 0)
	{
		char message[128];
		Format(message, sizeof(message), "ASSAULTSUIT");
		PrintToChat(client, message);
		return CS_GetWeaponPrice(client, CSWeapon_ASSAULTSUIT, false);
	}
	else if (strcmp(itemName, "item_defuser") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_DEFUSER, false);
	}
	else if (strcmp(itemName, "weapon_taser") == 0)
	{
		return CS_GetWeaponPrice(client, CSWeapon_TASER, false);
	}

	return 0;
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