{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "hi@dessa.dev" = {
        host = "gitlab.com github.com";
        identitiesOnly = true;
        identityFile = [
          "~/.ssh/id_dev"
        ];
      };
      "dess_key" = {
        host = "192.168.1.203";
        identitiesOnly = true;
        identityFile = ["~/.ssh/id_dess"];
      };
    };
  };
}
