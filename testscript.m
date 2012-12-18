clear all;
clc;

%Initializes empty matrices
average_final_percents=[];
sd_final_percents=[];
average_time_course_percents=[];

%Runs crowdsim.m 1000 times for 0 through 50 cheerstarters. Computes the
%average final percentage of the crowd cheering for each cheer starter
%value over the 1000 trials and stroes it in average_final_percents.
%Computes the standard deviation of the final cheering percentages
%for the 1000 trials with a given number of
%cheer starters and stores it in sd_final_percents.
%For each number of cheer starters, the loop also computes the average
%percentage of the crowd cheering in each round averaged over the 1000
%trials.
for n=0:50  
    total_percent=[];
    time_course_percents=[];
    for i=1:1000
        [hist, percent]=crowdsim(20,100,11,46,10,n);
        total_percent=[total_percent, percent(end)];
        time_course_percents=[time_course_percents; percent];
    end
    average_final_percents=[average_final_percents mean(total_percent)];
    sd_final_percents=[sd_final_percents std(total_percent)];
    average_time_course_percents=[average_time_course_percents; mean(time_course_percents,1)];
    
    n
end

p_values=[]; %Initializes empty p_values vector

%Computes p-value for each number of cheer starters
for j=1:length(average_final_percents)
    p=1-normcdf(average_final_percents(j),average_final_percents(1),sd_final_percents(1));
    p_values=[p_values p];
end

% Multiplies each number by 100 to get percentage
average_final_percents=(average_final_percents*100)';
sd_final_percents=(sd_final_percents*100)';
average_time_course_percents=average_time_course_percents*100;
p_values=p_values';
    

%figure(1)
%plot([1:10], average_time_course_percents(1,:)*100,[1:10], average_time_course_percents(11,:)*100, [1:10], average_time_course_percents(21,:)*100,[1:10], average_time_course_percents(31,:)*100,[1:10], average_time_course_percents(41,:)*100,[1:10], average_time_course_percents(44,:)*100,[1:10], average_time_course_percents(51,:)*100, [1:10], average_time_course_percents(61,:)*100)    

%figure(2)
% plot([0:60], average_final_percents*100)