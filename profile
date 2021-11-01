# set PATH so it includes /usr/local/go/bin if it exists
if [ -d "/usr/local/go/bin" ] ; then
    PATH="$PATH:/usr/local/go/bin"
fi

# set PATH so it includes user's private go/bin if it exists
if [ -d "$HOME/go/bin" ] ; then
    PATH="$PATH:$HOME/go/bin"
fi

# set GOPATH if it exists
GOPATH=$(go env GOPATH)
if [ -d "$GOPATH" ] ; then
    export GOPATH
fi
