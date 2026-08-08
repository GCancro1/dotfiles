#!/usr/bin/env python3
"""Generate test portfolio snapshots CSV with 30 days of historical data."""

import csv
import random
from datetime import date, timedelta
from pathlib import Path

OUTPUT = Path(__file__).parent / "test_portfolio_snapshots.csv"

# Holdings configuration
holdings = [
    {
        "account": "401k",
        "symbol": "SPY",
        "shares": 13.5,  # ~$7000 / ~$518 = ~13.5 shares
        "cost_basis_per_share": 518.0,
        "start_value": 7000,
        "end_value": 8200,
    },
    {
        "account": "Roth IRA",
        "symbol": "Cash",
        "shares": "",
        "cost_basis_per_share": "",
        "start_value": 11339,
        "end_value": 11339,  # constant
    },
    {
        "account": "Roth IRA",
        "symbol": "VOO",
        "shares": 16.264,
        "cost_basis_per_share": 707.96,
        "start_value": 9500,
        "end_value": 11514,
    },
    {
        "account": "Roth IRA",
        "symbol": "VB",
        "shares": 7.048,
        "cost_basis_per_share": 303.90,
        "start_value": 1800,
        "end_value": 2142,
    },
    {
        "account": "Roth IRA",
        "symbol": "VOOV",
        "shares": 3.1,
        "cost_basis_per_share": 226.77,
        "start_value": 600,
        "end_value": 703,
    },
    {
        "account": "Roth IRA",
        "symbol": "VTI",
        "shares": 2.043,
        "cost_basis_per_share": 379.83,
        "start_value": 650,
        "end_value": 776,
    },
]

def generate_daily_values(start_val, end_val, days, volatility=0.015):
    """Generate daily values with growth trend and daily volatility."""
    total_growth = end_val / start_val
    daily_growth = total_growth ** (1.0 / days)
    
    values = []
    current = start_val
    for _ in range(days):
        # Apply daily growth
        current *= daily_growth
        # Add volatility (±volatility)
        vol = random.uniform(-volatility, volatility)
        current *= (1 + vol)
        values.append(round(current, 2))
    return values

def main():
    random.seed(42)  # Reproducible results
    
    start_date = date(2026, 7, 7)
    end_date = date(2026, 8, 6)
    days = (end_date - start_date).days + 1  # 31 days inclusive
    
    # Generate daily values for each holding
    for h in holdings:
        h["daily_values"] = generate_daily_values(
            h["start_value"], h["end_value"], days, volatility=0.015
        )
    
    # Write CSV
    with open(OUTPUT, "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=["date", "account", "symbol", "shares", "cost_basis_per_share", "value"])
        writer.writeheader()
        
        for day_idx in range(days):
            current_date = start_date + timedelta(days=day_idx)
            for h in holdings:
                row = {
                    "date": current_date.isoformat(),
                    "account": h["account"],
                    "symbol": h["symbol"],
                    "shares": h["shares"] if h["shares"] != "" else "",
                    "cost_basis_per_share": h["cost_basis_per_share"] if h["cost_basis_per_share"] != "" else "",
                    "value": h["daily_values"][day_idx],
                }
                writer.writerow(row)
    
    print(f"Generated {OUTPUT} with {days} days of data")
    
    # Print summary
    first_day = date(2026, 7, 7).isoformat()
    last_day = date(2026, 8, 6).isoformat()
    
    with open(OUTPUT, "r") as f:
        reader = csv.DictReader(f)
        rows = list(reader)
    
    first_total = sum(float(r["value"]) for r in rows if r["date"] == first_day)
    last_total = sum(float(r["value"]) for r in rows if r["date"] == last_day)
    
    print(f"Total on {first_day}: ${first_total:,.2f}")
    print(f"Total on {last_day}: ${last_total:,.2f}")
    print(f"Growth: {((last_total - first_total) / first_total * 100):.1f}%")

if __name__ == "__main__":
    main()