# Quadratum (UNFINISHED)
Quadratum is an arcade shooter roguelite where you control a box and try to survive the attacks of your enemy.

https://github.com/rchiedev/Quadratum/assets/92310253/961e052e-2a94-4a09-81f1-98b0f1bc84aa

# About the project
This is my second project created to learn game development using Godot Engine. I chose to make a shooter roguelike as it is one of my favorite game genres.

Actually before publishing <a href="https://github.com/rchiedev/Emojika" target="_blank">Emojika</a>, i tried on making a similar game, a shooter 2d roguelike that is more inspired by <a href="https://store.steampowered.com/app/311690/Enter_the_Gungeon/" target="_blank">Enter the Gungeon</a>. After about 3 - 4 weeks of development, I realized that the scope of the project was too big for my current skill. I got lost on the project. I know what i should make but i did not break the tasks into smaller parts (Ex. Bosses, Items) which makes me hesitant on doing them even though they are core gameplay mechanics and instead keep on focusing on other unimportant parts of the game (Polishing, Effects).

Hopefully by doing a smaller project like this one. I will get a better idea on how to properly scope games before starting on developing them. With this project also hopefully i learn on how to develop the core mechanics and maybe one day improve them when I'm ready to develop a game with bigger scale.

Things that i learned from this project are:
+ Scene Inheritance (Enemy units)
+ Signal management using Signal Bus
+ Game state management (Wave, Gems)
+ UI Updates based on game states.
+ Particle effects

Things that are still in development:
+ Pause Menu
+ Small upgrade systems every round end, purchasable using the gems
+ Proper difficulty ramp and game balance
+ Sound Effects
+ More enemy types
+ Maybe a boss (?)

Things that i wish to learn and improve more:
+ Scene Structure especially the UI.
+ Particle effects, how and when to use them. (So far i only use them on hits or spawn. I need to learn on how to do them when objects disappear/queued free)
+ Proper Signal Bus management (Concern on over-using the signal system).
+ Better thought process on Inheritance (Could've made a Unit scene and both enemies and player could inherit from that).
+ Github (i STILL have absolutely 0 idea how this platform works).

# Special Thanks
+ a327ex for inspiration on the project's artstyle
+ blobfish's Brotato for inspiration on the project's gameplay
+ Kenney for the assets

# Known Issues 
Some issues i notice and will fix some time in the future
+ (URGENT) Bullets stutter and teleports when gameplay fps lags (Most likely have to do with the delta usage)
