{ config, pkgs, ... }:

{
  targets.genericLinux.enable = true;
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "anes";
  home.homeDirectory = "/home/anes";

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
      plugins = [ "git" "kubectl" "kube-ps1" "npm" ];
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
    extraConfig = ''
      set-option -g focus-events on
      set-option -sa terminal-overrides ",XXX:RGB"

      is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

      is_fzf="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?fzf$'"

      bind -n C-h run "($is_vim && tmux send-keys C-h) || tmux select-pane -L"

      bind -n C-j run "($is_vim && tmux send-keys C-j) || ($is_fzf && tmux send-keys C-j) || tmux select-pane -D"

      bind -n C-k run "($is_vim && tmux send-keys C-k) || ($is_fzf && tmux send-keys C-k) || tmux select-pane -U"

      bind -n C-l run  "($is_vim && tmux send-keys C-l) || tmux select-pane -R"

      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'

      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -n 'C-Space' if-shell "$is_vim" 'send-keys C-Space' 'select-pane -t:.+'

      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R
      bind-key -T copy-mode-vi 'C-\' select-pane -l
      bind-key -T copy-mode-vi 'C-Space' select-pane -t:.+
    '';
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
    btop
    neofetch
  ];

  xdg.configFile.nvim = {
    source = ./config/nvim;
    recursive = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}

