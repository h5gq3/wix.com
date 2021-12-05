/+  wix
|=  freeform-component-state=(unit manx)
^-  [$-([(unit manx) bowl:gall] marl) _freeform-component-state]
:_  freeform-component-state
|=  [component-state=(unit manx) =bowl:gall]
=*  lib  ~(. wix bowl)
::
=/  script
|^
;:  weld
  imports
  global-variables
  event-handlers
  event-listeners
  helper-functions
==
::
++  imports
  "import \{EditorState, EditorView, basicSetup} from 'https://cdn.skypack.dev/@codemirror/basic-setup';"
++  global-variables
  |^
  ;:  weld
    editors
    root-div
    last-active-element
    freeform-element-offsets
    key-stopper
    current-mode
  ==
  ::
  ++  editors
    %-  trip
    '''
    let editors = {};
    '''
  ++  root-div
    %-  trip
    '''
    let rootDiv = document.getElementById('root');
    '''
  ++  last-active-element
    %-  trip
    '''
    var lastActiveElement;
    '''
  ++  freeform-element-offsets
    %-  trip
    '''
    var elXoffset;
    var elYoffset;
    '''
  ++  key-stopper
    %-  trip
    '''
    var keyDown = false;
    var longPress = false;
    '''
  ++  current-mode
    %-  trip                                            ::   0 is ctrl+shift+m mode, 1 is fixure
    '''
    var mode = 1;
    '''
  --
