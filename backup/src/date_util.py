from calendar import monthrange
from datetime import date, timedelta

def get_last_seven_days(today):
    """
    Returns the last 7 days dates including today.
    """
    dates = []

    for i in range(0, 7):
        delta = timedelta(days=i)
        dates.append(today - delta)

    return dates

def get_last_day_of_prev_tweleve_months(today):
    """
    Returns the last day of the month for the past year from today.
    """
    dates = []

    # Accumulate all days of months from this year
    current_year = today.year
    for month in range(1, today.month):
        day = monthrange(today.year, month)[1]
        dates.append(date(current_year, month, day))

    # Accumulate remaining days of months from previous year
    prev_year = current_year - 1
    for month in range(today.month, 13):
        day = monthrange(prev_year, month)[1]
        dates.append(date(prev_year, month, day))

    return dates

def get_retention_dates(today):
    """
    Returns the dates of backup files to retain.
    Currently retaining:
        - Last 7 days of backups
        - Last day of the past 12 months
    """
    # Get the last 7 days dates
    past_week = get_last_seven_days(today)

    # Get the last day of the month for the past year
    past_year = get_last_day_of_prev_tweleve_months(today)

    return past_week + past_year
