clc
clear
close all



medt=@med;

load('assign3 2018.mat')

z.correctclassA=[];
z.correctclassB=[];
z.incorrectclassA=[];
z.incorrectclassB=[];
z.perlin=[];
z.a1=[];
z.b1=[];
d1=repmat(z,1,10);
d2=repmat(z,1,10);
d3=repmat(z,1,10);
mua=mean(a);
mua=mua';
mub=mean(b);
mub=mub';
cova=cov(a);
covb=cov(b);
 mineucdis=medt(a,b,mua,mub,cova,covb);
 numberoferrorclass1=mineucdis.alpha12;
 numberoferrorclass2=mineucdis.alpha21;
%%  D1
q=30;
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
for i=0:q-1
    c=1;
    d=50;
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
    d1(1,i+1).correctclassA=mineucdis.correctclassA;
    d1(1,i+1).correctclassB=mineucdis.correctclassB;
    d1(1,i+1).incorrectclassA=mineucdis.incorrectclassA;
    d1(1,i+1).incorrectclassB=mineucdis.incorrectclassB;
    d1(1,i+1).perlint=mineucdis.per;
    d1(1,i+1).a1=alin;
    d1(1,i+1).b1=blin;
%     aq=[mineucdis.correctclassA;mineucdis.incorrectclassB];
%     bq=[mineucdis.correctclassB;mineucdis.incorrectclassA];
%     plot(aq(:,1),aq(:,2),'ro')
%     hold on
%      plot(bq(:,1),bq(:,2),'go')
%     title('Dataset D1');
%     legend('Class A','Class B')
%     hold on
%     plot(mualin(1),mualin(2),'rs','MarkerSize',10,'MarkerFaceColor',...
%         [0,0,0],...
%         'DisplayName','Mean of Class A');
%     hold on
%     plot(mublin(1),mublin(2),'gs','MarkerSize',10,'MarkerFaceColor',...
%         [0,0,0],...
%         'DisplayName','Mean of Class B');
%     hold on
%     u = linspace(170, 450, 400);
%     v = linspace(0, 350, 400);
%     z = zeros(length(u), length(v));
%     for i = 1:length(u)
%         for j = 1:length(v)
%             z(i,j) = ((u(i)- mualin(1))^2 + (v(j)- mualin(2))^2)...
%                 - ((u(i)- mublin(1))^2 + (v(j)- mublin(2))^2);
%         end
%     end
%     z = z';
%     contour(u,v,z,[0, 0], 'LineWidth', 1,'LineColor','b','DisplayName','MED');
%     pause
     close all
 
 

end

 
perlintt=min(perlint);

kp=perlint==perlintt;

correctclassA=d1(1,kp).correctclassA;
correctclassB=d1(1,kp).correctclassB;
incorrectclassA=d1(1,kp).incorrectclassA;
incorrectclassB=d1(1,kp).incorrectclassB;
a1=d1(1,kp).a1;
b1=d1(1,kp).b1;
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

%% d2
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
perlint2=[];
[bh bj]=size(ac3);
[bu bi]=size(bc3);

for i=0:q-1
    c=1;
    d=bh;
    adt=round(c+(d-c)*rand(1,1));
    d=bu;
    adt2=round(c+(d-c)*rand(1,1));
    xx=ac3;
    yy=bc3;
    alin=[];
    blin=[];
    alin=[alin;ac3(adt,:)];
    blin=[blin;bc3(adt2,:)];
    xx(adt,:)=[];
    yy(adt2,:)=[];
    xx=[xx;xc];
    yy=[yy;yc];
    
    mualin=alin;
    mualin=mualin';
    mublin=blin;
    mublin=mublin';
    covalin=cov(alin);
    covblin=cov(blin);
    
    
    
    mineucdis=medt(xx,yy,mualin,mublin,covalin,covblin);
    perlin=mineucdis.per;
    perlint2=[perlint2;perlin];
    d2(1,i+1).correctclassA=mineucdis.correctclassA;
    d2(1,i+1).correctclassB=mineucdis.correctclassB;
    d2(1,i+1).incorrectclassA=mineucdis.incorrectclassA;
    d2(1,i+1).incorrectclassB=mineucdis.incorrectclassB;
    d2(1,i+1).perlint=mineucdis.per;
    d2(1,i+1).ac3=alin;
    d2(1,i+1).bc3=blin;
    
