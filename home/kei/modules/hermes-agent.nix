{ config, inputs, ... }:

{
  imports = [
    inputs.hermes-agent.homeManagerModules.default
  ];

  programs.hermes-agent.enable = true;

  services.hermes-agent = {
    enable = true;

    settings = {
      model.default = "deepseek/deepseek-v4.1-flash";
    };

    # FILL: write OPENROUTER_API_KEY=... here, mode 600. Never via `environment`
    # or `settings` — anything in a Nix expression lands in the world-readable store.
    # Activation merges this into $HERMES_HOME/.env on every rebuild.
    environmentFiles = [ "${config.home.homeDirectory}/.hermes/env" ];

    # Messaging (Telegram/Discord/Slack) needs the extras sealed into the venv at
    # build time, plus the user-level service running past logout:
    #   gateway.enable = true; extraDependencyGroups = [ "messaging" ];
  };
}
