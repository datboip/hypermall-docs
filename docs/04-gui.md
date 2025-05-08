# 04 - Web GUI

A simple Flask app to configure and monitor your Pear validator.

## app.py

The main Flask application:

```python
from collections import deque
from flask import Flask, render_template, request, redirect
import json, os

CONFIG_PATH = os.path.expanduser('~/hypermall_config.json')

def load_cfg():
    if os.path.isfile(CONFIG_PATH):
        with open(CONFIG_PATH) as f:
            return json.load(f)
    return {
        "pear_url": "pear://YOUR_PEAR_URL",
        "store": "store1"
    }

def save_cfg(cfg):
    with open(CONFIG_PATH, 'w') as f:
        json.dump(cfg, f, indent=2)

app = Flask(__name__)

@app.route('/', methods=['GET','POST'])
def index():
    cfg = load_cfg()
    if request.method == 'POST':
        cfg['pear_url'] = request.form['pear_url']
        cfg['store'] = request.form['store']
        save_cfg(cfg)
        return redirect('/')
    return render_template('index.html', cfg=cfg)

@app.route('/logs')
def logs():
    log_path = '/tmp/tracstore.log'
    if not os.path.isfile(log_path):
        return "Log file not found", 404
    with open(log_path) as f:
        last_lines = deque(f, maxlen=200)
    return (
        "<h1>Hypermall Log</h1>"
        "<pre>{}</pre>"
        "<a href='/'>← Back</a>"
    ).format("".join(last_lines))

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```

## templates/index.html

The HTML template for the GUI:

```html
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Hypermall GUI</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
  <div class="container py-4">
    <div class="card shadow-sm mb-4">
      <div class="card-body">
        <h1 class="card-title mb-3">Hypermall MSB Config</h1>
        <form method="post">
          <div class="mb-3">
            <label class="form-label">Pear URL</label>
            <input type="text" class="form-control" name="pear_url" value="{{cfg.pear_url}}">
          </div>
          <div class="mb-3">
            <label class="form-label">Store Name</label>
            <input type="text" class="form-control" name="store" value="{{cfg.store}}">
          </div>
          <button type="submit" class="btn btn-primary">Save &amp; Restart</button>
        </form>
      </div>
    </div>

    <div class="card shadow-sm mb-4">
      <div class="card-body">
        <h2 class="card-title mb-3">Current Command</h2>
        <pre class="bg-white p-2 rounded">{{ 'pear run ' + cfg.pear_url + ' ' + cfg.store }}</pre>
      </div>
    </div>

    <div class="text-center">
      <a href="/logs" class="btn btn-outline-secondary">View Log</a>
    </div>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

## Starting the GUI

Run the Flask app:

```bash
python3 app.py
```

Then visit `http://<YOUR_PI_IP>:5000` in your browser.

## Viewing Logs

Click **View Log** in the UI to tail the last 200 lines of `/tmp/tracstore.log`.
