/*
 * iaj plugins for dactyl
 */
"use strict";
dactyl.beep = function () {};

//tabs["_tweak_old_remove"] = tabs.remove;
//tabs.remove = function (tab, count, something) {
  //if (tabs.count === 1) return;
  //tabs._tweak_old_remove(tab, count, something);
//}

//function openUpTypo() {
  //javascript:void(window.open(‘http://’+window.location.host+’/typo3/’,'_blank’))
//}
function jQuerify() {
  var s=content.document.createElement('script');
  s.setAttribute('src','http://jquery.com/src/jquery-latest.js');
  content.document.getElementsByTagName('body')[0].appendChild(s);
}

function selectorGadget() {
  var s=content.document.createElement('div');
  // style settings for that odd button and stuff
  s.innerHTML='Loading...'; s.style.color='black'; s.style.padding='20px'; s.style.position='fixed'; s.style.zIndex='9999'; s.style.fontSize='3.0em'; s.style.border='2px solid black'; s.style.right='40px'; s.style.top='40px'; s.setAttribute('class','selector_gadget_loading'); s.style.background='white';
  content.document.body.appendChild(s);
  s=content.document.createElement('script');
  s.setAttribute('type','text/javascript');
  s.setAttribute('src','http://www.selectorgadget.com/unstable/lib/selectorgadget_edge.js?raw=true');
  content.document.body.appendChild(s);
}
