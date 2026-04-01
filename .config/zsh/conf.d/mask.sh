# Masks the first three quarters of a string with asterisks.
function mask() {
  # This is a zsh thing.
  # shellcheck disable=SC2296
  printf '%s\n' "${(l[$#1][*])1:$#1*3/4}"
}
