{ config, inputs, pkgs, ... }:

{
  imports = [
    inputs.hermes-agent.homeManagerModules.default
  ];

  programs.hermes-agent.enable = true;

  services.hermes-agent = {
    enable = true;

    # The jcodemunch MCP server below uses uvx. uvx is part of uv.
    extraPackages = [ pkgs.uv ];

    mcpServers.jcodemunch = {
      command = "uvx";
      args = [ "--from" "git+https://github.com/jgravelle/jcodemunch-mcp.git" "jcodemunch-mcp" ];
    };

    settings = {
      model.default = "deepseek/deepseek-v4.1-flash";

      display = {
        compact = false;
        personality = "concise";
        resume_display = "full";
        resume_exchanges = 10;
        resume_max_user_chars = 300;
        resume_max_assistant_chars = 200;
        resume_max_assistant_lines = 3;
        resume_skip_tool_only = true;
        busy_input_mode = "interrupt";
        interface = "cli";
        tui_auto_resume_recent = false;
        tui_agents_nudge = true;
        bell_on_complete = false;
        show_reasoning = true;
        reasoning_full = true;
        memory_notifications = "on";
        background_process_notifications = "concise";
        streaming = true;
        timestamps = false;
        final_response_markdown = "strip";
        persistent_output = true;
        persistent_output_max_lines = 200;
        persist_prompts = true;
        inline_diffs = true;
        file_mutation_verifier = true;
        credits_notices = true;
        turn_completion_explainer = true;
        show_cost = false;
        skin = "nous";
        language = "en";
        tui_status_indicator = "kaomoji";
        user_message_preview = {
          first_lines = 2;
          last_lines = 2;
        };
        interim_assistant_messages = true;
        tool_progress_command = false;
        tool_preview_length = 0;
        tool_progress_grouping = "accumulate";
        ephemeral_system_ttl = 0;
        runtime_footer = {
          enabled = false;
          fields = [
            "model"
            "context_pct"
            "cwd"
          ];
        };
        copy_shortcut = "auto";
        busy_ack_detail = true;
        cleanup_progress = false;
        long_running_notifications = true;
        tool_progress = "all";
        sections = {
          thinking = "expanded";
        };
      };

      agent = {
        max_turns = 60;
        gateway_timeout = 1800;
        restart_drain_timeout = 180;
        api_max_retries = 3;
        tool_use_enforcement = "auto";
        task_completion_guidance = true;
        environment_probe = true;
        coding_context = "auto";
        verify_on_stop = false;
        gateway_timeout_warning = 900;
        clarify_timeout = 600;
        gateway_notify_interval = 180;
        gateway_auto_continue_freshness = 3600;
        image_input_mode = "auto";
        reasoning_effort = "max";
        verbose = false;
      };

      compression = {
        enabled = true;
        threshold = 0.5;
        target_ratio = 0.2;
        protect_last_n = 20;
        hygiene_hard_message_limit = 400;
        protect_first_n = 3;
        abort_on_summary_failure = false;
        codex_gpt55_autoraise = true;
      };

      memory = {
        memory_enabled = true;
        user_profile_enabled = true;
        write_approval = false;
        memory_char_limit = 2200;
        user_char_limit = 1375;
        nudge_interval = 10;
        flush_min_turns = 6;
      };

      terminal = {
        backend = "local";
        timeout = 180;
        persistent_shell = true;
        lifetime_seconds = 300;
        font_family = "FiraCode Nerd Font";
      };

      session_reset = {
        at_hour = 4;
        idle_minutes = 1440;
        mode = "both";
      };

      plugins = {
        enabled = [
          "disk-cleanup"
          "herdr-agent-state"
          "jev-approvals"
          "jev-curator"
          "jev-skill-router"
          "nerve"
          "security-guidance"
          "yantrikdb"
        ];
        entries = {
          "jev-curator".settings = {
            mode = "observe";
            provider = "openrouter";
            allow_content_egress = true;
          };
          "jev-skill-router".settings.mode = "on";
        };
      };

      # Skill selection for the bundled skills. Skills that you write, or that
      # the agent creates, live in HERMES_HOME. Use `hermes backup` to move
      # them. They never go through this repo.
      skills.disabled = [
        "airtable"
        "arxiv"
        "baoyu-infographic"
        "blogwatcher"
        "claude-code"
        "codex"
        "comfyui"
        "dogfood"
        "godmode"
        "google-workspace"
        "heartmula"
        "himalaya"
        "huggingface-hub"
        "jupyter-live-kernel"
        "llama-cpp"
        "llm-wiki"
        "manim-video"
        "maps"
        "nano-pdf"
        "notion"
        "opencode"
        "openhue"
        "p5js"
        "polymarket"
        "popular-web-designs"
        "powerpoint"
        "pretext"
        "segment-anything-model"
        "sketch"
        "songsee"
        "songwriting-and-ai-music"
        "teams-meeting-pipeline"
        "touchdesigner-mcp"
        "weights-and-biases"
        "yuanbao"
      ];
    };

    # FILL: write OPENROUTER_API_KEY=... in this file with mode 600.
    # Do not use `environment` or `settings` for secrets. Each value in a Nix
    # expression goes into the world-readable store. The activation merges this
    # file into $HERMES_HOME/.env at each rebuild.
    environmentFiles = [ "${config.home.homeDirectory}/.hermes/env" ];

    # Messaging (Telegram/Discord/Slack) needs the extras in the venv at build
    # time. The user-level service must also stay up after logout:
    #   gateway.enable = true; extraDependencyGroups = [ "messaging" ];
  };
}
