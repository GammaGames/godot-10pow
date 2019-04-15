---
title: Rules
date: 2019-04-15 03:30 PM
previous: 
    url: /
next: 
    url: /examples
signoff: false
---

* The project can have only one scene
* The one scene can consist of at most 10 nodes
  * Autoload nodes count as a single node
  * You **can** duplicate nodes using code at runtime
  * You **cannot** create new nodes using code at runtime
* Each node may have a script, but each script can have no more than 100 lines
  * This includes comments and whitespace
  * Length is to encourage documentation
* The total project size can be no larger than 1MB in size
  * This allows users to include textures, sounds, 3D models, etc
