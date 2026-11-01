| SPDX-License-Identifier: AGPL-3.0-or-later
| Macro (Digi2MacroOSC) on core-dt2 2.4: the MACRO machine and its five parameters, as DigiKit's machines/plaits module
| (module.toml [[entry]]) describes them, given to core's tables; and the two hook tails of its DX7 name hooks.

        .equ    P_MODEL, 275
        .equ    P_HARM, 276
        .equ    P_TIMBRE, 277
        .equ    P_MORPH, 278
        .equ    P_MIX, 279

        .section .rodata
        .balign 4
| struct core_machine_dt2 (core-dt2 2.4, machines.s)
        .globl  plaits_machine
plaits_machine:
        .long   11                      | type (DigiKit's types.toml: machines/plaits:plaits = 11)
        .long   6                       | clone_of: MANUAL SLICE
        .long   255                     | position: the end of the list
        .long   1                       | flags: one SRC page (POLY does not share its voices)
        .long   0xf8, P_MODEL, P_HARM, 0, P_TIMBRE, P_MORPH, P_MIX, 0xfe, 0x0a
        .long   pl_name, pl_short

| struct core_param_dt2 (core-dt2 2.0, params.s): code, name, short, template, slot, min, max, default, formatter,
| randomize
        .globl  plaits_p_model, plaits_p_harm, plaits_p_timbre, plaits_p_morph, plaits_p_mix
plaits_p_model:
        .long   P_MODEL, pn_model, ps_model, 0xfe, 1, 0, 0x1800, 0, plaits_model_fmt, plaits_model_rand
plaits_p_harm:
        .long   P_HARM, pn_harm, ps_harm, 0xfe, 2, 0, 0x7f00, 0x4000, 0, 1
plaits_p_timbre:
        .long   P_TIMBRE, pn_timbre, ps_timbre, 0xfe, 4, 0, 0x7f00, 0x4000, 0, 1
plaits_p_morph:
        .long   P_MORPH, pn_morph, ps_morph, 0xfe, 5, 0, 0x7f00, 0x4000, 0, 1
plaits_p_mix:
        .long   P_MIX, pn_mix, ps_mix, 0xfe, 6, 0, 0x7f00, 0, 0, 0

pl_name:   .asciz "Macro"
pl_short:  .asciz "MAC"
pn_model:  .asciz "Model"
ps_model:  .asciz "MODEL"
pn_harm:   .asciz "Harmonics"
ps_harm:   .asciz "HARM"
pn_timbre: .asciz "Timbre"
ps_timbre: .asciz "TIMB"
pn_morph:  .asciz "Morph"
ps_morph:  .asciz "MORPH"
pn_mix:    .asciz "Mix"
ps_mix:    .asciz "MIX"

| the hook tails (DigiKit's hook.plaits.dx7.*.tail): the displaced instructions, then back
        .text
        .globl  _dn_tail, _dn_ltail
_dn_tail:                               | at 0x4006ce92: jsr param_value_text
        jsr     0x400c8952
        jmp     _dn_ret
_dn_ltail:                              | at 0x40069cc8: movea.l 0x5c(a1),a1; move.l d0,0x44(a7)
        movea.l 0x5c(%a1), %a1
        move.l  %d0, 0x44(%sp)
        jmp     _dn_lret