++  event-handlers
  |^
  ;:  weld
    on-click-root-div
    on-key-down-body
    on-key-up-body
    on-click-freeform-element
    on-drag-start-freeform-element
    on-drag-end-freeform-element
    on-key-down-freeform-element
    on-key-up-freeform-element
    on-double-click-freeform-element
    on-hover-freeform-element
    on-hover-out-freeform-element
    on-page-visibility-change
  ==
  ::
  ++  on-click-root-div
    %-  trip
    '''
    function onClickRootDiv(e) {
      if (mode == 1) {return}
      if (e.target !== e.currentTarget || lastActiveElement !== this.id)
        lastActiveElement = this.id
      else {
        let xpos = e.pageX
        let ypos = e.pageY
        let container = document.createElement('div');
        container.id = `q${Date.now()}`
        container.classList.add('container')
        container.style.position = 'absolute'
        container.style.left = xpos+'px'
        container.style.top = ypos+'px'
        container.style.whiteSpace = 'pre';
        container.draggable = "true"
        container.onclick = onClickFreeformElement
        container.ondblclick = onDoubleClickFreeformElement;
        container.ondragstart = onDragStartFreeformElement
        container.ondragend = onDragEndFreeformElement
        container.onkeydown = onKeyDownFreeformElement
        container.onkeyup = onKeyUpFreeformElement
        container.onmouseover = onHoverFreeformElement;
        container.onmouseout = onHoverOutFreeformElement;
        let facade = document.createElement('div');
        facade.classList.add('facade')
        container.appendChild(facade);
        let carcass = document.createElement('div');
        carcass.classList.add('carcass')
        let editor = new EditorView({
        state: EditorState.create({
        extensions: [basicSetup]
        }),
        parent: carcass
        });
        //carcass.contentEditable = true;
        container.appendChild(carcass);
        rootDiv.appendChild(container);
        editor.focus();
        lastActiveElement = this.id
        //
        return editors[container.id] = editor
      }
    }
    '''
  ++  on-key-down-body
    %-  trip
    '''
    function onKeyDownBody(e) {
      //e.preventDefault();
      //e.stopPropagation();
      //e.stopImmediatePropagation();
      if (keyDown) {
        longPress = true;
      }
      else {
        keyDown = true;
      }
      switch (true) {
        case (e.key == 'M' && e.ctrlKey && e.shiftKey):
          e.preventDefault();
          oneToZero();
          console.log('pressed ctrl shift M key');
          mode = 0;
          break;
        case (e.key == 'Escape' && longPress):
          if (mode == 1) {return}
          else {
          zeroToOne();
          mode = 1;
          }
          break;
        default: return;
      }
    }
    '''
  ++  on-key-up-body
    %-  trip
    '''
    function onKeyUpBody(e) {
      keyDown = false;
      longPress = false;
    }
    '''
  ++  on-click-freeform-element
    %-  trip
    '''
    function onClickFreeformElement(e) {
      lastActiveElement = e.target.id;
      e.stopPropagation();
    }
    '''
  ++  on-drag-start-freeform-element
    %-  trip
    '''
    function onDragStartFreeformElement(e) {
      console.log(e.clientX);
      elXoffset = e.offsetX;
      elYoffset = e.offsetY;
    }
    '''
  ++  on-drag-end-freeform-element
    %-  trip
    '''
    function onDragEndFreeformElement(e) {
      e.target.style.left = e.pageX - elXoffset + 'px';
      e.target.style.top = e.pageY - elYoffset + 'px';
    }
    '''
  ++  on-key-down-freeform-element
    %-  trip
    '''
    async function onKeyDownFreeformElement(e) {
      if (e.key == 'Escape') {
        e.target.blur();
      }
      if (e.key == 'Delete') {
        e.target.closest('.container').remove();
      }
      if (e.key == 'Enter' && longPress) {
      e.target.blur();
      let editor = editors[e.target.closest('.container').id]
      let editorText = editor.state.doc.toString();
      let start = editorText.length - 2
      let end = editorText.length
      editor.dispatch({ changes: {from:start, to:end} });
      if (!e.target.textContent.startsWith('!')) {
        console.log("need to poke urbit with this value")
      }
      else {
      let replacee = await carcassToFacade(editorText)
      console.log(replacee)
      e.target.closest('.container').children[0].replaceWith(replacee);
      e.target.closest('.carcass').hidden = true;
      }
      }
      else {
      if (e.target.textContent.startsWith('!')) {
        e.target.classList.add('mod')
      }
      else {
        e.target.classList.remove('mod')
      }
      console.log(`pressed key ${e.key}`)
      }
      }
    '''
  ++  on-key-up-freeform-element
    %-  trip
    '''
    function onKeyUpFreeformElement(e) {
      return
    }
    '''
  ++  on-double-click-freeform-element
    %-  trip
    '''
    function onDoubleClickFreeformElement(e) {
      let thisFacade = e.target.closest('.facade');
      let thisCarcass = thisFacade.parentElement.children[1]
      thisFacade.hidden = true;
      thisCarcass.hidden = false
    }
    '''
  ++  on-hover-freeform-element
    %-  trip
    '''
    function onHoverFreeformElement(e) {
      if (e.target.classList.contains('carcass')) {
        e.target.classList.add('border')
      }
      e.stopPropagation()
    }
    '''
  ++  on-hover-out-freeform-element
    %-  trip
    '''
    function onHoverOutFreeformElement(e) {
      e.target.classList.remove('border');
      e.stopPropagation();
    }
    '''
  ++  on-page-visibility-change
    %-  trip
    '''
    function onPageVisibilityChange(e) {
      if (document.visibilityState === 'hidden') {
      let enXML = new XMLSerializer();
      let enRootDiv = enXML.serializeToString(document.body.children.root);
      navigator.sendBeacon('/wix/html', enRootDiv);
      }
    }
    '''
  --
++  event-listeners
  |^
  ;:  weld
    root-div-click-listener
    body-key-press-listener
    page-visibility-change-listener
  ==
  ++  root-div-click-listener
    "rootDiv.onclick = onClickRootDiv;"
  ++  body-key-press-listener
    %+  weld
    "document.body.onkeydown = onKeyDownBody;"
    "document.body.onkeyup = onKeyUpBody;"
  ++  page-visibility-change-listener
    "document.onvisibilitychange = onPageVisibilityChange;"
  --
