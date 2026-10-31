{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.modules.base.localai.enable {
    nixpkgs.overlays = [
      (final: prev: {
        pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
          (pyFinal: pyPrev: {
            posthog = pyPrev.posthog.overridePythonAttrs (old: {
              disabledTests = (old.disabledTests or [ ]) ++ [
                "test_prepare_tool_result_delivers_into_call_tool_result_models"
              ];
            });
          })
        ];
      })
    ];

    environment.systemPackages = with pkgs; [
      open-webui
    ];

    services.ollama = {
      enable = true;
    };
  };
}
