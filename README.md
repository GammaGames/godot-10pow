# godot-10pow

<sub>Challenge idea from [/u/thismarty](https://www.reddit.com/r/godot/comments/b90if7/a_godot_10liners_contest/ek2u8n7?utm_source=share&utm_medium=web2x) and [/u/MrMaidx](https://www.reddit.com/r/godot/comments/b90if7/a_godot_10liners_contest/ek3f9sf?utm_source=share&utm_medium=web2x)</sub>

* 1 (10<sup>0</sup>) scene
* 10 (10<sup>1</sup>) nodes
* 100 (10<sup>2</sup>) loc/script
* 1000 (10<sup>3</sup>) KB max

## Rules

* One main scene allowed
* The one scene can consist of 10 nodes max
  * Autoload nodes count as a single node
  * You can duplicate nodes using code at runtime
* Each node may have a script, but each script can have no more than 100 lines
  * This includes comments and whitespace
  * The length is to encourage documentation
* The total project size can be 1MB no larger in size
  * This allows users to include textures, sounds, 3D models, etc

Since this is a new project the rules are subject to modifications. We are still determining the legality of if the following:
  * Creating new child nodes at runtime
    * Would lets users use the code size limit more to its extent
    * Would allow more freedom in tree structure
  * How addons should work in the constraints
    * You could probably make a complex game with an addon (for example, VR)
