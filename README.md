# The challenge

PhysioNet Computing in Cardiology Challenge 2017: Atrial fibrillation detection from a short single lead ECG recording

https://physionet.org/challenge/2017/

The official results:

https://physionet.org/challenge/2017/results.csv

Our best result is 0.77.

# The team

University of Valencia: Computational Multiscale Simulation Lab (CoMMLab).

Team members:

- [Miguel Lozano](https://www.uv.es/mlozano/)
- Viktor Kifer
- [Francisco Martinez-Gil](https://www.uv.es/uvweb/universidad/es/ficha-persona-1285950309813.html?p2=fmgil)


# This Fork

This repo is simply a fork of the official repo of the CoMMLab team referenced above to make it easier to reproduce their
results, with a focus on just running the ML training and evaluation, and not so worried about official submissions to
the 2017 challenge.

After cloning this repo, basic directions:

1. Create the conda environment containing all of the necessary libraries. Note you will need to have conda installed in your environment. From inside this directory: `conda env create --file environment.yml`
2. Activate the environment: `conda activate ecg_af_detect_victorkifer`
3. Download the [2017 Challenge Dataset zip](https://physionet.org/static/published-projects/challenge-2017/af-classification-from-a-short-single-lead-ecg-recording-the-physionet-computing-in-cardiology-challenge-2017-1.0.0.zip)
4. Unzip it somewhere else. We will call this CHALLENGE_DATA_PATH. You may also need to unzip training2017.zip and sample2017.zip in that directory.
5. Train the model: `python3 main.py -d CHALLENGE_DATA_PATH/training2017 -m train` This will train the model and output results. It should also show some feature importance charts.
6. Test the model on the sample2017 validation data: `python3 main.py -d CHALLENGE_DATA_PATH/sample2017/validation -m classify -o validation_pred.csv` This will run classification using the trained model on each sample in the validation directory and store the predicted results into the csv.
7. Calculate validation scores: `python3 get_val_scores.py CHALLENGE_DATA_PATH/sample2017/validation/REFERENCE.csv validation_pred.csv`

