import json
from pathlib import Path

dashboard_path = Path(
    "/opt/monitoring/grafana/dashboards/linux-dashboard.json"
)

with dashboard_path.open() as file:
    dashboard = json.load(file)

# Prometheus queries for the four KPI cards
kpis = [
    {
        "id": 5,
        "title": "CPU Usage",
        "expr": '100 * (1 - avg by (instance) (rate(node_cpu_seconds_total{mode="idle"}[5m])))',
        "unit": "percent",
        "thresholds": [70, 85],
    },
    {
        "id": 6,
        "title": "Memory Usage",
        "expr": "100 * (1 - node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)",
        "unit": "percent",
        "thresholds": [70, 85],
    },
    {
        "id": 7,
        "title": "Root Disk Usage",
        "expr": '100 * (1 - node_filesystem_avail_bytes{mountpoint="/",fstype!~"tmpfs|overlay"} / node_filesystem_size_bytes{mountpoint="/",fstype!~"tmpfs|overlay"})',
        "unit": "percent",
        "thresholds": [80, 90],
    },
    {
        "id": 8,
        "title": "System Uptime",
        "expr": "time() - node_boot_time_seconds",
        "unit": "dtdurations",
        "thresholds": None,
    },
]

# Keep existing panels and move them below the KPI row
for panel in dashboard["panels"]:
    panel["gridPos"]["y"] += 4

# Build the new Stat panels
new_panels = []

for index, kpi in enumerate(kpis):
    steps = [{"color": "green", "value": None}]

    if kpi["thresholds"]:
        steps.extend([
            {"color": "yellow", "value": kpi["thresholds"][0]},
            {"color": "red", "value": kpi["thresholds"][1]},
        ])

    panel = {
        "id": kpi["id"],
        "title": kpi["title"],
        "type": "stat",
        "gridPos": {
            "h": 4,
            "w": 6,
            "x": index * 6,
            "y": 0,
        },
        "datasource": {
            "type": "prometheus",
            "uid": "prometheus",
        },
        "targets": [{
            "expr": kpi["expr"],
            "legendFormat": "{{instance}}",
            "refId": "A",
        }],
        "fieldConfig": {
            "defaults": {
                "unit": kpi["unit"],
                "decimals": 1,
                "color": {"mode": "thresholds"},
                "thresholds": {
                    "mode": "absolute",
                    "steps": steps,
                },
            },
            "overrides": [],
        },
        "options": {
            "reduceOptions": {
                "calcs": ["lastNotNull"],
                "fields": "",
                "values": False,
            },
            "orientation": "auto",
            "textMode": "auto",
            "colorMode": "background",
            "graphMode": "none",
            "justifyMode": "center",
            "wideLayout": True,
        },
    }

    new_panels.append(panel)

dashboard["panels"] = new_panels + dashboard["panels"]
dashboard["version"] = dashboard.get("version", 1) + 1

# Validate before writing
json.dumps(dashboard)
assert len(dashboard["panels"]) == 8
assert len({p["id"] for p in dashboard["panels"]}) == 8

with dashboard_path.open("w") as file:
    json.dump(dashboard, file, indent=2)
    file.write("\n")

print("SUCCESS: Dashboard upgraded")
print("Total panels:", len(dashboard["panels"]))

for panel in dashboard["panels"]:
    print(
        panel["id"],
        "|",
        panel["title"],
        "|",
        panel["type"],
        "|",
        panel["gridPos"],
    )
