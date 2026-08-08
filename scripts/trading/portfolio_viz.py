#!/usr/bin/env python3
"""Generate a 4-panel portfolio dashboard from portfolio_snapshots.csv."""

import argparse
import sys
import webbrowser
from pathlib import Path

import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
from plotly.subplots import make_subplots

SCRIPT_DIR = Path(__file__).parent
DEFAULT_CSV = SCRIPT_DIR / "portfolio_snapshots.csv"
DARK_BG = "#1a1a2e"
LIGHT_TEXT = "#e0e0e0"
ACCENT = ["#00d2ff", "#7b2ff7", "#ff6b6b", "#ffd93d", "#6bcb77", "#ff8a5c", "#a3d8f4"]


def load_data(csv_path: Path) -> pd.DataFrame:
    df = pd.read_csv(csv_path, parse_dates=["date"])
    df["shares"] = pd.to_numeric(df["shares"], errors="coerce")
    df["cost_basis_per_share"] = pd.to_numeric(df["cost_basis_per_share"], errors="coerce")
    df["value"] = pd.to_numeric(df["value"], errors="coerce")
    return df


def chart_allocation(df: pd.DataFrame) -> go.Figure:
    latest = df[df["date"] == df["date"].max()]
    invested = latest[latest["symbol"] != "Cash"]
    agg = invested.groupby("symbol", as_index=False)["value"].sum()
    cash_val = latest[latest["symbol"] == "Cash"]["value"].sum()

    fig = go.Figure()
    fig.add_trace(go.Pie(
        labels=agg["symbol"],
        values=agg["value"],
        hole=0.45,
        textinfo="label+percent",
        textfont=dict(color=LIGHT_TEXT, size=12),
        marker=dict(colors=ACCENT[:len(agg)]),
        hovertemplate="%{label}: $%{value:,.0f}<extra></extra>",
    ))
    fig.update_layout(
        title=dict(text="Portfolio Allocation", font=dict(color=LIGHT_TEXT, size=18)),
        paper_bgcolor=DARK_BG,
        plot_bgcolor=DARK_BG,
        font=dict(color=LIGHT_TEXT),
        showlegend=False,
        annotations=[dict(
            text=f"Cash: ${cash_val:,.0f}",
            x=0.5, y=-0.05,
            showarrow=False,
            font=dict(color="#ffd93d", size=13),
        )],
    )
    return fig


def chart_growth(df: pd.DataFrame) -> go.Figure:
    daily = df.groupby(["date", "account"], as_index=False)["value"].sum()
    total = df.groupby("date", as_index=False)["value"].sum()
    total["account"] = "Total"

    if df["date"].nunique() == 1:
        combined = pd.concat([daily, total])
        fig = px.bar(combined, x="account", y="value", color="account",
                     color_discrete_sequence=ACCENT, barmode="group")
        fig.update_traces(hovertemplate="%{x}: $%{y:,.0f}<extra></extra>")
    else:
        combined = pd.concat([daily, total])
        fig = px.line(combined, x="date", y="value", color="account",
                      color_discrete_sequence=ACCENT, markers=True)
        fig.update_traces(hovertemplate="%{x|%b %d}: $%{y:,.0f}<extra></extra>")
        total_trace = combined[combined["account"] == "Total"]
        fig.add_trace(go.Scatter(
            x=total_trace["date"], y=total_trace["value"],
            mode="lines", name="Total",
            line=dict(color="#ff6b6b", dash="dash", width=3),
        ))

    fig.update_layout(
        title=dict(text="Portfolio Growth Over Time", font=dict(color=LIGHT_TEXT, size=18)),
        paper_bgcolor=DARK_BG,
        plot_bgcolor="#16213e",
        font=dict(color=LIGHT_TEXT),
        xaxis=dict(gridcolor="#2a2a4a"),
        yaxis=dict(gridcolor="#2a2a4a", tickformat="$,.0f"),
        legend=dict(bgcolor="rgba(0,0,0,0)"),
    )
    return fig


