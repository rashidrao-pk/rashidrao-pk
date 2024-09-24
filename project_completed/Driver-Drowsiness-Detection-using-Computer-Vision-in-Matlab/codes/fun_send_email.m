function success=fun_send_email()
% SEND_TEXT_MESSAGE send text message to cell phone or other mobile device.
%    SEND_TEXT_MESSAGE(NUMBER,CARRIER,SUBJECT,MESSAGE) sends a text message
%    to mobile devices in USA. NUMBER is your 10-digit cell phone number.
%    CARRIER is your cell phone service provider, which can be one of the
%    following: 'Alltel', 'AT&T', 'Boost', 'Cingular', 'Cingular2',
%    'Nextel', 'Sprint', 'T-Mobile', 'Verizon', or 'Virgin'. SUBJECT is the
%    subject of the message, and MESSAGE is the content of the message to
%    send.
% 
%    Example:
%      send_text_message('234-567-8910','Cingular', ...
%         'Calculation Done','Don't forget to retrieve your result file')
%      send_text_message('234-567-8910','Cingular', ...
%         'This is a text message without subject')
%
%   See also SENDMAIL.
%
%%  
t = datetime('now');

subject='------ ALERT ------';
message="--ALERT-- Driver is in Drowsiness State : ";
string2= char(t);
string3 = message+string2;

%% Enter Email of Guardian here
emailto='sidra.bscs3503@iiu.edu.pk';
% =========================================================================
%% YOU NEED TO TYPE EMAIL AND PASSWORDS of SMTP Account:
mail = 'driverdrowsinessiiui@gmail.com';    %Your GMail email address
password = '';          %Your GMail password
% =========================================================================


%% Set up Gmail SMTP service.
% Note: following code found from
% http://www.mathworks.com/support/solutions/data/1-3PRRDV.html
% If you have your own SMTP server, replace it with yours.
% Then this code will set up the preferences properly:
setpref('Internet','E_mail',mail);
setpref('Internet','SMTP_Server','smtp.gmail.com');
setpref('Internet','SMTP_Username',mail);
setpref('Internet','SMTP_Password',password);
% The following four lines are necessary only if you are using GMail as
% your SMTP server. Delete these lines wif you are using your own SMTP
% server.
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');
%% Send the email
%  Checking Internet Availability
x=fun_net_availability();
    if x==1
        sendmail(emailto,subject,message);
        success=1;
    elseif x==0
        success=0;
    else
    end
end

