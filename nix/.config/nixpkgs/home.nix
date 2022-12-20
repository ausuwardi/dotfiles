{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "agustian";
  home.homeDirectory = "/home/agustian";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Agustianes U. S.";
    userEmail = "anezch@gmail.com";
    extraConfig = {
      credential = {
        helper = "store";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.bat = {
    enable = true;
  };

  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "kubectl" "kube-ps1" ];
      theme = "robbyrussell";
    };

    enableAutosuggestions = true;
    envExtra = "source \"$HOME/.cargo/env\"\n";

    history = {
      extended = true;
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      character = {
        success_symbol = "[››](bold green)";
        error_symbol = "[⨳›](bold red)";
      };
      hostname = {
        ssh_only = false;
      };
      aws = {
        disabled = true;
      };
      gcloud = {
        disabled = true;
      };
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    extraConfig = "set-option g focus-events on\nset-option sa terminal-overrides ',XXX:RGB'\n";
  };

  programs.neovim = {
    enable = true;
    extraConfig = ''
      luafile ~/.config/nvim/lua/init.lua
    '';
  };

  home.packages = with pkgs; [
    gcc
    python311
    nodejs
    ripgrep
    jq
    ranger
    httpie
  ];

  xdg.configFile.nvim = {
    source = ./config/nvim;
    recursive = true;
  };
}