def chart_holdings(df: pd.DataFrame) -> go.Figure:
    daily = df.groupby(["date", "account", "symbol"], as_index=False)["value"].sum()
    accounts = daily["account"].unique()
    specs = [[{"type": "xy"} for _ in accounts]]
    fig = make_subplots(rows=1, cols=len(accounts), subplot_titles=list(accounts),
                        horizontal_spacing=0.08)

    for i, account in enumerate(accounts):
        subset = daily[daily["account"] == account]
        symbols = subset["symbol"].unique()
        for j, sym in enumerate(symbols):
            s = subset[subset["symbol"] == sym]
            fig.add_trace(go.Bar(
                x=s["date"], y=s["value"], name=sym,
                marker_color=ACCENT[j % len(ACCENT)],
                showlegend=(i == 0),
                hovertemplate=f"{sym}: $%{{y:,.0f}}<extra></extra>",
            ), row=1, col=i + 1)

    fig.update_layout(
        barmode="stack",
        title=dict(text="Holdings by Account", font=dict(color=LIGHT_TEXT, size=18)),
        paper_bgcolor=DARK_BG,
        plot_bgcolor="#16213e",
        font=dict(color=LIGHT_TEXT),
        legend=dict(bgcolor="rgba(0,0,0,0)"),
    )
    fig.update_yaxes(tickformat="$,.0f", gridcolor="#2a2a4a")
    fig.update_xaxes(gridcolor="#2a2a4a")
    for ann in fig.layout.annotations:
        if ann.text in accounts:
            ann.font = dict(color=LIGHT_TEXT, size=14)
    return fig


def chart_gainloss(df: pd.DataFrame) -> go.Figure:
    latest = df[df["date"] == df["date"].max()]
    rows = []
    for _, r in latest.iterrows():
        if r["symbol"] == "Cash" or pd.isna(r["shares"]) or r["shares"] == 0 or pd.isna(r["cost_basis_per_share"]):
            pct = 0.0
        else:
            cost_total = r["shares"] * r["cost_basis_per_share"]
            pct = ((r["value"] - cost_total) / cost_total) * 100
        rows.append({"label": f"{r['account']}: {r['symbol']}", "pct": pct})

    gl = pd.DataFrame(rows).sort_values("pct")
    colors = ["#ff6b6b" if v < 0 else "#6bcb77" for v in gl["pct"]]

    fig = go.Figure()
    fig.add_trace(go.Bar(
        y=gl["label"], x=gl["pct"], orientation="h",
        marker_color=colors,
        text=[f"{v:+.1f}%" for v in gl["pct"]],
        textposition="outside",
        textfont=dict(color=LIGHT_TEXT),
        hovertemplate="%{y}: %{x:+.2f}%<extra></extra>",
    ))
    fig.update_layout(
        title=dict(text="Position Gain/Loss %", font=dict(color=LIGHT_TEXT, size=18)),
        paper_bgcolor=DARK_BG,
        plot_bgcolor="#16213e",
        font=dict(color=LIGHT_TEXT),
        xaxis=dict(title="% Return", gridcolor="#2a2a4a", zeroline=True, zerolinecolor="#555"),
        yaxis=dict(gridcolor="#2a2a4a"),
        showlegend=False,
    )
    return fig


def build_dashboard(df: pd.DataFrame, output_path: Path, static: bool = False):
    latest_date = df["date"].max().strftime("%Y-%m-%d")
    total_value = df[df["date"] == latest_date]["value"].sum()
    num_positions = len(df[df["date"] == latest_date])
    num_accounts = df[df["date"] == latest_date]["account"].nunique()

    fig1 = chart_allocation(df)
    fig2 = chart_growth(df)
    fig3 = chart_holdings(df)
    fig4 = chart_gainloss(df)

    figs = [fig1, fig2, fig3, fig4]
    fig_divs = []
    for i, fig in enumerate(figs):
        div = fig.to_html(full_html=False, include_plotlyjs=False)
        fig_divs.append(f'<div class="chart" id="chart{i+1}">{div}</div>')

    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Portfolio Dashboard</title>
