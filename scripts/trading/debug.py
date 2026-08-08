import pandas as pd
from pathlib import Path

DEFAULT_CSV = Path("/home/g/dotfiles/scripts/trading/test_portfolio_snapshots.csv")

df = pd.read_csv(DEFAULT_CSV, parse_dates=["date"])
df["shares"] = pd.to_numeric(df["shares"], errors="coerce")
df["cost_basis_per_share"] = pd.to_numeric(df["cost_basis_per_share"], errors="coerce")
df["value"] = pd.to_numeric(df["value"], errors="coerce")

print("Shape:", df.shape)
print("Unique dates:", df["date"].nunique())
print("Unique accounts:", df["account"].unique())
print("Latest date:", df["date"].max())

latest = df[df["date"] == df["date"].max()]
print("Latest values:")
print(latest[["account", "symbol", "shares", "cost_basis_per_share", "value"]].to_string())
print("Latest sum:", latest["value"].sum())

# Test chart_growth
daily = df.groupby(["date", "account"], as_index=False)["value"].sum()
total = df.groupby("date", as_index=False)["value"].sum()
total["account"] = "Total"
combined = pd.concat([daily, total])
print("\nCombined shape:", combined.shape)
print("Combined accounts:", combined["account"].unique())
print(combined.head(15).to_string())

# Test chart_gainloss
print("\nGain/Loss calc:")
for _, r in latest.iterrows():
    if r["symbol"] == "Cash" or pd.isna(r["shares"]) or r["shares"] == 0 or pd.isna(r["cost_basis_per_share"]):
        pct = 0.0
    else:
        cost_total = r["shares"] * r["cost_basis_per_share"]
        pct = ((r["value"] - cost_total) / cost_total) * 100
    print(f"  {r['account']}: {r['symbol']} -> cost_total={cost_total if 'cost_total' in locals() else 'N/A'}, pct={pct:.1f}%")