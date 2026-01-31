RegisterNetEvent('leo:openMenu', function()
    lib.registerContext({
        id = 'leo_menu',
        title = 'LEO Interactions',
        position = Config.Align,
        options = {
            {
                title = Locales.en.cuff,
                icon = 'handcuffs',
                onSelect = function()
                    TriggerEvent('leo:interaction', 'cuff')
                end
            },
            {
                title = Locales.en.escort,
                icon = 'person-walking',
                onSelect = function()
                    TriggerEvent('leo:interaction', 'escort')
                end
            },
            {
                title = Locales.en.putveh,
                onSelect = function()
                    TriggerEvent('leo:interaction', 'putveh')
                end
            },
            {
                title = Locales.en.outveh,
                onSelect = function()
                    TriggerEvent('leo:interaction', 'outveh')
                end
            }
        }
    })

    lib.showContext('leo_menu')
end)
