setProperty('skipCountdown', true)

local playVideo = true
function onStartCountdown()
    if playVideo then
        startVideo('indomitablecutscene')
        runTimer('end', 13.3)
        playVideo = false
        return Function_Stop
    end
end

function onTimerCompleted(tag)
    if tag == 'end' then
        startCountdown()
    end
end
