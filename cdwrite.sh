#!/bin/bash
# cdwrite.sh: Write from one .iso file repeatedly to multiple CDs
#
# Copyright (c) 2009 Robert Wall (http://rww.name/)
#
# Version 0.5
# - Argument checking
# - Added improvements from Grant Bowman
# - Header standardization; added MIT license text
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
################################################################################

if [ $# -ne 2 ] || [ $1 -ne $1 ] || [ ! -r $2 ]
then
	echo "Usage: `basename $0` number_of_CDs path_to_iso"
	exit 1		# TODO: check this is correct for terminating scripts
fi
	
REPEATS=$1
FILENAME=$2

DEVICE=/dev/cdrw
# just in case, not exported
LS_OPTIONS=''
# get file size in bytes (5th column from ls -l output)
FILESIZE=`ls -l $FILENAME | cut -d" " -f5`
# look up filename in MD5SUMS and get the hash, first 32 characters
# assumes wget http://releases.ubuntu.com/9.04/MD5SUMS
# TODO: add checking for MD5SUMS file and value
TARGETMD5=`egrep $FILENAME MD5SUMS | cut -b -32`
# TODO: check all paths so this script can be located anywhere like ~/bin/
# currently script, MD5SUMS and images are all in the same directory

for i in $(seq 1 $REPEATS); do
	eject
	read -p "Place a blank CD in the open tray for writing #$i of $REPEATS
	and press [Enter] to continue."
	eject -t	# -t: Close the CD tray
	sleep 10	# wait for spin up

	# write the disc
	# -----
	# -tao and burnfree specify burn modes
	# -v increases verbosity (needed for progress data)
	# -data pulls the .iso filename from the commandline
	# speed=8 sets speed to 8x (burning at high speeds can cause problems)
	wodim dev=$DEVICE -tao driveropts=burnfree -v -data $FILENAME speed=8

	# Check the disc
	# -----
	sleep 30	# Without this and the below sleep statements, we go on
	eject		# before the CD drive is ready, and dd fails.
	eject -t	# This auto-remounts for reading.
	sleep 30

	echo '***** TARGET md5sum is' $TARGETMD5
	echo '***** ACTUAL md5sum follows below.'
	dd if=$DEVICE | head -c $FILESIZE | md5sum
	sleep 10
	# TODO: make this refuse to proceed if they don't match.
	# -----
	
	beep		# the regular echo -e '\a' doesn't work for me for some reason
			# beep is in package "beep".
done
eject   # open the tray for the last disc
