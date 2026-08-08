#!/usr/bin/env python3
"""Parse portfolio.md and write portfolio_snapshots.csv with today's date."""

import csv
import re
import sys
from datetime import date
from pathlib import Path

PORTFOLIO_MD = Path.home() / ".config/opencode/tools/portfolio.md"
OUTPUT = Path(__file__).parent / "portfolio_snapshots.csv"


def parse_section(text, section_name):
    """Extract table rows from a markdown section."""
    pattern = rf"## {re.escape(section_name)}\s*\n(.*?)(?=\n## |\n\*\*Total|$)"
    match = re.search(pattern, text, re.DOTALL)
    if not match:
        return []
    block = match.group(1)
    rows = []
    for line in block.splitlines():
        line = line.strip()
        if not line.startswith("|") or line.startswith("| ---") or line.startswith("| Symbol"):
            continue
        cells = [c.strip() for c in line.split("|")[1:-1]]
        if len(cells) < 3:
            continue
        symbol = cells[0]
        value_str = cells[1].replace("$", "").replace(",", "").replace("~", "").strip()
        shares_str = cells[2].replace("—", "").replace("N/A", "").replace(",", "").strip()
        cost_str = cells[3].replace("$", "").replace(",", "").strip() if len(cells) > 3 else ""
        try:
            value = float(value_str)
        except ValueError:
            continue
        try:
            shares = float(shares_str) if shares_str else None
        except ValueError:
            shares = None
        try:
            cost = float(cost_str) if cost_str else None
        except ValueError:
            cost = None
        rows.append({"symbol": symbol, "shares": shares, "cost": cost, "value": value})
    return rows


def main():
    if not PORTFOLIO_MD.exists():
        print(f"Error: {PORTFOLIO_MD} not found", file=sys.stderr)
        sys.exit(1)

    text = PORTFOLIO_MD.read_text()
    today = date.today().isoformat()

    accounts = {
        "401k": parse_section(text, "401(k)"),
        "Roth IRA": parse_section(text, "Roth IRA"),
    }

    all_rows = []
    for account, positions in accounts.items():
        for p in positions:
            all_rows.append({
                "date": today,
                "account": account,
                "symbol": p["symbol"],
                "shares": p["shares"] if p["shares"] is not None else "",
                "cost_basis_per_share": p["cost"] if p["cost"] is not None else "",
                "value": p["value"],
            })

    with open(OUTPUT, "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=["date", "account", "symbol", "shares", "cost_basis_per_share", "value"])
        writer.writeheader()
        writer.writerows(all_rows)

    total_positions = sum(len(v) for v in accounts.values())
    print(f"Parsed {total_positions} positions from {PORTFOLIO_MD}")
    print(f"Wrote {OUTPUT} ({today})")


if __name__ == "__main__":
    main()
