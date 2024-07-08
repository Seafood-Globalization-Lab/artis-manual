### Import images from Github Repos ###

#########################
# Get images from Seafood-Globalization-Lab/artis-model repo
# Create a temporary directory for the sparse checkout
if mkdir temp-repo; then
    cd temp-repo
    echo "created temp-repo"
else
    echo "Failed to create temp-repo directory. Check permissions."
    exit 1
fi

# Initialize a new Git repository
git init

# Add the remote repository
git remote add origin https://github.com/Seafood-Globalization-Lab/artis-model.git

# Enable sparse-checkout
git config core.sparseCheckout true

# Create the sparse-checkout file and define the sparse-checkout path to include only the images directory
mkdir -p .git/info
echo "images/*" >> .git/info/sparse-checkout

# Pull the main branch from the remote repository
git pull origin main

# Ensure the destination images directory exists
mkdir -p ../images

# Move the files from the images directory to your R project directory
if [ -d "images" ] && [ "$(ls -A images)" ]; then
    mv images/* ../artis-run-model/images/
    echo "Files moved successfully."
else
    echo "No files found in the images directory."
fi

# Clean up by removing the temporary directory
cd ..
rm -rf temp-repo

#########################
# Get images from Seafood-Globalization-Lab/artis_database repo
# Create a temporary directory for the sparse checkout
if mkdir temp-repo; then
    cd temp-repo
    echo "created temp-repo"
else
    echo "Failed to create temp-repo directory. Check permissions."
    exit 1
fi

# Initialize a new Git repository
git init

# Add the remote repository
git remote add origin https://github.com/Seafood-Globalization-Lab/artis_database.git

# Enable sparse-checkout
git config core.sparseCheckout true

# Create the sparse-checkout file and define the sparse-checkout path to include only the images directory
mkdir -p .git/info
echo "images/*" >> .git/info/sparse-checkout

# Pull the main branch from the remote repository
git pull origin main

# Ensure the destination images directory exists
mkdir -p ../images

# Move the files from the images directory to your R project directory
if [ -d "images" ] && [ "$(ls -A images)" ]; then
    mv images/* ../artis-infrastructure/images/
    echo "Files moved successfully."
else
    echo "No files found in the images directory."
fi

# Clean up by removing the temporary directory
cd ..
rm -rf temp-repo

