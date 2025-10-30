{ lib, ... }:
{
  options = {
    username = lib.mkOption {
      type = lib.types.str;
      description = "username for default user";
      default = "nick";
    };
  };
}
