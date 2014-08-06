#!/usr/bin/env node

log = console.log.bind(console);
window = global;

var termColors = [0x000000, 0x800000, 0x008000, 0x808000, 0x000080, 0x800080, 0x008080, 0xc0c0c0, 0x808080, 0xff0000, 0x00ff00, 0xffff00, 0x0000ff, 0xff00ff, 0x00ffff, 0xffffff, 0x000000, 0x00005f, 0x000087, 0x0000af, 0x0000d7, 0x0000ff, 0x005f00, 0x005f5f, 0x005f87, 0x005faf, 0x005fd7, 0x005fff, 0x008700, 0x00875f, 0x008787, 0x0087af, 0x0087d7, 0x0087ff, 0x00af00, 0x00af5f, 0x00af87, 0x00afaf, 0x00afd7, 0x00afff, 0x00d700, 0x00d75f, 0x00d787, 0x00d7af, 0x00d7d7, 0x00d7ff, 0x00ff00, 0x00ff5f, 0x00ff87, 0x00ffaf, 0x00ffd7, 0x00ffff, 0x5f0000, 0x5f005f, 0x5f0087, 0x5f00af, 0x5f00d7, 0x5f00ff, 0x5f5f00, 0x5f5f5f, 0x5f5f87, 0x5f5faf, 0x5f5fd7, 0x5f5fff, 0x5f8700, 0x5f875f, 0x5f8787, 0x5f87af, 0x5f87d7, 0x5f87ff, 0x5faf00, 0x5faf5f, 0x5faf87, 0x5fafaf, 0x5fafd7, 0x5fafff, 0x5fd700, 0x5fd75f, 0x5fd787, 0x5fd7af, 0x5fd7d7, 0x5fd7ff, 0x5fff00, 0x5fff5f, 0x5fff87, 0x5fffaf, 0x5fffd7, 0x5fffff, 0x870000, 0x87005f, 0x870087, 0x8700af, 0x8700d7, 0x8700ff, 0x875f00, 0x875f5f, 0x875f87, 0x875faf, 0x875fd7, 0x875fff, 0x878700, 0x87875f, 0x878787, 0x8787af, 0x8787d7, 0x8787ff, 0x87af00, 0x87af5f, 0x87af87, 0x87afaf, 0x87afd7, 0x87afff, 0x87d700, 0x87d75f, 0x87d787, 0x87d7af, 0x87d7d7, 0x87d7ff, 0x87ff00, 0x87ff5f, 0x87ff87, 0x87ffaf, 0x87ffd7, 0x87ffff, 0xaf0000, 0xaf005f, 0xaf0087, 0xaf00af, 0xaf00d7, 0xaf00ff, 0xaf5f00, 0xaf5f5f, 0xaf5f87, 0xaf5faf, 0xaf5fd7, 0xaf5fff, 0xaf8700, 0xaf875f, 0xaf8787, 0xaf87af, 0xaf87d7, 0xaf87ff, 0xafaf00, 0xafaf5f, 0xafaf87, 0xafafaf, 0xafafd7, 0xafafff, 0xafd700, 0xafd75f, 0xafd787, 0xafd7af, 0xafd7d7, 0xafd7ff, 0xafff00, 0xafff5f, 0xafff87, 0xafffaf, 0xafffd7, 0xafffff, 0xd70000, 0xd7005f, 0xd70087, 0xd700af, 0xd700d7, 0xd700ff, 0xd75f00, 0xd75f5f, 0xd75f87, 0xd75faf, 0xd75fd7, 0xd75fff, 0xd78700, 0xd7875f, 0xd78787, 0xd787af, 0xd787d7, 0xd787ff, 0xd7af00, 0xd7af5f, 0xd7af87, 0xd7afaf, 0xd7afd7, 0xd7afff, 0xd7d700, 0xd7d75f, 0xd7d787, 0xd7d7af, 0xd7d7d7, 0xd7d7ff, 0xd7ff00, 0xd7ff5f, 0xd7ff87, 0xd7ffaf, 0xd7ffd7, 0xd7ffff, 0xff0000, 0xff005f, 0xff0087, 0xff00af, 0xff00d7, 0xff00ff, 0xff5f00, 0xff5f5f, 0xff5f87, 0xff5faf, 0xff5fd7, 0xff5fff, 0xff8700, 0xff875f, 0xff8787, 0xff87af, 0xff87d7, 0xff87ff, 0xffaf00, 0xffaf5f, 0xffaf87, 0xffafaf, 0xffafd7, 0xffafff, 0xffd700, 0xffd75f, 0xffd787, 0xffd7af, 0xffd7d7, 0xffd7ff, 0xffff00, 0xffff5f, 0xffff87, 0xffffaf, 0xffffd7, 0xffffff, 0x080808, 0x121212, 0x1c1c1c, 0x262626, 0x303030, 0x3a3a3a, 0x444444, 0x4e4e4e, 0x585858, 0x606060, 0x666666, 0x767676, 0x808080, 0x8a8a8a, 0x949494, 0x9e9e9e, 0xa8a8a8, 0xb2b2b2, 0xbcbcbc, 0xc6c6c6, 0xd0d0d0, 0xdadada, 0xe4e4e4, 0xeeeeee];

