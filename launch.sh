#!/bin/sh

echo ""
if [ -d /data -a -w /data ]; then
    DATADIR=/data
    echo "** Be sure to save persistent files in /data if using persistent storage."
else
    echo "** WARNING: writable persistent data storage not available."
    DATADIR=/tmp
fi
echo ""

# persist (or move to device with more space) .local and .cache/pip
mkdir -p $DATADIR/.app-pythondev/.local
mkdir -p $DATADIR/.app-pythondev/.cache
mkdir -p $DATADIR/.app-pythondev/.config/JetBrains
mkdir -p $DATADIR/.app-pythondev/.java
mkdir -p $DATADIR/PycharmProjects .
cd
mkdir -p .cache
rm -rf .local && ln -s $DATADIR/.app-pythondev/.local .
rm -rf .cache && ln -s $DATADIR/.app-pythondev/.cache .
rm -rf .config/JetBrains && ln -s $DATADIR/.app-pythondev/.config/JetBrains .config
rm -rf .java && ln -s $DATADIR/.app-pythondev/.java .
rm -rf PycharmProjects && ln -s $DATADIR/PycharmProjects .

PATH=$HOME/.local/bin:$PATH; export PATH

exec "$@"
