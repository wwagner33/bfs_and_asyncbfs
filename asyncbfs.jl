function asyncBFS(adjacencyMatrix, startNode)
    numNodes = size(adjacencyMatrix, 1)
    distance = fill(Inf, numNodes)
    parent = fill(-1, numNodes)
    sendBuffers = [[] for _ in 1:numNodes]

    distance[startNode] = 0
    sendBuffers[startNode] = adjacencyMatrix[startNode, :]

    visitedOrder = Int[]
    push!(visitedOrder, startNode)

    function processMessages(node)
        while !isempty(sendBuffers[node])
            neighbor, neighborDistance = popfirst!(sendBuffers[node])

            if neighborDistance + 1 < distance[neighbor]
                distance[neighbor] = neighborDistance + 1
                parent[neighbor] = node
                sendBuffers[neighbor] = adjacencyMatrix[neighbor, :]
                push!(visitedOrder, neighbor)
            end
        end
    end

    while any(!isempty, sendBuffers)
        for i in 1:numNodes
            if !isempty(sendBuffers[i])
                processMessages(i)
            end
        end
    end

    return visitedOrder
end
