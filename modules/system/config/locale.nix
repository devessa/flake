{lib, ...}: {
  time = {
    timeZone = lib.mkDefault "America/Indiana/Indianapolis";
    hardwareClockInLocalTime = lib.mkDefault true;
  };
}
