--- @diagnostic disable:undefined-global
return {
    -- print current date and time
    s(
        "cdt",
        f(function()
            return os.date "%Y/%m/%d - %H:%M"
        end)
    ),
    -- add:
    -- change_node for todo comment (TODO, DEBUG, HACK, FIX etc...)
}
