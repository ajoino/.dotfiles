local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
    print("mason did not load")
    return
end

mason.setup()
