
local cfg = {}

-- define each group with a set of permissions
-- _config property:
--- title (optional): group display name
--- gtype (optional): used to have only one group with the same gtype per player (example: a job gtype to only have one job)
--- onspawn (optional): function(user) (called when the character spawn with the group)
--- onjoin (optional): function(user) (called when the character join the group)
--- onleave (optional): function(user) (called when the character leave the group)

function police_init(user)
  local weapons = {}
  weapons["WEAPON_STUNGUN"] = {ammo=1000}
  weapons["WEAPON_COMBATPISTOL"] = {ammo=100}
  weapons["WEAPON_NIGHTSTICK"] = {ammo=0}
  weapons["WEAPON_FLASHLIGHT"] = {ammo=0}
  
  vRP.EXT.PlayerState.remote._giveWeapons(user.source,weapons,true)
  vRP.EXT.Police.remote._setCop(user.source,true)
  vRP.EXT.PlayerState.remote._setArmour(user.source,100)
  vRP.EXT.Functions.remote._onDuty(user.source)
end

function police_onjoin(user)
  police_init(user)
end

function police_onleave(user)
  --vRP.EXT.PlayerState.remote._giveWeapons(user.source,{},true)
  vRP.EXT.Police.remote._setCop(user.source,false)
  vRP.EXT.PlayerState.remote._setArmour(user.source,0)
  vRP.EXT.Functions.remote._offDuty(user.source)
  user:removeCloak()
end

function police_onspawn(user)
  police_init(user)
end

function ems_init(user)
  vRP.EXT.Functions.remote._onDuty(user.source)
end

function police_onjoin(user)
  ems_init(user)
end

function ems_onleave(user)
  vRP.EXT.Functions.remote._offDuty(user.source)
  user:removeCloak()
end

function ems_onspawn(user)
  ems_init(user)
end

