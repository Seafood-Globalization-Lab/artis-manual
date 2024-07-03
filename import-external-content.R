# Import external content to use within manual


# Create directory to store content
if(!dir.exists(file.path("external-content"))){
  dir.create(file.path("external-content"))
  message("created external-content/ directory")
}

# Create directory to store external images
if(!dir.exists(file.path("external-content", "images"))){
  dir.create(file.path("external-content/images"))
  message("created external-content/images directory")
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

# run shell script to import images folder from repo
system(file.path("scripts", "get_images.sh"))