---
layout: single
title: "Graph problems"
date: 2021-11-12 09:08:53 +0200
categories: development
comments: true
lang: en
tags: 
image: 
---

Graph is a collection of nodes and edges. 

We have directed and undirected graphs

Graphs are really useful to explain relationships between things, for instance we can represent a map of cities with a graph

adjacency list is the favourite way to represent a graph. It's implemented with a HashMap. The values are going to be in an array. Even that a node has no neighbours it should appear in the map but with empty value

Aciclic graph has no cicles that can lead to infinite traversal.

Most known algorithms

DFS -> depth first search (busqueda en profundidad)
In this case we start in a node and we pick a direction and continue in the same direction until we cannot continue. You are exploring one direction as far as you can before switching directions.
It uses a stack. We have to see as a vertical data structure.

```javascript
const depthFirstPrint = (graph, source) => {
    const stack = [source];
    while(stack.lenght > 0){
        const current = stack.pop();
        console.log(current);
        for(let neighbor of graph[current]){
            stack.push(neighbor);
        }
    }
};

const graph = {
 a: ['c', 'b'],
 b: ['d']
 c: ['e']
 d: ['f']
 e: []
 f: []
}

```

BFS -> breath first search (busqueda en ancho)
We explore all the inmediate neighbours from a starting node.
A queue: you add to the back and take from the front.

```javascript
const breathFirstPrint = (graph, source) => {
    const queue = [source];
    while(queue.lenght > 0){
        const current = queue.shift();
        console.log(current);
        for(let neighbor of graph[current]){
            queue.push(neighbor);
        }
    }
};

const graph = {
 a: ['c', 'b'],
 b: ['d']
 c: ['e']
 d: ['f']
 e: []
 f: []
};

breathFirstPrint(graph, 'a');

```

Problem 1:

There's a path between two nodes of a graph:

```javascript
const hasPath = (graph, src, dst) => {

    if(src==dst) return true;

    for(let neighbor of graph[src]){
        if(hasPath(graph,neighbor, dst)== true){
            return true;
        }
    }

    return false;
}

```

Problem 2:

Connected components count:

public int connectedComponentsCount(Map<Node, List<Node>> graph){

    Set<Node> visited = new HashSet<>();

    int count = 0;
     
    for(Node node: graph) {
      if (explore(graph, node,visited)){
        count++;
      }
    } 
    return count;
}

public boolean explore()


Problem 3:

Largest component problem:


Problem 4:

Shortest path problem:




### Conclusion

