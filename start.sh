#!/bin/bash

DELAY_SEC=15
MINNER_ADDR=0x7f6Ca20E0C24F931395B34F4b438882aa0a6d116
CHAIN_ID=369420
DATA_DIR=~/data
IS_ARCHIVE_NODE=true
IS_LIGHT_NODE=false
IS_FULL_NODE=false

runWithDelay () {
    sleep $1;
    shift;
    "${@}";
}

runWithDelay $DELAY_SEC ./build/bin/geth attach --exec admin.nodeInfo.enode $DATA_DIR/geth.ipc &

if $IS_ARCHIVE_NODE
then
    nohup ./build/bin/geth --datadir $DATA_DIR --networkid $CHAIN_ID --http --http.addr 0.0.0.0 --port 30303 --http.port 8545 --http.api personal,eth,net,debug,txpool,web3,admin --http.corsdomain '*' --ws --ws.addr 0.0.0.0 --ws.port 8546 --ws.api personal,eth,net,debug,txpool --http.vhosts '*' --syncmode full --gcmode archive --mine --miner.threads=1 --miner.etherbase=$MINNER_ADDR --nat extip:$IP &
elif $IS_LIGHT_NODE
then
    nohup ./build/bin/geth --datadir $DATA_DIR --networkid $CHAIN_ID --http --http.addr 0.0.0.0 --port 30303 --http.port 8545 --http.api personal,eth,net,debug,txpool,web3,admin --http.corsdomain '*' --ws --ws.addr 0.0.0.0 --ws.port 8546 --ws.api personal,eth,net,debug,txpool --http.vhosts '*' --syncmode snap --mine --miner.threads=1 --miner.etherbase=$MINNER_ADDR --nat extip:$IP &
elif $IS_FULL_NODE
then
    nohup ./build/bin/geth --datadir $DATA_DIR --networkid $CHAIN_ID --http --http.addr 0.0.0.0 --port 30303 --http.port 8545 --http.api personal,eth,net,debug,txpool,web3,admin --http.corsdomain '*' --ws --ws.addr 0.0.0.0 --ws.port 8546 --ws.api personal,eth,net,debug,txpool --http.vhosts '*' --syncmode full --mine --miner.threads=1 --miner.etherbase=$MINNER_ADDR --nat extip:$IP &
else
    echo "Nothing...";
fi
