/-  spider, sur=wix
/+  libstrand=strand, strandio, graph-lib=graph
=,  strand=strand:libstrand
=,  strand-fail=strand-fail:libstrand
|_  =bowl:gall
+*  graph-lib  ~(. ^graph-lib bowl)
++  strands
  |%
  ++  eval-sail
  |=  =cord
  =/  m  (strand ,tang)
  ^-  form:m
  ;<  =bowl:spider  bind:m  get-bowl:strandio
  =/  sail-body  (rush cord sail-body:de-sail-lus-lus)
  ?~  sail-body
    (pure:m `tang`[%leaf "Syntax Error 1"]~)
  =/  sail-body-ast  (rush u.sail-body vest)
  ?~  sail-body-ast
    (pure:m `tang`[%leaf "Syntax Error 2"]~)
  =/  fake-arms  (fake-arms-map cord)
  =/  fowl=[our=@p now=@da eny=@uvJ]
    :+  our.bowl
      now.bowl
    (shaz (cat 3 (mix [now eny]:bowl) %eny))
  ::
  =/  subject  [fowl hoonscript ..zuse]
  =/  minted=(each [=type =nock] (list tank))
    %-  mule  |.
    (~(mint ut -:!>(subject)) %noun u.sail-body-ast)
  ?:  ?=(%| -.minted)  (pure:m `tang`p.minted)
  =/  =toon
    (mock [subject nock.p.minted] |=(^ ~))
  %-  pure:m
  ^-  tang
  ?-  -.toon
    %0  :-  :-  %leaf
        ?~  fake-arms  (en-xml:html ;;(manx p.toon))
        (en-xml:html (give-fake-arms:helpers u.fake-arms ;;(manx p.toon)))  ~
    %1  :-  leaf+".^ unsupported in sail eval"
        (turn ;;((list path) p.toon) smyt)
    %2  [leaf+"crash!" p.toon]
  ==
  --
++  de-sail-lus-lus
  |%
  ++  parse  |=([=cord =rule] (rush cord rule))
  ++  mod
    (cook crip (ifix [zap gah] (star prn)))
  ++  fake-arm-name
    (cook crip (ifix [(jest '++') gap] (star ;~(less gap prn))))
  ++  javascript
    :: or hoonscript
    %+  cook
    ::mint here based on hoon on js
    |=  i=[term tape]
    ?.  ?=(%hoon -.i)  (crip +.i)
    %-  crip
    !<(tape ((swat |.(!>([hoonscript ..zuse])) (ream (crip +.i)))))
    ;~  pose
    (stag %js ;~(sfix ;~(plug ;~(less kel prn) (star prn)) gah))
    (stag %hoon (ifix [kel ;~(plug ker gah)] (star ;~(less ker prn))))
    ==
  ++  fake-arms
    %-  star
    ;~(plug fake-arm-name javascript)
  ++  sail-body
    %+  cook  crip
    ;~  pfix
      ;~  plug
      mod  fake-arms
      ==
      ;~(sfix (star ;~(pose prn gah)) (star ;~(less prn gah)))
    ==
  --
++  dejs
  =,  dejs:format
  |%
  ++  action
    |^
    ^-  $-(json action:sur)
    %-  of
    :~  textbox-entry+so
    ==
    --
  --
::  ++  enjs
::    =,  enjs:format
::    |%
::    ++  action
::      |=  act=action:sur
::      ^-  json
::    --
++  cors-proxy
  :: peek graph-store to get cors proxy provider URL
  |=  url=tape
  =/  cors-proxy-store  (get-graph-mop:graph-lib [~sun %cors-proxy-providers-8626])
  =/  keys  ~(tap in ~(key by cors-proxy-store))
  =/  no-of-keys  (lent keys)
  ?~  no-of-keys  !!
  =/  random-number
    -:(~(rads og eny.bowl) no-of-keys)
  =/  random-index  (snag random-number keys)
  =/  random-node  (~(got by cors-proxy-store) random-index)
  ?>  ?=(%.y -.post.val.random-node)
  =+  (skim contents.p.post.val.random-node |=(=content:store:graph-lib ?=(%url -.content)))
  =/  provider-url
    ?<(?=(~ -) ;;(@t +.i.-))
  :(weld (trip provider-url) "/" url)
  ::
++  helpers
  |%
  ++  give-fake-arms
    |=  [arms=(map @t @t) =manx]
    ^-  ^manx
    =/  oninit  (~(get by arms) 'oninit')
    =/  onload  (~(get by arms) 'onload')
    %+  append-child:manx-tools  manx
    ;div(oninit "{?~(oninit "" (scow %tas u.oninit))}", onload "{?~(onload "" (scow %tas u.onload))}");
  --
  ++  fake-arms-map
    |=  =cord
    ^-  (unit (map @t @t))
    =/  parsed  (rush cord (ifix [mod:de-sail-lus-lus (star ;~(pose prn gah))] fake-arms:de-sail-lus-lus))
    ?~  parsed  ~
    `(molt u.parsed)
::
++  manx-tools
  |%
  ++  append-child
    |=  [child=manx parent=manx]
    ^-  manx
    [g.parent (snoc c.parent child)]
  --
++  hoonscript
  |%
  ++  unfold-json-array
    |=  [url=tape f=tape]
    """
    (() => \{
    let req = new XMLHttpRequest();
    req.open('GET', '{url}');
    req.responseType = 'json';
    req.send();
    req.onreadystatechange = () => \{ if (req.readyState === 4) \{ req.response.forEach( item => {f})}};
    })()
    """
  ++  console-log
    |=  =tape
    "console.log({tape})"
  ++  create-child-append
    |=  [child=tape parent=tape child-content=tape]
    """
    \{
    let child = document.createElement('{child}');
    child.innerText = {child-content};
    let parent = document.querySelector('{parent}');
    parent.appendChild(child);
    }
    """
  --
--
