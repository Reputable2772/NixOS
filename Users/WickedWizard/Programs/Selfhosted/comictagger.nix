{ pkgs, lib, ... }:
let
  comictagger = lib.getExe (pkgs.callPackage ../../../../Packages/comictagger.nix { });
in
{
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
          --filename-parser comicfn2dict \
          --save \
          --skip-existing-tags \
          --tags-write CR,CIX \
          --series-match-identify-thresh 91 \
          --cv-use-series-start-as-volume \
          --use-year-when-identifying \
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
        --template "{series} ({volume})/{series} #{issue} ({year})" \
        --issue-number-padding 3 \
        --tags-read CR,CIX \
        --verbose \
        "$SOURCE_DIR" 2>&1 | tee "$LOG_DIR/moving-final.log"

      echo ">>> Done."
      echo ">>> Check $LOG_DIR/moving-final.log for errors."
    '')
  ];
}
