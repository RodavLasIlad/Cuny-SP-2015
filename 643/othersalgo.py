import numpy as np
import pandas as pd
from collections import deque

def initialize(context):
    context.max_notional = 1000000
    context.min_notional = -1000000
    context.stocks = [sid(8229), sid(21090)]
    context.ratio = deque([])
    context.strategy = 0

       
def handle_data(context, data):
    priceOne = data[context.stocks[0]].price
    priceTwo = data[context.stocks[1]].price
    sharesOne = context.portfolio.positions[context.stocks[0]].amount
    sharesTwo = context.portfolio.positions[context.stocks[1]].amount
    
    if len(context.ratio)<context.nobs:
        temp = price0/price1
        context.ratio.append(temp)
    else:
        beta=sum(context.ratio)/context.nobs
        if price0 > beta*1.02*price1 and context.strategy != 1:
            order(context.stocks[0], -shares0)
            order(context.stocks[1], -shares1)
            num_shares = int(context.max_notional / price1)
            order(context.stocks[1], num_shares)
            order(context.stocks[0], -1 * num_shares/beta )
            context.strategy = 1

        elif price0 < beta*0.98*price1 and context.strategy != 2 :
            order(context.stocks[0], -shares0)
            order(context.stocks[1], -shares1)
            num_shares = int(context.max_notional / price0)
            order(context.stocks[0], num_shares)
            order(context.stocks[1], -1 * num_shares*beta )
            context.strategy = 2

        context.ratio.popleft()
        temp=price0 / price1
        context.ratio.append(temp)
        record(gap=price0-beta*price1)
        record(shares0=shares0, shares1=shares1)