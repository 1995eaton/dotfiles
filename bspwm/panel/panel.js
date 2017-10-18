#!/usr/bin/env node

'use strict';

let exec = require('child_process').exec;

function zfill(str, n) {
  return ('0'.repeat(n) + str).slice(-n);
}

class PanelHelpers {

  static desktops() {
    return new Promise(accept => {
      exec('bspc query -D -d', (error, stdout) => {
        let current = stdout.split('\n')[0];
        exec('bspc query -D', (error, stdout) => {
          let all = stdout.split('\n').filter(e => e);
          accept(all.map(name => {
            return current === name ? '-' : '+';
          }).join('  '));
        });
      });
    });
  }

  static cpu() {
    return new Promise(accept => {
      exec('mpstat 1 1', (error, stdout) => {
        stdout = (100 - stdout.split('\n')
                              .slice(-2)[0]
                              .split(/\s+/)
                              .filter(e => e)
                              .slice(-1)[0]
                 ).toFixed(2);
        accept(stdout);
      });
    });
  }

  static battery() {
    return new Promise(accept => {
      exec('acpi -b', (error, stdout) => {
        stdout = stdout.split('\n')[0]
                       .replace(/[^:]*:\s*/, '')
                       .split(/,\s+/);
        let percent = +stdout[1].slice(0, -1);
        let batteries = ['\uf244', '\uf243', '\uf242', '\uf241', '\uf240'];
        let battery = batteries[Math.round(percent / 100 * (batteries.length - 1))];
        switch (stdout[0]) {
        case 'Unknown':
        case 'Full':
        case 'Charging':
          accept(`${battery} +${percent}%`);
          break;
        default:
          accept(`${battery} -${percent}%`);
        }
      });
    });
  }

  static volume() {
    return new Promise(accept => {
      exec('amixer sget Master', (error, stdout) => {
        try {
          stdout = stdout.split('\n').find(line => /\[o(n|ff)\]/.test(line));
          stdout = stdout.split(/\s+/).filter(e => e);
          let percent = stdout.find(e => e.startsWith('[')).slice(1, -2) | 0;
          let volumes = ['\uf026', '\uf027', '\uf028'];
          let volume = volumes[Math.round(percent / 100 * (volumes.length - 1))];
          if (stdout[stdout.length - 1] === '[off]') {
            accept(`${volumes[0]} MM`);
          } else {
            accept(`${volume} ${percent}`);
          }
        } catch (error) {
          accept('ERR');
        }
      });
    });
  }

  static thermal() {
    return new Promise(accept => {
      exec('sensors', (error, stdout) => {
        stdout = stdout.split(/\n+/)
                       .filter(line => /^Core \d+:/.test(line));
        stdout = stdout.reduce((a, b) => {
          return a + parseInt(b.split(/\s+/)[2].slice(1, -2), 10);
        }, 0) / stdout.length;
        accept(stdout.toFixed(2));
      });
    });
  }

  static date() {
    return new Promise(accept => {
      let date = new Date();
      let month = date.getMonth() + 1,
          day   = zfill(date.getDate(), 2),
          year  = date.getFullYear().toString().slice(-2);
      accept(`${month}/${day}/${year}`);
    });
  }

  static time() {
    return new Promise(accept => {
      let date = new Date();
      let hour   = zfill(date.getHours() % 12 || 12, 2),
          minute = zfill(date.getMinutes(), 2);
      let ampm = date.getHours() >= 12 ? 'pm' : 'am';
      accept(`${hour}:${minute} ${ampm}`);
    });
  }
}

class PanelItem {
  constructor(updateFunc, updateFreq) {
    this.updateFunc = updateFunc;
    this.updateFreq = updateFreq;
    this.isRunning = false;
    this.panelText = null;
  }

  updateText() {
    return this.updateFunc().then(panelText => this.panelText = panelText);
  }

  start() {
    if (this.isRunning)
      return false;
    this.isRunning = true;
    this.interval = setInterval(() => {
      this.updateText();
    }, this.updateFreq);
  }

  stop() {
    if (!this.isRunning)
      return false;
    this.isRunning = false;
    clearInterval(this.interval);
  }

  getText() {
    return new Promise(accept => {
      if (this.panelText === null) {
        this.updateText().then(accept);
      } else {
        accept(this.panelText);
      }
    });
  }
}

(function() {
  let items = {
    desktops: 1000 * 0.5,
    cpu:      1000 * 1,
    // battery:  1000 * 5,
    volume:   1000 * 1,
    thermal:  1000 * 1,
    date:     1000 * 5,
    time:     1000 * 1
  };

  let interval = Math.min.apply(null, Object.getOwnPropertyNames(items).map(name => items[name]));

  Object.getOwnPropertyNames(items).forEach(name => {
    items[name] = new PanelItem(PanelHelpers[name], items[name]);
    items[name].start();
  });

  (function init() {
    let itemText = {}, firstRun = true;
    function printPanel() {
      let _ = itemText,
          fmt = `  ${_.desktops}%{r}${_.volume} | ` +
                `CPU (${_.cpu}% ${_.thermal}°C) | ${_.date} | ${_.time} `;
      // let _ = itemText,
      //     fmt = `  ${_.desktops}%{r}${_.volume} | ${_.battery} | ` +
      //           `CPU (${_.cpu}% ${_.thermal}°C) | ${_.date} | ${_.time} `;
      process.stdout.write(fmt + '\n');
    }
    (function loopFunc() {
      if (!firstRun)
        printPanel();
      Promise.all(Object.getOwnPropertyNames(items).map(name => {
        return new Promise(accept => {
          items[name].getText().then(text => {
            itemText[name] = text;
            accept();
          });
        });
      })).then(() => {
        if (firstRun) {
          firstRun = false;
          printPanel();
        }
        setTimeout(loopFunc, interval);
      });
    })();
  })();
})();
