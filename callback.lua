minetest.register_privilege("ownerTag", "is an owner of the server") 

colours = { "yellow", "cyan", "red", "white" }

rankO = minetest.colorize(colours[4], "[").. minetest.colorize(colours[1], "Owner").. minetest.colorize(colours[4], "] ")
rankA = minetest.colorize(colours[4], "[").. minetest.colorize(colours[2], "Admin").. minetest.colorize(colours[4], "] ")
rankP = minetest.colorize(colours[4], "[").. minetest.colorize(colours[3], "Player").. minetest.colorize(colours[4], "] ")

minetest.register_on_mods_loaded(function()
    minetest.register_on_chat_message(function(name, message)
        for k, ref in pairs(minetest.get_connected_players()) do
            local receiver = ref:get_player_name()
            local vtable = minetest.get_version().string:split('-')[1]:split('.')

            local player = minetest.get_player_by_name(name);
            
            for _, nameUser in ipairs(minetest.get_connected_players()) do
                if minetest.check_player_privs(name, { server = true, ownerTag = true }) then
                    rankChosen = rankO
                elseif minetest.check_player_privs(name, { server = true }) and not minetest.check_player_privs(name, { ownerTag = true }) then
                    rankChosen = rankA
                else
                    rankChosen = rankP
                end
            end

            if (receiver ~= name or (tonumber(vtable[1]) > 0 or tonumber(vtable[2]) > 4 or tonumber(vtable[3]) >= 15)) and not ignore.get_ignore(name, receiver) then
                minetest.chat_send_player(receiver, ("%s%s: %s"):format(rankChosen, name, message))
            end
        end

        return true
    end)
end)
