pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
cube = {{{-1,-1,-1}, -- points
 {-1,-1,1},
 {1,-1,1},
 {1,-1,-1},
 {-1,1,-1},
 {-1,1,1},
 {1,1,1},
 {1,1,-1},
 {-0.5,-0.5,-0.5}, -- inside
 {-0.5,-0.5,0.5},
 {0.5,-0.5,0.5},
 {0.5,-0.5,-0.5},
 {-0.5,0.5,-0.5},
 {-0.5,0.5,0.5},
 {0.5,0.5,0.5},
 {0.5,0.5,-0.5}},
{{1,2}, -- lines
 {2,3},
 {3,4},
 {4,1},
 {5,6},
 {6,7},
 {7,8},
 {8,5},
 {1,5},
 {2,6},
 {3,7},
 {4,8},
 {2,10},
 {3,11},
 {4,12},
 {5,13},
 {6,14},
 {7,15},
 {8,16}}}
function _init()
cam = {0,0,-2.5} -- initialise the camera position
mult = 64 -- view multiplier
a = flr(rnd(3))+1 -- angle for random rotation
t = flr(rnd(50))+25 -- time until next angle change
end
function _update()
-- handle the inputs
if btn(0) then cam[1] -= 0.1 end
if btn(1) then cam[1] += 0.1 end
if btn(2) then cam[2] += 0.1 end
if btn(3) then cam[2] -= 0.1 end
if btn(4) then cam[3] -= 0.1 end
if btn(5) then cam[3] += 0.1 end
t -= 1 -- decrease time until next angle change
if t <= 0 then -- if t is 0 then change the random angle and restart the timer

t = flr(rnd(50))+25 -- restart timer
a = flr(rnd(3))+1 -- update angle
end
cube = rotate_shape(cube,a,0.01) -- rotate our cube
end
function _draw()
cls() -- clear the screen
print("t="..t,0,6*0) -- print time until angle change
print("x="..cam[1],0,6*1) -- print x, y, and z location of the camera
print("y="..cam[2],0,6*2)
print("z="..cam[3],0,6*3)
draw_shape(cube) -- draw the cube
end
function draw_shape(s,c)
for l in all(s[2]) do -- for each line in the shape...
 draw_line(s[1][l[1]], s[1][l[2]], c) -- draw the line
end
end
function draw_line(p1,p2,c)
 x0, y0 = project(p1) -- get the 2d location of the 3d points...
 x1, y1 = project(p2)
 line(x0, y0, x1, y1, c or 10) -- and draw a line between them
end
function draw_point(p,c)
x, y = project(p) -- get the 2d location of the 3d point...
pset(x, y, c or 11) -- and draw the point
end
function project(p)
x = (p[1]-cam[1])*mult/(p[3]-cam[3]) + 127/2
-- calculate x and center it
y = -(p[2]-cam[2])*mult/(p[3]-cam[3]) + 127/2
-- calculate y and center it
return x, y -- return the two points
end

function translate_shape(s,t)
ns = {{},s[2]}
-- copy the shape, but zero out the points and keep the lines
for p in all(s[1]) do -- for each point in the original shape...
 add(ns[1],{p[1]+t[1],p[2]+t[2],p[3]+t[3]})
 -- add the displacement to the point and add it to our new shape
 end
return ns -- return the new shape
end
function rotate_shape(s,a,r)
ns = {{},s[2]}
-- copy the shape, but zero out the points and keep the lines
for p in all(s[1]) do -- for each point in the original shape...
 add(ns[1], rotate_point(p,a,r))
 -- rotate the point and add it to the new shape
end
return ns -- return the new shape
end
function rotate_point(p,a,r)
-- figure out which axis we�█▥re rotating on
if a==1 then
 x,y,z = 3,2,1
elseif a==2 then
 x,y,z = 1,3,2
elseif a==3 then
 x,y,z = 1,2,3
end
_x = cos(r)*(p[x]) - sin(r) * (p[y])
-- calculate the new x location
 _y = sin(r)*(p[x]) + cos(r) * (p[y])
-- calculate the new y location
np = {}
-- make new point and assign the new x and y to the correct axes
np[x] = _x
np[y] = _y
np[z] = p[z]
return np -- return new point
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
