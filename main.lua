minutes = 0
seconds = 0
label = ""

local i = 1
local paused = true
local bruce = love.image.newImageData("bruce.png")

function love.load()
	love.window.setMode(1080, 720)
	love.graphics.setNewFont("digital-7 (mono).ttf", 256)

	love.window.setTitle("Regular Expression")
	love.window.setIcon(bruce)

	set_timer(states[i])
	text_color(states[i])
end

function text_color(color)
	love.graphics.setColor(color.red, color.green, color.blue)
end

function set_timer(color)
	minutes = color.minutes
	seconds = color.seconds
end

purple = {red=150, green=0, blue=255, minutes=0, seconds=5}
green = {red=0, green=255, blue=0, minutes=2, seconds=0}
amber = {red=255, green=194, blue=0, minutes=2, seconds=0}
red = {red=255, green=0, blue=0, minutes=2, seconds=0}
blue = {red=0, green=255, blue=255, minutes=0, seconds=20}

states = {
	purple,
	green,
	blue,
	amber,
	blue,
	red,
}

function love.keypressed(key, scancode, isrepeat)
	if key == "escape" then
		love.event.quit()
	elseif (key == "space") or (key == " ") then
		paused = not paused
	elseif key == "left" then
		if (i == 1) then return end

		i = i - 1
		set_timer(states[i])
		text_color(states[i])
	elseif key == "right" then
		if (i == #states) then return end

		i = i + 1
		set_timer(states[i])
		text_color(states[i])
	end
end

function love.update(dt)
	if (paused) then
		label = string.format("%02d:%02d", minutes, seconds)
		return 
	end

	if (i > #states) then 
		label = string.format("end", minutes, seconds)
		return
	end

	seconds = seconds - 1

	if (seconds < 0) then
		if (minutes > 0) then 
			seconds = 59
			minutes = minutes - 1
		elseif (minutes <= 0) then
			i = i + 1

			if (i <= #states) then
				set_timer(states[i])
				text_color(states[i])
			end
		end
	end

	label = string.format("%02d:%02d", minutes, seconds)
	love.timer.sleep(1)
end

function love.draw(dt)
	love.graphics.printf(label, 0, 720/2, 1080, 'center')
end
