local status_ok, jenkins = pcall(require, "nvim-jenkinsfile-linter")
if not status_ok then
    print("Could not start jenkins linter.")
    return
end

jenkins.setup ()
