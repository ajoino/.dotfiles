local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
    print("Couldn't load `null-ls`")
    return
end

null_ls.setup()
