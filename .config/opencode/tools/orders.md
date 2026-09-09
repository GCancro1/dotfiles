# Orders Log

Track all executed trades for tax records and strategy review.

---

## Executed Trades (2026)

| Date       | Account   | Action | Symbol | Shares/Contracts | Price  | Proceeds/Cost | Realized P&L | Type     | Notes                                    |
|------------|-----------|--------|--------|------------------|--------|---------------|--------------|----------|------------------------------------------|
| 2026-08-24 | Brokerage | SELL   | OKLO   | 4 shares         | $40.25 | $161.00       | ~$80 ST loss | Tax-loss  | ✅ **EXECUTED** Pre-revenue spec, harvested              |
| 2026-08-24 | Brokerage | SELL   | SMR    | 40 shares        | $9.21  | $368.40       | ~$120 ST loss| Tax-loss  | ✅ **EXECUTED** Pre-revenue spec, harvested              |
| 2026-08-24 | Brokerage | SELL   | SPY/QQQ Puts | All contracts | —      | —             | **$4,680 ST loss** | Tax-loss | ✅ **EXECUTED** Mid-Sept expiry, locked 97% loss         |

---

## Pending / Planned Trades

| Target Date | Account   | Action | Symbol | Shares/Contracts | Est. Price | Est. Proceeds | Est. Realized P&L | Type     | Notes                                    |
|-------------|-----------|--------|--------|------------------|------------|---------------|-------------------|----------|------------------------------------------|
| 2026-08-25  | Brokerage | SELL   | VOO    | **25.0770 shares** (Spec ID, oldest lots) | **$702.44** | **$17,608** | **$4,674 LT gain** | Tax-offset | ✅ **EXECUTED** — hits $4,680 put loss target; keep ~16.6 sh ($11.7k) |
| 2026-08-25  | Brokerage | SELL   | AMZN   | ~12 (all)        | ~$263      | ~$3,150       | ~$300 LT gain     | Tax-offset | Redundant with VOO                       |
| 2026-08-25  | Brokerage | SELL   | MSTR   | ~8 (all)         | ~$123      | ~$980         | ~$300 ST loss     | Tax-loss   | Leveraged BTC vehicle, decide after data |
| 2026-08-25  | Brokerage | BUY    | VUSXX  | ~$22,600         | $1.00      | —             | —                 | Cash mgmt  | Move proceeds to MMF (3.62%)             |

---

## Wash Sale Tracking

| Sold Symbol | Sale Date | Wash Sale Window Ends | Replacement Blocked | Notes                          |
|-------------|-----------|----------------------|---------------------|--------------------------------|
| VOO         | 2026-08-25| 2026-09-25           | VOO, SPY, IVV, SPLG | Wait 31 days to rebuy S&P 500  |
| SPY/QQQ Puts| 2026-08-24| 2026-09-24           | SPY, QQQ options    | Options on same underlying     |

---

## Tax-Loss Harvest Summary (2026 YTD)

| Loss Source              | Amount   | Type    | Status    |
|--------------------------|----------|---------|-----------|
| SPY/QQQ Puts             | $4,680   | ST      | ✅ Locked  |
| OKLO (4 sh @ $40.25)     | ~$80     | ST      | ✅ **EXECUTED**  |
| SMR (40 sh @ $9.21)      | ~$120    | ST      | ✅ **EXECUTED**  |
| MSTR (planned)           | ~$300    | ST      | ⏳ Pending |
| **Total ST Losses**      | **~$5,180** |         |           |
| VOO (25.077 sh, Spec ID oldest)  | **$4,674**  | LT      | ✅ **EXECUTED** |
| AMZN (planned, ~12 sh all)           | ~$300    | LT      | ⏳ Pending |
| **Total LT Gains to Offset** | **~$4,974** |       |           |
| **Net Taxable Gain**     | **~$0**      |         |           |
| **ST Loss Carryforward** | **~$200**    |         |           |

---

## Re-entry Watchlist (Post Wash Sale)

| Target Date | Symbol | Target Allocation | Max Buy Price | Notes                          |
|-------------|--------|-------------------|---------------|--------------------------------|
| 2026-09-25+ | VTI    | 55% total market  | $375          | Core replacement for VOO       |
| 2026-09-25+ | VOOV   | 7% value          | $228          | Value tilt                     |
| 2026-09-25+ | VTV    | 5% value          | $224          | Value tilt                     |
| 2026-09-25+ | VXUS   | 5% intl           | $86.50        | International diversification  |
| Ongoing     | VUSXX  | 10% cash          | $1.00         | Treasury MMF @ 3.62%           |

---

## Format Notes

- **ST** = Short-term (held ≤1 year)
- **LT** = Long-term (held >1 year)
- **Spec ID** = Specific Identification (Vanguard MinTax default)
- **Realized P&L** = Estimated until settlement confirmed
- Update "Status" column when trades settle