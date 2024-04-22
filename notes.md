#### 04/14

spent 4-5 hours on game jam. learning godot (2d game tutorial + skimming docs); started planning out game

started on shop theme (3 hrs) + title screen theme
made basic tilesheet

#### 04/15

Started work on pause menu

Got basic pause menu to work (resume/exit game + menu navigation), learned a bit about focus and signals
Worked on player movement, drill display code
Got basic clock to work
got drill to deal damage to rocks, having a hard time connecting everything

made rocks collidable, very basic tilemap
particles on rock health decrease
made simple camera

(8-9 hours so far)

##### 04/16

Made dictionary of collected items
implemented drill power drain; started on results screen, tested first web export
made basic flashlight
made ship
added sfx

(8-9 hours so far)

##### 04/17

added game over screen
started on shop screen
modified results screen, goes to shop screen now so that's cool
started connecting UI screens
can no longer use tools if player power <= 0
finally added footsteps
added explosions/bombs (but explosions need some tuning, range doesn't match sprite)
added charging SFX

(11-12 hours so far)

##### 04/18

painful but necessary process of moving player/ship/ship ui out of the cave scene and reconnecting everything
working on scene transitions/saving memory between cave and overworld

(4-5 hours so far)

##### 04/19

fixed a bug where ship/ramp/ui wouldn't display when loading overworld again
finally fixed issues with ship ui and canvasmodulate
made simple day/night light cycle for overworld
added ambient cave noises
added overtime pay
added short intro "cutscene"
updated brian sprite / quotes in shop
added wind sfx at night; overworld day theme sketch

(7-8 hours so far)

##### 04/20

started reorganizing code for inventory
added basic sword
got basic inventory UI working


inventory has been more difficult than expected / burnt out

(4-5 hours so far)

##### 04/21

continued work on inventory hotbar
fixed bomb rendering bug
battery pickups don't do anything if player charge is full
corrected explosion range + lighting scale
finished basic inventory ui
added small rock, big rock, iron
added flashlight icon
added tutorial screen
fixed bug where cave wouldn't reset after day change
added warp
added speed
game over screen: "play again" resets globals / goes back to tutorial
fleshed out item tab in shop screen
shop adds to items now

(6-7 hours so far)

TODO cave gen

TODO today: start making world?
TODO: test enemy?
TODO: medkit pickup
TODO: add dead player sprite
TODO: queue free mobs/explosions/etc on death
TODO: add few seconds wait before missing? / killed screen transition
TODO: finish out credits page
TODO: work on day theme
TODO: warp particles/sfx

TODO pause menu [x]
player movement?
figure out levels
game over screen
results screen
shop screen
globals
lighting
tilemaps


10/s - drill

15m rock - 6s
30m coal - 12s
