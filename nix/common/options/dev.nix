{ lib, ... }:
{
  options.modules.dev = {
    c.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable C/C++ tooling, might be necessary for other modules becuase this installs compilers.";
    };
    dotnet.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable Dotnet programming environment";
    };
    go.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable Go programming environment";
    };
    godot.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable Godot game engine";
    };
    javascript.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable JavaScript/TypeScript programming environment";
    };
    lua.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable Lua programming environment";
    };
    nix.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable Nix development tooling (formatters, language servers, linters)";
    };
    rust.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable Rust programming environment";
    };
    unity.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable Unity game engine";
    };
    zig.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable Zig compiler";
    };
  };

  imports = [
    ../dev/c.nix
    ../dev/dotnet.nix
    ../dev/go.nix
    ../dev/godot.nix
    ../dev/javascript.nix
    ../dev/lua.nix
    ../dev/nix.nix
    ../dev/rust.nix
    ../dev/unity.nix
    ../dev/zig.nix
  ];
}
