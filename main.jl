using LightGraphs
using Plots

include("bfs.jl")
include("asyncbfs.jl")

function drawGraph(adjacencyMatrix)
    g = Graph(adjacencyMatrix)
    node_labels = 1:nv(g)

    layout = circular_layout(g)
    Plots.plot(g, layout=layout, nodecolor=:white, edgestrokecolor=:black, nodefillcolor=:white,
               nodelabel=node_labels, nodelabelfontsize=10, nodelabelcolor=:black, nodefontsize=10)
end

function animateBFS(adjacencyMatrix, visitedOrder)
    g = Graph(adjacencyMatrix)
    node_labels = 1:nv(g)

    layout = circular_layout(g)
    Plots.plot(g, layout=layout, nodecolor=:white, edgestrokecolor=:black, nodefillcolor=:white,
               nodelabel=node_labels, nodelabelfontsize=10, nodelabelcolor=:black, nodefontsize=10)

    for (i, node) in enumerate(visitedOrder)
        Plots.annotate!([(node, text("$node", :black, :center))])
        Plots.plot!(g, layout=layout, nodecolor=:white, edgestrokecolor=:black, nodefillcolor=:yellow,
                    nodelabel=node_labels, nodelabelfontsize=10, nodelabelcolor=:black, nodefontsize=10)
        Plots.savefig("bfs_animation_$(i).png")
    end
end

# Example usage
adjacencyMatrix = [0 1 1 0 0;
                   1 0 1 1 0;
                   1 1 0 0 0;
                   0 1 0 0 1;
                   0 0 0 1 0]

startNode = 1

bfsVisitedOrder = bfs(adjacencyMatrix, startNode)
asyncBFSVisitedOrder = asyncBFS(adjacencyMatrix, startNode)

drawGraph(adjacencyMatrix)
animateBFS(adjacencyMatrix, bfsVisitedOrder)
animateBFS(adjacencyMatrix, asyncBFSVisitedOrder)
