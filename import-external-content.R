# Import external content to use within manual

# Create directory to store README.md files
if(!dir.exists(file.path("external-content"))){
  dir.create(file.path("external-content"))
  message("created external-content/ directory")
}

# Copy content from artis-model github repo -------------------------------

# Artis Model Repo - download if it doesn't exist
if(!file.exists(file.path("external-content", 
                          "artis-model-readme.md"))){
  download.file("https://raw.githubusercontent.com/Seafood-Globalization-Lab/artis-model/main/README.md", 
                file.path("external-content", 
                          "artis-model-readme.md"))
  message("downloaded artis-model readme into external-content/ dir")
}

# Create directory to store associated README.md images
if(!dir.exists(file.path("artis-run-model", "images"))){
  dir.create(file.path("artis-run-model", "images"))
  message("created artis-run-model/images directory")
}



# Copy content from artis-hpc github repo -------------------------------------------

# Artis HPC Repo README - download if it doesn't exist
if(!file.exists(file.path("external-content", 
                          "artis-hpc-readme.md"))){
  download.file("https://raw.githubusercontent.com/Seafood-Globalization-Lab/artis-hpc/main/README.md", 
                file.path("external-content", 
                          "artis-hpc-readme.md"))
  message("downloaded artis-hpc readme into external-content/ dir")
}
# No images included in README - do not need external images folder 2024-07-08



# Copy content from artis-database github repo -------------------------------

# Artis Model Repo README - download if it doesn't exist
if(!file.exists(file.path("external-content", 
                          "artis-database-readme.md"))){
  download.file("https://raw.githubusercontent.com/Seafood-Globalization-Lab/artis_database/main/README.md", 
                file.path("external-content", 
                          "artis-database-readme.md"))
  message("downloaded artis-database readme into external-content/ dir")
}

# Create directory to store associated README.md images
if(!dir.exists(file.path("artis-infrastructure", "images"))){
  dir.create(file.path("artis-infrastructure", "images"))
  message("created artis-infrastructure/images directory")
}



# Pull external images (all repos above) ----------------------------------------------
# run shell script to import images folder from repos
system(file.path("scripts", "get_images.sh"))


