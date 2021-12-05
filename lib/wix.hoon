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
  =/  ast=(unit hoon)
    (rush cord vest)
  ?~  ast
    (pure:m `tang`[%leaf "Syntax Error"]~)
  =/  fowl=[our=@p now=@da eny=@uvJ]
    :+  our.bowl
      now.bowl
    (shaz (cat 3 (mix [now eny]:bowl) %eny))
  ::
  =/  subject  [fowl ..zuse]
  =/  minted=(each [=type =nock] (list tank))
    %-  mule  |.
    (~(mint ut -:!>(subject)) %noun u.ast)
  ?:  ?=(%| -.minted)  (pure:m `tang`p.minted)
  =/  =toon
    (mock [subject nock.p.minted] |=(^ ~))
  %-  pure:m
  ^-  tang
  ?-  -.toon
    %0  [leaf+(en-xml:html ;;(manx p.toon)) ~]
    %1  :-  leaf+".^ unsupported in sail eval"
        (turn ;;((list path) p.toon) smyt)
    %2  [leaf+"crash!" p.toon]
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
--
