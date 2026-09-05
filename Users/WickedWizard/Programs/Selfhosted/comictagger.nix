{
  config,
  pkgs,
  lib,
  ...
}:
let
  comictagger = lib.getExe (pkgs.callPackage ../../../../Packages/comictagger.nix { });
in
{
  secretspec.config.profiles.wickedwizard.COMICVINE_API_KEY.description =
    "ComicVine API Key for ComicTagger";

  xdg.configFile."ComicTagger/settings.json" = {
    text = builtins.toJSON {
      "Issue Identifier" = {
        series_match_identify_thresh = 91;
        series_match_search_thresh = 90;
        border_crop_percent = 10;
        sort_series_by_year = true;
        exact_series_matches_first = true;
      };

      "Filename Parsing" = {
        filename_parser = "complicated";
        remove_c2c = false;
        remove_fcbd = false;
        remove_publisher = false;
        protofolius_issue_number_scheme = false;
        allow_issue_start_with_letter = false;
      };

      Sources = {
        source = "comicvine";
      };

      "Metadata Options" = {
        assume_lone_credit_is_primary = false;
        copy_characters_to_tags = false;
        copy_teams_to_tags = false;
        copy_locations_to_tags = false;
        copy_storyarcs_to_tags = false;
        copy_notes_to_comments = false;
        copy_weblink_to_comments = false;
        apply_transform_on_import = false;
        apply_transform_on_bulk_operation = false;
        remove_html_tables = false;
        use_short_tag_names = false;
        cr = true;
        tag_merge = "overlay";
        metadata_merge = "overlay";
        tag_merge_lists = true;
        metadata_merge_lists = true;
      };

      "File Rename" = {
        template = "{series} ({volume})/{series} #{issue} ({year})";
        issue_number_padding = 3;
        use_smart_string_cleanup = true;
        auto_extension = true;
        dir = "";
        move = false;
        only_move = false;
        strict_filenames = false;

        replacements = [
          [
            [
              ": "
              " - "
              true
            ]
            [
              ":"
              "-"
              true
            ]
          ]
          [
            [
              ": "
              " - "
              true
            ]
            [
              ":"
              "-"
              true
            ]
            [
              "/"
              "-"
              false
            ]
            [
              "//"
              "--"
              false
            ]
            [
              "\\"
              "-"
              true
            ]
          ]
        ];
      };

      "Auto-Tag" = {
        save_on_low_confidence = false;
        use_year_when_identifying = true;
        assume_issue_one = false;
        ignore_leading_numbers_in_filename = false;
        clear_tags = false;

        publisher_filter = [
          "Panini Comics"
          "Abril"
          "Planeta DeAgostini"
          "Editorial Televisa"
          "Dino Comics"
        ];

        use_publisher_filter = false;
        auto_imprint = false;
      };

      General = {
        check_for_new_version = false;
        blur = false;
        prompt_on_save = true;
      };

      "Dialog Flags" = {
        show_disclaimer = false;
        dont_notify_about_this_version = "";
        notify_plugin_changes = true;
      };

      Archive = {
        rar = "rar";
      };

      "Source comicvine" = {
        comicvine_key = "@COMICVINE_API_KEY@";
        comicvine_url = null;
        cv_use_series_start_as_volume = true;
        comicvine_custom_parameters = null;
      };
    };
    onChange =
      config.secretspec.runtimeSecretReplacementFunc "${config.xdg.configHome}/ComicTagger/settings.json"
        {
          "@COMICVINE_API_KEY@" = config.secretspec.secrets.profiles.wickedwizard.COMICVINE_API_KEY;
        };
  };

  home.packages = with pkgs; [
    (writeShellScriptBin "tag-comics" ''
      set -uo pipefail

      SORTED_DIR="./sorted"
      LOG_DIR="./logs"
      COOLDOWN=1800
      MAX_ATTEMPTS=10
      CLEAR_TAGS=false
      EXPORT_TO_ZIP=true

      usage() {
        echo "Usage: $0 [OPTIONS] SOURCE_DIR"
        echo
        echo "Options:"
        echo "  -o DIR    Output directory (default: ./sorted)"
        echo "  -l DIR    Log directory (default: ./logs)"
        echo "  -c SEC    Rate-limit cooldown (default: 1800)"
        echo "  -m NUM    Maximum tagging attempts (default: 20)"
        echo "  -e        Export to zip & delete original. Set flag to disable (default: true)"
        echo "  -t        Clear existing tags (default: false)"
        echo "  -h        Show this help"

        echo "rar must be installed manually for cbr files"
      }

      while getopts "o:l:c:m:eth" opt; do
        case "$opt" in
          o) SORTED_DIR="$OPTARG" ;;
          l) LOG_DIR="$OPTARG" ;;
          c) COOLDOWN="$OPTARG" ;;
          m) MAX_ATTEMPTS="$OPTARG" ;;
          e) EXPORT_TO_ZIP=true ;;
          t) CLEAR_TAGS=true ;;
          h)
            usage
            exit 0
            ;;
          *)
            usage
            exit 1
            ;;
        esac
      done

      shift $((OPTIND - 1))

      SOURCE_DIR="''${1:?Source directory required. Use -h for help.}"

      mkdir -p "$SORTED_DIR" "$LOG_DIR"

      # Step 1: clear existing tags
      if $CLEAR_TAGS; then
        echo ">>> Clearing existing tags..."
        ${comictagger} \
          --no-gui -d -t CR,CIX -v \
          "$SOURCE_DIR" 2>&1 | tee "$LOG_DIR/clear-tags.log"
      else
        echo ">>> Not clearing existing tags..."
      fi

      # Step 2: Export to zip, and delete originals
      if $EXPORT_TO_ZIP; then
        echo ">>> Exporting to zip..."
        ${comictagger} \
          --export-to-zip \
          --delete-original \
          "$SOURCE_DIR" 2>&1 | tee "$LOG_DIR/conversion.log"
      else
        echo ">> Not exporting to zip..."
      fi

      # Step 3: tag, retrying on rate limits
      attempt=1

      while true; do
        echo ">>> Tagging attempt $attempt at $(date)"
        logfile="$LOG_DIR/retry-attempt-''${attempt}.log"

        ${comictagger} \
          --no-gui \
          --online \
          --parse-filename \
          --save \
          --skip-existing-tags \
          --tags-write CR,CIX \
          --verbose \
          "$SOURCE_DIR" 2>&1 | tee "$logfile"

        rate_limited=$(grep -c "rate limit error" "$logfile" || true)

        echo ">>> Rate-limit hits: $rate_limited"

        if [[ "$rate_limited" -eq 0 || "$attempt" -ge "$MAX_ATTEMPTS" ]]; then
          break
        fi

        echo ">>> Sleeping ''${COOLDOWN}s before retry..."
        sleep "$COOLDOWN"
        attempt=$((attempt + 1))
      done

      # Step 4: move/rename
      echo ">>> Moving files into $SORTED_DIR..."

      ${comictagger} \
        --no-gui \
        --rename \
        --move \
        --dir "$SORTED_DIR" \
        --tags-read CR,CIX \
        --verbose \
        "$SOURCE_DIR" 2>&1 | tee "$LOG_DIR/moving-final.log"

      echo ">>> Done."
      echo ">>> Check $LOG_DIR/moving-final.log for errors."
    '')
  ];
}
