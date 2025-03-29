function goodNoteHit(_, d, t)
    bothSing(d, t)
end
function opponentNoteHit(_, d, t)
    bothSing(d, t)
end

function noteMiss(_, d, t) 
    bothSing(d, t, true) 
end

function bothSing(d, t, m)
   if t == 'GF Duet' then

         playAnim('gf', getProperty('singAnimations')[d+1]..(m and '-miss' or ''),true)
        setProperty('gf.holdTimer', 0)
      end 
end