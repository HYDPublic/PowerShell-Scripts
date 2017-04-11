# Shortcut for running docker script to render techcasestudies markdown

function startServer() {
    docker run --rm -v C:\Users\jaearle\Documents\Code\techcasestudies-private:/site -p 4000:4000 andredumas/github-pages serve --watch --force_polling
}

startServer

# Only executes when the above command fails
if ($LASTEXITCODE -eq 125) {
    # The port wasn't correctly deallocated, delete
    docker kill $(docker ps -q) # NOTE this command kills ALL VMs you have.
    startServer
}