/*Start of phone number formating */
var p;
var p1;

function format_phone(n){
n=document.getElementById(n);
p=p1.value;
console.log(p);
if(p.length==3){
    pp=p;
    d4=p.indexOf('(')
    d5=p.indexOf(')')
    if(d4==-1){
        pp="("+pp;
    }
    if(d5==-1){
        pp=pp+") ";
    }
    console.log(n);
    n.value="";
    n.value=pp;
}
if(p.length>3){
    d1=p.indexOf('(')
    d2=p.indexOf(')')
    if (d2==-1){
        l30=p.length;
        p30=p.substring(0,4);
        p30=p30+") "
        p31=p.substring(5,l30);
        pp=p30+p31;
        n.value="";
        n.value=pp;
    }
    }
if(p.length>7){
    p11=p.substring(d1+1,d2);
    if(p11.length>4){
    p12=p11;
    l12=p12.length;
    l15=p.length
    p13=p11.substring(0,4);
    p14=p11.substring(4,l12);
    p15=p.substring(d2+1,l15);
    document.f.n.value="";
    pp="("+p13+") "+p14+p15;
    document.f.n.value=pp;
    }
    l16=p.length;
    p16=p.substring(d2+2,l16);
    l17=p16.length;
    if(l17>3&&p16.indexOf('-')==-1){
        p17=p.substring(d2+1,d2+5);
        p18=p.substring(d2+5,l16);
        p19=p.substring(0,d2+1);
    pp=p19+p17+"-"+p18;
    n.value="";
    n.value=pp;
    }
}

setTimeout(format_phone,100);
}
function getIt(m){
    n=m.name;
    p1=m;
    format_phone(n);
}
/* End of phone number formating */