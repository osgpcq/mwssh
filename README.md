# mwssh

I wanted a multi SSH solution but was not convinced by cssh nor by ssh-multi,
because I wanted to send commands at the same time to several hosts but no 
to the whole list at the same time.
So I quickly make this script: mwssh (Multi Windows SSH), my goal was to learn
on tmux in the process.


## Usage
./mwssh.bash `cat /home/vince/git/osgpcq/mwssh/bp_liste.conf | awk {'printf "%s ",$0'}`

cat bp_liste.conf
```
host01
host02
...
```

## Requirement
* [tmux](https://github.com/tmux/tmux/)


## History
Initially called BigRepuppet, I searched a name to push on github, and found
lot of other projects!

Here a quick list:
* multissh [C](https://github.com/techhifzu/MultiSSH), the name is used for
  others projects...
* [ssh-multi](https://github.com/johnko/ssh-multi).
* [tmssh](https://github.com/greymd/tmssh) Not maintened anymore, point now to
  tmux-xpanes.
* [tmux-xpanes](https://github.com/greymd/tmux-xpanes) (This one looks great).
