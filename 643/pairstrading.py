
    Create a short list of potential pairs.
    Test the relationship of the pairs using cointegration.
    Design rules for the trade including thresholds and any limits.
    Back test from Jan 1, 2010 using Quantopian.

The value of the strategy is determined by the resulting Alpha and Sharpe Ratio.  Try to maximize those values.  What you need to submit is any code that you use to complete this task.  There should be a least three major components.  The cointegration tests, the trade design, and the back test.  I will supply an example of what I’m looking for.

import numpy as np

# build trading
# first 30 days
def initialize(context):
	context.max_notional = 1000000
    context.min_notional = -1000000
    context.stocks = [sid(8229), sid(21090)]
    context.ratio = deque([])
    context.strategy = 0


#regression

# Spread = share1 - hedgeRatio * share2

# calculate the mean of the spread on the training set

# zscore = (spread - spreadMean)sd(spread)

# buy spread when value drops below 1 sds

# short when it rises above 1 sds

# exit any position when within .5 sd of the mean

# sharpe ratio on train should be about 2.3
# and 1.5 on the test