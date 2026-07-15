#!/usr/bin/env bash
# One-shot: prompt for kei's password, hash it, persist to a machine-local
# file OUTSIDE the repo, then rebuild. The hash file is git-ignored and never
# enters the nix store, so the password never touches version control.
#
# Usage (as root, from the flake dir on the target machine / VM):
#   ./bin/set-password.sh
set -euo pipefail

SECRET_DIR="/etc/nixos/secrets"
HASH_FILE="${SECRET_DIR}/kei.hash"
FLAKE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

command -v mkpasswd >/dev/null 2>&1 || {
  echo "mkpasswd not found. Install it (nixpkgs mkpasswd) or run from a shell with it on PATH." >&2
  exit 1
}

mkdir -p "${SECRET_DIR}"
chmod 700 "${SECRET_DIR}"

read -r -s -p "Password for kei: " PASSWORD
echo
read -r -s -p "Confirm password: " PASSWORD2
echo

if [ "${PASSWORD}" != "${PASSWORD2}" ]; then
  echo "Passwords do not match." >&2
  exit 1
fi

# Hash with sha-512, high rounds. File must contain exactly one line.
printf '%s' "${PASSWORD}" | mkpasswd -m sha-512 --rounds=656000 -s >"${HASH_FILE}"
chmod 600 "${HASH_FILE}"

echo "Hash written to ${HASH_FILE} (mode 600, git-ignored)."

cd "${FLAKE_DIR}"
exec nixos-rebuild switch --flake .#kei-nixos
