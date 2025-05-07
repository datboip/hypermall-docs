#!/bin/bash

# Send /exit to the screen session
screen -S tracstore -X stuff "/exit$(printf \\r)"
sleep 3
# Just in case: force kill the session if still alive
screen -S tracstore -X quit
