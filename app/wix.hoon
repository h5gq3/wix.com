/+  default-agent, server
/=  freeform-layer  /app/wix/freeform-layer
/=  channel  /app/wix/channel
::
::
|%
+$  card     card:agent:gall
+$  eyre-id  @ta
--
::
=|  state=_(freeform-layer)
=*  state  -
=<
^-  agent:gall
|_  =bowl:gall
+*  this      .
    default   ~(. (default-agent this %|) bowl)
    app-core        ~(. +> bowl)
::
++  on-init
  ^-  (quip card _this)
  :_  this
  [%pass /eyre/connect %arvo %e %connect [~ /[dap.bowl]] dap.bowl]~
:: 
++  on-save  !>(state)
++  on-load
  |=  =vase
  ^-  (quip card _this)
  =/  loaded  !<(_(freeform-layer) vase)
  [~ this(state loaded)]
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  =^  cards  state
  ?+  mark  (on-poke:default mark vase)
    %noun  (on-poke:default mark vase)
    %handle-http-request
  =+  !<([=eyre-id =inbound-request:eyre] vase)
  =;  [[status=@ud out=(unit @t)] =_state]
  :_  state
  %+  give-simple-payload:app:server
    eyre-id
  :-  [status ~]
  ?~  out  ~
  `[(met 3 u.out) u.out]
  ?+  method.request.inbound-request  [[405 ~] state]
      %'GET'
        ?+  (stab url.request.inbound-request)  [[405 ~] state]
              [@ ~]
                :_  state
                [200 `(crip (en-xml:html app:app-core))]
              ::
              [@ %editors ~]
                :_  state
                [200 `+>.state]
        ==
      %'POST'
        ?+  (stab url.request.inbound-request)  [[405 ~] state]
              [@ %html ~]
                ?~  body.request.inbound-request  [[200 ~] state]
                =/  shitload-of-json-and-xml  q.u.body.request.inbound-request
                =/  asdasd
                  ((at ~[so so]):dejs:format (need (de-json:html shitload-of-json-and-xml)))
                =/  manx-head  (de-xml:html -.asdasd)
                :_  state(. (freeform-layer [manx-head +.asdasd]))
                [200 ~]
        ==
  ==
  ==
  [cards this]
::
++  on-watch
  |=  =path
  ?:  ?=([%http-response @ ~] path)
    [~ this]
  (on-watch:default path)
++  on-leave  on-leave:default
++  on-peek   on-peek:default
++  on-agent  on-agent:default
++  on-arvo
    |=  [=wire =sign-arvo]
    ^-  (quip card _this)
    ?+  sign-arvo  (on-arvo:default wire sign-arvo)
        [%eyre %bound *]
      ~?  !accepted.sign-arvo
        [dap.bowl 'bind rejected!' binding.sign-arvo]
      [~ this]
    ==
++  on-fail   on-fail:default
--
|_  =bowl:gall
++  app
  ^-  manx
  ::
  ;html
    ;body
      ;*  (-.state [+<.state bowl])
      ;script: {channel}
      ;script: window.addEventListener('load', (event) => \{ window.channel = new Channel() })
    ==
  ==
--
