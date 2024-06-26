source ~/.bashrc

# Halcon environment variables
export HALCONARCH="x64-linux"
export HALCONROOT="/opt/MVTec/HALCON-23.05-Progress"
export HALCONEXAMPLES="$HALCONROOT/examples"
export HALCONIMAGES="$HALCONEXAMPLES/images"
export PATH=$PATH:"$HALCONROOT/bin/$HALCONARCH"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"$HALCONROOT/lib/$HALCONARCH"