++  helper-functions
  |^
  ;:  weld
    zero-to-one
    one-to-zero
    carcass-to-facade
    once
  ==
  ++  one-to-zero
    %-  trip
    '''
    function oneToZero() {
      rootDiv.classList.add('matrix');
      rootDiv.onclick = onClickRootDiv;
      let nodes = document.querySelectorAll('.container')
      nodes.forEach(node => (
      node.children[0].hidden = true,
      node.children[1].hidden = false,
      node.setAttribute('draggable', true),
      node.onclick = onClickFreeformElement,
      node.ondblclick = onDoubleClickFreeformElement,
      node.ondragstart = onDragStartFreeformElement,
      node.ondragend = onDragEndFreeformElement,
      node.onkeydown = onKeyDownFreeformElement,
      node.onkeyup = onKeyUpFreeformElement
      ))
    }
    '''
  ++  zero-to-one
    %-  trip
    '''
    async function zeroToOne() {
      rootDiv.classList.remove('matrix');
      rootDiv.onclick = null;
      let nodes = document.querySelectorAll('.container')
      nodes.forEach(async node => {
        if (node.children[1].innerHTML == "") {
          node.remove()
        }
        else
        if (node.children[0].hidden == false && node.children[0].innerHTML !== "") 
          (
          node.setAttribute('draggable', false),
          node.ondragstart = null,
          node.ondragend = null,
          node.ondblclick = null,
          node.onkeydown = null,
          node.onkeyup = null
          )
        else
        (
        node.children[0].replaceWith(await carcassToFacade(editors[node.id].state.doc.toString())),
        node.children[1].hidden = true,
        node.setAttribute('draggable', false),
        node.ondragstart = null,
        node.ondragend = null,
        node.ondblclick = null,
        node.onkeydown = null,
        node.onkeyup = null
        )
      }
      )
    }
    '''
  ++  carcass-to-facade
    %-  trip
    '''
    async function carcassToFacade(text) {
      let response = await new Promise(resolve => {
      var req = new XMLHttpRequest();
      req.open("POST", `${window.origin}/spider/landscape/wix-action/entry/tang.json`);
      req.responseType = 'json'
      req.send(JSON.stringify({ 'textbox-entry': text }));
      let replaceContainer = document.createElement('template')
      req.onreadystatechange = () => {
        if (req.readyState === 4) {
        replaceContainer.innerHTML = `<div class="facade">${req.response[0][0]}</div>`
        let replacee = replaceContainer.content.firstElementChild;
        resolve(replacee)
        }
        }})
      return response
    }
    '''
  ++  once
    %-  trip
    '''
    const once = fn => (...args) => {
    if (!fn) return;
    fn(...args);
    fn = null;
    };
    '''
  --
--
::
=/  style
  """
  #root \{
  position: relative;
  width: 100%;
  height: 1000px;
  }

  .matrix \{
    border: outset;
    border-color: red;
    border-width: thin;
    cursor: crosshair;
  }
  
  .container \{
    width: 200px;
  }
  
  .facade \{
    position: inherit;
  }
  
  .carcass \{
    position: inherit;
    max-width: 200px;
    padding-top: 3px;
    padding-bottom: 3px;
    padding-left: 3px;
    padding-right: 6px;
    //background-color: #e0e0e026;
  }

  .border \{
    cursor: move;
  }
  
  div.mod::first-line \{
    color: orange;
  }

  @font-face \{
      font-family: "Ida";
      src: url({(cors-proxy:lib "https://idaidaida.net/_nuxt/fonts/ida-Regular.99cae5c.woff")});
    }
  
  body \{
  margin: 0;
  }

  * \{
    font-family: dejavu sans mono, monospace;
    font-size: small;
  }
  """
::
;=
;+  ?~(component-state ;div(id "root"); u.component-state)
;style: {style}
;script(type "module"): {script}
==
