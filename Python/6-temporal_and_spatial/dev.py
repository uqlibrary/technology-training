import pandas as pd
import matplotlib.pyplot as plt

# Convert to datetime
xao = pd.read_csv(
    "Python/6-temporal_and_spatial/data/XAO_5min.csv", parse_dates=["Datetime"]
)

print("XAO")
print(xao)

print("DTYPES")
print(xao.dtypes)

# Filter
print("OCTOBER:")
print(xao[xao["Datetime"].dt.month == 10])

# Resampling
print("DAILY")
print(xao.resample("D", on="Datetime").sum())

# Let's get rid of weekends
print("NO WEEKENDS")
print(xao[xao["Datetime"].dt.weekday < 5].resample("B", on="Datetime").mean())

weekdays = (
    xao[xao["Datetime"].dt.weekday < 5]
    .resample("B", on="Datetime")
    .mean()
    .reset_index()
)
print(weekdays)

# Index vs column
print("INDEX VS COLUMNS")
print(weekdays.columns)
print(weekdays.index)

print(weekdays[weekdays.index.day == 3])

# Group by day
# weekdays["day"] = weekdays.index.day

print("DAYS")
print(weekdays.groupby(weekdays.index.day).agg(["mean", "std", "count"]))

# Timezones
print("CHANGING TIMEZONES")
print(xao["Datetime"].dt.tz_convert("Australia/Brisbane"))

# Time formatting
# https://docs.python.org/3/library/datetime.html#strftime-and-strptime-behavior
print("TIME FORMATTING")
print(xao["Datetime"].dt.strftime("%c"))

print("PLOTTING")
weekday_limits = xao.resample("B", on="Datetime").agg(["max", "min"])

# weekday_limits.plot(y=(("High", "max"), ("Low", "min")))

weekday_limits[[("High", "max"), ("Low", "min")]].plot()

plt.savefig("Python/6-temporal_and_spatial/finance.png")

# Activity
# Download the 1d data, and play
