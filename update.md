# Logic Engine Update 2.0
Hi everyone, I'm so proud to announce the upcoming update for my Logic Engine. For those who don't know, Logic Engine is a free and open-source Logic Circuit Simulator. 

![](https://img.itch.zone/aW1nLzY2MTE1MzIucG5n/original/wNbhMI.png)

The program was built in one month, so it was buggy. During summer, I had time to sit and redesign the application, so I did. And with the upcoming patch, I'm presenting you with a completely redesigned version of my application. 
* Now, let's check out each part of the upcoming update.

## UI Redesign
* UI is completely redesigned with cleaner aspects to provide you with as much space as possible.
* It keeps all pre-existing features but provides in a much cleaner and eye-pleasing way.
  
![UI Redesign](https://img.itch.zone/aW1nLzY2MTE1MzUucG5n/original/%2FqKjPH.png)

## Introducing Package Manager : 
* The new patch features a package manager which allows users to download and upload custom tools (such as `prefabs`). That way, you can start building logic tools faster than ever.

![](https://img.itch.zone/aW1nLzY2MTE1OTYucG5n/original/lF1Vwx.png)

## Optimization :
* The project is entirely rewritten with static-typing in Godot 3.3 to improve the performance.
* I worked hard on optimizing the previous code. And I'm happy to see the better results.
* Instead of custom tools, I used `GraphNode`  and  `GraphEdit`, which are more optimized.

![](https://img.itch.zone/aW1nLzY2MTE2MDAucG5n/original/vV7REm.png)


## Redesigned file Structure : 
* The saving files option had to be redesigned due to the implementation of the package manager. They will keep using `JSON`  files but in a cleaner way.
  
![](https://img.itch.zone/aW1nLzY2MTE2MjUucG5n/original/0SHS5q.png)

## Bug Fixes :
* Current version of the application had many bugs, and most will be fixed until the release.


## Upcoming Features : 
* Linux Support ( From now on, this will be one of my priorities )
* Text Editor
* Server for Package Manager


