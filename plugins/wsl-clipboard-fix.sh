# fix wsl clipboard (no-op outside WSL)
if [[ -n "$WSL_DISTRO_NAME" ]]; then
  alias pbcopy="clip.exe"
  alias pbpaste="powershell.exe -command 'Get-Clipboard' | head -n -1"
fi
