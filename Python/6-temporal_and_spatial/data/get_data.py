import yfinance
import pandas as pd

aord_5m = yfinance.download("^AORD", interval="5m", period="max")
aord_1d = yfinance.download("^AORD", interval="1d", period="max")

aord_5m.droplevel("Ticker", axis=1).to_csv(
    "Python/6-temporal_and_spatial_data/data/AORD_persecond.csv"
)

aord_1d.droplevel("Ticker", axis=1).to_csv(
    "Python/6-temporal_and_spatial_data/data/AORD_daily.csv"
)
