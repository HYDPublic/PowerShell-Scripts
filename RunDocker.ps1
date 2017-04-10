# Shortcut for running docker script to render techcasestudies markdown

docker run --rm -v C:\Users\jaearle\Documents\Code\techcasestudies-private:/site -p 4000:4000 andredumas/github-pages serve --watch --force_polling