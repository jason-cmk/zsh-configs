# ---- delta (better git diff) -----

# Per-mode delta features. Names must match `[delta "<name>"]` sections
# in ~/.gitconfig.
local LIGHT_FEATURE="latte"
local DARK_FEATURE="mocha"

if [[ "$LIGHT_SWITCH" == "0" ]]; then
  export DELTA_FEATURES="$DARK_FEATURE"
else
  export DELTA_FEATURES="$LIGHT_FEATURE"
fi
