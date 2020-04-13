%% Kmeans算法
% 输入：
% data 输入的不带分类标号的数据
% K 数据一共分多少类
% middlenodeInit 自行指定初始聚类中心
% iterations 迭代次数

% 输出：
% IndexID 分类标号
% middlenode 类中心
% Distance 类内总距离

 
function [IndexID,middlenode,Distance]=KMeans(data,K,middlenodeInit,iterations)
[numOfData,numOfAttr]=size(data); 
middlenode=middlenodeInit;
% 迭代
for iter=1:iterations
    pre_middlenode=middlenode;% 上一次求得的中心位置
    
    tags=zeros(numOfData,K);
    % 寻找最近中心，更新中心
    for i=1:numOfData
        D=zeros(1,K);
        Dist=D;
        
        
        for j=1:K
            Dist(j)=norm(data(i,:)-middlenode(j,:),2);
        end
        
        [minDistance,index]=min(Dist);
        tags(i,index)=1;
    end
    
    
    % 更新中心点
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

% 计算输出结果
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
