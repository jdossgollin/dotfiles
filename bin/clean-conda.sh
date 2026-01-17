# Remove all conda environments except the base environment
for environment_name in $(conda env list | grep -v "^#" | grep -v "^base" | cut -d' ' -f1); do
    if [ -n "$environment_name" ]; then
        echo "Removing environment: $environment_name"
        conda env remove --name "$environment_name" --yes
    fi
done
