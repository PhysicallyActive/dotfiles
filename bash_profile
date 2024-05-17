source ~/.bashrc

### Path extentions ###
export http_proxy="http://localhost:3128"
export HTTP_PROXY="http://localhost:3128"
export https_proxy="http://localhost:3128"
export HTTPS_PROXY="http://localhost:3128"
export ftp_proxy="http://localhost:3128"
export FTP_PROXY="http://localhost:3128"
export all_proxy="http://localhost:3128"
export ALL_PROXY="http://localhost:3128"

# Halcon environment variables
export HALCONARCH="x64-linux"
export HALCONROOT="/opt/MVTec/HALCON-23.11-Progress"
export HALCONEXAMPLES="$HALCONROOT/examples"
export HALCONIMAGES="$HALCONEXAMPLES/images"
export PATH=$PATH:"$HALCONROOT/bin/$HALCONARCH"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"$HALCONROOT/lib/$HALCONARCH"
