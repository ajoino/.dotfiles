P = function (arg)
    print(vim.inspect(arg))
end

RELOAD = function(...)
    return require"plenary.reload".reload_module(...)
end

R = function(name)
    RELOAD(name)
    return require(name)
end
