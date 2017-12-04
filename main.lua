minutes = 02
seconds = 00
label = ""

local i = 1

function love.load()
	love.window.setMode(1080, 720)
	love.graphics.setNewFont("digital-7 (mono).ttf", 256)
	text_color(blue)
end

function text_color(color)
	love.graphics.setColor(color.red, color.green, color.blue)
end

function set_timer(color)
	minutes = color.minutes
	seconds = color.seconds
end

green = {red=0, green=255, blue=0, minutes=2, seconds=0}
amber = {red=255, green=194, blue=0, minutes=2, seconds=0}
red = {red=255, green=0, blue=0, minutes=2, seconds=0}
blue = {red=0, green=0, blue=255, minutes=0, seconds=30}

states = {
	red,
	blue,
	amber,
	blue,
	green,
}

function love.keypressed(key, scancode, isrepeat)
	if key == "escape" then
		love.event.quit()
	end
end

function love.update(dt)
	if minutes < 0 and seconds < 0 then return end

	seconds = seconds - 1

	if (seconds <= 0) then
		if (minutes > 0) then 
			seconds = 59
			minutes = minutes - 1
		elseif (minutes <= 0) then
			i = i + 1
		end
	end

	label = string.format("%02d:%02d", minutes, seconds)

	love.timer.sleep(1)
end

function love.draw(dt)
	love.graphics.printf(label, 0, 720/2, 1080, 'center')
end