cfg.groups = {
  ["superadmin"] = {
    _config = {onspawn = function(user) vRP.EXT.Base.remote._notify(user.source, "Du er nu superadmin.") end},
    "player.group.add",
    "player.group.remove",
    "player.givemoney",
    "player.giveitem",
    "profiler.server",
    "profiler.client"
  },
  ["admin"] = {
    "admin.tickets",
    "admin.announce",
    "player.list",
    "player.whitelist",
    "player.unwhitelist",
    "player.kick",
    "player.ban",
    "player.unban",
    "player.noclip",
    "player.custom_emote",
    "player.custom_model",
    "player.custom_sound",
    "player.display_custom",
    "player.coords",
    "player.tptome",
    "player.tpto"
  },
  ["god"] = {
    "admin.god" -- reset survivals/health periodically
  },
  ["user"] = {
    "player.characters", -- characters menu
    "player.phone",
    "player.calladmin",
    "player.store_weapons",
    "police.seizable" -- can be seized
  },
  --==========|===================|==========--
  --==========|Whitelisting Groups|==========--
  --==========|===================|==========-- 
  ["police"] = { --add this group to users for whitelisted police roles. This group is used by department heads to hire and fire officers. DO NOT DELETE
    "police.whitelisted"
  },
  ["DeptHead"] = { --add this group to users for whitelisted department head roles. DO NOT DELETE
    "department.head.whitelisted"
  },
  ["EMS"] = { --add this group to users for whitelisted department head roles. DO NOT DELETE
    "EMS.whitelisted"
  },
  --==========|===========|==========--
  --==========|LSPD Groups|==========--
  --==========|===========|==========--
  ["cadet"] = {
    _config = {
      title = "LSPD Kadet",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lspdcadet.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.vehicle",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["police1"] = {
    _config = {
      title = "Politimand",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "officer.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.vehicle2",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["police2"] = {
    _config = {
      title = "Senior politibetjent",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "officer.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.vehicle2",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lspd_corporal"] = {
    _config = {
      title = "LSPD korporal",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lspdcorp.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.vehicle2",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lspd_sgt"] = {
    _config = {
      title = "LSPD Sergent",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lspdsgt.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.vehicle3",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lspd_lt"] = {
    _config = {
      title = "LSPD Løjtnant",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lspdlt.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.vehicle3",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lspd_cpt"] = {
    _config = {
      title = "LSPD Kaptajn",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lspdcpt.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.vehicle3",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lspd_ltmjr"] = {
    _config = {
      title = "LSPD Løjtnant major",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lspdltmjr.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.vehicle3",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lspd_mjr"] = {
    _config = {
      title = "LSPD Major",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lspdmjr.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.vehicle4",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lspd_cmdr"] = {
    _config = {
      title = "LSPD Kommandør",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lspdcmdr.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.vehicle4",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lspd_asscheif"] = {
    _config = {
      title = "LSPD Assistentchef",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lspdasscheif.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.vehicle4",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lspd_cheif"] = {
    _config = {
      title = "LSPD Chief",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.admin",
    "police.menu",
    "police.askid",
    "lspdasscheif.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.vehicle4",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ----------------
  -----EMS--------
  ----------------
  ["emergency"] = {
    _config = {
      title = "Reder",
      gtype = "job"
    },
    "emergency.revive",
    "emergency.shop",
    "emergency.service",
    "emergency.vehicle",
    "emergency.cloakroom"
  },
  ["repair"] = {
    _config = {
      title = "Repair",
      gtype = "job"
    },
    "vehicle.repair",
    "vehicle.replace",
    "repair.service"
--    "mission.repair.satellite_dishes", -- basic mission
--    "mission.repair.wind_turbines" -- basic mission
  },
  ["taxi"] = {
    _config = {
      title = "Taxi",
      gtype = "job"
    },
    "taxi.service",
    "taxi.vehicle"
  },
  ["Borger"] = {
    _config = {
      title = "Borger",
      gtype = "job"
    }
  }
}

-- groups are added dynamically using the API or the menu, but you can add group when a character is loaded here
-- groups for everyone
cfg.default_groups = {
  "user"
}

-- groups per user
-- map of user id => list of groups
cfg.users = {
  [1] = { -- give superadmin and admin group to the first created user in the database
    "superadmin",
    "admin"
  }
}

-- group selectors
-- _config
--- x,y,z, map_entity, permissions (optional)
---- map_entity: {ent,cfg} will fill cfg.title, cfg.pos

cfg.selectors = {
  ["Jobs"] = {
    _config = {x = -268.363739013672, y = -957.255126953125, z = 31.22313880920410, map_entity = {"PoI", {blip_id = 351, blip_color = 47, marker_id = 1}}},
    "taxi",
    "repair",
    "Borger"
  },
  
  --=====|====|=====--
  --=====|LSPD|=====--
  --=====|====|=====--
  ["Police job"] = {
    _config = {x = 437.924987792969, y = -987.974182128906, z = 30.6896076202393, permissions={"police.whitelisted"} map_entity = {"PoI", {blip_id = 351, blip_color = 38, marker_id = 1}}},
    "cadet",
    "police1",
    "police2",
    "Borger"
  },
  ["Emergency job"] = {
    _config = {x = -498.959716796875, y = -335.715148925781, z = 34.5017547607422, permissions={"EMS.whitelisted"} map_entity = {"PoI", {blip_id = 351, blip_color = 1, marker_id = 1}}},
    "emergency",
    "Borger"
  }
}

-- identity display gtypes
-- used to display gtype groups in the identity
-- map of gtype => title
cfg.identity_gtypes = {
  job = "Job"
}

-- count display

cfg.count_display_interval = 15 -- seconds

cfg.count_display_css = [[
.div_group_count_display{
  position: absolute;
  right: 0;
  bottom: 0;
  display: flex;
  flex-direction: row;
  padding: 2px;
  padding-right: 5px;
}

.div_group_count_display > div{
  padding-left: 7px;
  color: white;
  font-weight: bold;
  line-height: 22px;
}

.div_group_count_display > div > img{
  margin-right: 2px;
  vertical-align: bottom;
}
]]

-- list of {permission, img_src}
cfg.count_display_permissions = {
  {"!group.user", "https://i.imgur.com/tQ2VHAi.png"},
  {"!group.admin", "https://i.imgur.com/cpSYyN0.png"},
  {"!group.cadet", "https://i.imgur.com/dygLDfC.png"},
  {"!group.police1", "https://i.imgur.com/dygLDfC.png"},
  {"!group.police2", "https://i.imgur.com/dygLDfC.png"},
  {"!group.lspd_corporal", "https://i.imgur.com/dygLDfC.png"},
  {"!group.lspd_sgt", "https://i.imgur.com/dygLDfC.png"},
  {"!group.lspd_lt", "https://i.imgur.com/dygLDfC.png"},
  {"!group.lspd_cpt", "https://i.imgur.com/dygLDfC.png"},
  {"!group.lspd_ltmjr", "https://i.imgur.com/dygLDfC.png"},
  {"!group.lspd_cmdr", "https://i.imgur.com/dygLDfC.png"},
  {"!group.lspd_asscheif", "https://i.imgur.com/dygLDfC.png"},
  {"!group.lspd_cheif", "https://i.imgur.com/dygLDfC.png"},
  {"!group.emergency", "https://i.imgur.com/K5lXutO.png"},
  {"!group.repair", "https://i.imgur.com/QEjFgzM.png"},
  {"!group.taxi", "https://i.imgur.com/yY4yrZN.png"}
}

return cfg

