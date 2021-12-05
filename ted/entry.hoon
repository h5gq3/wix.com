/-  spider, sur=wix
/+  strandio, lib=wix
=,  strand=strand:spider
^-  thread:spider
|=  arg=vase
=/  m  (strand ,vase)
^-  form:m
=+  !<([~ =action:sur] arg)
?>  ?=(%textbox-entry -.action)
;<  =bowl:spider  bind:m  get-bowl:strandio
=*  lib  ~(. ^lib *bowl:gall)
::  get first line of cord from textbox:
::  parse cord until first newline char
=/  mod
  (rush cord.action (cook crip (ifix [zap (star ;~(sfix gah (star prn)))] (star prn))))
?~  mod  (pure:m !>(`tang`[%leaf "Syntax Error"]~))
=/  bod
  (crip (oust [0 (add 1 (lent (trip u.mod)))] (trip cord.action)))
::
?+  u.mod  (pure:m !>(`tang`[%leaf "yet unknown mod type"]~))
  %sail
;<  =tang  bind:m  (eval-sail:strands:lib bod)
(pure:m !>(tang))
  %html
;<  html-tang=tang  bind:m
  =/  m  (strand ,tang)
  (pure:m `tang`[leaf+(trip bod)]~)
(pure:m !>(html-tang))
==