function HEX_RGB(hex) {
  var hexVal = typeof hex === 'string' ? window.parseInt(hex.replace('#', ''), 16) : hex;
  var R = (hexVal >> 16) & 0xff,
      G = (hexVal >> 8) & 0xff,
      B = hexVal & 0xff;
  return [R, G, B];
}

function RGB_XYZ(rgb) {
  var R = rgb[0] / 255,
      G = rgb[1] / 255,
      B = rgb[2] / 255;
  R = R > 0.04045 ?
    Math.pow((R + 0.055) / 1.055, 2.4) :
    R / 12.92;
  G = G > 0.04045 ?
    Math.pow((G + 0.055) / 1.055, 2.4) :
    G / 12.92;
  B = B > 0.04045 ?
    Math.pow((B + 0.055) / 1.055, 2.4) :
    B / 12.92;
  R *= 100;
  G *= 100;
  B *= 100;
  var X = R * 0.4124 + G * 0.3576 + B * 0.1805,
      Y = R * 0.2126 + G * 0.7152 + B * 0.0722,
      Z = R * 0.0193 + G * 0.1192 + B * 0.9505;
  return [X, Y, Z];
}

function XYZ_Lab(xyz) {
  var ep = 0.008856,
      ka = 903.3;
  var X = xyz[0] / 95.047,
      Y = xyz[1] / 100,
      Z = xyz[2] / 108.883;
  var fX = X > ep ?
    Math.pow(X, 1 / 3) :
    (ka * X + 16) / 116;
  var fY = Y > ep ?
    Math.pow(Y, 1 / 3) :
    (ka * Y + 16) / 116;
  var fZ = Z > ep ?
    Math.pow(Z, 1 / 3) :
    (ka * Z + 16) / 116;
  var L = 116 * fY - 16,
      a = 500 * (fX - fY),
      b = 200 * (fY - fZ);
  return [L, a, b];
}

function Lab_LCH(lab) {
  var a = lab[1], b = lab[2];
  var H = Math.atan2(b, a);
  H = H > 0 ? (H / Math.PI) * 180 :
              360 - (Math.abs(H) / Math.PI) * 180;
  var C = Math.sqrt(a * a + b * b);
  return [lab[0], C, H];
}

function CIE76(lab1, lab2) {
  var dE = Math.sqrt(Math.pow(lab2[0] - lab1[0], 2) +
                     Math.pow(lab2[1] - lab1[1], 2) +
                     Math.pow(lab2[2] - lab1[2], 2));
  return dE;
}

function HEX_LAB(hex) {
  var rgb = HEX_RGB(hex);
  var xyz = RGB_XYZ(rgb);
  var lab = XYZ_Lab(xyz);
  return lab;
}

function HEX_TERM(hex) {
  var lab = HEX_LAB(hex);
  var deltas = termColors.map(function(hex) {
    return CIE76(lab, HEX_LAB(hex));
  });
  var deltaUpper = Infinity;
  var deltaCode;
  deltas.slice(16).forEach(function(e, i) {
    if (e < deltaUpper) {
      deltaUpper = e;
      deltaCode = i + 16;
    }
  });
  return deltaCode;
}

function FG(string, code) {
  return '\x1b[38;5;' + code + 'm' + string + '\x1b[0m';
}

function BG(string, code) {
  return '\x1b[48;5;' + code + 'm' + string + '\x1b[0m';
}

function printColor(arg) {
  var rgb;
  if (arg.length <= 3) {
    rgb = ('000000000' + termColors[arg % termColors.length].toString(16)).slice(-6);
    log(rgb + ': ' + BG(FG(' ' + arg + ' ', 0), arg), FG(arg, arg));
  } else {
    rgb = arg.slice(-6);
    var term = HEX_TERM(rgb);
    log(rgb + ': ' + BG(FG(' ' + term + ' ', 0), term), FG(term, term));
  }
}

var arg = process.argv[2];
if (arg) {
  printColor(arg);
} else {
  for (var i = 0; i < 256; i++) {
    printColor('' + i);
  }
}
