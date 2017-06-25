clear all 

Sub_Id = {'228', '230', '231', '233', '239'};

stim = 'VisCheck';
for sub = 1: size(Sub_Id, 2) 
    filename = sprintf ('/Users/vikrant/Dropbox/Software TimeCapsule/Sinha Lab/New Data//PIA%s_%s.bdf', Sub_Id{sub}, stim);
    load filename
    SIG.data
end
