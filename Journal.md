# Dungeon of the 4 Torches - Development Journal

## Development Updates

## Day 1 [07/01/2026]

### Initial Setup
- **Changes**:
  - Project initialized with Godot
  - Added project structure with Scenes, Scripts, and Assets directories

### Player System
- **Changes**:
  - Created player scene with ANimatedSPrite2D and collision Shape2D nodes a Child.
  - Implemented player script with basic movements
  - Added FREE Adventurer 2D Pixel Art assets for player character
  - Player sprite includes animations: ATTACK 1, and other movement animations

### Enemy System - Slimes
- **Changes**:
  - Created slime enemy scene with ANimatedSPrite2D and collision Shape2D nodes a Child.
  - Implemented slime script in which I defined some states and also added Player Follow Logic
  - Added slime sprite assets with animations:
    - Animations: Attack, Death, Hurt, Idle, Run, Walk

#### In  Summary I have completly Intialized the Project with Basic Player and a baic enemy Slime and I have also named 2D Physics Layer as required like layer 2 i for Player and layer 3 is for Enemy. 

---

## Day 2 [08/01/2026] (Time took around 3-4 hours)

### Player System
- **Changes**:
  - Created StateMAchine and States for the Player.
  - Distributed the Player Code and functionality into States
  - Added Attack Logic to the Player With ShapeCast2D intead of Area2D (not Properly Working Yet)
  - Change the Player Collision Shape and Offset accordng to needs of Y-Sorting

### Enemy System - Slimes
- **Changes**:
  - Added Movement Logic For the Slime.
  - Created 2 States for the Slime Idle,Follow and Attack and all 3 of them are working
  - Added Attack and Invul Timer to the Slime

### World Changes
- **Changes**:
  - Added assets from itch.io into the Game for testing
  - Created Some Decorations and floor and also tested Y-Sorting

## Day 3 [09/01/2026]

### Player System
- **Changes**:
  - Fixed the Attack Animation Bug
  - Added Damage For Attacks which means Player Can now Damage ands kill Enemies
  - ShapeCast2D now Perfectly alligns with Player

### Enemy System - Slimes
- **Changes**:
  - Created Two New States Death and Hurt.
  - Added Logic for Death and Hurt
  - Slime ca Die and damage the Player now.

  ### World Changes
- **Changes**:
  - Created Box as a RigidBody2D for Puzzles.
  - Created SPikes to Damage Player.

## Day 4[10/01/2026]
- **Changes**
  - Updated health system and add health bar UI; fix spike activation logic

## Dayy 4[11/01/2026]
- **Changes**
  - Fixed Many Bugs in the Player.
  - Gave Hearts to the Player as a Health Bar
  - Added Boss to the Game
  - Created and added all the 5 Rooms and decorated them.
  - Added Traps with Different Timers
  - Added Keys to Collect and Unlock the North Door
  - Did Many Other Things (can't Describe right now I am tired) and there are still bugs in the game which I will solve today