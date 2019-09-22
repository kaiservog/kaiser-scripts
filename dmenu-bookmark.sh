#!/bin/sh


# use it like dmenu-bookmark.sh firefox
# dmenu-bookmark show bookmarks in dmenu and open in firefox or surf
# this scripts will search inside all .bm files for links and show in dmenu
# the first word in the .bm file must be the url of the bookmark after space will help in dmenu search

if [ "$1" == "surf" ]; then
	surf $(cat $HOME/.bookmarks/*.bm | dmenu -i | awk '{print $1;}' )
else
        firefox $(cat $HOME/.bookmarks/*.bm | dmenu -i | awk '{print $1;}' )
fi

