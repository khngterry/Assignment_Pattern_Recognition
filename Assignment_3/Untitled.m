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

% % D2

[f g]=size(incorrectclassA);
[r s]=size(incorrectclassB);
[o g]=size(correctclassA);
[m s]=size(correctclassB);
df=round(f/2);
dr=round(r/2);

x=incorrectclassA;
y=incorrectclassB;
ac=correctclassA;
bc=correctclassB;
a2=[];
b2=[];
ac2=[];
bc2=[];
for i=0:df-1
    c=1;
    d=f-i;
    adt=round(c+(d-c)*rand(1,1));
    d=o-i;
    adtc=round(c+(d-c)*rand(1,1));
    a2=[a2;x(adt,:)];
    x(adt,:)=[];
    ac2=[ac2;ac(adt,:)];
    ac(adtc,:)=[];

end

for i=0:dr-1
    c=1;
    d=r-i;
    adt=round(c+(d-c)*rand(1,1));
    d=m-i;
    adtc=round(c+(d-c)*rand(1,1));
    b2=[b2;y(adt,:)];
    y(adt,:)=[];
    bc2=[bc2;bc(adt,:)];
    bc(adtc,:)=[];

end

ac3=[a2;ac2];
bc3=[b2;bc2];
xc=[x;ac];
yc=[y;bc];
ac3(:,3)=[];
bc3(:,3)=[];
xc(:,3)=[];
yc(:,3)=[];

mua2=mean(ac3);
mua2=mua2';
mub2=mean(bc3);
mub2=mub2';
cova2=cov(ac3);
covb2=cov(bc3);




mineucdis=medt(xc,yc,mua2,mub2,cova2,covb2);
d2correctclassA=mineucdis.correctclassA;
d2correctclassB=mineucdis.correctclassB;
d2incorrectclassA=mineucdis.incorrectclassA;
d2incorrectclassB=mineucdis.incorrectclassB;
d2permedboosted=mineucdis.per;
ac3(:,3)=1;
bc3(:,3)=2;
d2correctclassA=[d2correctclassA;ac3]
d2correctclassB=[d2correctclassB;bc3]

[nincd2A mj]=size(d2incorrectclassA);
[nincd2B kj]=size(d2incorrectclassB);
ncd2A=200-nincd2A;
ncd2B=200-nincd2B;
NonNormlizedscored2A=(ncd2A/200)*0.5;
NonNormlizedscored2B=(ncd2B/200)*0.5;
NonNormlizedscored2=NonNormlizedscored2A+NonNormlizedscored2B;

c2a=[d2correctclassA;d2incorrectclassA];
c2b=[d2correctclassB;d2incorrectclassB];
% % d3
x3=c2a;
y3=c2b;
a3=[];
b3=[];
ll=0
for i=1:200
   kk=c2a(:,1:2)==c1a(i,1:2);
   nn=c2b(:,1:2)==c1b(i,1:2);
   zzzz=1;
   [as ag]=size(c2a);
   [bs bg]=size(c2b);
   for j=1:as
       
      if kk(j,1)==1 && kk(j,2)==1 
          
         if c2a(j,3)>c1a(i,3) ||  c2a(j,3)<c1a(i,3)
         a3=[a3;c2a(j,:)];   
         c2a(j,:)=[];
         
             
         
             
             
         end
      end
      
      
       
   end
   
   for k=1:bs
      if nn(k,1)==1 && nn(k,2)==1
          
          if c2b(k,3)>c1b(i,3) ||  c2b(k,3)<c1b(i,3)
              b3=[b3;c2b(k,:)];
              c2b(k,:)=[];
              
              
              
              
          end
      end 
       
   end
       
    
    
end
x3=c2a;
y3=c2b;


mua3=mean(a3);
mua3=mua3';
mub3=mean(b3);
mub3=mub3';
cova3=cov(a3);
covb3=cov(b3);
mineucdis=medt(x3,y3,mua3,mub3,cova3,covb3);
d3correctclassA=mineucdis.correctclassA;
d3correctclassB=mineucdis.correctclassB;
d3incorrectclassA=mineucdis.incorrectclassA;
d3incorrectclassB=mineucdis.incorrectclassB;
d3permedboosted=mineucdis.per;

[nincd3A mj]=size(d3incorrectclassA);
[nincd3B kj]=size(d3incorrectclassB);
ncd3A=200-nincd3A;
ncd3B=200-nincd3B;
NonNormlizedscored3A=(ncd3A/200)*0.5;
NonNormlizedscored3B=(ncd3B/200)*0.5;
NonNormlizedscored3=NonNormlizedscored3A+NonNormlizedscored3B;

Normlizedscoredd1=(exp(NonNormlizedscored1))/((exp(NonNormlizedscored1))+(exp(NonNormlizedscored2))+(exp(NonNormlizedscored3)));
Normlizedscoredd2=(exp(NonNormlizedscored2))/((exp(NonNormlizedscored1))+(exp(NonNormlizedscored2))+(exp(NonNormlizedscored3)));
Normlizedscoredd3=(exp(NonNormlizedscored3))/((exp(NonNormlizedscored1))+(exp(NonNormlizedscored2))+(exp(NonNormlizedscored3)));

%% selected linear
perlint=[];
for i=0:9
    c=1;
    d=200;
    adt=round(c+(d-c)*rand(1,1));
    xx=a;
    yy=b;
    alin=[];
    blin=[];
    alin=[alin;a(adt,:)];
    blin=[blin;b(adt,:)];
    xx(adt,:)=[];
    yy(adt,:)=[];
    
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



   
 f;
 
 