# Quadratum
Quadratum is an arcade shooter roguelite where you control a box and try to survive the attacks of your enemy.
Play it here: https://thermian.itch.io/quadratum

https://github.com/rchiedev/Quadratum/assets/92310253/e62b5c17-95e8-4986-b04b-bc9db761301b

# About the project
This is my second project created to learn game development using Godot Engine. I chose to make a shooter roguelike as it is one of my favorite game genres.
This project is worked on for 11 days, where i spend on average 2 hours a day, so 22 hours spent in total.

Actually before publishing <a href="https://github.com/rchiedev/Emojika" target="_blank">Emojika</a>, i tried on making a similar game, a shooter 2d roguelike that is more inspired by <a href="https://store.steampowered.com/app/311690/Enter_the_Gungeon/" target="_blank">Enter the Gungeon</a>. After about 3 - 4 weeks of development, I realized that the scope of the project was too big for my current skill. I got lost on the project. I know what i should make but i did not break the tasks into smaller parts (Ex. Bosses, Items) which makes me hesitant on doing them even though they are core gameplay mechanics and instead keep on focusing on other unimportant parts of the game (Polishing, Effects).

Hopefully by doing a smaller project like this one. I will get a better idea on how to properly scope games before starting on developing them. With this project also hopefully i learn on how to develop the core mechanics and maybe one day improve them when I'm ready to develop a game with bigger scale.

Things that i learned from this project are:
+ Scene Inheritance (Enemy units)
+ Scene Transitions
+ Signal management using Signal Bus
+ Game state management (Wave, Gems)
+ UI Updates based on game states.
+ Interactable UIs (Shop, Game over screen)
+ Small Particle effects

Things that i wish to learn and improve more:
+ Scene Structure especially the UI.
+ Proper difficulty ramp and game balance.
+ More enemy AIs and proper management of them.
+ Particle effects, how and when to use them. (So far i only use them on hits or spawn. I need to learn on how to do them when objects disappear/queued free)
+ Proper Signal Bus management (Concern on over-using the signal system).
+ Better thought process on Inheritance (Could've made a Unit scene and both enemies and player could inherit from that).
+ Use proper SFX and Music (Currently i just use whatever that might fit and fill the game, need to learn on how to get and implement both of them)
+ Font and theme management
+ Github (i STILL have absolutely 0 idea how this platform works).

I notice that i really struggle in 2 things that kept me from advancing:
+ I did the project very slowly, 2 hours a day is basically nothing. I should've spent more time on the game, so i can finish it faster, implement more content, and move on to learn with new project faster. Most likely i will try to learn by finishing 1 project every week.
+ It feels very hard to keep working on the game when I don't see any progress VISUALLY, art or audios. I think this is also the reason why i do the project very slowly and definitely something i need to avoid.

# Special Thanks
+ a327ex for inspiration on the project's artstyle
+ blobfish's Brotato for inspiration on the project's gameplay
+ Kenney for the assets
+ Daniel Linssen for the pixel font

# Known Issues 
Some issues i notice and will fix some time in the future
+ (FIXED?) Bullets stutter and teleports when gameplay fps lags
+ Sometimes shop's prices are incorrectly colored (Price turns red when upgrade is still purchasable after refreshing)
