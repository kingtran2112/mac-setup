-- HANDLE SCROLLING WITH RIGHT MOUSE BUTTON PRESSED

local deferred = false

overrideOtherMouseDown =
  hs.eventtap.new(
  {hs.eventtap.event.types.rightMouseDown},
  function(e)
    deferred = true
    return true
  end
)

overrideOtherMouseUp =
  hs.eventtap.new(
  {hs.eventtap.event.types.rightMouseUp},
  function(e)
    if (deferred) then
      overrideOtherMouseDown:stop()
      overrideOtherMouseUp:stop()
      hs.eventtap.rightClick(e:location(), pressedMouseButton)
      overrideOtherMouseDown:start()
      overrideOtherMouseUp:start()
      return true
    end
    return false
  end
)

local oldmousepos = {}
local scrollmult = 2 -- negative multiplier makes mouse work like traditional scrollwheel, for macOS, use positive number.

dragOtherToScroll =
  hs.eventtap.new(
  {hs.eventtap.event.types.rightMouseDragged},
  function(e)
    deferred = false
    oldmousepos = hs.mouse.getAbsolutePosition()
    local dx = e:getProperty(hs.eventtap.event.properties["mouseEventDeltaX"])
    local dy = e:getProperty(hs.eventtap.event.properties["mouseEventDeltaY"])
    local scroll = hs.eventtap.event.newScrollEvent({dx * scrollmult, dy * scrollmult}, {}, "pixel")
    -- put the mouse back
    hs.mouse.setAbsolutePosition(oldmousepos)
    return true, {scroll}
  end
)

overrideOtherMouseDown:start()
overrideOtherMouseUp:start()
dragOtherToScroll:start()