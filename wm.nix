{ pkgs, ... }:
let
  awesome = pkgs.awesome.overrideAttrs (old: {
    version = "ad0290bc1aac3ec2391aa14784146a53ebf9d1f0";
    src = pkgs.fetchFromGitHub {
      owner = "awesomeWM";
      repo = "awesome";
      rev = "ad0290bc1aac3ec2391aa14784146a53ebf9d1f0";
      sha256 = "uaskBbnX8NgxrprI4UbPfb5cRqdRsJZv0YXXshfsxFU=";
    };

    patches = [ ];

    postPatch = ''
      patchShebangs tests/examples/_postprocess.lua
      '';
  });
in {
  services.xserver.windowManager = {
    awesome = {
      enable = true;
      package = awesome;
    };
  };

  services.displayManager.defaultSession = "none+awesome";
}
