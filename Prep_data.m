function [prepped_data] = Prep_data(data,rdwL)
   prepped_data = cell(1,size(data,1));
   for i = 1:size(data,1)
       proc_data = [];
       instance = data(i,:);
    if(rdwL(1) == 1)
        proc_data = [proc_data;instance(2:end)];
    end
    if(rdwL(2) == 1)
        proc_data = [proc_data;diff(instance)];
    end
    if(rdwL(3) == 1)
        [a,d] = haart(instance(2:end),rdwL(4));
        dataHR = ihaart(a,d,2)';
        proc_data = [proc_data;dataHR];
    end
    prepped_data{i} = proc_data;
   end
end

