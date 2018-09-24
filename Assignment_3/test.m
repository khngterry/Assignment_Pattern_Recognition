clc
clear
close all



medt=@med;

load('assign3 2018.mat')
mua=mean(a);
mua=mua';
mub=mean(b);
mub=mub';
cova=cov(a);
covb=cov(b);
 mineucdis=medt(a,b,mua,mub,cova,covb);
 numberoferrorclass1=mineucdis.alpha12;
 numberoferrorclass2=mineucdis.alpha21;
 permed=mineucdis.per;
 
%% D1
x=a;
y=b;
a1=[];
b1=[];
for i=0:49
    c=1;
    d=200-i;
    adt=round(c+(d-c)*rand(1,1));
    a1=[a1;a(adt,:)];
    b1=[b1;b(adt,:)];
    x(adt,:)=[];
    y(adt,:)=[];

end

perlint=[];
for i=0:9
    c=1;
    d=50-i;
    adt=round(c+(d-c)*rand(1,1));
    xx=a1;
    yy=b1;
    alin=[];
    blin=[];
    alin=[alin;a1(adt,:)];
    blin=[blin;b1(adt,:)];
    xx(adt,:)=[];
    yy(adt,:)=[];
    xx=[xx;x];
    yy=[yy;y];
    
    mualin=alin;
    mualin=mualin';
    mublin=blin;
    mublin=mublin';
    covalin=cov(alin);
    covblin=cov(blin);
    
    
    
    mineucdis=medt(xx,yy,mualin,mublin,covalin,covblin);
    perlin=mineucdis.per;
    perlint=[perlint;perlin];

end

 
perlintt=min(perlint);

 
mua1=mean(a1);
mua1=mua1';
mub1=mean(b1);
mub1=mub1';
cova1=cov(a1);
covb1=cov(b1);




mineucdis=medt(x,y,mua1,mub1,cova1,covb1);
 correctclassA=mineucdis.correctclassA;
  correctclassB=mineucdis.correctclassB;
   incorrectclassA=mineucdis.incorrectclassA;
   incorrectclassB=mineucdis.incorrectclassB;
   d1permedboosted=mineucdis.per;
   a1(:,3)=1;
   b1(:,3)=2;
correctclassA=[correctclassA;a1];
correctclassB=[correctclassB;b1];
[nincA mj]=size(incorrectclassA);
[nincB kj]=size(incorrectclassB);
ncA=200-nincA;
ncB=200-nincB;
NonNormlizedscored1A=(ncA/200)*0.5;
NonNormlizedscored1B=(ncB/200)*0.5;
NonNormlizedscored1=NonNormlizedscored1A+NonNormlizedscored1B;



c1a=[correctclassA;incorrectclassA];
c1b=[correctclassB;incorrectclassB];