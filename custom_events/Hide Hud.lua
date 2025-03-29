function onEvent(name, value1, value2)
    if name == 'Hide Hud' then
        if value1 == 'hide' then
            doTweenAlpha('hideHUD', 'camHUD', 0, 0.3, 'linear')
        elseif value1 == 'unhide' then
            doTweenAlpha('unhideHUD', 'camHUD', 1, 0.3, 'linear')
        end
    end
end