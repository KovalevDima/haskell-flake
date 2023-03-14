source ../test/common.sh
set -euo pipefail

function templateTest () {
    # Build haskell executable
    nix build \
        ${OVERRIDE_HASKELL_FLAKE} \
        ${OVERRIDE_NIXPKGS}
    # Test haskell devshell (via HLS check)
    nix develop \
        ${OVERRIDE_HASKELL_FLAKE} \
        ${OVERRIDE_NIXPKGS} \
        -c haskell-language-server
}

TEMP_DIR=$(mktemp -d)
cd $TEMP_DIR

set -x
#### Test "#example" template
nix flake init -t ${HASKELL_FLAKE}#example
templateTest

### Test "#default" template
rm -f flake.nix
nix flake init -t ${HASKELL_FLAKE}
templateTest