# shellcheck shell=bash
# Remove named conda environments (keeps base) after explicit confirmation.
# Skips path-only entries like ~/.julia/conda/3, which Julia manages itself.

if ! command -v conda >/dev/null 2>&1; then
    echo "conda not found, skipping"
    return 0 2>/dev/null || exit 0
fi

# First field only when the line actually has a name (path-only lines start with /)
conda_envs=$(conda env list | grep -v '^#' | grep -v '^\s*$' | awk '$1 != "base" && $1 !~ /^\// {print $1}')

if [ -z "$conda_envs" ]; then
    echo "No named conda environments to remove"
    return 0 2>/dev/null || exit 0
fi

echo "The following conda environments will be PERMANENTLY removed:"
echo "$conda_envs" | sed 's/^/  - /'
echo
printf "Remove these environments? [y/N] "
read -r reply

case "$reply" in
    [yY])
        echo "$conda_envs" | while read -r environment_name; do
            [ -n "$environment_name" ] || continue
            echo "Removing environment: $environment_name"
            conda env remove --name "$environment_name" --yes
        done
        ;;
    *)
        echo "Aborted, no environments removed"
        ;;
esac
