#!/bin/bash

# Ref: https://keras.io/guides/, https://github.com/keras-team/keras-io/tree/master
sudo ln -s /usr/lib/x86_64-linux-gnu/libcuda.so.1 /usr/lib/x86_64-linux-gnu/libcuda.so
export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
for file in *.py; do
    if [ "$file" != "transfer_learning.py" ]; then
        # skipping transfer_learning.py because it has 20 epochs and it takes a very long time to execute
        # https://github.com/keras-team/keras-io/blob/master/guides/transfer_learning.py#L562
        python "$file" || exit $?
    fi
done
