-- Flexible Coordinate System Configuration

-- This table stores all coordinates and their associated jobs.
local coordinates = {
    -- Example of multiple jobs for a single coordinate
    { x = 100, y = 200, jobs = {"job1", "job2"} },
    -- Example of individual job coordinates
    { x = 150, y = 250, job = "job3" },
}

-- Function to add a new coordinate with customizable options
function addCoordinate(x, y, jobs)
    table.insert(coordinates, { x = x, y = y, jobs = jobs })
end

-- Function to get coordinates for a specific job
function getCoordinatesForJob(job)
    local result = {}
    for _, coord in ipairs(coordinates) do
        if coord.jobs then
            for _, j in ipairs(coord.jobs) do
                if j == job then
                    table.insert(result, coord)
                end
            end
        elseif coord.job == job then
            table.insert(result, coord)
        end
    end
    return result
end

-- Example Usage
-- addCoordinate(200, 300, {"job4"})

return coordinates
