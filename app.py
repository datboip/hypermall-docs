from collections import deque
from flask import Flask, render_template, request, redirect
import json, os

CONFIG_PATH = os.path.expanduser('~/hypermall_config.json')

def load_cfg():
    if os.path.isfile(CONFIG_PATH):
        with open(CONFIG_PATH) as f:
            return json.load(f)
    # default values
    return {
        "pear_url": "pear://f5ccjf7p5s3ay1x4w9dmnjoox4655ux96kdq4ydqeonho9abin8o",
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
        cfg['store']   = request.form['store']
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
