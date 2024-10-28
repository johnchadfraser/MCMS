// JavaScript Document

//setPrefix function adds cdn domain path to all img, script and link tags.

function setPrefix(domain,cdn) {


var imgTag = document.getElementsByTagName("img");

for (var i = imgTag.length; i--;) {
    var img = imgTag[i];
    var newimg = img.src.replace(domain, cdn);
    img.src=newimg;
    

}

var scriptTag = document.getElementsByTagName("script");

for (var i = scriptTag.length; i--;) {
    var script = scriptTag[i];
    var newscript = script.src.replace(domain, cdn);
    script.src=newscript;

}

var linkTag = document.getElementsByTagName("link");

for (var i = linkTag.length; i--;) {
    var link = linkTag[i];
    var newlink = link.href.replace(domain, cdn);
    link.href=newlink;


}
}
