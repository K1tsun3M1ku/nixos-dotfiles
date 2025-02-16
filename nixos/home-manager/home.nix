{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "miku";
  home.homeDirectory = "/home/miku";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs = {
    git = {
      enable = true;
      userName = "Faye Siller";
      userEmail = "faye.siller@protonmail.com";
    };
    gh = {
      enable = true;
    };
    neovim = 
    let
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in
    {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraLuaConfig = ''
        -- test Lua Code

        ${builtins.readFile ~/.dotfiles/nixos/home-manager/nvim/options.lua}

      '';
      extraPackages = with pkgs; [
        lua-language-server
        rnix-lsp

        xclip
        wl-clipboard
      ];

      plugins = with pkgs.vimPlugins; [
        # NOTE: neovim plugin has an option called type you can use to define the config type. so you can do 
        # { 
        #   plugin
        #   type = “lua”
        #   config = “lua code”
        # }
        {
          plugin = nvim-lspconfig;
          config = toLuaFile ~/.dotfiles/nixos/home-manager/nvim/plugin/lsp.lua;
        }
        {
          plugin = comment-nvim;
          type = "lua";
          config = toLua "require(\"Comment\").setup()";
        }
        {
          plugin = gruvbox-nvim;
          config = "colorscheme gruvbox";
        }
        neodev-nvim
        nvim-cmp 
        {
          plugin = nvim-cmp;
          config = toLuaFile ~/.dotfiles/nixos/home-manager/nvim/plugin/cmp.lua;
        }
        {
          plugin = telescope-nvim;
          config = toLuaFile ~/.dotfiles/nixos/home-manager/nvim/plugin/telescope.lua;
        }
        telescope-fzf-native-nvim
        cmp_luasnip
        cmp-nvim-lsp
        luasnip
        friendly-snippets
        lualine-nvim
        nvim-web-devicons
        {
          plugin = (nvim-treesitter.withPlugins (p: [
            p.tree-sitter-nix
            p.tree-sitter-vim
            p.tree-sitter-bash
            p.tree-sitter-lua
            p.tree-sitter-python
            p.tree-sitter-json
            p.tree-sitter-hyprlang
          ]));
          config = toLuaFile ~/.dotfiles/nixos/home-manager/nvim/plugin/treesitter.lua;
        }
        vim-nix
      ];
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/miku/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
