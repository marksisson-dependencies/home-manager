{ home-manager, runCommand }:

let

  hmBashLibInit = ''
    export TEXTDOMAIN=home-manager
    export TEXTDOMAINDIR=${home-manager}/share/locale
    source ${home-manager}/share/bash/home-manager.sh
  '';

in runCommand "home-manager-install" {
  propagatedBuildInputs = [ home-manager ];
  preferLocalBuild = true;
  shellHookOnly = true;
  shellHook = ''
    confDir="''${XDG_CONFIG_HOME:-$HOME/.config}/nixpkgs"
    exec ${home-manager}/bin/home-manager init --switch "$confDir"
  '';
} ''
  ${hmBashLibInit}
  _iError 'This derivation is not buildable, please run it using nix-shell.'
  exit 1
''
