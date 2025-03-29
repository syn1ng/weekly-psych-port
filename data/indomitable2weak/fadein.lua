fadeTime = 5 -- in seconds

function onCreatePost()
    makeLuaSprite('j', nil, 0, 0)
    makeGraphic('j', 1280 * 2, 720 * 2, '000000') -- doubled size just in case
    addLuaSprite('j', true)
    setObjectCamera('j', 'camOther')
    setProperty('j.alpha', 0) -- Ensure the sprite starts fully transparent
end

function onBeatHit()
    if curBeat == 294 then
        doTweenAlpha('j', 'j', 1, fadeTime, 'linear') -- Fade in over fadeTime seconds
    end
end

function onUpdate(elapsed)

    screenCenter('j'); -- EVERY FRAME just so it fucking works istg if this doesn't work i'm gonna

end
