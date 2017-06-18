import numpy as np

from loading import loader


def median_heartbeat(thb):
    m = [np.median(col) for col in thb.T]

    dists = [np.sum(np.square(s - m)) for s in thb]
    pmin = np.argmin(dists)

    median = thb[pmin]

    r_pos = int(0.2 * loader.FREQUENCY)
    if median[r_pos] < 0:
        median *= -1

    return median
