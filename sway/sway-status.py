#!/usr/bin/env python3
import json
import subprocess
import sys
import threading
import time

def get_outputs():
    result = subprocess.run(
        ["swaymsg", "-t", "get_outputs"],
        capture_output=True, text=True,
    )
    return json.loads(result.stdout)


def any_vrr_enabled(outputs):
    return any(o.get("adaptive_sync_status") == "enabled" for o in outputs)


def set_vrr(on):
    action = "on" if on else "off"
    subprocess.run(["swaymsg", "output", "*", "adaptive_sync", action],
                   capture_output=True)


def toggle_vrr():
    outputs = get_outputs()
    set_vrr(not any_vrr_enabled(outputs))


def has_fullscreen_window():
    result = subprocess.run(
        ["swaymsg", "-t", "get_tree"],
        capture_output=True, text=True,
    )
    tree = json.loads(result.stdout)

    def walk(n):
        if n.get("type") == "con" and n.get("fullscreen_mode", 0) > 0 and n.get("pid"):
            return True
        for c in n.get("nodes", []) + n.get("floating_nodes", []):
            if walk(c):
                return True
        return False

    return walk(tree)


def listen_for_clicks():
    for line in sys.stdin:
        line = line.strip().lstrip(",")
        if not line:
            continue
        try:
            event = json.loads(line)
        except json.JSONDecodeError:
            continue
        if event.get("name") == "vrr":
            toggle_vrr()


def format_time():
    return time.strftime("%Y-%m-%d %X")


print(json.dumps({"version": 1, "click_events": True}))
print("[")
print("[]")

thread = threading.Thread(target=listen_for_clicks, daemon=True)
thread.start()

was_fullscreen = False

while True:
    outputs = get_outputs()
    vrr = any_vrr_enabled(outputs)
    fullscreen_now = has_fullscreen_window()

    if fullscreen_now and not was_fullscreen:
        if not vrr:
            set_vrr(True)
    elif was_fullscreen and not fullscreen_now:
        if vrr:
            set_vrr(False)

    was_fullscreen = fullscreen_now

    outputs = get_outputs()
    vrr = any_vrr_enabled(outputs)

    blocks = []
    blocks.append({
        "full_text": " VRR ",
        "color": "#00ff00" if vrr else "#ff0000",
        "separator": False,
        "name": "vrr",
    })
    blocks.append({"full_text": " ", "separator": False})
    blocks.append({"full_text": format_time()})

    print(f",{json.dumps(blocks)}", flush=True)
    time.sleep(1)
