clear,close all
clc
tic

filename = "GPOPS2TEMPLATE.m";
options = gpops2_set('integral', 'on', 'path', 'on', 'event', 'on',...
    'probname', 'Your');
gpops2_template(filename, options);

toc