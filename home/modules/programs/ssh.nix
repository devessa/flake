{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "dess@kyoline.dev" = {
        host = "gitlab.com github.com 192.168.1.203";
        identitiesOnly = true;
        identityFile = [
          "~/.ssh/id_dess"
        ];
      };
    };
  };
}