<script src="https://cdn.plot.ly/plotly-2.27.0.min.js"></script>
<style>
  * {{ margin: 0; padding: 0; box-sizing: border-box; }}
  body {{ background: {DARK_BG}; color: {LIGHT_TEXT}; font-family: 'Segoe UI', system-ui, sans-serif; padding: 24px; }}
  .header {{ text-align: center; margin-bottom: 24px; }}
  .header h1 {{ font-size: 28px; font-weight: 600; }}
  .header .date {{ color: #aaa; font-size: 14px; margin-top: 4px; }}
  .stats {{ display: flex; justify-content: center; gap: 40px; margin-bottom: 28px; }}
  .stat {{ text-align: center; }}
  .stat .val {{ font-size: 24px; font-weight: 700; color: #00d2ff; }}
  .stat .lbl {{ font-size: 12px; color: #888; text-transform: uppercase; letter-spacing: 1px; }}
  .grid {{ display: grid; grid-template-columns: 1fr 1fr; gap: 20px; max-width: 1400px; margin: 0 auto; }}
  .chart {{ background: #16213e; border-radius: 12px; padding: 12px; min-height: 360px; }}
</style>
</head>
<body>
<div class="header">
  <h1>Portfolio Dashboard</h1>
  <div class="date">As of {latest_date}</div>
</div>
<div class="stats">
  <div class="stat"><div class="val">${total_value:,.0f}</div><div class="lbl">Total Value</div></div>
  <div class="stat"><div class="val">{num_positions}</div><div class="lbl">Positions</div></div>
  <div class="stat"><div class="val">{num_accounts}</div><div class="lbl">Accounts</div></div>
</div>
<div class="grid">
  {fig_divs[0]}
  {fig_divs[1]}
  {fig_divs[2]}
  {fig_divs[3]}
</div>
</body>
</html>"""

    if static:
        combined = make_subplots(rows=2, cols=2, specs=[[{"type": "pie"}, {"type": "xy"}], [{"type": "xy"}, {"type": "xy"}]],
                                 subplot_titles=["Portfolio Allocation", "Holdings by Account",
                                                 "Portfolio Growth", "Position Gain/Loss %"])
        for trace in fig1.data:
            combined.add_trace(trace, row=1, col=1)
        for trace in fig4.data:
            combined.add_trace(trace, row=2, col=2)
        combined.update_layout(paper_bgcolor=DARK_BG, plot_bgcolor=DARK_BG, font=dict(color=LIGHT_TEXT),
                               height=800, width=1200)
        png_path = output_path.with_suffix(".png")
        combined.write_image(str(png_path), scale=2)
        print(f"Dashboard exported: {png_path}")
    else:
        output_path.write_text(html)
        print(f"Dashboard written: {output_path}")


def main():
    parser = argparse.ArgumentParser(description="Portfolio visualization dashboard")
    parser.add_argument("--output", default=str(SCRIPT_DIR / "portfolio_dashboard.html"),
                        help="Output file path")
    parser.add_argument("--snapshots", default=str(DEFAULT_CSV),
                        help="Path to portfolio_snapshots.csv")
    parser.add_argument("--static", action="store_true",
                        help="Export as PNG instead of HTML (requires kaleido)")
    parser.add_argument("--open", action="store_true", default=True,
                        help="Open dashboard in browser after generating (default: True)")
    parser.add_argument("--no-open", action="store_true",
                        help="Don't open browser after generating")
    args = parser.parse_args()

    csv_path = Path(args.snapshots)
    if not csv_path.exists():
        print(f"Error: {csv_path} not found", file=sys.stderr)
        sys.exit(1)

    df = load_data(csv_path)
    if df.empty:
        print("Error: CSV is empty", file=sys.stderr)
        sys.exit(1)

    output_path = Path(args.output)
    build_dashboard(df, output_path, static=args.static)

    if not args.static and not args.no_open:
        webbrowser.open(f"file://{output_path.resolve()}")


if __name__ == "__main__":
    main()
