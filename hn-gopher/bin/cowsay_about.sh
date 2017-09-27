#!/usr/bin/env bash

## A quick script that loops through all of the installed cowsay
## images and generates a preview for the about page.

for f in /usr/share/cowsay/cows/*.cow
do
    name=$(basename ${f%.cow})
    echo ${name}
    cowsay -f ${name} << EOF
This site was created for my own enjoyment, and to learn about gopher and the history of the internet before the world wide web.

If you have comments or questions, I would love to hear them!
You can reach me via email at:

    lazar.michael22@gmail.com
EOF
done
