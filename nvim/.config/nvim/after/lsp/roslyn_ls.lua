local function is_unity_project(root)
    return root ~= nil and vim.uv.fs_stat(vim.fs.joinpath(root, "ProjectSettings", "ProjectVersion.txt")) ~= nil
end

return {
    before_init = function(_, config)
        if is_unity_project(config.root_dir) then
            config.settings["csharp|background_analysis"] = {
                dotnet_analyzer_diagnostics_scope = "openFiles",
                dotnet_compiler_diagnostics_scope = "openFiles",
            }
        end
    end,
    settings = {
        ["csharp|background_analysis"] = {
            dotnet_analyzer_diagnostics_scope = "fullSolution",
            dotnet_compiler_diagnostics_scope = "fullSolution",
        },
        ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = false,
        },
        ["csharp|formatting"] = {
            dotnet_organize_imports_on_format = true,
        },
    },
}
