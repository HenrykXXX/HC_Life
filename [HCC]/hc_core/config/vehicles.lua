HC.Config.Vehicles = {
    {
        --panto
        model = -431692672,
        basePrice = 5000,
        trunkCapacity = 48,
    }
}

function HC.Config.Vehicles.GetPrice(model)
    local price = 0

    for _, veh in ipairs(HC.Config.Vehicles) do
        if veh.model == model then
            price = veh.basePrice
            break
        end
    end

    return price
end

function HC.Config.Vehicles.GetTrunkCapacity(model)
    local capacity = 0

    for _, veh in ipairs(HC.Config.Vehicles) do
        if veh.model == model then
            capacity = veh.trunkCapacity
            break
        end
    end

    return capacity
end

