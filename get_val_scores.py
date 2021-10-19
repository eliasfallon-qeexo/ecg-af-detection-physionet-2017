#!/usr/bin/env python3
import os
import sys
import argparse
import pandas as pd
from sklearn.metrics import classification_report
from sklearn.metrics import confusion_matrix


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Get Validation Scores for Classification.')
    parser.add_argument("true_file", help='REFERENCE.csv file with the true labels for each data point')
    parser.add_argument("pred_file", help='CSV file with the predicted values for each label. Should contain a prediction for each label in the true_file.')
    args = parser.parse_args()
    true_values = pd.read_csv(args.true_file, header=None, names=['dataname','label'])
    pred_values = pd.read_csv(args.pred_file, header=None, names=['dataname','label'])
    true_values = true_values.sort_values(by=['dataname'])
    pred_values = pred_values.sort_values(by=['dataname'])
    if len(true_values) != len(pred_values):
        print("Predicted CSV has a different number of predictions {} from the True CSV {}.".format(len(pred_values), len(true_values)))
        sys.exit(1)
    match_names = pred_values.index[ pred_values['dataname']!=true_values['dataname'] ]
    if match_names.any():
        print("Some data point names between predicted and true values do not match.")
        sys.exit(2)
    print(classification_report(true_values['label'], pred_values['label']))
    print('Confusion matrix:')
    print(confusion_matrix(true_values['label'], pred_values['label']))
    sys.exit(0)
