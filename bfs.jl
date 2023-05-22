function bfs(adjacencyMatrix, startNode)
    numNodes = size(adjacencyMatrix, 1)
    visited = falses(numNodes)
    queue = Int[]

    visited[startNode] = true
    push!(queue, startNode)

    visitedOrder = Int[]

    while !isempty(queue)
        currentNode = shift!(queue)
        push!(visitedOrder, currentNode)

        for i in 1:numNodes
            if adjacencyMatrix[currentNode, i] == 1 && !visited[i]
                visited[i] = true
                push!(queue, i)
            end
        end
    end

    return visitedOrder
end
