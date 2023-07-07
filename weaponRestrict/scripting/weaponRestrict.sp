#include <sdkhooks>
#include <sdktools>
#include <sourcemod>
#pragma newdecls required
#pragma semicolon 1


public Plugin myinfo =
{
	name = "weaponRestrict",
	author = "StannArax",
	description = "Restricts weapons",
	version = "1.0.0",
	url = "https://github.com/StannArax/weaponRestrict"
};


public Action Event_PlayerSpawn(Handle event, const char[] name, bool dontBroadcast)
{
    int client = GetClientOfUserId(GetEventInt(event, "userid"));
    char weapon[40];
    GetEventString(event, "weapon", weapon, sizeof(weapon));

    if (stricmp(weapon, "weapon_zeus") == 0)
    {
        // Zeus should be given to one player per half
        if (GetPlayerCount() % 2 == 1)
        {
            StripPlayerWeapons(client);
            GivePlayerItem(client, "weapon_zeus");
        }
        else
        {
            StripWeapon(client, "weapon_zeus");
        }
    }
    else if (stricmp(weapon, "weapon_pumpshotgun") == 0)
    {
        // Pump shotguns should be given to a maximum of four players per team
        if (GetTeamNum(client) == 2 && GetPlayersOnTeam(2) > 4)
        {
            StripPlayerWeapons(client);
            GivePlayerItem(client, "weapon_pumpshotgun");
        }
        else if (GetTeamNum(client) == 3 && GetPlayersOnTeam(3) > 4)
        {
            StripPlayerWeapons(client);
            GivePlayerItem(client, "weapon_pumpshotgun");
        }
        else
        {
            StripWeapon(client, "weapon_pumpshotgun");
        }
    }
    else if (stricmp(weapon, "weapon_awp") == 0)
    {
        // AWP should be given to a maximum of two players per team
        if (GetTeamNum(client) == 2 && GetPlayersOnTeam(2) > 2)
        {
            StripPlayerWeapons(client);
            GivePlayerItem(client, "weapon_awp");
        }
        else if (GetTeamNum(client) == 3 && GetPlayersOnTeam(3) > 2)
        {
            StripPlayerWeapons(client);
            GivePlayerItem(client, "weapon_awp");
        }
        else
        {
            StripWeapon(client, "weapon_awp");
        }
    }
    else if (stricmp(weapon, "weapon_p90") == 0)
    {
        // P90 should be given to a maximum of four players per team
        if (GetTeamNum(client) == 2 && GetPlayersOnTeam(2) > 4)
        {
            StripPlayerWeapons(client);
            GivePlayerItem(client, "weapon_p90");
        }
        else if (GetTeamNum(client) == 3 && GetPlayersOnTeam(3) > 4)
        {
            StripPlayerWeapons(client);
            GivePlayerItem(client, "weapon_p90");
        }
        else
        {
            StripWeapon(client, "weapon_p90");
        }
    }

    // Disable player's buy menu
    StripPlayerMenu(client);

    return Plugin_Continue;
}