function [X] = reorg(T)

cnt=1;
for i=0:4
    for d=0:9
        for d2=0:9
            for k=0:9
                for s=0:2
                    if (d ~= d2)
                        X(i+1,k+1,s+1,cnt)= T(4*d2+1,i*300+d*30+k*3+s+1);
                        cnt= cnt+1;
                    end
                end
            end
        end
    end
end