function onCreate()
    -- This function is called when the note type is loaded
    -- You can initialize any variables or assets here if needed
end

function onOpponentNoteHit(id, direction, noteType, isSustainNote)
    if noteType == 'Female666' then
        -- Play F666's animation based on the note direction
        local anim = ''
        if direction == 0 then anim = 'singLEFT'
        elseif direction == 1 then anim = 'singDOWN'
        elseif direction == 2 then anim = 'singUP'
        elseif direction == 3 then anim = 'singRIGHT' end

        objectPlayAnimation('F666', anim, true)
        setProperty('F666.holdTimer', 0)

        -- Camera follows F666 for this note type
        triggerEvent('Camera Follow Pos', getProperty('F666.x') + 10, getProperty('F666.y') + 250)
    end
end

function onUpdate(elapsed)
    -- Optional: Add any additional behavior for the custom note type here
end