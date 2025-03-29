-- Dark overlay logic
function onUpdate(elapsed)
    -- Fade in the black overlay at step 1602
    if curStep >= 1602 and getProperty('black.alpha') < 0.5 then
        local fadeInSpeed = 5 * elapsed -- Faster fade-in speed
        setProperty('black.alpha', math.min(0.5, getProperty('black.alpha') + fadeInSpeed))
    end
end

function onCreate()
    -- Black overlay
    makeLuaSprite('black', '', -300, -300)
    makeGraphic('black', screenWidth * 2, screenHeight * 2, '000000')
    setScrollFactor('black', 0, 0)
    setProperty('black.alpha', 0) -- Start fully transparent
    addLuaSprite('black', false) -- Add below characters
end