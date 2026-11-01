# Digi2MacroOSC: MACRO for the Digitakt II

**MACRO** is a macro-oscillator machine for the **Elektron Digitakt II** (OS 1.17). It is an elekloader mod on
core-dt2 2.4: one machine (type 11) with five parameters (codes 275-279), a graphical model selector, and a DSP
voice that runs 25 synthesis models and four DX7 patch banks.

- **MODEL** picks the synthesis model (25 models, with a graphical selector in the knob drawer).
- **HARM**, **TIMBRE**, **MORPH**, **MIX** shape the chosen model, as on the Plaits engine.
- Four DX7 patch banks give the DX7 models their names and patches.

The synthesis is after Émilie Gillet's open-source Plaits (MIT). Its DSP object is built from DigiKit's
`machines/plaits` module (Em D; with Tyler Neely / spacejam's optimisations). The knob drawing follows Kári's
Digitakt UI 2.1.

> Unofficial and unsupported. Flashing modified firmware is at your own risk; the stock OS always recovers the
> unit (send the stock .syx from the boot menu). This repository contains no Elektron code or firmware.

## What you need

| | |
|---|---|
| Unit | Digitakt II, OS 1.17 |
| Mods | **core-dt2 2.4** and this mod, `elemods/macro-0.4.0.elemod` |
| elekloader | a build with `sharc_raw` support for the Digitakt II |
| Not with | `aio-plaits` (this mod conflicts with it) |

Build the firmware from your own stock OS file:

```
python -m elekloader.patch --stock Digitakt_II_OS1.17.syx \
  --mod core-2.4.elemod --mod elemods/macro-0.4.0.elemod --out Digitakt_II_macro.syx
```

Never share the resulting .syx: it contains Elektron's OS.

## Layout

| path | what |
|---|---|
| `mod/machine.s` | the machine descriptor and its five parameters |
| `mod/model_fmt.s`, `mod/dx7_text.s`, `mod/dx7_names.s` | the MODEL value text, the DX7 names and the two name hooks |
| `mod/ui21.s` | the graphical MODEL selector (Kári's UI 2.1) |
| `mod/randomize.s` | the randomise rules for the five parameters |
| `mod/plaits-48k-dsp.dko.json` | the built DSP object (DigiKit's machines/plaits, 48 kHz) |
| `mod/sharc_raw.json` | adds the DSP object to core's voice table |
| `elemods/` | the built mod |

## Licence

AGPL-3.0-or-later (see `LICENSE`), as DigiKit's DSP it is built from. Plaits (MIT) is credited above.
