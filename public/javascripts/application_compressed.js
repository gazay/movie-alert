(function(b){b.address=(function(){var a1=function(c){b(this).trigger(b.extend(b.Event(c),(function(){var d={value:this.value(),path:this.path(),pathNames:this.pathNames(),parameterNames:this.parameterNames(),parameters:{},queryString:this.queryString()};for(var e=0,f=d.parameterNames.length;e<f;e++){d.parameters[d.parameterNames[e]]=this.parameter(d.parameterNames[e])}return d}).call(this)))};var ag=function(){a1.call(b.address,"init")};var aR=function(){a1.call(b.address,"change")};var am=function(){var c=ah.href.indexOf("#");return c!=-1?aC(aQ(ah.href.substr(c+1))):""};var aX=function(){try{top.document;return top}catch(c){return window}};var ax=function(d,c){if(aB.strict){d=c?(d.substr(0,1)!="/"?"/"+d:d):(d==""?"/":d)}return d};var aP=function(c,d){return(aW&&ah.protocol=="file:")?(d?al.replace(/\?/,"%3F"):al.replace(/%253F/,"?")):c};var az=function(c){for(var e=0,f=c.childNodes.length,d;e<f;e++){if(c.childNodes[e].src){aU=String(c.childNodes[e].src)}if(d=az(c.childNodes[e])){return d}}};var ae=function(){if(!aN){var d=am();var c=!(al==d);if(aM&&aO<523){if(ay!=p.length){ay=p.length;if(typeof aG[ay-1]!=aw){al=aG[ay-1]}ai()}}else{if(aW&&c){if(aO<7){ah.reload()}else{av.value(d)}}else{if(c){al=d;ai()}}}}};var ai=function(){aR();aS(aK,10)};var aK=function(){var d=(ah.pathname+(/\/$/.test(ah.pathname)?"":"/")+aA.value()).replace(/\/\//,"/").replace(/^\/$/,"");var c=window[aB.tracker];if(typeof c==aY){c(d)}else{if(typeof pageTracker!=aw&&typeof pageTracker._trackPageview==aY){pageTracker._trackPageview(d)}else{if(typeof urchinTracker==aY){urchinTracker(d)}}}};var aZ=function(){var c=aJ.contentWindow.document;c.open();c.write("<html><head><title>"+aF.title+"</title><script>var "+aI+' = "'+am()+'";<\/script></head></html>');c.close()};var ao=function(){if(!aj){aj=true;b("a").attr("xref",function(){return b(this).attr("href")});if(aW&&aO<8){aF.body.innerHTML='<iframe id="'+aI+'" src="javascript:false;" width="0" height="0"></iframe>'+aF.body.innerHTML;aJ=aF.getElementById(aI);aS(function(){b(aJ).bind("load",function(){var c=aJ.contentWindow;var d=c.location.href;al=(typeof c[aI]!=aw?c[aI]:"");if(al!=am()){ai();ah.hash=aP(al,true)}});if(typeof aJ.contentWindow[aI]==aw){aZ()}},50)}else{if(aM){if(aO<418){b(aF.body).append('<form id="'+aI+'" style="position:absolute;top:-9999px;" method="get"></form>');at=aF.getElementById(aI)}if(typeof ah[aI]==aw){ah[aI]={}}if(typeof ah[aI][ah.pathname]!=aw){aG=ah[aI][ah.pathname].split(",")}}}aS(function(){ag();aR();aK()},1);if(aW&&aO>=8){aF.body.onhashchange=ae}else{aL(ae,50)}b("a").attr("href",function(){return b(this).attr("xref")}).removeAttr("xref");b("a[rel*=address:]").address()}};var aA={baseURL:function(){var c=ah.href;if(c.indexOf("#")!=-1){c=c.substr(0,c.indexOf("#"))}if(c.substr(c.length-1)=="/"){c=c.substr(0,c.length-1)}return c},strict:function(){return aB.strict},history:function(){return aB.history},tracker:function(){return aB.tracker},title:function(){return aF.title},value:function(){if(!a){return null}return aQ(ax(aP(al,false),false))},path:function(){var c=this.value();return(c.indexOf("?")!=-1)?c.split("?")[0]:c},pathNames:function(){var d=this.path();var c=d.split("/");if(d.substr(0,1)=="/"||d.length==0){c.splice(0,1)}if(d.substr(d.length-1,1)=="/"){c.splice(c.length-1,1)}return c},queryString:function(){var d=this.value();var c=d.indexOf("?");return(c!=-1&&c<d.length)?d.substr(c+1):""},parameter:function(h){var e=this.value();var g=e.indexOf("?");if(g!=-1){e=e.substr(g+1);var c=e.split("&");var d,f=c.length;while(f--){d=c[f].split("=");if(d[0]==h){return d[1]}}}},parameterNames:function(){var e=this.value();var g=e.indexOf("?");var d=[];if(g!=-1){e=e.substr(g+1);if(e!=""&&e.indexOf("=")!=-1){var c=e.split("&");var f=0;while(f<c.length){d.push(c[f].split("=")[0]);f++}}}return d}};var av={strict:function(c){aB.strict=c},history:function(c){aB.history=c},tracker:function(c){aB.tracker=c},title:function(c){aS(function(){au=aF.title=c;if(ar&&aJ&&aJ.contentWindow&&aJ.contentWindow.document){aJ.contentWindow.document.title=c;ar=false}if(!ap&&i){ah.replace(ah.href.indexOf("#")!=-1?ah.href:ah.href+"#")}ap=false},50)},value:function(d){d=aC(aQ(ax(d,true)));if(d=="/"){d=""}if(al==d){return}ap=true;al=d;aN=true;ai();aG[p.length]=al;if(aM){if(aB.history){ah[aI][ah.pathname]=aG.toString();ay=p.length+1;if(aO<418){if(ah.search==""){at.action="#"+al;at.submit()}}else{if(aO<523||al==""){var c=aF.createEvent("MouseEvents");c.initEvent("click",true,true);var e=aF.createElement("a");e.href="#"+al;e.dispatchEvent(c)}else{ah.hash="#"+al}}}else{ah.replace("#"+al)}}else{if(al!=am()){if(aB.history){ah.hash="#"+aP(al,true)}else{ah.replace("#"+al)}}}if((aW&&aO<8)&&aB.history){aS(aZ,50)}if(aM){aS(function(){aN=false},1)}else{aN=false}}};var aI="jQueryAddress",aY="function",aw="undefined",aE=b.browser,aO=parseFloat(b.browser.version),i=aE.mozilla,aW=aE.msie,aq=aE.opera,aM=aE.safari,a=false,an=aX(),aF=an.document,p=an.history,ah=an.location,aL=setInterval,aS=setTimeout,aQ=decodeURI,aC=encodeURI,aD=navigator.userAgent,aJ,at,aU,au=aF.title,ay=p.length,aN=false,aj=false,ap=true,ar=true,aG=[],aH={},al=am(),aV={},aB={history:true,strict:true};if(aW){aO=parseFloat(aD.substr(aD.indexOf("MSIE")+4))}a=(i&&aO>=1)||(aW&&aO>=6)||(aq&&aO>=9.5)||(aM&&aO>=312);if(a){for(var af=1;af<ay;af++){aG.push("")}aG.push(am());if(aW&&ah.hash!=am()){ah.hash="#"+aP(am(),true)}if(aq){history.navigationMode="compatible"}az(document);var a2=aU.indexOf("?");if(aU&&a2>-1){var aT,a0=aU.substr(a2+1).split("&");for(var af=0,ak;ak=a0[af];af++){aT=ak.split("=");if(/^(history|strict)$/.test(aT[0])){aB[aT[0]]=(isNaN(aT[1])?/^(true|yes)$/i.test(aT[1]):(parseInt(aT[1])!=0))}if(/^tracker$/.test(aT[0])){aB[aT[0]]=aT[1]}}}b(ao)}else{if((!a&&ah.href.indexOf("#")!=-1)||(aM&&aO<418&&ah.href.indexOf("#")!=-1&&ah.search!="")){aF.open();aF.write('<html><head><meta http-equiv="refresh" content="0;url='+ah.href.substr(0,ah.href.indexOf("#"))+'" /></head></html>');aF.close()}else{aK()}}b.each(("init,change").split(","),function(c,d){aV[d]=function(e,f){b(b.address).bind(d,f||e,f&&e);return this}});b.each(("baseURL,strict,history,tracker,title,value").split(","),function(c,d){aV[d]=function(e){if(typeof e!="undefined"){if(a){av[d](e)}return b.address}else{return aA[d]()}}});b.each(("path,pathNames,queryString,parameter,parameterNames").split(","),function(c,d){aV[d]=function(e){return aA[d](e)}});return aV})();b.fn.address=function(a){b(this).click(function(){var d=a?a.call(this):/address:/.test(b(this).attr("rel"))?b(this).attr("rel").split("address:")[1].split(" ")[0]:b(this).attr("href").replace(/^#/,"");b.address.value(d);return false})}}(jQuery));(function(a){a.fn.extend({autocomplete:function(b,c){var d=typeof b=="string";c=a.extend({},a.Autocompleter.defaults,{url:d?b:null,data:d?null:b,delay:d?a.Autocompleter.defaults.delay:10,max:c&&!c.scroll?10:150},c);c.highlight=c.highlight||function(e){return e};c.formatMatch=c.formatMatch||c.formatItem;return this.each(function(){new a.Autocompleter(this,c)})},result:function(b){return this.bind("result",b)},search:function(b){return this.trigger("search",[b])},flushCache:function(){return this.trigger("flushCache")},setOptions:function(b){return this.trigger("setOptions",[b])},unautocomplete:function(){return this.trigger("unautocomplete")}});a.Autocompleter=function(l,g){var c={UP:38,DOWN:40,DEL:46,TAB:9,RETURN:13,ESC:27,COMMA:188,PAGEUP:33,PAGEDOWN:34,BACKSPACE:8};var b=a(l).attr("autocomplete","off").addClass(g.inputClass);var j;var p="";var m=a.Autocompleter.Cache(g);var e=0;var u;var x={mouseDownOnSelect:false};var r=a.Autocompleter.Select(g,l,d,x);var w;a.browser.opera&&a(l.form).bind("submit.autocomplete",function(){if(w){w=false;return false}});b.bind((a.browser.opera?"keypress":"keydown")+".autocomplete",function(y){e=1;u=y.keyCode;switch(y.keyCode){case c.UP:y.preventDefault();if(r.visible()){r.prev()}else{t(0,true)}break;case c.DOWN:y.preventDefault();if(r.visible()){r.next()}else{t(0,true)}break;case c.PAGEUP:y.preventDefault();if(r.visible()){r.pageUp()}else{t(0,true)}break;case c.PAGEDOWN:y.preventDefault();if(r.visible()){r.pageDown()}else{t(0,true)}break;case g.multiple&&a.trim(g.multipleSeparator)==","&&c.COMMA:case c.TAB:case c.RETURN:if(d()){y.preventDefault();w=true;return false}break;case c.ESC:r.hide();break;default:clearTimeout(j);j=setTimeout(t,g.delay);break}}).focus(function(){e++}).blur(function(){e=0;if(!x.mouseDownOnSelect){s()}}).click(function(){if(e++>1&&!r.visible()){t(0,true)}}).bind("search",function(){var y=(arguments.length>1)?arguments[1]:null;function z(D,C){var A;if(C&&C.length){for(var B=0;B<C.length;B++){if(C[B].result.toLowerCase()==D.toLowerCase()){A=C[B];break}}}if(typeof y=="function"){y(A)}else{b.trigger("result",A&&[A.data,A.value])}}a.each(h(b.val()),function(A,B){f(B,z,z)})}).bind("flushCache",function(){m.flush()}).bind("setOptions",function(){a.extend(g,arguments[1]);if("data" in arguments[1]){m.populate()}}).bind("unautocomplete",function(){r.unbind();b.unbind();a(l.form).unbind(".autocomplete")});function d(){var B=r.selected();if(!B){return false}var y=B.result;p=y;if(g.multiple){var E=h(b.val());if(E.length>1){var A=g.multipleSeparator.length;var D=a(l).selection().start;var C,z=0;a.each(E,function(F,G){z+=G.length;if(D<=z){C=F;return false}z+=A});E[C]=y;y=E.join(g.multipleSeparator)}y+=g.multipleSeparator}b.val(y);v();b.trigger("result",[B.data,B.value]);return true}function t(A,z){if(u==c.DEL){r.hide();return}var y=b.val();if(!z&&y==p){return}p=y;y=i(y);if(y.length>=g.minChars){b.addClass(g.loadingClass);if(!g.matchCase){y=y.toLowerCase()}f(y,k,v)}else{n();r.hide()}}function h(y){if(!y){return[""]}if(!g.multiple){return[a.trim(y)]}return a.map(y.split(g.multipleSeparator),function(z){return a.trim(y).length?a.trim(z):null})}function i(y){if(!g.multiple){return y}var A=h(y);if(A.length==1){return A[0]}var z=a(l).selection().start;if(z==y.length){A=h(y)}else{A=h(y.replace(y.substring(z),""))}return A[A.length-1]}function q(y,z){if(g.autoFill&&(i(b.val()).toLowerCase()==y.toLowerCase())&&u!=c.BACKSPACE){b.val(b.val()+z.substring(i(p).length));a(l).selection(p.length,p.length+z.length)}}function s(){clearTimeout(j);j=setTimeout(v,200)}function v(){var y=r.visible();r.hide();clearTimeout(j);n();if(g.mustMatch){b.search(function(z){if(!z){if(g.multiple){var A=h(b.val()).slice(0,-1);b.val(A.join(g.multipleSeparator)+(A.length?g.multipleSeparator:""))}else{b.val("");b.trigger("result",null)}}})}}function k(z,y){if(y&&y.length&&e){n();r.display(y,z);q(z,y[0].value);r.show()}else{v()}}function f(z,B,y){if(!g.matchCase){z=z.toLowerCase()}var A=m.load(z);if(A&&A.length){B(z,A)}else{if((typeof g.url=="string")&&(g.url.length>0)){var C={timestamp:+new Date()};a.each(g.extraParams,function(D,E){C[D]=typeof E=="function"?E():E});a.ajax({mode:"abort",port:"autocomplete"+l.name,dataType:g.dataType,url:g.url,data:a.extend({q:i(z),limit:g.max},C),success:function(E){var D=g.parse&&g.parse(E)||o(E);m.add(z,D);B(z,D)}})}else{r.emptyList();y(z)}}}function o(B){var y=[];var A=B.split("\n");for(var z=0;z<A.length;z++){var C=a.trim(A[z]);if(C){C=C.split("|");y[y.length]={data:C,value:C[0],result:g.formatResult&&g.formatResult(C,C[0])||C[0]}}}return y}function n(){b.removeClass(g.loadingClass)}};a.Autocompleter.defaults={inputClass:"ac_input",resultsClass:"ac_results",loadingClass:"ac_loading",minChars:1,delay:400,matchCase:false,matchSubset:true,matchContains:false,cacheLength:10,max:100,mustMatch:false,extraParams:{},selectFirst:true,formatItem:function(b){return b[0]},formatMatch:null,autoFill:false,width:0,multiple:false,multipleSeparator:", ",highlight:function(c,b){return c.replace(new RegExp("(?![^&;]+;)(?!<[^<>]*)("+b.replace(/([\^\$\(\)\[\]\{\}\*\.\+\?\|\\])/gi,"\\$1")+")(?![^<>]*>)(?![^&;]+;)","gi"),"<strong>$1</strong>")},scroll:true,scrollHeight:180};a.Autocompleter.Cache=function(c){var f={};var d=0;function h(l,k){if(!c.matchCase){l=l.toLowerCase()}var j=l.indexOf(k);if(c.matchContains=="word"){j=l.toLowerCase().search("\\b"+k.toLowerCase())}if(j==-1){return false}return j==0||c.matchContains}function g(j,i){if(d>c.cacheLength){b()}if(!f[j]){d++}f[j]=i}function e(){if(!c.data){return false}var k={},j=0;if(!c.url){c.cacheLength=1}k[""]=[];for(var m=0,l=c.data.length;m<l;m++){var p=c.data[m];p=(typeof p=="string")?[p]:p;var o=c.formatMatch(p,m+1,c.data.length);if(o===false){continue}var n=o.charAt(0).toLowerCase();if(!k[n]){k[n]=[]}var q={value:o,data:p,result:c.formatResult&&c.formatResult(p)||o};k[n].push(q);if(j++<c.max){k[""].push(q)}}a.each(k,function(r,s){c.cacheLength++;g(r,s)})}setTimeout(e,25);function b(){f={};d=0}return{flush:b,add:g,populate:e,load:function(n){if(!c.cacheLength||!d){return null}if(!c.url&&c.matchContains){var m=[];for(var j in f){if(j.length>0){var o=f[j];a.each(o,function(p,k){if(h(k.value,n)){m.push(k)}})}}return m}else{if(f[n]){return f[n]}else{if(c.matchSubset){for(var l=n.length-1;l>=c.minChars;l--){var o=f[n.substr(0,l)];if(o){var m=[];a.each(o,function(p,k){if(h(k.value,n)){m[m.length]=k}});return m}}}}}return null}}};a.Autocompleter.Select=function(e,j,l,p){var i={ACTIVE:"ac_over"};var k,f=-1,r,m="",s=true,c,o;function n(){if(!s){return}c=a("<div/>").hide().addClass(e.resultsClass).css("position","absolute").appendTo(document.body);o=a("<ul/>").appendTo(c).mouseover(function(t){if(q(t).nodeName&&q(t).nodeName.toUpperCase()=="LI"){f=a("li",o).removeClass(i.ACTIVE).index(q(t));a(q(t)).addClass(i.ACTIVE)}}).click(function(t){a(q(t)).addClass(i.ACTIVE);l();j.focus();return false}).mousedown(function(){p.mouseDownOnSelect=true}).mouseup(function(){p.mouseDownOnSelect=false});if(e.width>0){c.css("width",e.width)}s=false}function q(u){var t=u.target;while(t&&t.tagName!="LI"){t=t.parentNode}if(!t){return[]}return t}function h(t){k.slice(f,f+1).removeClass(i.ACTIVE);g(t);var v=k.slice(f,f+1).addClass(i.ACTIVE);if(e.scroll){var u=0;k.slice(0,f).each(function(){u+=this.offsetHeight});if((u+v[0].offsetHeight-o.scrollTop())>o[0].clientHeight){o.scrollTop(u+v[0].offsetHeight-o.innerHeight())}else{if(u<o.scrollTop()){o.scrollTop(u)}}}}function g(t){f+=t;if(f<0){f=k.size()-1}else{if(f>=k.size()){f=0}}}function b(t){return e.max&&e.max<t?e.max:t}function d(){o.empty();var u=b(r.length);for(var v=0;v<u;v++){if(!r[v]){continue}var w=e.formatItem(r[v].data,v+1,u,r[v].value,m);if(w===false){continue}var t=a("<li/>").html(e.highlight(w,m)).addClass(v%2==0?"ac_even":"ac_odd").appendTo(o)[0];a.data(t,"ac_data",r[v])}k=o.find("li");if(e.selectFirst){k.slice(0,1).addClass(i.ACTIVE);f=0}if(a.fn.bgiframe){o.bgiframe()}}return{display:function(u,t){n();r=u;m=t;d()},next:function(){h(1)},prev:function(){h(-1)},pageUp:function(){if(f!=0&&f-8<0){h(-f)}else{h(-8)}},pageDown:function(){if(f!=k.size()-1&&f+8>k.size()){h(k.size()-1-f)}else{h(8)}},hide:function(){c&&c.hide();k&&k.removeClass(i.ACTIVE);f=-1},visible:function(){return c&&c.is(":visible")},current:function(){return this.visible()&&(k.filter("."+i.ACTIVE)[0]||e.selectFirst&&k[0])},show:function(){var v=a(j).offset();c.css({width:typeof e.width=="string"||e.width>0?e.width:a(j).width(),top:v.top+j.offsetHeight,left:v.left}).show();if(e.scroll){o.scrollTop(0);o.css({maxHeight:e.scrollHeight,overflow:"auto"});if(a.browser.msie&&typeof document.body.style.maxHeight==="undefined"){var t=0;k.each(function(){t+=this.offsetHeight});var u=t>e.scrollHeight;o.css("height",u?e.scrollHeight:t);if(!u){k.width(o.width()-parseInt(k.css("padding-left"))-parseInt(k.css("padding-right")))}}}},selected:function(){var t=k&&k.filter("."+i.ACTIVE).removeClass(i.ACTIVE);return t&&t.length&&a.data(t[0],"ac_data")},emptyList:function(){o&&o.empty()},unbind:function(){c&&c.remove()}}};a.fn.selection=function(i,b){if(i!==undefined){return this.each(function(){if(this.createTextRange){var j=this.createTextRange();if(b===undefined||i==b){j.move("character",i);j.select()}else{j.collapse(true);j.moveStart("character",i);j.moveEnd("character",b);j.select()}}else{if(this.setSelectionRange){this.setSelectionRange(i,b)}else{if(this.selectionStart){this.selectionStart=i;this.selectionEnd=b}}}})}var g=this[0];if(g.createTextRange){var c=document.selection.createRange(),h=g.value,f="<->",d=c.text.length;c.text=f;var e=g.value.indexOf(f);g.value=h;this.selection(e,e+d);return{start:e,end:e+d}}else{if(g.selectionStart!==undefined){return{start:g.selectionStart,end:g.selectionEnd}}}}})(jQuery);(function(c){c.tools=c.tools||{version:{}};c.tools.version.tooltip="1.0.2";var b={toggle:[function(){this.getTip().show()},function(){this.getTip().hide()}],fade:[function(){this.getTip().fadeIn(this.getConf().fadeInSpeed)},function(){this.getTip().fadeOut(this.getConf().fadeOutSpeed)}]};c.tools.addTipEffect=function(d,f,e){b[d]=[f,e]};c.tools.addTipEffect("slideup",function(){var d=this.getConf();var e=d.slideOffset||10;this.getTip().css({opacity:0}).animate({top:"-="+e,opacity:d.opacity},d.slideInSpeed||200).show()},function(){var d=this.getConf();var e=d.slideOffset||10;this.getTip().animate({top:"-="+e,opacity:0},d.slideOutSpeed||200,function(){c(this).hide().animate({top:"+="+(e*2)},0)})});function a(f,e){var d=this;var h=f.next();if(e.tip){if(e.tip.indexOf("#")!=-1){h=c(e.tip)}else{h=f.nextAll(e.tip).eq(0);if(!h.length){h=f.parent().nextAll(e.tip).eq(0)}}}function j(k,l){c(d).bind(k,function(n,m){if(l&&l.call(this)===false&&m){m.proceed=false}});return d}c.each(e,function(k,l){if(c.isFunction(l)){j(k,l)}});var g=f.is("input, textarea");f.bind(g?"focus":"mouseover",function(k){k.target=this;d.show(k);h.hover(function(){d.show()},function(){d.hide()})});f.bind(g?"blur":"mouseout",function(){d.hide()});h.css("opacity",e.opacity);var i=0;c.extend(d,{show:function(q){if(q){f=c(q.target)}clearTimeout(i);if(h.is(":animated")||h.is(":visible")){return d}var o={proceed:true};c(d).trigger("onBeforeShow",o);if(!o.proceed){return d}var n=f.position().top-h.outerHeight();var k=h.outerHeight()+f.outerHeight();var r=e.position[0];if(r=="center"){n+=k/2}if(r=="bottom"){n+=k}var l=f.outerWidth()+h.outerWidth();var m=f.position().left+f.outerWidth();r=e.position[1];if(r=="center"){m-=l/2}if(r=="left"){m-=l}n+=e.offset[0];m+=e.offset[1];h.css({position:"absolute",top:n,left:m});b[e.effect][0].call(d);c(d).trigger("onShow");return d},hide:function(){clearTimeout(i);i=setTimeout(function(){if(!h.is(":visible")){return d}var k={proceed:true};c(d).trigger("onBeforeHide",k);if(!k.proceed){return d}b[e.effect][1].call(d);c(d).trigger("onHide")},e.delay||1);return d},isShown:function(){return h.is(":visible, :animated")},getConf:function(){return e},getTip:function(){return h},getTrigger:function(){return f},onBeforeShow:function(k){return j("onBeforeShow",k)},onShow:function(k){return j("onShow",k)},onBeforeHide:function(k){return j("onBeforeHide",k)},onHide:function(k){return j("onHide",k)}})}c.prototype.tooltip=function(d){var e=this.eq(typeof d=="number"?d:0).data("tooltip");if(e){return e}var f={tip:null,effect:"slideup",delay:30,opacity:1,position:["top","center"],offset:[0,0],api:false};if(c.isFunction(d)){d={onBeforeShow:d}}c.extend(f,d);this.each(function(){e=new a(c(this),f);c(this).data("tooltip",e)});return f.api?e:this}})(jQuery);jQuery(function(a){setDeafultValue=function(d,c){if(!c||""==d.val()){d.addClass("default").val(d.data("defaultValue"))}};a("#filters input").focus(function(){a(this).prev().removeClass("clear").addClass("writing").attr("title","Press Enter to use filter")}).blur(function(){var c=a(this).prev();c.removeClass("writing").attr("title","");if(""!=a(this).val()){c.addClass("clear").attr("title","Clear filter")}}).keydown(function(d){if(13==d.keyCode){var c=a(this);if(c.hasClass("ac_input")){c.val(a(".ac_over").text())}c.blur();setDeafultValue(c,true);a.address.value(getSearchAddress());return false}});setDefaultInputs=function(c){c.each(function(){var d=a(this);d.data("defaultValue",d.val())}).focus(function(){var d=a(this);if(d.hasClass("default")){d.removeClass("default").val("")}}).blur(function(){var d=a(this);if(!d.parent("li").hasClass("used")){setDeafultValue(d,true)}})};setDefaultInputs(a("input.default"));a("#logo").click(function(){a("#filters input").each(function(){setDeafultValue(a(this),false)});a("#filters select").val("Genre").addClass("default");a.address.value("")});a("#filters .icon").click(function(){var c=a(this);if(c.hasClass("clear")){c.next().addClass("default").val(c.next().data("defaultValue"));c.removeClass("clear").attr("title","");a.address.value(getSearchAddress())}});a("#filters select").change(function(){var c=a(this);if(0==c.attr("selectedIndex")){c.addClass("default").parents("li").removeClass("used")}else{c.removeClass("default").parents("li").addClass("used")}}).change(function(){a.address.value(getSearchAddress())});a("#filters input[name=actor]").autocomplete("/suggest/actor");a("#filters input[name=director]").autocomplete("/suggest/director");getSearchData=function(){var c={};a("#filters .filter:not(.default)").each(function(){var d=a(this);d.parents("li").addClass("used");if(""!=d.val()){c[d.attr("name")]=d.val()}});a("#dates .used").each(function(){var d=a(this).attr("href").substring(2);if(""!=d){d=d.split("=");c[d[0]]=d[1]}});return c};getSearchAddress=function(){var d=getSearchData();var c="/?";for(key in d){c+=encodeURI(key)+"="+encodeURI(d[key])+"&"}return c.substring(0,c.length-1)};updateFilters=function(c){a(".used").removeClass("used");var d=a("#dates .all").addClass("used");for(key in c){if("year"==key||"release_date"==key){d.removeClass("used");a('a[href="/?'+key+"="+c[key]+'"]').addClass("used")}else{a("#filters [name="+key+"]").val(c[key]).removeClass("default").parents("li").addClass("used")}}};reloadMovies=function(d,c){a("#movies ul, .empty").addClass("old");a("#logo").addClass("loading");a.get("/index.part",d,function(e){a(".empty, .next").remove();a("#movies").prepend(e);a("#logo").removeClass("loading");if(c){var f=a("#movies ul:not(.old)").height()/1.6;a("#movies ul:not(.old)").slideDown(f,function(){a(".next").show()});a("#movies ul.old").slideUp(f,function(){a("#movies .old").remove()})}else{a("#movies .old").remove();a("#movies ul").show()}setDefaultInputs(a("#movies input.default"));if(0!=a("#header .filter:not(.default)").length){a("#subscriptions").show();a("#description").hide()}else{a("#subscriptions").hide();a("#description").show()}},"html")};a("#dates a").click(function(){a("#dates .used").removeClass("used");a(this).addClass("used");a.address.value(getSearchAddress());return false});var b=true;a.address.change(function(c){if(b){if(0!=c.parameterNames.length){updateFilters(c.parameters);reloadMovies(c.parameters,false)}b=false}else{updateFilters(c.parameters);reloadMovies(c.parameters,true)}});a(".next").show();a("#movies .next input").live("click",function(){var c=getSearchData();a(".next").addClass("loading");c.offset=a("#movies .next .offset").text();a.get("/index.part",c,function(d){a("#movies .next").remove();a("#movies").append(d);a("#movies ul:last").show();setDefaultInputs(a("#movies ul:last input.default"));a(".next").show()})});a("#movies li:not(.open)").live("click",function(){var d=a(this);var c=d.children(".panel");if(a(document).width()<(d.offset().left+c.width()+180)){c.addClass("left")}else{c.removeClass("left")}d.addClass("open");c.fadeIn(200)});a("#movies .close, #movies .open .card").live("click",function(){a(this).parents("li").children(".panel").fadeOut(200,function(){a(this).parents("li").removeClass("open")});return false});a("#info").tooltip({position:["center","left"],opacity:0.97})});