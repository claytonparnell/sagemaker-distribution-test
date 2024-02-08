#!/bin/bash

AUTOGLUON_VERSION=$(micromamba list | grep autogluon | tr -s ' ' | cut -d ' ' -f 3 | head -n 1)
git checkout tags/v$AUTOGLUON_VERSION

# Create an empty notebook file for papermill's output
touch nb_output.ipynb

# Run autogluon quick start as end-to-end check
papermill 'docs/tutorials/tabular/tabular-quick-start.ipynb' 'nb_output.ipynb'
papermill 'docs/tutorials/timeseries/forecasting-quick-start.ipynb' 'nb_output.ipynb'

# Detect gpu and run multimodal quick start if presented
python -c "import torch; exit(0) if torch.cuda.is_available() else exit(1)"
ret=$?

if [ $ret -eq 0 ]
then 
    papermill 'docs/tutorials/multimodal/multimodal_prediction/multimodal-quick-start.ipynb' 'nb_output.ipynb' -k 'python3'
fi
