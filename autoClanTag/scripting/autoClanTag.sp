#include <sourcemod>
#include <sdkhooks>
#include <sdktools>
#include <cstrike>

public Plugin myinfo =
{
    name        = "autoClanTag",
    author      = "StannArax",
    description = "Automatically updates players' clantag.",
    version     = "1.0.0",
    url         = "https://github.com/StannArax/autoArmor"
};

public void OnClientPutInServer(int client)
{
    CS_SetClientClanTag(client, "B4N | ");
}

public void OnPluginStart()
{
    CreateTimer(1.0, LoadStuff);
}
 
public Action LoadStuff(Handle timer)
{
    for (int client = 1; client <= MaxClients; client++)
    {
        if (!IsClientInGame(client))
            continue;
        
        CS_SetClientClanTag(client, "B4N | ");
    }

	return Plugin_Continue;
}