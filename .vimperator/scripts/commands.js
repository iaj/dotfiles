"command! valid :open javascript:void(location='http://validator.w3.org/check?uri='+escape(location))
"command! firebug :open javascript:(function(F,i,r,e,b,u,g,L,I,T,E){if(F.getElementById(b))return;E=F[i+'NS']&&F.documentElement.namespaceURI;E=E?F[i+'NS'](E,'script'):F[i]('script');E[r]('id',b);E[r]('src',I+g+T);E[r](b,u);(F[e]('head')[0]||F[e]('body')[0]).appendChild(E);E=new%20Image;E[r]('src',I+L);})(document,'createElement','setAttribute','getElementsByTagName','FirebugLite','4','firebug-lite.js','releases/lite/latest/skin/xp/sprite.png','https://getfirebug.com/','#startOpened');
"command! ghfinder :open javascript:(function(){var%20a=(new%20RegExp("github.com/(.+)","i")).exec(window.location.href);var%20f=a?a[1].split("/"):[];var%20b=f[0];var%20d=f[1];var%20e=f[3];var%20c="http://sr3d.github.com/GithubFinder/?utm_source=bml"+(a?"&user_id="+b+"&repo="+d+(e?"&branch="+e:""):"");if(!c){alert("Invalid%20Github%20URL");return}window.open(c)})()
"command! wirify :open javascript:(function(){wf_bookmarklet='1.1';if(typeof%20wfInit=='undefined'){document.body.appendChild(document.createElement('script')).src=(document.location.protocol=='https:'?'https:':'http:')+'//www.volkside.com/tools/wirify/wirify.min.js?'+parseInt(new%20Date().getTime()/43200000);}else{wfInit();}})();
"command! evernote js evernote_addSelectionToEn3(null);

" vim: set ts=8 sw=4 tw=0 ft=vimperator:
