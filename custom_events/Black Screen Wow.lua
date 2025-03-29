function onCreate()
    makeLuaSprite('blackScreen', '', 0, 0)
    makeGraphic('blackScreen', screenWidth, screenHeight, '000000')
    setObjectCamera('blackScreen', 'other')
    setProperty('blackScreen.alpha', 0)
    addLuaSprite('blackScreen', true)
end

function onEvent(name, value1, value2)
    if name == 'Black Screen Wow' then
        if value1 == 'show' then
            setProperty('blackScreen.alpha', 1)
        elseif value1 == 'hide' then
            setProperty('blackScreen.alpha', 0)
        end
    end
end