{...}:
let
  aliases = {
    ls="eza";
    la="eza -la --group-directories-first --git";
    ll="eza -l --group-directories-first --git";
    lt="eza -l --tree --git";
    lta="eza -la --tree --git-ignore --git";

    ssh="TERM=xterm-256color ssh";

    # You never know what you might type
    v="nvim";
    vi="nvim";
    vim="nvim";

    vimdiff="nvim -d";
    vd="nvim -d";

    ### Git stuff
    # should check out git aliases as well
    gil="git pull";
    gip="git push";
    gco="git checkout";
    gs="git switch";
    gsl="git log --abbrev-commit --oneline";
    gl="git log";
    gnb="git checkout -b";
    gam="git commit -am" ;
    gm="git commit -m" ;
    gst="git status" ;

    ".."="cd ..";
    "..."="cd ../..";
    "...."="cd ../../..";
  };
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
      "INC_APPEND_HISTORY"
      "SHARE_HISTORY"
    ];
    histFile = "$HOME/.local/share/zsh/history";
    histSize = 10000;
    shellAliases = aliases;
  };
}
