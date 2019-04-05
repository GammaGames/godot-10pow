# godot-10pow

<sup>Challenge idea from [/u/thismarty](https://www.reddit.com/r/godot/comments/b90if7/a_godot_10liners_contest/ek2u8n7?utm_source=share&utm_medium=web2x) and [/u/MrMaidx](https://www.reddit.com/r/godot/comments/b90if7/a_godot_10liners_contest/ek3f9sf?utm_source=share&utm_medium=web2x)</sup>

* 1 (10<sup>0</sup>) scene
* 10 (10<sup>1</sup>) nodes
* 100 (10<sup>2</sup>) loc/script
* 1000 (10<sup>3</sup>) KB max

The rules are pretty simple:
* One main scene allowed
* The one scene can consist of 10 nodes max
  * Autoload nodes count as a single node
  * You can duplicate nodes using code at runtime
* Each node may have a script, but each script can have no more than 100 lines
  * This includes comments and whitespace
  * The length is to encourage documentation
* The total project size can be 1MB no larger in size
  * This allows users to include textures, sounds, 3D models, etc

The rules may change, we are still determining the legality of if the following:
  * Creating new child nodes at runtime
  * How addons should work in the constraints
