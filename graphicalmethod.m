clc
clear 
c=[1,4]; %maximum objective func
a=[-2,7;3,5;4,2];
b=[140;210;180];
x1=0:1:max(b);

x21=((b(1)-a(1,1)*x1))/a(1,2);
x22=((b(2)-a(2,1)*x1))/a(2,2);
x23=((b(3)-a(3,1)*x1))/a(3,2);

x21=max(0,x21);
x22=max(0,x22);
x23=max(0,x23);
          
plot(x1,x21,'r',x1,x22,'b',x1,x23,'g');

%find the index positions where x21,x22,x23=0
c1=find(x1==0)
cx1=find(x21==0)
cx2=find(x22==0)
cx3=find(x23==0)

%find all the corner points
l1=[x1([c1,cx1]);x21([c1,cx1])]'
l2=[x1([c1,cx2]);x22([c1,cx2])]'
l3=[x1([c1,cx3]);x23([c1,cx3])]'

%to club all the points together
cornerpt=unique([l1;l2;l3],'rows')

%to find intersection points

pt=[0;0]
for i=1:size(a,1)
    a1=a(i,:);
    b1=b(i,:);
    for j=i+1:size(a,1)
        a2=a(j,:);
        b2=b(j,:);

        a3=[a1;a2];
        b3=[b1;b2];
        y=inv(a3)*b3
        pt=[pt y]
    end
end
 
ptt=pt'
allptt=[ptt;cornerpt]
points=unique(allptt,'rows')

%writing the equations
for i= 1:size(points,1)
    const1(i)=a(1,1)*points(i,1)-a(1,2)*points(i,2)-b(1)
    const2(i)=a(2,1)*points(i,1)-a(2,2)*points(i,2)-b(2)
    const3(i)=a(3,1)*points(i,1)-a(3,2)*points(i,2)-b(3)
    %finding the points which we need to discard
    s1= find(const1>0)
    s2= find(const2>0)
    s3= find(const3>0)
end
S=unique([s1,s2,s3])
%deleting the points
points(S,:)=[];
%feasible region points
points

value=points*c'
[obj,index] = max(value)
X1= points(index,1)
X2= points(index,2)
