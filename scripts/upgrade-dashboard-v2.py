import json
import shutil
from pathlib import Path
from datetime import datetime

PATH = Path("/opt/monitoring/grafana/dashboards/linux-dashboard.json")

# Preserve current dashboard before changes
backup = PATH.with_name(
    f"linux-dashboard.backup-{datetime.now():%Y%m%d-%H%M%S}.json"
)
shutil.copy2(PATH, backup)

with PATH.open() as f:
    dashboard = json.load(f)

panels = dashboard["panels"]
status_ids = {9, 10, 11, 12, 13}

# Shift original graphs down only once
if not any(p.get("id") in status_ids for p in panels):
    for p in panels:
        if p["id"] in {1, 2, 3, 4}:
            p["gridPos"]["y"] += 4

# Remove previous versions of these new panels (safe to rerun)
panels = [p for p in panels if p.get("id") not in status_ids]

# Improve the four KPI cards
for p in panels:
    if p.get("id") in {5, 6, 7, 8}:
        p["options"]["colorMode"] = "value"

def make_stat(panel_id, title, expr, x, width, mapping=None,
              thresholds=None, unit="none"):
    steps = [{"color": "green", "value": None}]

    if thresholds:
        for value, color in thresholds:
            steps.append({"color": color, "value": value})

    defaults = {
        "unit": unit,
        "decimals": 0,
        "color": {"mode": "thresholds"},
        "thresholds": {"mode": "absolute", "steps": steps},
    }

    if mapping:
        defaults["mappings"] = [{
            "type": "value",
            "options": mapping
        }]

    return {
        "id": panel_id,
        "title": title,
        "type": "stat",
        "gridPos": {"h": 4, "w": width, "x": x, "y": 4},
        "datasource": {"type": "prometheus", "uid": "prometheus"},
        "targets": [{
            "expr": expr,
            "refId": "A"
        }],
        "fieldConfig": {
            "defaults": defaults,
            "overrides": []
        },
        "options": {
            "reduceOptions": {
                "calcs": ["lastNotNull"],
                "fields": "",
                "values": False
            },
            "orientation": "auto",
            "textMode": "value_and_name",
            "colorMode": "value",
            "graphMode": "none",
            "justifyMode": "center",
            "wideLayout": True
        }
    }

healthy_mapping = {
    "0": {"text": "DOWN", "color": "red"},
    "1": {"text": "UP", "color": "green"}
}

threshold_mapping = {
    "0": {"text": "NORMAL", "color": "green"},
    "1": {"text": "HIGH", "color": "red"}
}

new_panels = [
    make_stat(
        9, "Prometheus Health",
        'max(up{job="prometheus"}) or vector(0)',
        0, 5, healthy_mapping,
        [(1, "red")]
    ),
    make_stat(
        10, "Node Exporter Health",
        'max(up{job="node-exporter"}) or vector(0)',
        5, 5, healthy_mapping,
        [(1, "red")]
    ),
    make_stat(
        11, "Firing Alerts",
        'sum(ALERTS{alertstate="firing"}) or vector(0)',
        10, 5, None,
        [(1, "yellow"), (5, "red")]
    ),
    make_stat(
        12, "CPU Threshold",
        '100 * (1 - avg(rate(node_cpu_seconds_total{mode="idle"}[5m]))) > bool 80',
        15, 5, threshold_mapping,
        [(1, "red")]
    ),
    make_stat(
        13, "Memory Threshold",
        '(100 * (1 - node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes) > bool 85) or vector(0)',
        20, 4, threshold_mapping,
        [(1, "red")]
    )
]

dashboard["panels"] = panels + new_panels
dashboard["version"] = dashboard.get("version", 1) + 1

# Validate before saving
json.dumps(dashboard)
assert len(dashboard["panels"]) == 13
assert len({p["id"] for p in dashboard["panels"]}) == 13

with PATH.open("w") as f:
    json.dump(dashboard, f, indent=2)
    f.write("\n")

print("SUCCESS: AEGIS dashboard upgraded")
print("Backup:", backup)
print("Total panels:", len(dashboard["panels"]))

for p in dashboard["panels"]:
    print(p["id"], "|", p["title"], "|", p["type"])
