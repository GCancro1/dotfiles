---
name: trading-analysis
description: Use when the user is pasting stock prices, options positions, holdings, portfolio data, or asking for trading/financial analysis. Triggers on mentions of tickers, options, Greeks, positions, P&L, entries, exits, support, resistance.
---

# Trading Analysis

> **Load this skill** when the user provides trading data or asks for market analysis.

## Data Parsing Guide

### Common Formats You'll See

**Simple holdings:**
```
AAPL 150 shares @ $178.50
TSLA 50 shares @ $245.00
```

**Options positions:**
```
AAPL 200C Aug-15 x10 @ $5.20
SPY 540P Sep-19 x5 @ $8.75
```

**Portfolio table:**
```
Ticker | Shares | Cost | Current
AAPL   | 150    | 178  | 192.50
MSFT   | 100    | 420  | 445.00
```

**Options chain:**
```
AAPL 2026-08-15
Strike | Call IV | Put IV | Call Price | Put Price
200    | 28%     | 30%    | $5.20      | $12.80
205    | 26%     | 32%    | $2.90      | $17.50
```

**Freeform:**
```
I'm long 200 shares of NVDA at $850, looking to hedge
Should I sell covered calls on my AAPL position?
```

### Parsing Rules

1. Recognize ticker symbols (1-5 uppercase letters)
2. Distinguish shares vs options (C/P suffix, expiry dates)
3. Extract quantities (x10, 10 contracts, 100 shares)
4. Identify entry prices (@ symbol or "at" keyword)
5. Flag missing data needed for full analysis

## Analysis Templates

### Single Stock Analysis
```markdown
## [TICKER] Analysis

**Position:** [shares/contracts] @ [entry] = [total cost]
**Current:** [price] | P&L: [amount] ([percent])
**Value:** [current market value]

### Technical
- Trend: [up/down/sideways]
- Support: [level 1], [level 2]
- Resistance: [level 1], [level 2]
- Key moving averages: [list relevant MAs]

### Risk
- Position size: [percent of portfolio]
- Max loss: [amount]
- Stop suggestion: [level] ([percent] from current)

### Recommendation
[Action] at [price level] with [stop/exit] at [level]
```

### Options Position Analysis
```markdown
## [TICKER] [Strike][C/P] Analysis

**Position:** [contracts] contracts @ [premium] = [total cost]
**Current:** [price] | P&L: [amount] ([percent])
**Expiry:** [date] ([days] days away)

### Greeks
- Delta: [value] ([directional exposure])
- Gamma: [value] (acceleration)
- Theta: [value]/day (time decay)
- Vega: [value] (IV sensitivity)
- IV: [current] vs [30-day avg] ([percentile])

### Probability
- Probability of profit: [estimate]
- Probability of touching [strike]: [estimate]
- Max profit: [amount] (if [condition])
- Max loss: [amount] (if [condition])

### Recommendation
[Action] — [rationale]
```

### Portfolio Review
```markdown
## Portfolio Summary

**Total Value:** [amount]
**Total Cost Basis:** [amount]
**Overall P&L:** [amount] ([percent])

### Holdings Breakdown
| Ticker | Shares | Cost | Current | P&L | % Portfolio |
|--------|--------|------|---------|-----|-------------|

### Concentration Risk
- Largest position: [ticker] at [percent]%
- Sector exposure: [breakdown]
- Correlation note: [if positions move together]

### Recommendations
1. [Action item 1]
2. [Action item 2]
```

## Key Metrics to Calculate

### For Stocks
- P&L: (current - entry) × shares
- P&L %: (current - entry) / entry × 100
- Position weight: position value / total portfolio value

### For Options
- Intrinsic value: max(0, stock - strike) for calls, max(0, strike - stock) for puts
- Time value: premium - intrinsic
- Breakeven: strike + premium (calls), strike - premium (puts)
- Days to expiry and theta impact

## Disclaimer

Always include: "This is analysis for educational purposes, not financial advice. Do your own research and consider consulting a financial advisor."

## Web Search Triggers

Search for live data when:
- User asks "what's [ticker] at right now"
- You need current price to calculate P&L
- User asks about earnings, news, or events
- User asks about live ticket prices or market data
- IV or options chain data is needed and not provided
