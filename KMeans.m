%% Kmeans�㷨
% ���룺
% data ����Ĳ��������ŵ�����
% K ����һ���ֶ�����
% middlenodeInit ����ָ����ʼ��������
% iterations ��������

% �����
% IndexID ������
% middlenode ������
% Distance �����ܾ���

 
function [IndexID,middlenode,Distance]=KMeans(data,K,middlenodeInit,iterations)
[numOfData,numOfAttr]=size(data); 
middlenode=middlenodeInit;
% ����
for iter=1:iterations
    pre_middlenode=middlenode;% ��һ����õ�����λ��
    
    tags=zeros(numOfData,K);
    % Ѱ��������ģ���������
    for i=1:numOfData
        D=zeros(1,K);
        Dist=D;
        
        
        for j=1:K
            Dist(j)=norm(data(i,:)-middlenode(j,:),2);
        end
        
        [minDistance,index]=min(Dist);
        tags(i,index)=1;
    end
    
    
    % �������ĵ�
    for i=1:K
        if sum(tags(:,i))~=0
            
            for j=1:numOfAttr
                middlenode(i,j)=sum(tags(:,i).*data(:,j))/sum(tags(:,i));
            end
        else
            randIndexID = randperm(size(data, 1));
            middlenode(i,:) = data(randIndexID(1),:);
            tags(randIndexID,:)=0;
            tags(randIndexID,i)=1;
        end
    end
    
   
    if sum(norm(pre_middlenode-middlenode,2))<0.001 
        break;
    end
    
    
end

% ����������
Distance=zeros(numOfData,1);
IndexID=zeros(numOfData,1);
for i=1:numOfData
    D=zeros(1,K);
    Dist=D;
  
    for j=1:K
        Dist(j)=norm(data(i,:)-middlenode(j,:),2);
    end
    
    [distance,IndexID]=min(Dist);
    distance=Dist(IndexID);
    
    Distance(i)=distance;
    IndexID(i)=IndexID;
end
Distance=sum(Distance,1);
end