%     aq=[mineucdis.correctclassA;mineucdis.incorrectclassB];
%     bq=[mineucdis.correctclassB;mineucdis.incorrectclassA];
%     plot(aq(:,1),aq(:,2),'ro')
%     hold on
%      plot(bq(:,1),bq(:,2),'go')
%     title('Dataset D2');
%     legend('Class A','Class B')
%     hold on
%     plot(mualin(1),mualin(2),'rs','MarkerSize',10,'MarkerFaceColor',...
%         [0,0,0],...
%         'DisplayName','Mean of Class A');
%     hold on
%     plot(mublin(1),mublin(2),'gs','MarkerSize',10,'MarkerFaceColor',...
%         [0,0,0],...
%         'DisplayName','Mean of Class B');
%     hold on
%     u = linspace(170, 450, 400);
%     v = linspace(0, 350, 400);
%     z = zeros(length(u), length(v));
%     for i = 1:length(u)
%         for j = 1:length(v)
%             z(i,j) = ((u(i)- mualin(1))^2 + (v(j)- mualin(2))^2)...
%                 - ((u(i)- mublin(1))^2 + (v(j)- mublin(2))^2);
%         end
%     end
%     z = z';
%     contour(u,v,z,[0, 0], 'LineWidth', 1,'LineColor','r','DisplayName','MED');
%     pause
    close all

end

 
perlintt2=min(perlint2);
kp2=perlint2==perlintt2;
d2correctclassA=d2(1,kp2).correctclassA;
d2correctclassB=d2(1,kp2).correctclassB;
d2incorrectclassA=d2(1,kp2).incorrectclassA;
d2incorrectclassB=d2(1,kp2).incorrectclassB;
ac3=d2(1,kp2).ac3;
bc3=d2(1,kp2).bc3;
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

% D3
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


perlint3=[];
[bh bj]=size(a3);
[bu bi]=size(b3);

for i=0:q-1
    c=1;
    d=bh;
    adt=round(c+(d-c)*rand(1,1));
    d=bu;
    adt2=round(c+(d-c)*rand(1,1));
    xx=a3;
    yy=b3;
    alin=[];
    blin=[];
    alin=[alin;a3(adt,:)];
    blin=[blin;b3(adt2,:)];
    xx(adt,:)=[];
    yy(adt2,:)=[];
    xx=[xx;x3];
    yy=[yy;y3];
    
    mualin=alin;
    mualin=mualin';
    mublin=blin;
    mublin=mublin';
    covalin=cov(alin);
    covblin=cov(blin);
    
    
    
    mineucdis=medt(xx,yy,mualin,mublin,covalin,covblin);
    perlin=mineucdis.per;
    perlint3=[perlint3;perlin];
    d3(1,i+1).correctclassA=mineucdis.correctclassA;
    d3(1,i+1).correctclassB=mineucdis.correctclassB;
    d3(1,i+1).incorrectclassA=mineucdis.incorrectclassA;
    d3(1,i+1).incorrectclassB=mineucdis.incorrectclassB;
    d3(1,i+1).perlint=mineucdis.per;
    d3(1,i+1).a3=alin;
    d3(1,i+1).b3=blin;
    
%        aq=[mineucdis.correctclassA;mineucdis.incorrectclassB];
%     bq=[mineucdis.correctclassB;mineucdis.incorrectclassA];
%     plot(aq(:,1),aq(:,2),'ro')
%     hold on
%      plot(bq(:,1),bq(:,2),'go')
%     title('Dataset D3');
%     legend('Class A','Class B')
%     hold on
%     plot(mualin(1),mualin(2),'rs','MarkerSize',10,'MarkerFaceColor',...
%         [0,0,0],...
%         'DisplayName','Mean of Class A');
%     hold on
%     plot(mublin(1),mublin(2),'gs','MarkerSize',10,'MarkerFaceColor',...
%         [0,0,0],...
%         'DisplayName','Mean of Class B');
%     hold on
%     u = linspace(170, 450, 400);
%     v = linspace(0, 350, 400);
%     z = zeros(length(u), length(v));
%     for i = 1:length(u)
%         for j = 1:length(v)
%             z(i,j) = ((u(i)- mualin(1))^2 + (v(j)- mualin(2))^2)...
%                 - ((u(i)- mublin(1))^2 + (v(j)- mublin(2))^2);
%         end
%     end
%     z = z';
%     contour(u,v,z,[0, 0], 'LineWidth', 1,'LineColor','r','DisplayName','MED');
%     pause
    close all

end

perlintt3=min(perlint3);
kp3=perlint3==perlintt3;
d3correctclassA=d3(1,kp3).correctclassA;
d3correctclassB=d3(1,kp3).correctclassB;
d3incorrectclassA=d3(1,kp3).incorrectclassA;
d3incorrectclassB=d3(1,kp3).incorrectclassB;
a3=d3(1,kp3).a3;
b3=d3(1,kp3).b3;
a3(:,3)=1;
b3(:,3)=2;
d3correctclassA=[d3correctclassA;a3];
d3correctclassB=[d3correctclassB;b3];
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


f
