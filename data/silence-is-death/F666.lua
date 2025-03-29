luaDebugMode = true

local tag = 'F666' -- name tag of character
local x = 450 -- x position
local y = 0 -- y position
local character = 'F666' -- name of json file
local isPlayer = false -- flips the character and the notetypes will only work when the player hits the note
local order = -1 -- basically the layer that the character will be on, use this if you need it to appear above or below something (-1 is default and it will add it normally)

-- notetypes that the character will sing on
-- you can configure with the variables to get the effect you want
local noteTypes = {
    ['Female666'] = {
        noAnimation = true, -- if this is true, real opponent or player will not sing along with the extra character
        noMissAnimation = true, -- if this is true, real player will not play their miss animations if this notetype has been missed
        singSuffix = '', -- instead of "singLEFT" etc, it will be "singLEFT"+suffix, e.g. if you put '-alt' then "singLEFT-alt"
        missSuffix = '' -- same as singSuffix, this is here just in case you dont have any extra animations for miss animations
    },

    ['Duet'] = {
        noAnimation = false, -- if this is true, real opponent or player will not sing along with the extra character
        noMissAnimation = true, -- if this is true, real player will not play their miss animations if this notetype has been missed
        singSuffix = '', -- instead of "singLEFT" etc, it will be "singLEFT"+suffix, e.g. if you put '-alt' then "singLEFT-alt"
        missSuffix = '' -- same as singSuffix, this is here just in case you dont have any extra animations for miss animations
    }
}

------------------------------------------------------------------------------------------------------------------------------------------------

createInstance(tag, 'objects.Character', {x, y, character, isPlayer})
if getProperty(tag..'.alpha') == 0.6 and getProperty(tag..'.color') == -16777216 then
    debugPrint(scriptName..': Missing character json!', 'red')
end
if order <= -1 then
    addInstance(tag)
else
    setObjectOrder(tag, order)
end

function onCountdownTick(counter)
    if getProperty(tag..'.danceIdle') or counter % 2 == 0 then
        callMethod(tag..'.dance')
    end
end

function onUpdatePost()
    if isPlayer then
        if not botPlay then
            for i = 0, getProperty('keysArray.length')-1 do
                if keyPressed(getProperty('keysArray['..i..']')) then return end
            end
        end
        if getProperty(tag..'.holdTimer') > stepCrochet * (0.0011 / getPropertyFromClass('flixel.FlxG', 'sound.music.pitch')) * getProperty(tag..'.singDuration') and stringStartsWith(getProperty(tag..'.animation.name'), 'sing') and not stringEndsWith(getProperty(tag..'.animation.name'), 'miss') then
            callMethod(tag..'.dance')
        end
    end
end

function onBeatHit()
    if curBeat % getProperty(tag..'.danceEveryNumBeats') == 0 and not stringStartsWith(getProperty(tag..'.animation.name'), 'sing') and not getProperty(tag..'.stunned') then
        callMethod(tag..'.dance')
    end
end

function onCreatePost()
    for i = 0, getProperty('unspawnNotes.length')-1 do
        for name, setting in pairs(noteTypes) do
            if getProperty('unspawnNotes['..i..'].noteType') == name then
                setProperty('unspawnNotes['..i..'].noAnimation', setting.noAnimation)
                setProperty('unspawnNotes['..i..'].noMissAnimation', setting.noMissAnimation)
            end
        end
    end
end

function noteMiss(_, d, t)
    if getProperty(tag..'.hasMissAnimations') then
        for name, setting in pairs(noteTypes) do
            if t == name and isPlayer then
                playAnim(tag, getProperty('singAnimations')[d+1]..'miss'..setting.missSuffix, true)
                setProperty(tag..'.holdTimer', 0)
            end
        end
    end
end

function goodNoteHit(_, d, t)
    for name, setting in pairs(noteTypes) do
        if t == name and isPlayer then
            playAnim(tag, getProperty('singAnimations')[d+1]..setting.singSuffix, true)
            setProperty(tag..'.holdTimer', 0)
        end
    end
end

function opponentNoteHit(_, d, t)
    for name, setting in pairs(noteTypes) do
        if t == name and not isPlayer then
            playAnim(tag, getProperty('singAnimations')[d+1]..setting.singSuffix, true)
            setProperty(tag..'.holdTimer', 0)
        end
    end
end
