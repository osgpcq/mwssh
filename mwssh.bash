#!/bin/bash
#############################################################################
# mwssh
# Vince 20211130
# /home/vince/git/osgpcq/mwssh/mwssh.bash `cat /home/vince/git/osgpcq/mwssh/bp_liste.conf | awk {'printf "%s ",$0'}`
# Remove old keys
# for i in `cat /home/vince/git/osgpcq/mwssh/bp_liste.conf`; do echo "${i}";ssh -o StrictHostKeyChecking=accept-new ${i} exit || ssh-keygen -R ${i};done
#############################################################################
# Multi Windows SSH
HOSTS=$*
if [ -z "$HOSTS" ]; then
	exit 1
fi
SESSION='BigPuppet'
#NBPANEBYWINDOWS=9
NBPANEBYWINDOWS=16
WINDOWS=1
NB=0
/usr/bin/gnome-terminal --maximize --working-directory "/home/vince" --zoom=0.6 -- tmux new -s ${SESSION}
tmux set -t ${SESSION} -g history-limit 10000
#tmux set -t ${SESSION} -g escape-time 5000
tmux set -t ${SESSION} -g mouse on
tmux set -t ${SESSION} -g default-terminal 'screen-256color'
tmux set -t ${SESSION} -g status-bg black
tmux set -t ${SESSION} -g status-fg yellow
for i in ${HOSTS}
  do
    sleep 0.05
    if [ ${NB} = 0 ]
      then
        tmux neww -n "Windows${WINDOWS}" -t ${SESSION} -- ssh ${i}
      else
        tmux split-window -h -t ${SESSION}:${WINDOWS}.${NUM} -- ssh ${i}
        tmux select-layout -t ${SESSION}:${WINDOWS} tiled
    fi
    NB=$((NB+1))
    if [ ${NB} = ${NBPANEBYWINDOWS} ] ; then
      WINDOWS=$((WINDOWS+1))
      NB=0
    fi
  done
for i in `seq -w 1 ${WINDOWS}`;
  do
    tmux set-window-option -t ${SESSION}:${i} synchronize-panes on
    tmux send-keys -t ${SESSION}:${i} "sudo -i" Enter
  done
tmux send-keys -t ${SESSION}:0.0 "tmux set-window-option -t ${SESSION}:1 synchronize-panes off"
tmux select-window -t ${SESSION}:1
#############################################################################
#############################################################################
#############################################################################
