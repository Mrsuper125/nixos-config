{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./features/kitty.nix
    ./features/waybar.nix
    inputs.nix-colors.homeManagerModules.default
  ];

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  nixpkgs.config = {
    allowUnfree = true;
  };
  home = {
    username = "alex";
    homeDirectory = "/home/alex";

    stateVersion = "23.11"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = with pkgs; [
      nitch
    ];
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # wayland.windowManager.hyprland = {
  #   enable = true;
  # };
}
