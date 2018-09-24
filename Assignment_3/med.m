function mineucdis=med(a,b,mua,mub,cova,covb)

% a
% n=1;
f=(a(:,1)-mua(1,1));
fb=(a(:,1)-mub(1,1));
f2=f.^2;
fb2=fb.^2;
ff=sum(f2);

% n=2;
g=(a(:,2)-mua(2,1));
gb=(a(:,2)-mub(2,1));
gb2=gb.^2;
g2=g.^2;
da=f2+g2;
dba=fb2+gb2;
dda=sqrt(da);
ddba=sqrt(dba);
gg=sum(g2);
jza=ff+gg;
mk=dda<ddba;
a(mk,3)=1;
mk2=dda>ddba;
a(mk2,3)=2;
% b
% n=1;
e=(b(:,1)-mub(1,1));
ea=(b(:,1)-mua(1,1));
e2=e.^2;
ea2=ea.^2;
ee=sum(e2);

% n=2;
w=(b(:,2)-mub(2,1));
wa=(b(:,2)-mua(2,1));
w2=w.^2;
wa2=wa.^2;
db=e2+w2;
dab=ea2+wa2;
ddb=sqrt(db);
ddab=sqrt(dab);
ko=ddb<ddab;
b(ko,3)=2;
ko2=ddb>ddab;
b(ko2,3)=1;
ww=sum(w2);
jzb=ee+ww;
[sd sf]=size(a);
[sy su]=size(b);
tohid=a(:,3)==1;
alpha11=sum(tohid);
alpha12=sd-alpha11;
kasra=b(:,3)==1;
alpha21=sum(kasra);
alpha22=sy-alpha21;
per=0.5*(alpha21/sy)+0.5*(alpha12/sd);

saeed=a(tohid,:);
vahid=b(:,3)==2;
hamed=b(vahid,:);
behnam=a;
amin=b;
behnam(tohid,:)=[];
amin(vahid,:)=[];

% mi=0;
% if a(:,3)>1
%     
%     mi=mi+1;
% end
% 
% 
% if b(:,3)==1
%         mi=mi+1;
% end
    




% fg=a(:,3)==1;
% aa=[a(fg,1),a(fg,2)];
% fg2=a(:,3)==2;
% bb=[a(fg2,1),a(fg2,2)];
% bg=b(:,3)==2;
% bbb=[b(bg,1),b(bg,2)];
% bg2=b(:,3)==1;
% aaa=[b(bg2,1),b(bg2,2)];
% at=[aa;aaa];
% bt=[bb;bbb];
% mineucdis.meda=sqrt(jza);
% mineucdis.medb=sqrt(jzb);
% mineucdis.asort=at;
% mineucdis.bsort=bt;
mineucdis.per=per;
% mineucdis.mi=mi;

mineucdis.alpha12=alpha12;
mineucdis.alpha21=alpha21;
mineucdis.correctclassA=saeed;
mineucdis.correctclassB=hamed;
mineucdis.incorrectclassA=behnam;
mineucdis.incorrectclassB=amin;

   

end