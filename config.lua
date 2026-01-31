Config = {}

Config.MenuKey = 'M'
Config.Align = 'left' -- left / right
Config.UseLOS = true
Config.MaxDistance = 3.0

Config.Cooldowns = {
    cuff = 3,
    escort = 2,
    jailJob = 60
}

Config.Duty = {
    useCommand = true,
    command = 'duty',
    locations = {
        vec3(441.2, -981.9, 30.6)
    }
}

Config.Departments = {
    LSPD = { label = 'LSPD', loadout = { 'weapon_pistol' } },
    BCSO = { label = 'BCSO', loadout = { 'weapon_smg' } }
}

Config.Jail = {
    entry = vec3(459.9, -994.3, 24.9),
    exit = vec3(1846.1, 2585.9, 45.7)
}
